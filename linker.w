% vim: set ai textwidth=80:
\input macro

\def\version{0.1}
\font\twentycmcsc=cmcsc10 at 20 truept

\datethis

@* Введение.
\vskip 120pt
\centerline{\twentycmcsc linkbk}
\vskip 20pt
\centerline{Простейший линковщик объектных файлов ассемблера MACRO-11}
\vskip 2pt
\centerline{(Версия \version)}
\vskip 10pt
\centerline{Yellow Rabbit}
\vskip 80pt

@* Общая схема программы.
@c
@<Включение заголовочных файлов@>@;
@h
@<Константы@>@;
@<Собственные типы данных@>@;
@<Глобальные переменные@>@;
int
main(int argc, char *argv[])
{
	@<Данные программы@>@;
	const char *objname;
	int i, all_resolved;

	@<Разобрать командную строку@>@;
	@<Инициализация каталога секций@>@;
	@<Инициализация таблицы глобальных символов@>@;
	@<Инициализация списка ссылок без констант@>@;

	/* Поочередно обрабатываем все заданные объектные файлы */
	cur_input = 0;
	all_resolved = 1;
	while ((objname = config.objnames[cur_input]) != NULL) {
		@<Открыть объектный файл@>@;
		handleOneFile(fobj);
		/* Разрешаем глобальные ссылки */
		all_resolved = resolveGlobals();
		fclose(fobj);
		++cur_input;
	}
	@<Вывод таблицы глобальных символов@>@;
	@<Создаём файл результата@>@;
	@<Очистка каталога секций@>@;
	@<Освободить список ссылок без констант@>@;
	return(0);
}

@ Номер текущего обрабатываемого объектного файла.
@<Глобальные переменные@>=
static int cur_input;
@ @<Данные программы@>=
FILE *fobj, *fresult;

@ @<Открыть объектный файл@>=
	fobj = fopen(objname,"r");
	if (fobj== NULL) {
		PRINTERR("Can't open %s\n", objname);
		return(ERR_CANTOPEN);
	}

@ По заданному в командной строке имени создаётся файл с программной секцией,
для которой указан адрес запуска. Остальные секции ненулевой длины планируется
писать в дополнительные файлы (оверлеи).
@<Создаём файл результата@>=
	fresult = fopen(config.output_filename, "w");
	if (fresult == NULL) {
		PRINTERR("Can't create %s\n", config.output_filename);
		return(ERR_CANTCREATE);
	}
	for (i = 0; i < NumSections; ++i) {
		if (SectDir[i].transfer_addr == 1 || SectDir[i].len == 0) 
			continue;
		fwrite(SectDir[i].text + SectDir[i].min_addr, 
			SectDir[i].len - SectDir[i].min_addr, 1, fresult);
	}
	fclose(fresult);

@* Обработка объектного файла.

@ Структура объектного файла.
Объектный файл состоит из блоков, которые начинаются заголовком
 |BinaryBlock|, собственно данных длиной |len - 4| и байта 
контрольной суммы (0 - сумма всех байт).  Между блоками может быть произвольное
количество нулевых байт.
@ @<Собственные типы данных@>=
typedef struct _BinaryBlock {
	uint8_t	one;	/* must be 1 */
	uint8_t	zero;	/* must be 0 */
	uint16_t len; /* length of block */
} BinaryBlock;


@ Обработать один объектный файл.
@c
static void
handleOneFile(FILE *fobj) {
	BinaryBlock obj_header;
	int first_byte;
	unsigned int block_len;
	
	while (!feof(fobj)) {
		/* Ищем начало блока */
		do {
			first_byte = fgetc(fobj);
			if (first_byte == EOF) goto end;
		} while (first_byte != 1);

		/* Читаем заголовок */
		ungetc(first_byte, fobj);
		if (fread(&obj_header, sizeof(BinaryBlock), 1, fobj) != 1) {
			PRINTERR("IO error: %s\n",config.objnames[cur_input]);
			break;
		}
		if (obj_header.zero != 0) continue;
		block_len = obj_header.len - 4;
		PRINTVERB(2, "Binary block found. Length:%o\n", block_len);

		/* Читаем тело блока с котрольной суммой */
		if (fread(block_body, block_len + 1, 1, fobj) != 1) {
			PRINTERR("IO error: %s\n", config.objnames[cur_input]);
			break;
		}
		@<Обработать блок@>@;
	}
end:;
}

@ Буффер для тела блока. 
@<Глобальные...@>=
static uint8_t block_body[65536 + 1];

@ Обработка одного бинарного блока. По первому байту блока выясняем его тип.
@<Обработать блок@>=
	PRINTVERB(2, "  Block type: %o, ", block_body[0]);
	switch (block_body[0]) {
		case 1 :
			PRINTVERB(2, "GSD\n");
			@<Разобрать GSD@>@;
			break;
		case 2 :
			PRINTVERB(2, "ENDGSD\n");
			break;
		case 3 :
			PRINTVERB(2, "TXT\n");
			@<Обработать секцию TXT@>@;
			break;
		case 4 :
			PRINTVERB(2, "RLD\n");
			@<Обработать секцию перемещений@>@;
			break;
		case 5 :
			PRINTVERB(2, "ISD\n");
			break;
		case 6 :
			PRINTVERB(2, "ENDMOD\n");
			break;
		case 7 :
			PRINTVERB(2, "Librarian header\n");
			break;
		case 8 :
			PRINTVERB(2, "Librarian end\n");
			break;
		default :
		  PRINTERR("Bad block type: %o : %s\n",
		  block_body[0], config.objnames[cur_input]);
	}

@* GSD.
@ Разбор блока GSD~---~Global Symbol Directory (каталог глобальных символов). Он
содержит всю информацию, необходимую линковщику для присваивания адресов
глобальным символам и выделения памяти.
Каталог состоит из 8-ми байтовых записей следующих типов:
@d GSD_MODULE_NAME			0
@d GSD_CSECT_NAME			1
@d GSD_INTERNAL_SYMBOL_NAME 2
@d GSD_TRANFER_ADDRESS		3
@d GSD_GLOBAL_SYMBOL_NAME	4
@d GSD_PSECT_NAME			5
@d GDS_IDENT				6
@d GSD_MAPPED_ARRAY			7
@<Разобрать GSD@>=
	handleGSD(block_len);
@ @<Собственные типы...@>=
typedef struct _GSD_Entry {
	uint16_t name[2];
	uint8_t flags;
	uint8_t type;
	uint16_t value;
} GSD_Entry;

@ @c
static void 
handleGSD(int len) {
	int i, sect;
	GSD_Entry *entry;
	char name[7];

	for (i = 2; i< len; i += 8) {
		entry = (GSD_Entry*)(block_body + i);
		@<Распаковать имя@>@;
		PRINTVERB(2, "    Entry name: '%s', type: %o --- ", name, entry->type);
		switch (entry->type) {
			case GSD_MODULE_NAME: 
				/* Просто имя модуля. */
				PRINTVERB(2, "ModuleName.\n");
				PRINTVERB(1, "Module:%s\n", name);
				break;
			case GSD_CSECT_NAME:
				/* Имя управляющей секции */
				PRINTVERB(2, "CSectName, flags:%o, length:%o.\n",
						entry->flags, entry->value);
				break;
			case GSD_INTERNAL_SYMBOL_NAME:
				/* Имя внутреннего символа */
				PRINTVERB(2, "InternalSymbolName\n");
				break;
			case GSD_TRANFER_ADDRESS:
				/* Адрес запуска программы */
				PRINTVERB(2, "TransferAddress, offset:%o.\n", entry->value);
				@<Установить адрес запуска@>@;
				break;
			case GSD_GLOBAL_SYMBOL_NAME:
				/* Определение/ссылка на глобольный адрес */
				PRINTVERB(2, "GlobalSymbolName, flags:%o, value:%o.\n",
						entry->flags, entry->value);
				@<Обработать глобальные символы и ссылки@>@;		
				break;		
			case GSD_PSECT_NAME:
				/* Имя программной секции */
				PRINTVERB(2, "PSectName, flags:%o, max length:%o.\n",
						entry->flags, entry->value);
				@<Обработать программную секцию@>@;
				break;
			case GDS_IDENT:
				/* Версия модуля */
				PRINTVERB(2, "Ident.\n");
				PRINTVERB(1, "  Ident: %s\n", name);
				break;
			case GSD_MAPPED_ARRAY:
				/* Массив */
				PRINTVERB(2, "MappedArray, length:%o.\n", entry->value);
				break;
			default:
			  PRINTERR("Bad entry type: %o : %s\n", 
				entry->type, config.objnames[cur_input]);
		}
	}
}

@ @<Распаковать имя@>=
	fromRadix50(entry->name[0], name);
	fromRadix50(entry->name[1], name + 3);

@ Разбор определения/ссылки на глобальный символ.
@ Таблица глобальных символов. |addr| содержит уже смещенный адрес относительно
0.
@d MAX_GLOBALS 512
@<Собственные типы данных...@>=
typedef struct _GSymDefEntry {
	uint16_t name[2];	
	uint8_t	flags;
	uint8_t	 sect; /* Номер секции, в которой определен глобальный символ */
	uint16_t addr; /* Адрес символа в секции */
} GSymDefEntry;


@ @<Глобальные переменные...@>=
static GSymDefEntry GSymDef[MAX_GLOBALS];
static int NumGlobalDefs;

@ @<Инициализация таблицы глобальных символов@>=
	NumGlobalDefs = 0;

@
@d GLOBAL_WEAK_MASK	  001 // 00000001b
@d GLOBAL_DEFINITION_MASK 010 // 00001000b
@d GLOBAL_RELOCATION_MASK 040 // 00100000b
@c
static void
handleGlobalSymbol(GSD_Entry *entry) {
	if (entry->flags & GLOBAL_DEFINITION_MASK) {
		GSymDef[NumGlobalDefs].name[0] = entry->name[0];
		GSymDef[NumGlobalDefs].name[1] = entry->name[1];
		GSymDef[NumGlobalDefs].flags = entry->flags;
		GSymDef[NumGlobalDefs].sect = CurSect;
		GSymDef[NumGlobalDefs].addr = SectDir[CurSect].start + entry->value;
		++NumGlobalDefs;
	}
	if (config.verbosity >= 2) {
		PRINTVERB(2, "        Flags: ");
		if (entry->flags & GLOBAL_WEAK_MASK) {
			PRINTVERB(2, "Weak,");
		} else {
			PRINTVERB(2, "Strong,");
		}
		if (entry->flags & GLOBAL_DEFINITION_MASK) {
			PRINTVERB(2, "Definition,");
		} else {
			PRINTVERB(2, "Reference,");
		}
		if (entry->flags & GLOBAL_WEAK_MASK) {
			PRINTVERB(2, "Relative.\n");
		} else {
			PRINTVERB(2, "Absolute.\n");
		}
	}	
}

@ Найти символ в таблице. -1~---~символ не найден.
@c
static int findGlobalSym(uint16_t *name) {
	int found, i;

	found = -1;
	for (i = 0; i< NumGlobalDefs; ++i) {
		if (name[0] == GSymDef[i].name[0] && name[1] == GSymDef[i].name[1]) {
			found = i;
			break;
		}
	}

	return(found);
}

@ @<Глобальные переменные...@>=
static int findGlobalSym(uint16_t *);

@ @<Данные программы...@>=
	char name[7];
@ @<Вывод таблицы глобальных символов@>=
	if (config.verbosity >= 1) {
		PRINTVERB(1, "=Global Definitions:\n");
		for(i = 0; i < NumGlobalDefs; ++i) {
			fromRadix50(GSymDef[i].name[0], name);
			fromRadix50(GSymDef[i].name[1], name + 3);
			fromRadix50(SectDir[GSymDef[i].sect].name[0], sect_name);
			fromRadix50(SectDir[GSymDef[i].sect].name[1], sect_name + 3);
			PRINTVERB(1, "%s: %s/%o\n", name, sect_name,
			GSymDef[i].addr);
		}	
	}
@ Разбор программной секции. Данные о секциях хранятся в каталоге секций.
@d MAX_PROG_SECTIONS 254
@<Собственные типы...@>=
typedef struct _SectionDirEntry {
	uint16_t name[2];	// Имя в Radix50
	uint8_t	 flags;	// Флаги секции
	uint16_t start;		// Смещение секции для текущего модуля
	int32_t min_addr;  // Минимальный адрес, с которого расположены данные
	uint16_t len;	// Длина секции
	uint16_t transfer_addr; // Адрес старта (1 --- секция не стартовая)
	uint16_t last_load_addr; // Адрес последнего загруженного блока TEXT
	uint8_t *text;	// Адрес блока памяти для текста секции
} SectionDirEntry;
@ @<Глобальные переменные...@>=
static SectionDirEntry SectDir[MAX_PROG_SECTIONS];
static int NumSections;
@
@d PSECT_SAVE_MASK	  0001	// 00000001b
@d PSECT_ALLOCATION_MASK  0004  // 00000100b
@d PSECT_ACCESS_MASK	  0020  // 00010000b
@d PSECT_RELOCATION_MASK  0040  // 00100000b
@d PSECT_SCOPE_MASK	  0100  // 01000000b
@d PSECT_TYPE_MASK	  0200  // 10000000b
@c
static void
handleProgramSection(GSD_Entry *entry) {
	@<Вывести отладочную информацию по секциям@>@;
	CurSect = findSection(entry->name);
	if (CurSect == -1) {
		@<Добавить программную секцию@>@;
	} else {
		// Изменить смещение секции в модуле
		SectDir[CurSect].start += SectDir[CurSect].len;
		SectDir[CurSect].len += entry->value;
	}
}

@ @<Глобальные переменные...@>=
static int CurSect;

@ Переключается текущая секция.
@<Установка текущей секции и позиции@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Name: %s, +Const: %o.\n", gname,
		const_entry->constant);
	CurSect = findSection(entry->value);
	if (SectDir[CurSect].min_addr == -1 ||
		SectDir[CurSect].min_addr > (const_entry->constant +
			SectDir[CurSect].start)) {
		SectDir[CurSect].min_addr = const_entry->constant +
			SectDir[CurSect].start;
	}
	RLD_i += 8;

@ Адрес запуска, равный единице игнорируется.
@ @<Установить адрес запуска@>=
	sect = findSection(entry->name);
	SectDir[sect].transfer_addr = entry->value;
@ Обработать секцию |TEXT|. Содержимое добавляется к текущей секции
|CurSect|. Поскольку секции |TEXT| могут следовать друг за другом, и лишь к
последней из них применяется секция настройки адресов, то запоминаем адрес, с
которого была загружена последняя секция |TEXT|.
@c
static void 
handleTextSection(uint8_t *block, unsigned int len) {
	uint16_t addr;

	addr = block[2] + block[3] * 256;
	PRINTVERB(2, "  Load address: %o, Current section: %d.\n", addr,
	CurSect);
	memcpy(SectDir[CurSect].text + SectDir[CurSect].start + addr, block + 4, len - 4);
	SectDir[CurSect].last_load_addr = SectDir[CurSect].start + addr;
}

@
@<Инициализация каталога секций@>=
	NumSections = 0;
	memset(SectDir, 0, sizeof(SectDir));

@ @<Данные программы...@>=
	char sect_name[7];
@ @<Очистка каталога секций@>=
	PRINTVERB(1, "=Sections:\n");
	for (i = 0; i < NumSections; ++i) {
		fromRadix50(SectDir[i].name[0], sect_name);
		fromRadix50(SectDir[i].name[1], sect_name + 3);
		PRINTVERB(1, "%s, addr: %p, len: %o, min addr: %o,"
			" current start: %o\n", sect_name,
		SectDir[i].text, SectDir[i].len, SectDir[i].min_addr,
		SectDir[i].start);
		if (SectDir[i].text != NULL)
			free(SectDir[i].text);
	}
	
@ Найти программную секцию по имени.
@c
static int
findSection(uint16_t *name) {
	int found, i;

	found = -1;
	for (i = 0; i < NumSections; ++i) {
		if (SectDir[i].name[0] == name[0] && SectDir[i].name[1] ==
		name[1]) {
			found = i;
			break;
		}
	}

	return(found);
}
@  Память выделяется под все секции, даже те, которые имеют нулевую длину.
@d DEFAULT_SECTION_LEN 65536
@<Добавить программную секцию@>=
	SectDir[NumSections].name[0] = entry->name[0];
	SectDir[NumSections].name[1] = entry->name[1];
	SectDir[NumSections].flags = entry->flags;
	SectDir[NumSections].len = entry->value;
	/* Если секции при слиянии выравниваются на слово, то изменить длину */
	if (!(entry->flags & PSECT_TYPE_MASK)) {
		if(SectDir[NumSections].len & 1)
			++SectDir[NumSections].len;
	}
	SectDir[NumSections].min_addr = -1;
	SectDir[NumSections].transfer_addr = 1;
	SectDir[NumSections].text = (uint8_t*)calloc(1, DEFAULT_SECTION_LEN);
	CurSect = NumSections;
	++NumSections;

@ @<Глобальные переменны...@>=
static int findSection(uint16_t *);


@ @<Вывести отладочную информацию по секциям@>=
	if (config.verbosity >= 2) {
		PRINTVERB(2, "        Flags: ");
		if (entry->flags & PSECT_SAVE_MASK) {
			PRINTVERB(2, "RootScope,");
		} else {
			PRINTVERB(2, "NonRootScope,");
		}
		if (entry->flags & PSECT_ALLOCATION_MASK) {
			PRINTVERB(2, "Overlay,");
		} else {
			PRINTVERB(2, "Concatenate,");
		}
		if (entry->flags & PSECT_ACCESS_MASK) {
			PRINTVERB(2, "ReadOnly,");
		} else {
			PRINTVERB(2, "ReadWrite,");
		}
		if (entry->flags & PSECT_RELOCATION_MASK) {
			PRINTVERB(2, "Relocable,");
		} else {
			PRINTVERB(2, "Absolute,");
		}
		if (entry->flags & PSECT_SCOPE_MASK) {
			PRINTVERB(2, "Global,");
		} else {
			PRINTVERB(2, "Local,");
		}
		if (entry->flags & PSECT_TYPE_MASK) {
			PRINTVERB(2, "Dref.\n");
		} else {
			PRINTVERB(2, "Iref.\n");
		}
	}

@* Списки ссылок на глобальные символы.
@ Есть три вида ссылок на глобальные символы: без добавления константы, с
добавлением константы и сложная ссылка. Первые два вида имеют фиксированный
(хотя и разный) размер, а третья~---~произвольный размер.

Кусочки маленькие, поэтому попробуем не дергать операционку для выделения
памяти, а используем линейные списки с хранением в массиве.

@ Структура элемента списка для хранения ссылок без  константы.
@d INITIAL_SIMPLE_REF_LIST_SIZE 100
@<Собственные типы данных...@>=
typedef struct _SimpleRefEntry {
	uint16_t link; /* Поле связи */
	uint8_t	type;
	uint8_t	sect;	/* Номер секции */
	uint16_t	disp;	/* Смещение в секции уже учитывающее адрес самой сецкии */
	uint16_t name[2];
} SimpleRefEntry;
typedef struct _SimpleRefList {
	uint16_t avail;	/* Начало списка свободных блоков */
	uint16_t poolmin;	/* Номер элемента --- нижней границы пула */
	SimpleRefEntry *pool;	/* Массив для хранения списка */
} SimpleRefList;

@ @<Глобальные переменные...@>=
static SimpleRefList SRefList;
static int simpleRefIsEmpty(void);
@ 
@c
static int
simpleRefIsEmpty(void) {
	return(SRefList.pool[0].link == 0);
}

@ Добавляем новую ссылку в список
@c
static void
addSimpleRef(RLD_Entry *ref) {
	SimpleRefEntry *new_entry;
	uint16_t new_index;

	/* Если не хватило начального размера пула */
	if (SRefList.poolmin == INITIAL_SIMPLE_REF_LIST_SIZE) {
		PRINTERR("No memory for simple ref list");
		return;
	}
	/* Если есть свободные блоки */
	if (SRefList.avail != 0) {
		new_index = SRefList.avail;
		SRefList.avail = SRefList.pool[SRefList.avail].link;
	} else {
	/* Свободных блоков нет, используем пул */
		new_index = SRefList.poolmin;
		++SRefList.poolmin;
	}
	new_entry = SRefList.pool + new_index;
	new_entry->link = SRefList.pool[0].link;
	SRefList.pool[0].link = new_index;

	/* Собственно данные ссылки */
	new_entry->name[0] = ref->value[0];
	new_entry->name[1] = ref->value[1];
	new_entry->disp = ref->disp - 4 + SectDir[CurSect].last_load_addr;
	new_entry->sect = CurSect;
	new_entry->type = ref->cmd.type;
}

@ Удаляем ссылку из списка. Возвращает поле связи удалямого элемента. Задача
вызывающей функции: записать это значение в поле связи предыдущего элемента.
@c
static uint16_t 
delSimpleRef(uint16_t ref_i) {
	uint16_t link;

	link = SRefList.pool[ref_i].link;
	SRefList.pool[ref_i].link = SRefList.avail;
	SRefList.avail = ref_i;
	
	return(link);
}

@ |poolmin| устанавливаем равным 1, так как для данной системы хранения ссылок
нулевой элемент пула не используется, а его номер считается чем-то вроде NULL.
@<Инициализация списка ссылок без констант...@>=
	SRefList.pool = (SimpleRefEntry *)malloc(sizeof(SimpleRefEntry) *
		INITIAL_SIMPLE_REF_LIST_SIZE);
	SRefList.pool[0].link = 0;	
	SRefList.avail = 0;
	SRefList.poolmin = 1;

@ @<Освободить список ссылок без констант...@>=
	if (config.verbosity >= 2) {
		PRINTVERB(2, "=Simple Refs:\n avail: %d, poolmin: %d\n",
		 SRefList.avail, SRefList.poolmin);
		for (i = SRefList.pool[0].link; i != 0; i = SRefList.pool[i].link) {
			fromRadix50(SRefList.pool[i].name[0], name);
			fromRadix50(SRefList.pool[i].name[1], name + 3);
			fromRadix50(SectDir[SRefList.pool[i].sect].name[0], sect_name);
			fromRadix50(SectDir[SRefList.pool[i].sect].name[1], sect_name + 3);
			PRINTVERB(2, "i: %4d, name: %s, disp: %s/%o\n", i, name, sect_name,
			SRefList.pool[i].disp);
		}
	}
	free(SRefList.pool);

@ @<Глобальные переменные...@>=
static void addSimpleRef(RLD_Entry *);
static uint16_t delSimpleRef(uint16_t);

@* Разрешение ссылок на глобальные символы.
@ Пробегаем набранные списки ссылок на глобальные символы и смотрим нет ли уже
возможности разрешить ссылки. Возвращает 0, если неразрешенных ссылок нет.
@c
static int
resolveGlobals(void) {
	uint16_t ref, *dest_addr;
	int global;
	char name [7];

	PRINTVERB(2, "resolve globals. [0].link: %d\n", SRefList.pool[0].link);
	/* Ссылки без констант */
	if (!simpleRefIsEmpty()) {
		for (ref = SRefList.pool[0].link; ref != 0; ref =
			SRefList.pool[ref].link) {
			global = findGlobalSym(SRefList.pool[ref].name);
			if (global == -1) {
				continue;
			}
			fromRadix50(SRefList.pool[ref].name[0], name);
			fromRadix50(SRefList.pool[ref].name[1], name + 3);
			PRINTVERB(2, "try resolve %s.", name);
			if (SRefList.pool[ref].type == RLD_CMD_GLOBAL_RELOCATION) {
				/* Прямая ссылка */
				PRINTVERB(2, " global: %d, sect: %d, disp: %o, addr: %o\n", global, SRefList.pool[ref].sect,
					SRefList.pool[ref].disp, GSymDef[global].addr);
				dest_addr =
				(uint16_t*)(SectDir[SRefList.pool[ref].sect].text + SRefList.pool[ref].disp);
				*dest_addr = GSymDef[global].addr;
			}
		}
	}
	return (simpleRefIsEmpty() && 1);
}


@ @<Глобальные переменные...@>=
static int resolveGlobals(void);

@* Каталоги перемещений.
@ Блоки каталогов перемещений содержат информацию, которая нужна линковщику для
корректировки ссылок в предыдущем блоке |TEXT|. Каждый модуль должеен иметь хотя
бы один блок RLD, который расположен впереди всех блоков |TEXT|, его
задача~---~описать текущую PSECT и её размещение.

Каталог перемещений состоит из записей:
@ @<Собственные типы...@>=
typedef struct _RLD_Entry {
	struct {
	    uint8_t type:7;
	    uint8_t b:1;
	} cmd;
	uint8_t disp;
	uint16_t value[2];
} RLD_Entry;

typedef struct _RLD_Const_Entry {
	RLD_Entry ent;
	uint16_t constant;
} RLD_Const_Entry;

@ Поле |cmd.type| указывает  
@d RLD_CMD_INTERNAL_RELOCATION			01
@d RLD_CMD_GLOBAL_RELOCATION			02
@d RLD_CMD_INTERNAL_DISPLACED_RELOCATION	03
@d RLD_CMD_GLOBAL_DISPLACED_RELOCATION		04
@d RLD_CMD_GLOBAL_ADDITIVE_RELOCATION		05
@d RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION 06
@d RLD_CMD_LOCATION_COUNTER_DEFINITION		07
@d RLD_CMD_LOCATION_COUNTER_MODIFICATION	010 
@d RLD_CMD_PROGRAM_LIMITS			011
@d RLD_CMD_PSECT_RELOCATION			012
@d RLD_CMD_PSECT_DISPLACED_RELOCATION		014
@d RLD_CMD_PSECT_ADDITIVE_RELOCATION		015
@d RLD_CMD_PSECT_ADDITIVE_DISPLACED_RELOCATION  016
@d RLD_CMD_COMPLEX_RELOCATION			017
@c
static void 
handleRelocationDirectory(uint8_t *block, int len) {
	RLD_Entry *entry;
	RLD_Const_Entry *const_entry;
	char gname[7];
	uint16_t *value;
	int RLD_i;

	for (RLD_i = 2; RLD_i < len; ) {
		entry = (RLD_Entry*)(block + RLD_i);
		PRINTVERB(2, "    cmd: %o --- ", entry->cmd.type);
		switch (entry->cmd.type) {
			case RLD_CMD_INTERNAL_RELOCATION:
				PRINTVERB(2, "Internal Relocation.\n");
				@<Прямая ссылка на абсолютный адрес@>@;
				break;
			case RLD_CMD_GLOBAL_RELOCATION:
				PRINTVERB(2, "Global Relocation.\n");
				@<Прямая ссылка на глобальный символ@>@;
				break;
			case RLD_CMD_INTERNAL_DISPLACED_RELOCATION:
				PRINTVERB(2, "Internal Displaced Relocation.\n");
				@<Косвенная ссылка на абсолютный адрес@>@;
				break;
			case RLD_CMD_GLOBAL_DISPLACED_RELOCATION:
				PRINTVERB(2, "Global Displaced Relocation.\n");
				@<Косвенная ссылка на глобальный символ@>@;
				break;
			case RLD_CMD_GLOBAL_ADDITIVE_RELOCATION:
				PRINTVERB(2, "Global Additive Relocation.\n");
				@<Прямая ссылка на смещенный глобальный символ@>@;
				break;
			case RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION:
				PRINTVERB(2, "Global Additive Displaced Relocation.\n");
				@<Косвенная ссылка на смещенный глобальный
				  символ@>@;
				break;
			case RLD_CMD_LOCATION_COUNTER_DEFINITION:
				PRINTVERB(2, "Location Counter Definition.\n");
				@<Установка текущей секции и позиции@>@;
				break;
			case RLD_CMD_LOCATION_COUNTER_MODIFICATION:
				PRINTVERB(2, "Location Counter Modification.\n");
				@<Изменение текущей позиции@>@;
				break;
			case RLD_CMD_PROGRAM_LIMITS:
				PRINTVERB(2, "Program Limits.\n");
				@<Установка пределов@>@;
				break;
			case RLD_CMD_PSECT_RELOCATION:
				PRINTVERB(2, "PSect Relocation.\n");
				@<Прямая ссылка на секцию@>@;
				break;
			case RLD_CMD_PSECT_DISPLACED_RELOCATION:
				PRINTVERB(2, "PSect Displaced Relocation.\n");
				@<Косвенная ссылка на секцию@>@;
				break;
			case RLD_CMD_PSECT_ADDITIVE_RELOCATION:
				PRINTVERB(2, "PSect Additive Relocation.\n");
				@<Прямая смещенная ссылка на секцию@>@;
				break;
			case RLD_CMD_PSECT_ADDITIVE_DISPLACED_RELOCATION:
				PRINTVERB(2, "PSect Additive Displaced Relocation.\n");
				@<Косвенная смещенная ссылка на секцию@>@;
				break;
			case RLD_CMD_COMPLEX_RELOCATION:
				PRINTVERB(2, "Complex Relocation.\n");
				@<Сложная ссылка@>@;
				break;
			default :
				PRINTERR("Bad RLD entry type: %o : %s\n", 
					entry->cmd.type, config.objnames[cur_input]);
				return;	
		}
	}
}

@ ?
@<Прямая ссылка на абсолютный адрес@>=
	PRINTVERB(2, "      Disp: %o, +Const: %o.\n", entry->disp, entry->value[0]);
	RLD_i += 4;
@ ?
@<Косвенная ссылка на абсолютный адрес@>=
	PRINTVERB(2, "      Disp: %o, +Const: %o.\n", entry->disp, entry->value[0]);
	RLD_i += 4;
@ ?
@<Прямая ссылка на глобальный символ@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	addSimpleRef(entry);
	RLD_i += 6;
@ ?
@<Косвенная ссылка на глобальный символ@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	RLD_i += 6;

@ ?
@<Прямая ссылка на смещенный глобальный символ@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s, +Const: %o.\n", entry->disp, gname,
		const_entry->constant);
	RLD_i += 8;

@ ?
@<Косвенная ссылка на смещенный глобальный символ@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s, +Const: %o.\n", entry->disp, gname,
		const_entry->constant);
	RLD_i += 8;

@ ?
@<Изменение текущей позиции@>=
	PRINTVERB(2, "      +Const: %o.\n", entry->value[0]);
	RLD_i += 4;

@ ?
@<Установка пределов@>=
	PRINTVERB(2, "      Disp: %o.\n", entry->disp);
	RLD_i += 2;

@ ?
@<Прямая ссылка на секцию@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	RLD_i += 6;

@ ?
@<Косвенная ссылка на секцию@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	RLD_i += 6;

@ ?
@<Прямая смещенная ссылка на секцию@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Name: %s, +Const: %o.\n", gname,
		const_entry->constant);
	RLD_i += 8;

@ ?
@<Косвенная смещенная ссылка на секцию@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Name: %s, +Const: %o.\n", gname,
		const_entry->constant);
	RLD_i += 8;

@ ?
@d CREL_OP_NONE			000
@d CREL_OP_ADDITION		001
@d CREL_OP_SUBSTRACTION		002
@d CREL_OP_MULTIPLICATION	003
@d CREL_OP_DIVISION		004
@d CREL_OP_AND			005
@d CREL_OP_OR			006
@d CREL_OP_XOR			007
@d CREL_OP_NEG			010
@d CREL_OP_COM			011
@d CREL_OP_STORE_RESULT		012
@d CREL_OP_STORE_RESULT_DISP	013
@d CREL_OP_FETCH_GLOBAL		016
@d CREL_OP_FETCH_RELOCABLE	017
@d CREL_OP_FETCH_CONSTANT	020
@<Сложная ссылка@>=
	PRINTVERB(2, "      Disp: %o.\n        ", entry->disp);
	for (RLD_i += 2; block[RLD_i] != CREL_OP_STORE_RESULT; ++RLD_i) {
		switch (block[RLD_i]) {
			case CREL_OP_NONE:
				break;
			case CREL_OP_ADDITION:
				PRINTVERB(2, "+ ");
				break;
			case CREL_OP_SUBSTRACTION:
				PRINTVERB(2, "- ");
				break;
			case CREL_OP_MULTIPLICATION:
				PRINTVERB(2, "* ");
				break;
			case CREL_OP_DIVISION:
				PRINTVERB(2, "/ ");
				break;
			case CREL_OP_AND:
				PRINTVERB(2, "and ");
				break;
			case CREL_OP_OR:
				PRINTVERB(2, "or ");
				break;
			case CREL_OP_XOR:
				PRINTVERB(2, "xor ");
				break;
			case CREL_OP_NEG:
				PRINTVERB(2, "neg ");
				break;
			case CREL_OP_COM:
				PRINTVERB(2, "com ");
				break;
			case CREL_OP_STORE_RESULT_DISP:
				break;
			case CREL_OP_FETCH_GLOBAL:
				++RLD_i;
				value = (uint16_t *)(block + RLD_i);
				fromRadix50(value[0], gname);
				fromRadix50(value[1], gname + 3);
				RLD_i += 3;
				PRINTVERB(2, "%s ", gname);
				break;
			case CREL_OP_FETCH_RELOCABLE:
				value = (uint16_t *)(block + RLD_i + 2);
				PRINTVERB(2, "sect:%o/%o ", block[RLD_i + 1],
					value[0]);
				RLD_i += 3;	
				break;
			case CREL_OP_FETCH_CONSTANT:
				++RLD_i;
				value = (uint16_t *)(block + RLD_i);
				++RLD_i;
				PRINTVERB(2, "%o ", *value);
				break;
			default :
				PRINTERR("Bad complex relocation opcode.\n");
				return;
		}
	}
	++RLD_i;
	PRINTVERB(2, "\n");

@ @<Обработать глобальные символы и ссылки@>=
handleGlobalSymbol(entry);

@ @<Обработать программную секцию@>=
handleProgramSection(entry);

@ @<Обработать секцию TXT@>=
handleTextSection(block_body, block_len);

@ @<Обработать секцию перемещен...@>=
handleRelocationDirectory(block_body, block_len);

@ @<Глобальные...@>=
static void handleGlobalSymbol(GSD_Entry *);
static void handleProgramSection(GSD_Entry *);
static void handleTextSection(uint8_t *, unsigned int);
static void handleRelocationDirectory(uint8_t *, int);

@* Вспомогательные функции.

@ Перевод двух байт из RADIX-50 в строку.
@c
static void fromRadix50(int n, char *name) {
	int i, x;

	for (i = 2; i >= 0; --i) {
		x = n % 050;
		n /= 050;
		if (x <= 032 && x != 0) {
			name[i] = x + 'A' - 1; 
			continue;
		}
		if (x >= 036) {
			name[i] = x + '0' - 036;
			continue;
		}
		switch (x) {
			case 033 : name[i] = '$'; break;
			case 034 : name[i] = '.'; break;
			case 035 : name[i] = '%'; break;
			case 000 : name[i] = ' '; break;
		}
	}
	name[3] = '\0';
}

@ @<Глобальные...@>=
static void handleOneFile(FILE *);
static void handleGSD(int);
static void fromRadix50(int, char*);

@* Разбор параметров командной строки.

Для этой цели используется достаточно удобная свободная библиотека 
{\sl argp}.
@d VERSION "0.6"

@ @<Константы@>=
const char *argp_program_version = "linkbk, " VERSION;
const char *argp_program_bug_address = "<yellowrabbit@@bk.ru>";

@ @<Глобальн...@>=
static char argp_program_doc[] = "Link MACRO-11 object files";

@ Распознаются следующие опции:
\smallskip
	\item {} {\tt -o} --- имя выходного файла.
\smallskip
@<Глобальн...@>=
static struct argp_option options[] = {@|
	{ "output", 'o', "FILENAME", 0, "Output filename"},@|
	{ "verbose", 'v', NULL, 0, "Verbose output"},@!
	{ 0 }@/
};
static error_t parse_opt(int, char*, struct argp_state*);@!
static struct argp argp = {options, parse_opt, NULL, argp_program_doc};

@ Эта структура используется для получения результатов разбора параметров командной строки.
@<Собственные...@>=
typedef struct _Arguments {
	int  verbosity;
	char output_filename[FILENAME_MAX]; /* Имя файла с тектом */
	char **objnames;		    /* Имена объектных файлов
					 objnames[?] == NULL --> конец имен*/
} Arguments;

@ @<Глобальные...@>=
static Arguments config = { 0, {0}, NULL, };


@ Задачей данного простого парсера является заполнение структуры |Arguments| из указанных
параметров командной строки.
@c
static error_t 
parse_opt(int key, char *arg, struct argp_state *state) {
 Arguments *arguments;
	arguments = (Arguments*)state->input;
 switch (key) {
	case 'v':
		++arguments->verbosity;
		break;
	case 'o':
		if (strlen(arg) == 0)
			return(ARGP_ERR_UNKNOWN);
		strncpy(arguments->output_filename, arg, FILENAME_MAX - 1);
		break;
	case ARGP_KEY_ARG:
		/* Имена объектных файлов */
		arguments->objnames = &state->argv[state->next - 1];
		/* Останавливаем разбор параметров */
		state->next = state->argc;
		break;
	default:
		break;
		return(ARGP_ERR_UNKNOWN);
	}
	return(0);
}
@ 
@d ERR_SYNTAX		1
@d ERR_CANTOPEN		2
@d ERR_CANTCREATE	3
@<Разобрать ком...@>=
	argp_parse(&argp, argc, argv, 0, 0, &config);@|
	/* Проверка параметров */
	if (strlen(config.output_filename) == 0) {
		PRINTERR("No output filename specified\n");
		return(ERR_SYNTAX);
	}
	if (config.objnames == NULL) {
		PRINTERR("No input filenames specified\n");
		return(ERR_SYNTAX);
	}

@ @<Включение ...@>=
#include <string.h>
#include <stdlib.h>

#ifdef __linux__
#include <stdint.h>
#endif

#include <argp.h>

@
@<Глобальные...@>=
#define PRINTVERB(level, fmt, a...) (((config.verbosity) >= level) ? printf(\
  (fmt), ## a) : 0)
#define PRINTERR(fmt, a...) fprintf(stderr, (fmt), ## a) 

