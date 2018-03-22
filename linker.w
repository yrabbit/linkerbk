% vim: set ai textwidth=80:
\input lib/verbatim
\input cwebmac-ru

\def\version{0.6}
\font\twentycmcsc=cmcsc10 at 20 truept

\datethis

\vskip 120pt
\centerline{\twentycmcsc linkbk}
\vskip 20pt
\centerline{���������� ��������� ��������� ������ ���������� MACRO-11}
\vskip 2pt
\centerline{(������ \version)}
\vskip 10pt
\centerline{Yellow Rabbit}
\vskip 80pt

��������� ������������ ��� ��������� ����������� ������ �� ��������� ������
���������� MACRO-11\footnote{$^1$}{�������������� BSD-������ ����������
Richard'�
Krehbiel'�.

GIT-����������� ����������, ���������� � ������ https://github.com/yrabbit
}. 
�������� ����������� ��������: �������� ���� ��������� ������, ���
��������� ����� � ��������� ����������� ������.
�� ������ ��������� ����������� ���� ��� ��11�.

��������� �������� ��������� ������ ��������� ������, ������������ �����������
MACRO-11:
\item{$\bullet$} ��� ������, ������ ������, ����� �������;
\item{$\bullet$} ����������� ������, ��� ����������, ��� � ������������;
\item{$\bullet$} ������ � ��������� ������ ������ ������;
\item{$\bullet$} ������, ������ �� ���������, ��������� � ��������� �� ���������
������ �� ���������� �������;
\item{$\bullet$} ������, ������ �� ���������, ��������� � ��������� �� ���������
������ �� ����������� ������ ������ ������;
\item{$\bullet$} ������ ���������� ������� ������������� ������������ �����;
\item{$\bullet$} ������� ������.

������������:
\item{$\bullet$} ������ � ������������.

�����������:
\item{$\bullet$} ���� ��������/��������� ������ ``���������'' �� ����������
��������� ������, �� ���� � ������ ������� ��������� ������ ���� ������ �
��������� ������ ������;
\item{$\bullet$} ���� ������ ``���������'' �� ���������� ��������� ������, ��
����, � ������� ������� ��������� �������� ������, ������ ���� ������ � ���������
������.

@* ������� ��������� ��������.
� ����� ������� ������ ��������� ������� �� ������ �����, � ������� ��
������������ ����������� ������, �, �������������, ��� ���������� ��������, �
��� ����� ������������� ������.

������� ���������� ���������.
\listing{tests/simple.asm}

����� ���� ���������� \verbatim!simple.asm!, �, ����� ���������� �����������, ����������
��������� ���� \verbatim!simple.o!.
����� ������� ���������� \verbatim!linkerbk -v -o simple simple.o! ���������� �����:
\listing{tests/simple.log}

�� ����, ��������� ��� ����� ������ ��� ������: ���������� ������ � ������
\verbatim!. ABS.!, ������� �� �������� ������������������ ����� ��� ������
(\verbatim!len: 0!) � �� �������� ����� ������ 
{(\verbatim!min addr: 37777777777!)}, � ������������ ������ � ������, ��������� �� ����� ��������,
������� ����������� ����� ��� 1114 ���� � �������� ������, ������� �� ��������
1000. 

��������� ������� ������ ���� �������� ����~---~\verbatim!simple!.

@ ����������� �� ��������� ���������� ������� ����� ���������������, ����
��������� ��������� ���������� \verbatim!.ASECT! ��� � ��������� �������:
\listing{tests/abs.asm}

��� �������� ����������, ��� ���������� ������ ����������� ����� ��� ������, ��,
��������� ���� ������ � ������ �� �����������, �� ����� ������ ������ ���� ����,
������� �������� ������������� ������������ ������:
\listing{tests/abs.log}

��� ������ ������������ ����, ��� ����� ������������ ������������� ����������
������. 
@ �� �������� ��� ����� ����� ��� ������ �������� ���������� ��� ���������
���������
��� ��� ����-������ ����� ������������ ������
������������ �������� ��� � ��������� �������\footnote{$^2$}{��� ����� ������ ����,
��� ����� �������� ��������� �� ����� ��������:) ��� ���������� �����
������� macro11 ������� � ������� �������� (����� \verbatim!-p!) ��� ����������
���������� ��������� \verbatim!MCALL!. � ����� ����� ��������� ��������� �����
�������� ��� �������� ��11� � MKDOS.}.
\listing{tests/abs2.asm}

@ ������������� ����������� ������ ��� ���������� �����������, ������������ ��
����� ����������. ����� �� ����� ���������� ��������� ���������� ������� � �����
� ��������� ����� ������������, ����� �������� ��� ������������ � ���������
����������� ����������� ������ (\verbatim!SUBS!) � ��������� ��� ��� ���������
�����, ����� ��������� ���� ��������� ��������������� ������ �� ��� ������. 

��������� ����� ����������� ����������� ������ � ��������� ����� ��������, �����
������� ���������� �� ����� ��������� ������������ ����� + ``-'' + ��� ������ +
``.v''. ��� ������������� ���������� ��� ����� ������� ��������� �� ���������
�����\footnote{$^3$}{���� \verbatim!-l! ����������.}.

����� ��������, ��� ��������� �� ����������� ����������� �� ������ �����������
������, � ������ ������� �� � ������ ����� �������� �� �������������.
\listing{tests/overlay.asm}
��� ��������:
\listing{tests/overlay.log}

@ 
��������� ���������� ����������� ����������� ������ � ���������� ������, �������
��������� ����� ������� �� ����� ��������� ������, ������� ��������������
��-�����������, � ����� ���������.

������ ����:
\listing{tests/ovr2.asm}

������ ����:
\listing{tests/ovr2-part2.asm}

��� ��������:
\listing{tests/ovr2.log}

@* ������� � ������������� �������� (������� SAV).

�������� ���������� ������� ��� ������ � ����� ����������� �����. �����������
��� ������ ��� ���������� ������ �� ������ ������� �� ����� ����������
���������. 

����� ������� ���������� �� ������ ����� ��������, � �������� ������ �
����������� ���� � ������� �������� \verbatim!SAV! ��������� \verbatim!.PSECT!.
����� ����������� ������ ���������� � ����������� ���� ����� ����� ���������
����������� ������. 

��������� ������ ����������� ������� � ������������ ������������ ������ �
����������� ����� (� ������ � ������� �������� ����� �������� ���: ������� �
���������� ���� ������� �������� ����� ��). ������������ ������ �� ������������
������~---~����� ����� ��������� ������. ������ �� �� ����� ��������� ���
������� ����� �������, ������������ � ������ � ����� ������������ ������.

������ ������ ������� � ���, ����� ������������ ����� ������� � ������������
������ � ������������ ��������� \verbatim!.LIMIT!, ������� ���������� � ��� ���
����� ��������� � �������� ������ ������ ����� ��������, ��� ��������������� �
��������� �������.

�������� ����.
\listing{tests/save.asm}

����, ��� ������� ������������ ������.
\listing{tests/save-part2.asm}

��� ��������.
\listing{tests/save.log}

@ �������������� ������ (RAM-BIOS).

��� ������������� ������������ ``�������'' � �������������� �������
64~--~512~K�� � ������� ��� �� ���� 2.0 �������� ��������� ����������� ��� �
������ � ���� �������������� ������. ������ � �������������� �������
�������������� ����� ����������� ������� � ������������
����������\footnote{$^4$}{������ ���������� �������� �������
\verbatim!http://forum.pk-fpga.ru/viewtopic.php?f=39&t=5410!}, ����� ��������
������ ���� ��������� � ������. 

� ����������� tests ������� ����� instBIOS � MEMORY, ������ ��� ��� � ������ ���
�������� ����� RAM-BIOS � ������. ��������� MEMORY ������������� ���
�������������� ���������/��������� ��������� �������������� ������.

����� �� ���������� �� ������� � ������ ���������� ����� �������� ���������
RAM-BIOS � ���� ���������, ������� ��� ��� �������, ���������� � ������ 40000.

� ��������� ������� ��������� ��������� ��� �����������. ��������� 
�������������� ��������� ��� ���� �������� ������ (������� � ������������
RAM-BIOS), ����������� ������ � ���������� ������������ � ��� ���������� �������
. �������� � ������� �����~---~������ ������������. ����� ������������
���������� ��� ���������� ����� � �������������� ������, ����������� ������
����������� �������� ``��������'', ����������� ���������� ��������. ����� ����
��� ``��������'' ���������� � �������� ������� ������ ��� �����������.

��������� ������ ���������� �������� �������������� ������ ``�������'', ��
����������� � ��� ������������ ����� ������ � ������������ �����, ��� �������� �
�������.

���� ram-bios.asm.
\listing{tests/ram-bios.asm}

@* ����� ����� ���������.
@c
@<��������� ������������ ������@>@;
@h
@<���������@>@;
@<����������� ���� ������@>@;
@<���������� ����������@>@;
int
main(int argc, char *argv[])
{
	@<������ ���������@>@;
	const char *objname;
	int i, j, not_resolved;

	@<��������� ��������� ������@>@;
	@<������������� �������� ������@>@;
	@<������������� ������� ���������� ��������@>@;
	@<������������� ������ ������ ��� ��������@>@;
	@<������������� ������ ������� ���������@>@;
	@<������������� ������ ��������@>@;

	/* ���������� ������������ ��� �������� ��������� ����� */
	cur_input = 0;
	not_resolved = 1;
	num_start_addresses = 0;
	while ((objname = config.objnames[cur_input]) != NULL) {
		@<������� ��������� ����@>@;
		handleOneFile(fobj);
		/* ��������� ���������� ������ */
		not_resolved = resolveGlobals();
		/* ��������� ������� ������ */
		not_resolved += resolveComplex();
		fclose(fobj);
		++cur_input;
		if (num_start_addresses >= 2) {
			PRINTERR("Too many start addresses.\n");
			return(1);
		}
	}
	if (not_resolved == 0) {
		@<����� ������� ���������� ��������@>@;
		@<��������� ������� ������@>@;
		@<������� ���� ����������@>@;
	} else {
		@<����� ������������� ������@>@;
	}
	@<������� �������� ������@>@;
	@<���������� ������ ������� ���������@>@;
	@<���������� ������ ������@>@;
	@<���������� ������ ��������@>@;
	return(not_resolved);
}

@ ����� �������� ��������������� ���������� �����.
@<���������� ����������@>=
static int cur_input;
static int num_start_addresses;

@ @<������ ���������@>=
FILE *fobj, *fresult;
char ovrname[200];

@ @<������� ��������� ����@>=
	fobj = fopen(objname,"r");
	if (fobj== NULL) {
		PRINTERR("Can't open %s\n", objname);
		return(ERR_CANTOPEN);
	}
@ @<����� ������������� ������@>=
	if (!simpleRefIsEmpty()) {
		printf("Unresolved simple refs:\n");
		for (i = SRefList.pool[0].link; i != 0; i = SRefList.pool[i].link) {
			fromRadix50(SRefList.pool[i].name[0], name);
			fromRadix50(SRefList.pool[i].name[1], name + 3);
			fromRadix50(SectDir[SRefList.pool[i].sect].name[0], sect_name);
			fromRadix50(SectDir[SRefList.pool[i].sect].name[1], sect_name + 3);
			printf("i: %4d, name: %s, disp: %s/%o, file: %s\n", i, name, sect_name,
				SRefList.pool[i].disp, config.objnames[SRefList.pool[i].obj_file]);
		}
	}
	if (!complexRefIsEmpty()) {
		printf("Unresolved complex refs:\n");
		for (i = CExprList.pool[0].link; i != 0; i = CExprList.pool[i].link) {
			for (j = 0; j < CExprList.pool[i].NumTerms; ++j) {
				if (CExprList.pool[i].terms[j].code ==
					CREL_OP_FETCH_GLOBAL) {
					fromRadix50(CExprList.pool[i].terms[j].un.name[0], name);
					fromRadix50(CExprList.pool[i].terms[j].un.name[1],
						name + 3);
					printf("i: %4d, j: %2d, name: %s, file:"
						" %s\n", i, j, name,
						config.objnames[CExprList.pool[i].obj_file]);
				}
			}
		}
	}

@ �� ��������� � ��������� ������ ����� ��������� ���� � ����������� �������,
��� ������� ������ ����� �������. ��������� ������ ��������� ����� �����������
������ � �������������� ����� (�������). ���������� ���������� ������ �
��������� \verbatim!SAV!~---~����� ������ ������������ � ����������� ����.
@<������� ���� ����������@>=
	for (i = 0; i < NumSections; ++i) {
		if (SectDir[i].len != 0 && SectDir[i].min_addr != -1 &&
		    SectDir[i].transfer_addr == 1 &&
		    !(SectDir[i].flags & PSECT_SAVE_MASK)) {
			fromRadix50(SectDir[i].name[0], sect_name);
			fromRadix50(SectDir[i].name[1], sect_name + 3);
			/* ������� */
			for (j = 5; j >= 0; --j) {
				if (sect_name[j] != ' ') {
					sect_name[j + 1] = 0;
					break;
				}
			}
			strncpy(ovrname, config.output_filename,
				config.max_filename_len - strlen(sect_name) - 3);
			ovrname[config.max_filename_len - strlen(sect_name) - 3] = '\0';
			strcat(ovrname, "-"); strcat(ovrname, sect_name); strcat(ovrname, ".v");
			fresult = fopen(ovrname, "w");
			if (fresult == NULL) {
				PRINTERR("Can't create %s\n", ovrname);
				return(ERR_CANTCREATE);
			}
			fwrite(SectDir[i].text + SectDir[i].min_addr, 
				SectDir[i].len - SectDir[i].min_addr, 1, fresult);
			fclose(fresult);
			continue;
		}
		if (SectDir[i].transfer_addr != 1 && SectDir[i].len != 0) {
			/* �������� ���� */
			fresult = fopen(config.output_filename, "w");
			if (fresult == NULL) {
				PRINTERR("Can't create %s\n", config.output_filename);
				return(ERR_CANTCREATE);
			}
			fwrite(SectDir[i].text + SectDir[i].min_addr, 
				SectDir[i].len - SectDir[i].min_addr, 1, fresult);
			fclose(fresult);
			continue;
		}
	}
	/* ���������� � ������� ������ ������ � ������ SAVE */
	for (i = 0; i < NumSections; ++i) {
		if (SectDir[i].flags & PSECT_SAVE_MASK) {
			fresult = fopen(config.output_filename, "a");
			if (fresult == NULL) {
				PRINTERR("Can't create %s\n", config.output_filename);
				return(ERR_CANTCREATE);
			}
			fwrite(SectDir[i].text + SectDir[i].min_addr, 
				SectDir[i].len - SectDir[i].min_addr, 1, fresult);
			fclose(fresult);
		}
	}

@* ��������� ���������� �����.

��������� ���������� �����.
��������� ���� ������� �� ������, ������� ���������� ����������
 |BinaryBlock|, ���������� ������ ������ |len - 4| � ����� 
����������� ����� (0 - ����� ���� ����).  ����� ������� ����� ���� ������������
���������� ������� ����.
@ @<����������� ���� ������@>=
typedef struct _BinaryBlock {
	uint8_t	one;	/* must be 1 */
	uint8_t	zero;	/* must be 0 */
	uint16_t len; /* length of block */
} BinaryBlock;


@ ���������� ���� ��������� ����.
@c
static void
handleOneFile(FILE *fobj) {
	BinaryBlock obj_header;
	int first_byte, i;
	int crc;
	unsigned int block_len;
	char name[7];
	
	@<�������� ������������� ������@>@;
	while (!feof(fobj)) {
		/* ���� ������ ����� */
		do {
			first_byte = fgetc(fobj);
			if (first_byte == EOF) goto end;
		} while (first_byte != 1);

		/* ������ ��������� */
		ungetc(first_byte, fobj);
		if (fread(&obj_header, sizeof(BinaryBlock), 1, fobj) != 1) {
			PRINTERR("IO error while read header: %s\n",config.objnames[cur_input]);
			exit(EXIT_FAILURE);
		}
		if (obj_header.zero != 0) continue;
		block_len = obj_header.len - 4;
		PRINTVERB(2, "Binary block found. Length:%o\n", block_len);

		if (obj_header.len == 0) {
			PRINTERR("Block len = 0: %s\n",config.objnames[cur_input]);
			exit(EXIT_FAILURE);
		}

		/* ������ ���� ����� � ����������� ������ */
		if (fread(block_body, block_len + 1, 1, fobj) != 1) {
			PRINTERR("IO error while read block: %s\n", config.objnames[cur_input]);
			exit(EXIT_FAILURE);
		}@/
		/* ������� ����������� ����� */@/
		crc = - obj_header.one - obj_header.zero - obj_header.len % 256
			- obj_header.len / 256;
		for (i = 0; (uint16_t)i < block_len; ++i) {
			crc -= block_body[i];
		}
		crc &= 0xff;	
		if (crc != block_body[block_len]) {
			PRINTERR("Bad block checksum: %s\n", config.objnames[cur_input]);
			exit(EXIT_FAILURE);
		}
		@<���������� ����@>@;
	}
end:;
}

@ ������ ��� ���� �����. 
@<����������...@>=
static uint8_t block_body[65536 + 1];

@ ��������� ������ ��������� �����. �� ������� ����� ����� �������� ��� ���.
@<���������� ����@>=
	PRINTVERB(2, "  Block type: %o, ", block_body[0]);
	switch (block_body[0]) {
		case 1 :
			PRINTVERB(2, "GSD\n");
			@<��������� GSD@>@;
			break;
		case 2 :
			PRINTVERB(2, "ENDGSD\n");
			@<������� ������������� ������@>@;
			break;
		case 3 :
			PRINTVERB(2, "TXT\n");
			@<���������� ������ TXT@>@;
			break;
		case 4 :
			PRINTVERB(2, "RLD\n");
			@<���������� ������ �����������@>@;
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

 ������ ����� GSD~---~Global Symbol Directory (������� ���������� ��������). ��
�������� ��� ����������, ����������� ���������� ��� ������������ �������
���������� �������� � ��������� ������.
������� ������� �� 8-�� �������� ������� ��������� �����:
@d GSD_MODULE_NAME			0
@d GSD_CSECT_NAME			1
@d GSD_INTERNAL_SYMBOL_NAME 2
@d GSD_TRANFER_ADDRESS		3
@d GSD_GLOBAL_SYMBOL_NAME	4
@d GSD_PSECT_NAME			5
@d GDS_IDENT				6
@d GSD_MAPPED_ARRAY			7
@<��������� GSD@>=
	handleGSD(block_len);
@ @<����������� ����...@>=
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
		@<����������� ���@>@;
		PRINTVERB(2, "    Entry name: '%s', type: %o --- ", name, entry->type);
		switch (entry->type) {
			case GSD_MODULE_NAME: 
				/* ������ ��� ������. */
				PRINTVERB(2, "ModuleName.\n");
				PRINTVERB(1, "Module:%s\n", name);
				break;
			case GSD_CSECT_NAME:
				/* ��� ����������� ������ */
				PRINTVERB(2, "CSectName, flags:%o, length:%o.\n",
						entry->flags, entry->value);
				break;
			case GSD_INTERNAL_SYMBOL_NAME:
				/* ��� ����������� ������� */
				PRINTVERB(2, "InternalSymbolName\n");
				break;
			case GSD_TRANFER_ADDRESS:
				/* ����� ������� ��������� */
				PRINTVERB(2, "TransferAddress, offset:%o.\n", entry->value);
				@<���������� ����� �������@>@;
				break;
			case GSD_GLOBAL_SYMBOL_NAME:
				/* �����������/������ �� ���������� ����� */
				PRINTVERB(2, "GlobalSymbolName, flags:%o, value:%o.\n",
						entry->flags, entry->value);
				@<���������� ���������� ������� � ������@>@;		
				break;		
			case GSD_PSECT_NAME:
				/* ��� ����������� ������ */
				PRINTVERB(2, "PSectName, flags:%o, max length:%o.\n",
						entry->flags, entry->value);
				@<���������� ����������� ������@>@;
				break;
			case GDS_IDENT:
				/* ������ ������ */
				PRINTVERB(2, "Ident.\n");
				PRINTVERB(1, "  Ident: %s\n", name);
				break;
			case GSD_MAPPED_ARRAY:
				/* ������ */
				PRINTVERB(2, "MappedArray, length:%o.\n", entry->value);
				break;
			default:
			  PRINTERR("Bad entry type: %o : %s\n", 
				entry->type, config.objnames[cur_input]);
		}
	}
}

@ @<����������� ���@>=
	fromRadix50(entry->name[0], name);
	fromRadix50(entry->name[1], name + 3);

@ ������ �����������/������ �� ���������� ������.
@ ������� ���������� ��������. |addr| �������� ��� ��������� ����� ������������
0.
@d MAX_GLOBALS 1024
@<����������� ���� ������...@>=
typedef struct _GSymDefEntry {
	uint16_t name[2];	
	uint8_t	flags;
	uint8_t	 sect; /* ����� ������, � ������� ��������� ���������� ������ */
	uint16_t addr; /* ����� ������� � ������ */
	uint8_t	obj_file; /* ����, ��� ��������� ������ */
} GSymDefEntry;
 

@ @<���������� ����������...@>=
static GSymDefEntry GSymDef[MAX_GLOBALS];
static int NumGlobalDefs;

@ @<������������� ������� ���������� ��������@>=
	NumGlobalDefs = 0;

@
@d GLOBAL_WEAK_MASK	  001 // 00000001b
@d GLOBAL_DEFINITION_MASK 010 // 00001000b
@d GLOBAL_RELOCATION_MASK 040 // 00100000b
@c
static void
handleGlobalSymbol(GSD_Entry *entry) {
	char name[7];
	int found_sym;

	if (entry->flags & GLOBAL_DEFINITION_MASK) {
		/* ��������� ����������� ����������� ������� */
		if ((found_sym = findGlobalSym(entry->name)) != -1) {
			fromRadix50(entry->name[0], name);
			fromRadix50(entry->name[1], name + 3);
			PRINTERR("Global definition conflict: %s in %s"
				" conflicts with %s.\n", name,
				config.objnames[cur_input],
				config.objnames[GSymDef[found_sym].obj_file]);
			exit(EXIT_FAILURE);
		}
		GSymDef[NumGlobalDefs].name[0] = entry->name[0];
		GSymDef[NumGlobalDefs].name[1] = entry->name[1];
		GSymDef[NumGlobalDefs].flags = entry->flags;
		GSymDef[NumGlobalDefs].sect = CurSect;
		GSymDef[NumGlobalDefs].addr = SectDir[CurSect].start + entry->value;
		GSymDef[NumGlobalDefs].obj_file = cur_input;
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

@ ����� ������ � �������. -1~---~������ �� ������.
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

@ @<���������� ����������...@>=
static int findGlobalSym(uint16_t *);

@ @<������ ���������...@>=
	char name[7];
@ @<����� ������� ���������� ��������@>=
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
@ ������ ����������� ������. ������ � ������� �������� � �������� ������.
@d MAX_PROG_SECTIONS 254
@<����������� ����...@>=
typedef struct _SectionDirEntry {
	uint16_t name[2];	// ��� � Radix50
	uint8_t	 flags;	// ����� ������
	uint16_t start;		// �������� ������ ��� �������� ������
	int32_t min_addr;  // ����������� �����, � �������� ����������� ������
	uint16_t len;	// ����� ������
	uint16_t transfer_addr; // ����� ������ (1 --- ������ �� ���������)
	uint16_t last_load_addr; // ����� ���������� ������������ ����� TEXT
	uint8_t *text;	// ����� ����� ������ ��� ������ ������
} SectionDirEntry;
@ @<���������� ����������...@>=
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
	char name[7];
	@<������� ���������� ���������� �� �������@>@;
	CurSect = findSection(entry->name);
	if (CurSect == -1) {
		@<�������� ����������� ������@>@;
	} else {
		/* ��������� �� ���������� �� ����� ������ */
		if (SectDir[CurSect].flags != entry->flags) {
			fromRadix50(SectDir[CurSect].name[0], name);
			fromRadix50(SectDir[CurSect].name[1], name + 3);
			PRINTERR("Section %s flags conflict. Old flags: %x, new"
			" flags: %x. File: %s\n", name, SectDir[CurSect].flags,
			entry->flags, config.objnames[cur_input]);
			exit(EXIT_FAILURE);
		}
		/* �������� �������� ������ � ������ */
		SectDir[CurSect].start = SectDir[CurSect].len;
		SectDir[CurSect].len += entry->value;
	}
	@<�������� ������������� ������@>@;
}

@ @<���������� ����������...@>=
static int CurSect;

@ ������������� ������� ������.
@<��������� ������� ������ � �������@>=
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

@ ����� �������, ������ ������� ������������.
@<���������� ����� �������@>=
	sect = findSection(entry->name);
	SectDir[sect].transfer_addr = entry->value;
	if (entry->value != 1) ++num_start_addresses;

@ ���������� ������ |TEXT|. ���������� ����������� � ������� ������
|CurSect|. ��������� ������ |TEXT| ����� ��������� ���� �� ������, � ���� �
��������� �� ��� ����������� ������ ��������� �������, �� ���������� �����, �
�������� ���� ��������� ��������� ������ |TEXT|.
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
@<������������� �������� ������@>=
	NumSections = 0;
	memset(SectDir, 0, sizeof(SectDir));

@ @<������ ���������...@>=
	char sect_name[7];
@ @<������� �������� ������@>=
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
	
@ ����� ����������� ������ �� �����.
@c
static int
findSection(uint16_t *name) {
	int found, i;

	found = -1;
	for (i = 0; i < NumSections; ++i) {
		if (SectDir[i].name[0] == name[0] && 
		    SectDir[i].name[1] == name[1]) {
			found = i;
			break;
		}
	}

	return(found);
}
@  ������ ���������� ��� ��� ������, ���� ��, ������� ����� ������� �����.
@d DEFAULT_SECTION_LEN 65536
@<�������� ����������� ������@>=
	SectDir[NumSections].name[0] = entry->name[0];
	SectDir[NumSections].name[1] = entry->name[1];
	SectDir[NumSections].flags = entry->flags;
	SectDir[NumSections].len = entry->value;
	/* ���� ������ ��� ������� ������������� �� �����, �� �������� ����� */
	if (!(entry->flags & PSECT_TYPE_MASK)) {
		if(SectDir[NumSections].len & 1)
			++SectDir[NumSections].len;
	}
	SectDir[NumSections].min_addr = -1;
	SectDir[NumSections].transfer_addr = 1;
	SectDir[NumSections].text = (uint8_t*)calloc(1, DEFAULT_SECTION_LEN);
	CurSect = NumSections;
	++NumSections;

@ @<���������� ���������...@>=
static int findSection(uint16_t *);


@ @<������� ���������� ���������� �� �������@>=
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

@* ������ ������ �� ���������� �������.

 ���� ��� ���� ������ �� ���������� �������: ��� ���������� ���������, �
����������� ��������� � ������� ������. ������ ��� ���� ����� �������������
(���� � ������) ������, � ������~---~������������ ������.

������� ���������, ������� ��������� �� ������� ����������� ��� ���������
������, � ���������� �������� ������ � ��������� � �������.

@ ��������� �������� ������ ��� �������� ������.
@d INITIAL_SIMPLE_REF_LIST_SIZE 100
@<����������� ���� ������...@>=
typedef struct _SimpleRefEntry {
	uint16_t link; /* ���� ����� */
	uint8_t	type;
	uint8_t	sect;	/* ����� ������ */
	uint16_t	disp;	/* �������� � ������ ��� ����������� ����� ����� ������ */
	uint16_t	constant;
	uint16_t name[2];
	uint8_t	obj_file;	/* ����� �������� ����� */
} SimpleRefEntry;
typedef struct _SimpleRefList {
	uint16_t avail;	/* ������ ������ ��������� ������ */
	uint16_t poolmin;	/* ����� �������� --- ������ ������� ���� */
	SimpleRefEntry *pool;	/* ������ ��� �������� ������ */
	int	num_allocations; /* ������� ��������� ������ ��� �������� ����������
	����*/
} SimpleRefList;

@ @<���������� ����������...@>=
static SimpleRefList SRefList;
static int simpleRefIsEmpty(void);
@ 
@c
static int
simpleRefIsEmpty(void) {
	return(SRefList.pool[0].link == 0);
}

@ ��������� ����� ������ � ������
@c
static void
addSimpleRef(RLD_Entry *ref) {@/
	SimpleRefEntry *new_entry;
	SimpleRefEntry *new_memory;
	uint16_t new_index;

	/* ���� �� ������� ���������� ������� ���� */
	if (SRefList.poolmin == INITIAL_SIMPLE_REF_LIST_SIZE *
			SRefList.num_allocations) {
		++SRefList.num_allocations;	
		new_memory = (SimpleRefEntry*)realloc(SRefList.pool, 
		sizeof(SimpleRefEntry) * INITIAL_SIMPLE_REF_LIST_SIZE *
			SRefList.num_allocations);
		if (new_memory == NULL) {	
			PRINTERR("No memory for simple ref list");
			abort();
		}	
		PRINTVERB(2, "Done SRefList allocation:%d\n", SRefList.num_allocations);
		SRefList.pool = new_memory;
	}
	/* ���� ���� ��������� ����� */
	if (SRefList.avail != 0) {
		new_index = SRefList.avail;
		SRefList.avail = SRefList.pool[SRefList.avail].link;
	} else {
	/* ��������� ������ ���, ���������� ��� */
		new_index = SRefList.poolmin;
		++SRefList.poolmin;
	}
	new_entry = SRefList.pool + new_index;
	new_entry->link = SRefList.pool[0].link;
	SRefList.pool[0].link = new_index;

	/* ���������� ������ ������ */
	new_entry->obj_file = cur_input;
	new_entry->name[0] = ref->value[0];
	new_entry->name[1] = ref->value[1];
	new_entry->disp = ref->disp - 4 + SectDir[CurSect].last_load_addr;
	new_entry->sect = CurSect;
	new_entry->type = ref->cmd.type;
	if (new_entry->type == RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION ||
		new_entry->type == RLD_CMD_GLOBAL_ADDITIVE_RELOCATION) {
		new_entry->constant = ((RLD_Const_Entry*)ref)->constant;
	}
}

@ ������� ������ �� ������. ���������� ���� ����� ��������� ��������. ������
���������� �������: �������� ��� �������� � ���� ����� ����������� ��������.
@c
static uint16_t 
delSimpleRef(uint16_t ref_i) {
	uint16_t link;

	link = SRefList.pool[ref_i].link;
	SRefList.pool[ref_i].link = SRefList.avail;
	SRefList.avail = ref_i;
	
	return(link);
}

@ |poolmin| ������������� ������ 1, ��� ��� ��� ������ ������� �������� ������
������� ������� ���� �� ������������, � ��� ����� ��������� ���-�� ����� NULL.
@<������������� ������ ������ ��� ��������...@>=
	SRefList.pool = (SimpleRefEntry *)malloc(sizeof(SimpleRefEntry) *
		INITIAL_SIMPLE_REF_LIST_SIZE);
	SRefList.num_allocations = 1;	
	SRefList.pool[0].link = 0;	
	SRefList.avail = 0;
	SRefList.poolmin = 1;

@ @<���������� ������ ������...@>=
	if (config.verbosity >= 2) {
		PRINTVERB(2, "=Simple Refs:\n avail: %d, poolmin: %d\n",
		 SRefList.avail, SRefList.poolmin);
		for (i = SRefList.pool[0].link; i != 0; i = SRefList.pool[i].link) {
			fromRadix50(SRefList.pool[i].name[0], name);
			fromRadix50(SRefList.pool[i].name[1], name + 3);
			fromRadix50(SectDir[SRefList.pool[i].sect].name[0], sect_name);
			fromRadix50(SectDir[SRefList.pool[i].sect].name[1], sect_name + 3);
			PRINTVERB(2, "i: %4d, name: %s, disp: %s/%o, file: %s\n", i, name, sect_name,
			SRefList.pool[i].disp, config.objnames[SRefList.pool[i].obj_file]);
		}
	}
	free(SRefList.pool);

@ @<���������� ����������...@>=
static void addSimpleRef(RLD_Entry *);
static uint16_t delSimpleRef(uint16_t);

@* ���������� ������ �� ���������� �������.

 ��������� ��������� ������ ������ �� ���������� ������� � ������� ��� �� ���
����������� ��������� ������. ���������� 0, ���� ������������� ������ ���.
@c
static int
resolveGlobals(void) {
	uint16_t ref, prev_ref, *dest_addr;
	int global;

	prev_ref = 0;@/
	if (!simpleRefIsEmpty()) {@/
		for (ref = SRefList.pool[0].link; ref != 0; prev_ref = ref, ref = SRefList.pool[ref].link) {
			global = findGlobalSym(SRefList.pool[ref].name);
			if (global == -1) {
				continue;
			}
			if (SRefList.pool[ref].type ==
			RLD_CMD_GLOBAL_RELOCATION) {@/
				/* ������ ������ */
				@<��������� ������ ������@>@;@/
				/* ��� �������� |ref| ����� ��������� �� ��� ����� */
				SRefList.pool[prev_ref].link = delSimpleRef(ref);
				ref = prev_ref;
				continue;
			}
			if (SRefList.pool[ref].type ==
			RLD_CMD_GLOBAL_DISPLACED_RELOCATION) {@/
				/* ��������� ������ */
				@<��������� ��������� ������@>@;@/
				SRefList.pool[prev_ref].link =
					delSimpleRef(ref);@/
				/* ��� �������� |ref| ����� ��������� �� ��� ����� */
				ref = prev_ref;
				continue;
			}
			if (SRefList.pool[ref].type ==
			RLD_CMD_GLOBAL_ADDITIVE_RELOCATION) {@/
				/* ������ ������ �� ��������� */
				@<��������� ��������� ������ ������@>@;@/
				SRefList.pool[prev_ref].link =
					delSimpleRef(ref);@/
				/* ��� �������� |ref| ����� ��������� �� ��� ����� */
				ref = prev_ref;
				continue;
			}
			if (SRefList.pool[ref].type ==
			RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION) {@/
				/* ��������� ������ �� ��������� */
				@<��������� ��������� ��������� ������@>@;@/
				SRefList.pool[prev_ref].link =
					delSimpleRef(ref);@/
				/* ��� �������� |ref| ����� ��������� �� ��� ����� */
				ref = prev_ref;
				continue;
			}
		}
	}
	return (!simpleRefIsEmpty());
}

@ ��� ���������� ������ ������ ���������� ����� ������ ���� ��������.
@<��������� ������ ������@>=
	dest_addr =
	(uint16_t*)(SectDir[SRefList.pool[ref].sect].text + SRefList.pool[ref].disp);
	*dest_addr = GSymDef[global].addr;

@ ��� ���������� ������ ������ �� �������� ���������� ����� ������ + ��������� �
���� ��������.
@<��������� ��������� ������ ������@>=
	dest_addr =
	(uint16_t*)(SectDir[SRefList.pool[ref].sect].text + SRefList.pool[ref].disp);
	*dest_addr = GSymDef[global].addr +
					SRefList.pool[ref].constant;

@ ��� ���������� ��������� ������ ���������� �������� �� ���� �������� � ����
��������.
@<��������� ��������� ������@>=
	dest_addr =
	(uint16_t*)(SectDir[SRefList.pool[ref].sect].text + SRefList.pool[ref].disp);
	*dest_addr = GSymDef[global].addr - (SRefList.pool[ref].disp + 2);

@ ��� ���������� ��������� ������ �� ��������� ���������� �������� �� ����
�������� + ��������� � ����
��������.
@<��������� ��������� ��������� ������@>=
	dest_addr =
	(uint16_t*)(SectDir[SRefList.pool[ref].sect].text + SRefList.pool[ref].disp);
	*dest_addr = GSymDef[global].addr - (SRefList.pool[ref].disp + 2) +
					SRefList.pool[ref].constant;
@ @<���������� ����������...@>=
static int resolveGlobals(void);

@* ��������� �������� (|.LIMIT|) ��� ������.

��������� �������� ������ ��� �������� ������ �� �������.
@d INITIAL_LIMIT_LIST_SIZE 5
@<����������� ���� ������...@>=
typedef struct _LimListEntry {
	uint16_t link; /* ���� ����� */
	uint8_t	sect;	/* ����� ������ */
	uint16_t	disp;	/* �������� � ������ ��� ����������� ����� ����� ������ */
} LimListEntry;
typedef struct _LimList {
	LimListEntry *pool;	/* ������ ��� �������� ������ */
	int num_limits;
	int	num_allocations; /* ������� ��������� ������ ��� �������� ����������
	����*/
} LimList;

@ @<���������� ����������...@>=
static LimList LimitList;
static void addLimit(RLD_Entry *);
static void resolveLimit(void);

@ ��������� ����� ������ �� ������ � ������
@c
static void
addLimit(RLD_Entry *ref) {@/
	LimListEntry *new_entry;
	LimListEntry *new_memory;

	/* ���� �� ������� ���������� ������� ���� */
	if (LimitList.num_limits == INITIAL_LIMIT_LIST_SIZE *
			LimitList.num_allocations) {
		++LimitList.num_allocations;	
		new_memory = (LimListEntry*)realloc(LimitList.pool, sizeof(LimListEntry)
		* INITIAL_LIMIT_LIST_SIZE *
			LimitList.num_allocations);
		if (new_memory == NULL) {	
			PRINTERR("No memory for limit list");
			abort();
		}	
		PRINTVERB(2, "Done LimitList allocation:%d\n", LimitList.num_allocations);
		LimitList.pool = new_memory;
	}
	new_entry = LimitList.pool + LimitList.num_limits;
	/* ���������� ������ ������ */
	new_entry->disp = ref->disp - 4 + SectDir[CurSect].last_load_addr;
	new_entry->sect = CurSect;
	++LimitList.num_limits;
}

@ @<������������� ������ ��������...@>=
	LimitList.pool = (LimListEntry *)malloc(sizeof(LimListEntry) *
		INITIAL_LIMIT_LIST_SIZE);
	LimitList.num_allocations = 1;	
	LimitList.num_limits = 0;

@ @<���������� ������ ��������...@>=
	if (config.verbosity >= 2) {
		PRINTVERB(2, "=Limit Refs:\n num_limits: %d\n",
		 LimitList.num_limits);
		for (i = 0; i < LimitList.num_limits; ++i) {
			fromRadix50(SectDir[LimitList.pool[i].sect].name[0], sect_name);
			fromRadix50(SectDir[LimitList.pool[i].sect].name[1], sect_name + 3);
			PRINTVERB(2, "i: %4d, disp: %s/%o\n", i, sect_name,
			LimitList.pool[i].disp);
		}
	}
	free(LimitList.pool);
@
@<��������� ������� ������@>=
	resolveLimit();
@ @c	
static void 
resolveLimit(void) {
	int i;
	uint16_t *dest_dir;

	for(i = 0; i < LimitList.num_limits; ++i) {
		dest_dir = (uint16_t*)(SectDir[LimitList.pool[i].sect].text +
			LimitList.pool[i].disp);
		dest_dir[0] = SectDir[LimitList.pool[i].sect].min_addr;
		dest_dir[1] = SectDir[LimitList.pool[i].sect].len;
	}
}

@* �������� �����������.

 ����� ��������� ����������� �������� ����������, ������� ����� ���������� ���
������������� ������ � ���������� ����� |TEXT|. ������ ������ ������ ����� ����
�� ���� ���� RLD, ������� ���������� ������� ���� ������ |TEXT|, ���
������~---~������� ������� PSECT � �� ����������.

������� ����������� ������� �� �������:
@ @<����������� ����...@>=
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

@ ���� |cmd.type| ��������� �� ��� ������. 
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
	uint16_t *value, *dest_addr;
	int RLD_i, sect;

	for (RLD_i = 2; RLD_i < len; ) {
		entry = (RLD_Entry*)(block + RLD_i);
		PRINTVERB(2, "    cmd: %o --- ", entry->cmd.type);
		switch (entry->cmd.type) {
			case RLD_CMD_INTERNAL_RELOCATION:
				PRINTVERB(2, "Internal Relocation.\n");
				@<������ ������ �� ���������� �����@>@;
				break;
			case RLD_CMD_GLOBAL_RELOCATION:
				PRINTVERB(2, "Global Relocation.\n");
				@<������ ������ �� ���������� ������@>@;
				break;
			case RLD_CMD_INTERNAL_DISPLACED_RELOCATION:
				PRINTVERB(2, "Internal Displaced Relocation.\n");
				@<��������� ������ �� ���������� �����@>@;
				break;
			case RLD_CMD_GLOBAL_DISPLACED_RELOCATION:
				PRINTVERB(2, "Global Displaced Relocation.\n");
				@<��������� ������ �� ���������� ������@>@;
				break;
			case RLD_CMD_GLOBAL_ADDITIVE_RELOCATION:
				PRINTVERB(2, "Global Additive Relocation.\n");
				@<������ ������ �� ��������� ���������� ������@>@;
				break;
			case RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION:
				PRINTVERB(2, "Global Additive Displaced Relocation.\n");
				@<��������� ������ �� ��������� ����������
				  ������@>@;
				break;
			case RLD_CMD_LOCATION_COUNTER_DEFINITION:
				PRINTVERB(2, "Location Counter Definition.\n");
				@<��������� ������� ������ � �������@>@;
				break;
			case RLD_CMD_LOCATION_COUNTER_MODIFICATION:
				PRINTVERB(2, "Location Counter Modification.\n");
				@<��������� ������� �������@>@;
				break;
			case RLD_CMD_PROGRAM_LIMITS:
				PRINTVERB(2, "Program Limits.\n");
				@<��������� ��������@>@;
				break;
			case RLD_CMD_PSECT_RELOCATION:
				PRINTVERB(2, "PSect Relocation.\n");
				@<������ ������ �� ������@>@;
				break;
			case RLD_CMD_PSECT_DISPLACED_RELOCATION:
				PRINTVERB(2, "PSect Displaced Relocation.\n");
				@<��������� ������ �� ������@>@;
				break;
			case RLD_CMD_PSECT_ADDITIVE_RELOCATION:
				PRINTVERB(2, "PSect Additive Relocation.\n");
				@<������ ��������� ������ �� ������@>@;
				break;
			case RLD_CMD_PSECT_ADDITIVE_DISPLACED_RELOCATION:
				PRINTVERB(2, "PSect Additive Displaced Relocation.\n");
				@<��������� ��������� ������ �� ������@>@;
				break;
			case RLD_CMD_COMPLEX_RELOCATION:
				PRINTVERB(2, "Complex Relocation.\n");
				@<������� ������@>@;
				break;
			default :
				PRINTERR("Bad RLD entry type: %o : %s\n", 
					entry->cmd.type, config.objnames[cur_input]);
				return;	
		}
	}
}

@ 
@<������ ������ �� ���������� �����@>=
	PRINTVERB(2, "      Disp: %o, +Const: %o.\n", entry->disp, entry->value[0]);
	dest_addr = (uint16_t*)(SectDir[CurSect].text +
		SectDir[CurSect].last_load_addr + entry->disp - 4);
	*dest_addr = SectDir[CurSect].start + entry->value[0];	
	RLD_i += 4;
@ 
@<��������� ������ �� ���������� �����@>=
	PRINTVERB(2, "      Disp: %o, +Const: %o.\n", entry->disp, entry->value[0]);
	dest_addr = (uint16_t*)(SectDir[CurSect].text +
		SectDir[CurSect].last_load_addr + entry->disp - 4);
	*dest_addr = entry->value[0] - SectDir[CurSect].last_load_addr -
		entry->disp + 4 - 2;	
	RLD_i += 4;
@ 
@<������ ������ �� ���������� ������@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	addSimpleRef(entry);
	RLD_i += 6;
@ 
@<��������� ������ �� ���������� ������@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	addSimpleRef(entry);
	RLD_i += 6;

@ 
@<������ ������ �� ��������� ���������� ������@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s, +Const: %o.\n", entry->disp, gname,
		const_entry->constant);
	addSimpleRef(entry);	
	RLD_i += 8;

@ 
@<��������� ������ �� ��������� ���������� ������@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s, +Const: %o.\n", entry->disp, gname,
		const_entry->constant);
	addSimpleRef(entry);	
	RLD_i += 8;

@ �� ������������.
@<��������� ������� �������@>=
	PRINTVERB(2, "      +Const: %o.\n", entry->value[0]);
	RLD_i += 4;

@ 
@<��������� ��������@>=
	PRINTVERB(2, "      Disp: %o.\n", entry->disp);
	addLimit(entry);
	RLD_i += 2;

@ 
@<������ ������ �� ������@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	sect = findSection(entry->value);
	dest_addr = (uint16_t*)(SectDir[CurSect].text +
		SectDir[CurSect].last_load_addr + entry->disp - 4);
	*dest_addr = SectDir[sect].start;	
	RLD_i += 6;

@ 
@<��������� ������ �� ������@>=
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Disp: %o, Name: %s.\n", entry->disp, gname);
	sect = findSection(entry->value);
	dest_addr = (uint16_t*)(SectDir[CurSect].text +
		SectDir[CurSect].last_load_addr + entry->disp - 4);
	*dest_addr = SectDir[sect].start - SectDir[CurSect].last_load_addr -
		entry->disp + 4 - 2;
	RLD_i += 6;

@ 
@<������ ��������� ������ �� ������@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Name: %s, +Const: %o.\n", gname,
		const_entry->constant);
	sect = findSection(entry->value);
	dest_addr = (uint16_t*)(SectDir[CurSect].text +
		SectDir[CurSect].last_load_addr + entry->disp - 4);
	*dest_addr = SectDir[sect].start + const_entry->constant;
	RLD_i += 8;

@ 
@<��������� ��������� ������ �� ������@>=
	const_entry = (RLD_Const_Entry *) entry;
	fromRadix50(entry->value[0], gname);
	fromRadix50(entry->value[1], gname + 3);
	PRINTVERB(2, "      Name: %s, +Const: %o.\n", gname,
		const_entry->constant);
	sect = findSection(entry->value);
	dest_addr = (uint16_t*)(SectDir[CurSect].text +
		SectDir[CurSect].last_load_addr + entry->disp - 4);
	*dest_addr = SectDir[sect].start - SectDir[CurSect].last_load_addr -
		entry->disp + 4 - 2 + const_entry->constant;
	RLD_i += 8;

@* ��������� ������� ������.

 ��� ������� ������ ����� ����� ������ ������ � ������� ������.
@<����������� ���� ������...@>=
typedef struct _CurSectEntry {
	uint16_t name[2];
	uint8_t	global_sect;
} CurSectEntry;

@ @<���������� ����������...@>=
static CurSectEntry curSections[MAX_PROG_SECTIONS];
static int NumCurSections;

@ @<�������� ������������� ������@>=
	NumCurSections = 0;
@ @<�������� ������������� ������@>=
	curSections[NumCurSections].name[0] = SectDir[CurSect].name[0];
	curSections[NumCurSections].name[1] = SectDir[CurSect].name[1];
	curSections[NumCurSections++].global_sect = CurSect;
@ @<������� ������������� ������@>=
	PRINTVERB(2, "=Sections recoding.\n");
	for (i = 0; i < NumCurSections; ++i) {
		fromRadix50(curSections[i].name[0], name);
		fromRadix50(curSections[i].name[1], name + 3);
		PRINTVERB(2, "sect: %3d, %s, global sect: %d\n", i, name,
			curSections[i].global_sect);
	}

@ ������ ������� ������. ������ ������ �������� ������� ������ ������ ��������
���������. ������������ ���������� ������ � ��������� ���������� ��������
������������
MACRO-11\footnote{$^5$}{AA-KX10A-TC\_PDP-11\_MACRO-11\_Reference\_Manual\_May88}.
@d MAX_COMPLEX_TERMS 20
@<����������� ���� ������...@>=
typedef struct _ComplexTerm {
	uint8_t code;
	union {
		uint16_t name[2];
		struct {
			uint8_t sect;
			uint16_t disp;
		} inter;
		uint16_t constant;
	} un;
} ComplexTerm;

typedef struct _ComplexExprEntry {
	uint16_t link;		/* ���� ����� */
	uint16_t disp;
	uint8_t sect;
	uint8_t obj_file;
	uint8_t	result_type;
	uint8_t NumTerms;	/* ���������� ������ � ��������� */
	ComplexTerm terms[MAX_COMPLEX_TERMS]; 
} ComplexExprEntry;

typedef struct _ComplexExpressionList {
	uint16_t avail;
	uint16_t poolmin;
	uint16_t num_allocations; 
	ComplexExprEntry *pool;
} ComplexExpressionList;

@ @<���������� ����������...@>=
static ComplexExpressionList CExprList;
static int complexRefIsEmpty(void);
static void addComplexExpr(RLD_Entry *);
static uint16_t delComplexExpr(uint16_t);
@ 
@d INITIAL_COMPLEX_EXPR_LIST_SIZE 10
@c
static int
complexRefIsEmpty(void) {
	return(CExprList.pool[0].link == 0);
}

@ @<������������� ������ ������� ���������...@>=
	CExprList.pool = (ComplexExprEntry *)malloc(sizeof(ComplexExprEntry) *
		INITIAL_COMPLEX_EXPR_LIST_SIZE);
	CExprList.num_allocations = 1;	
	CExprList.pool[0].link = 0;	
	CExprList.avail = 0;
	CExprList.poolmin = 1;

@ @<���������� ������ ������� ���������...@>=
	if (config.verbosity >= 2) {
		PRINTVERB(2, "=Complex Refs:\n avail: %d, poolmin: %d\n",
		 CExprList.avail, CExprList.poolmin);
		for (i = CExprList.pool[0].link; i != 0; i = CExprList.pool[i].link) {
			fromRadix50(SectDir[CExprList.pool[i].sect].name[0], sect_name);
			fromRadix50(SectDir[CExprList.pool[i].sect].name[1], sect_name + 3);
			PRINTVERB(2, "i: %4d, disp: %s/%o, file: %s\n", i, sect_name,
			CExprList.pool[i].disp, config.objnames[CExprList.pool[i].obj_file]);
		}
	}
	free(CExprList.pool);

@ ��������� ����� ������� ��������� � ������
@c
static void
addComplexExpr(RLD_Entry *ref) {@/
	ComplexExprEntry *new_entry;
	ComplexExprEntry *new_memory;
	uint16_t new_index;

	/* ���� �� ������� ���������� ������� ���� */
	if (CExprList.poolmin == INITIAL_SIMPLE_REF_LIST_SIZE *
			CExprList.num_allocations) {
		++CExprList.num_allocations;	
		new_memory = (ComplexExprEntry*)realloc(CExprList.pool, 
		sizeof(ComplexExprEntry) * INITIAL_SIMPLE_REF_LIST_SIZE *
			CExprList.num_allocations);
		if (new_memory == NULL) {	
			PRINTERR("No memory for complex ref list");
			abort();
		}	
		PRINTVERB(2, "Done CExprList allocation:%d\n", CExprList.num_allocations);
		CExprList.pool = new_memory;
	}
	/* ���� ���� ��������� ����� */
	if (CExprList.avail != 0) {
		new_index = CExprList.avail;
		CExprList.avail = CExprList.pool[CExprList.avail].link;
	} else {
	/* ��������� ������ ���, ���������� ��� */
		new_index = CExprList.poolmin;
		++CExprList.poolmin;
	}
	new_entry = CExprList.pool + new_index;
	new_entry->link = CExprList.pool[0].link;
	CExprList.pool[0].link = new_index;

	/* ���������� ������ ������ */
	new_entry->obj_file = cur_input;
	new_entry->disp = ref->disp - 4 + SectDir[CurSect].last_load_addr;
	new_entry->sect = CurSect;
	CurComplexExpr = new_index;
}
@ @<���������� ����������...@>=
static uint16_t CurComplexExpr;
static void addComplexTerm(uint8_t, uint16_t *, uint8_t, uint16_t, uint16_t);

@ ��������� ���� � ������� ������� ���������.
@c
static void 
addComplexTerm(uint8_t code, uint16_t *name, uint8_t sect, uint16_t disp,
uint16_t constant) {
	ComplexTerm *term;

	term = CExprList.pool[CurComplexExpr].terms +
		(CExprList.pool[CurComplexExpr].NumTerms++);
	term->code = code;
	switch (code) {
		case CREL_OP_FETCH_GLOBAL:
			term->un.name[0] = name[0];
			term->un.name[1] = name[1];
			break;
		case CREL_OP_FETCH_RELOCABLE:
			term->un.inter.sect = sect;
			term->un.inter.disp = disp;
			break;
		case CREL_OP_FETCH_CONSTANT:
			term->un.constant = constant;
		default:
			;
	}
}

@ ������� ������ �� ������. ���������� ���� ����� ��������� ��������. ������
���������� �������: �������� ��� �������� � ���� ����� ����������� ��������.
@c
static uint16_t 
delComplexExpr(uint16_t ref_i) {
	uint16_t link;

	link = CExprList.pool[ref_i].link;
	CExprList.pool[ref_i].link = CExprList.avail;
	CExprList.avail = ref_i;
	
	return(link);
}

@ ���������� ����������� ������. ������ �������� ������ �� ���������, �������
�������� ������������� ������. �������� �� ���� ��� �� ��������� ��������� ���
������ � ���������, �� ����� �������������� ���������, ������� ������, �������
������� ���������, �� ���������. � ��������� ��� ��� �� �������� ����������
������� �� �����.
@c
static int 
resolveComplex(void) {
	ComplexExprEntry *entry;
	int prev, i;
	uint16_t value, *dest_addr;

	prev = 0;
	for (i = CExprList.pool[0].link; i != 0; prev = i, i =
			CExprList.pool[i].link) {@/
		entry = CExprList.pool + i;@/
		/* �������� ��������� ��� ������ ������ ��������� */
		if (!resolveTerms(entry)) {@/
			/* ������� ��������� ��� ������ */
			value = calcTerms(entry);@/
			/* � ����������� �� ���� ���������� ��������� */
			if (entry->result_type == CREL_OP_STORE_RESULT) {@/
				/* ������ ��������� */
				dest_addr = (uint16_t*)(SectDir[entry->sect].text +
					+ entry->disp);@/
				*dest_addr = value;@/
			} else {@/
				/* ��������� ��������� */
				dest_addr = (uint16_t*)(SectDir[entry->sect].text +
					+ entry->disp);@/
				*dest_addr = value - 2 - entry->disp;
			}
			CExprList.pool[prev].link = delComplexExpr(i);
			i = prev;@/
		}@/
	}@/

	return(!complexRefIsEmpty());@/
}@/
@ ������� ��������� ������� ������ ������ ���������.
@c 
static int
resolveTerms(ComplexExprEntry *entry) {
	int i, not_resolved, global;
	uint16_t addr;
	
	not_resolved = 0;
	for (i = 0; i < entry->NumTerms; ++i) {
		switch (entry->terms[i].code) {
			case CREL_OP_FETCH_GLOBAL:
				global = findGlobalSym(entry->terms[i].un.name);
				if (global == -1) {
					++not_resolved;
					break;
				}	
				/* ������ �� ����� ��������� */
				entry->terms[i].code = CREL_OP_FETCH_CONSTANT;
				entry->terms[i].un.constant =
					GSymDef[global].addr;
				break;
			case CREL_OP_FETCH_RELOCABLE:
				/* ������������ ����� ������ � ��������� ����� */
				global = curSections[entry->terms[i].un.inter.sect].global_sect;
				addr = SectDir[global].start +
					entry->terms[i].un.inter.disp;
				entry->terms[i].un.constant = addr;
				entry->terms[i].code = CREL_OP_FETCH_CONSTANT;
				break;
			default:;
		}
	}
	return(not_resolved);
}

@ ���������� �������� ���������. ��� ������ �� ��������, ����� �������� � ��������
��� ����, ��� ��� ������� ���� �� 20 ������� � ������������. � ����� ��������
���������� ����� ������� ���� ���������~---~�� ������������ ��������
������������� ��� �������, ��� � ���������� ���������� ����������.
@c
static uint16_t 
calcTerms(ComplexExprEntry *entry) {
	uint16_t stack[MAX_COMPLEX_TERMS];
	uint16_t *sp;
	ComplexTerm *term;
	int i;

	sp = stack;
	for (i = 0; i < entry->NumTerms; ++i) {
		term = entry->terms + i;
		switch (term->code) {
			case CREL_OP_NONE:
				break;
			case CREL_OP_ADDITION:
				*(sp - 1) = *sp + *(sp - 1);
				--sp;
				break;
			case CREL_OP_SUBSTRACTION:
				*(sp - 1) = *(sp - 1) - *sp;
				--sp;
				break;
			case CREL_OP_MULTIPLICATION:
				*(sp - 1) = *sp * *(sp - 1);
				--sp;
				break;
			case CREL_OP_DIVISION:
				*(sp - 1) = *(sp - 1) / *sp;
				--sp;
				break;
			case CREL_OP_AND:
				*(sp - 1) = *sp & *(sp - 1);
				--sp;
				break;
			case CREL_OP_OR:
				*(sp - 1) = *sp | *(sp - 1);
				--sp;
				break;
			case CREL_OP_XOR:
				*(sp - 1) = *sp ^ *(sp - 1);
				--sp;
				break;
			case CREL_OP_NEG:
				*sp = 0 - *sp;
				break;
			case CREL_OP_COM:
				*sp = ~*sp;
				break;
			case CREL_OP_STORE_RESULT:
			case CREL_OP_STORE_RESULT_DISP:
				entry->result_type = term->code;
				break;
			case CREL_OP_FETCH_CONSTANT:
				*(++sp) = term->un.constant;
				break;
			default:
				PRINTERR("Bad term code: %o\n", term->code);
		}
	}
	return(*sp);
}

@ @<���������� ����������...@>=
static int resolveComplex(void);
static int resolveTerms(ComplexExprEntry *);
static uint16_t calcTerms(ComplexExprEntry *);

@ 
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
@<������� ������@>=
	addComplexExpr(entry);
	PRINTVERB(2, "      Disp: %o.\n        ", entry->disp);
	for (RLD_i += 2; block[RLD_i] != CREL_OP_STORE_RESULT &&
			 block[RLD_i] != CREL_OP_STORE_RESULT_DISP; ++RLD_i) {
		switch (block[RLD_i]) {
			case CREL_OP_NONE:
				addComplexTerm(CREL_OP_NONE, NULL, 0, 0, 0);
				break;
			case CREL_OP_ADDITION:
				PRINTVERB(2, "+ ");
				addComplexTerm(CREL_OP_ADDITION, NULL, 0, 0, 0);
				break;
			case CREL_OP_SUBSTRACTION:
				PRINTVERB(2, "- ");
				addComplexTerm(CREL_OP_SUBSTRACTION, NULL, 0, 0, 0);
				break;
			case CREL_OP_MULTIPLICATION:
				PRINTVERB(2, "* ");
				addComplexTerm(CREL_OP_MULTIPLICATION, NULL, 0, 0, 0);
				break;
			case CREL_OP_DIVISION:
				PRINTVERB(2, "/ ");
				addComplexTerm(CREL_OP_DIVISION, NULL, 0, 0, 0);
				break;
			case CREL_OP_AND:
				PRINTVERB(2, "and ");
				addComplexTerm(CREL_OP_AND, NULL, 0, 0, 0);
				break;
			case CREL_OP_OR:
				PRINTVERB(2, "or ");
				addComplexTerm(CREL_OP_OR, NULL, 0, 0, 0);
				break;
			case CREL_OP_XOR:
				PRINTVERB(2, "xor ");
				addComplexTerm(CREL_OP_XOR, NULL, 0, 0, 0);
				break;
			case CREL_OP_NEG:
				PRINTVERB(2, "neg ");
				addComplexTerm(CREL_OP_NEG, NULL, 0, 0, 0);
				break;
			case CREL_OP_COM:
				PRINTVERB(2, "com ");
				addComplexTerm(CREL_OP_COM, NULL, 0, 0, 0);
				break;
			case CREL_OP_FETCH_GLOBAL:
				++RLD_i;
				value = (uint16_t *)(block + RLD_i);
				fromRadix50(value[0], gname);
				fromRadix50(value[1], gname + 3);
				RLD_i += 3;
				PRINTVERB(2, "%s ", gname);
				addComplexTerm(CREL_OP_FETCH_GLOBAL, value, 0, 0, 0);
				break;
			case CREL_OP_FETCH_RELOCABLE:
				value = (uint16_t *)(block + RLD_i + 2);
				PRINTVERB(2, "sect:%o/%o ", block[RLD_i + 1],
					value[0]);
				addComplexTerm(CREL_OP_FETCH_RELOCABLE, NULL, block[RLD_i +
					1], value[0], 0);
				RLD_i += 3;	
				break;
			case CREL_OP_FETCH_CONSTANT:
				++RLD_i;
				value = (uint16_t *)(block + RLD_i);
				++RLD_i;
				PRINTVERB(2, "%o ", *value);
				addComplexTerm(CREL_OP_FETCH_CONSTANT, NULL, 0, 0, value[0]);
				break;
			default :
				PRINTERR("Bad complex relocation opcode: %d.\n",
				block[RLD_i]);
				return;
		}
	}
	addComplexTerm(block[RLD_i], NULL, 0, 0, 0);
	++RLD_i;
	PRINTVERB(2, "\n");

@ @<���������� ���������� ������� � ������@>=
handleGlobalSymbol(entry);

@ @<���������� ����������� ������@>=
handleProgramSection(entry);

@ @<���������� ������ TXT@>=
handleTextSection(block_body, block_len);

@ @<���������� ������ ���������...@>=
handleRelocationDirectory(block_body, block_len);

@ @<����������...@>=
static void handleGlobalSymbol(GSD_Entry *);
static void handleProgramSection(GSD_Entry *);
static void handleTextSection(uint8_t *, unsigned int);
static void handleRelocationDirectory(uint8_t *, int);

@* ��������������� �������.

 ������� ���� ���� �� RADIX-50 � ������.
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

@ @<����������...@>=
static void handleOneFile(FILE *);
static void handleGSD(int);
static void fromRadix50(int, char*);

@* ������ ���������� ��������� ������.

��� ���� ���� ������������ ���������� ������� ��������� ���������� 
{\sl argp}.
@d VERSION "0.6"

@ @<���������@>=
const char *argp_program_version = "linkbk, " VERSION;
const char *argp_program_bug_address = "<yellowrabbit@@bk.ru>";

@ @<��������...@>=
static char argp_program_doc[] = "Link MACRO-11 object files";
static char args_doc[] = "file [...]";

@ ������������ ��������� �����:
\smallskip
	\item {} {\tt -o} --- ��� ��������� �����.
	\item {} {\tt -v} --- ����� �������������� ���������� (�������� ��������
	������);
	\item {} {\tt -l NUM} --- ����������� ����� �������� ����� ����� ������
	�� ����� NUM ��������.
\smallskip
@<��������...@>=
static struct argp_option options[] = {@/
	{ "output", 'o', "FILENAME", 0, "Output filename"},@/
	{ "verbose", 'v', NULL, 0, "Verbose output"},@!
	{ "length", 'l', "LENGTH", 0, "Max overlay file name length"},@!
	{ 0 }@/
};
static error_t parse_opt(int, char*, struct argp_state*);@!
static struct argp argp = {options, parse_opt, args_doc, argp_program_doc};

@ ��� ��������� ������������ ��� ��������� ����������� ������� ���������� ��������� ������.
@<�����������...@>=
typedef struct _Arguments {
	int  verbosity;
	char output_filename[FILENAME_MAX]; /* ��� ����� � ������� */
	int  max_filename_len;	    /* ������������ ����� ����� ��������
						������. �� ��������� ��� MKDOS
						����� 14 */
	char **objnames;		    /* ����� ��������� ������
					 objnames[?] == NULL --> ����� ����*/
} Arguments;

@ @<����������...@>=
static Arguments config = { 0, {0}, 14, NULL, };


@ ������� ������� �������� ������� �������� ���������� ��������� |Arguments| �� ���������
���������� ��������� ������.
@c
static error_t 
parse_opt(int key, char *arg, struct argp_state *state) {
 Arguments *arguments;
	arguments = (Arguments*)state->input;
 switch (key) {
	case 'l':
		arguments->max_filename_len = atoi(arg);
		/* �� ������ x-SECTIO.v */
		if (arguments->max_filename_len < 1 + 6 + 2)
		  arguments->max_filename_len = 1 + 1 + 6 + 2;
		break;
	case 'v':
		++arguments->verbosity;
		break;
	case 'o':
		if (strlen(arg) == 0)
			return(ARGP_ERR_UNKNOWN);
		strncpy(arguments->output_filename, arg, FILENAME_MAX - 1);
		break;
	case ARGP_KEY_ARG:
		/* ����� ��������� ������ */
		arguments->objnames = &state->argv[state->next - 1];
		/* ������������� ������ ���������� */
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
@<��������� ���...@>=
	argp_parse(&argp, argc, argv, 0, 0, &config);@/
	/* �������� ���������� */
	if (strlen(config.output_filename) == 0) {
		PRINTERR("No output filename specified\n");
		return(ERR_SYNTAX);
	}
	if (config.objnames == NULL) {
		PRINTERR("No input filenames specified\n");
		return(ERR_SYNTAX);
	}

@ @<��������� ...@>=
#include <string.h>
#include <stdlib.h>

#ifdef __linux__
#include <stdint.h>
#endif

#include <argp.h>

@
@<����������...@>=
#define PRINTVERB(level, fmt, a...) (((config.verbosity) >= level) ? printf(\
  (fmt), ## a) : 0)
#define PRINTERR(fmt, a...) fprintf(stderr, (fmt), ## a) 

@* ������� ��� �������� ��11�.

���� lib/bk11m/bk11m.inc
\listing{tests/lib/bk11m/bk11m.inc}
���� lib/bk11m/.BINIT.MAC
\listing{tests/lib/bk11m/.BINIT.MAC}
���� lib/bk11m/.BEXIT.MAC
\listing{tests/lib/bk11m/.BEXIT.MAC}
���� lib/bk11m/.BJSR.MAC
\listing{tests/lib/bk11m/.BJSR.MAC}
���� lib/bk11m/.BMEM.MAC
\listing{tests/lib/bk11m/.BMEM.MAC}
���� lib/bk11m/.BPAGE.MAC
\listing{tests/lib/bk11m/.BPAGE.MAC}
���� lib/bk11m/.BWORK.MAC
\listing{tests/lib/bk11m/.BWORK.MAC}
���� lib/bk11m/.BSTR.MAC
\listing{tests/lib/bk11m/.BSTR.MAC}
���� lib/bk11m/.BTSET.MAC
\listing{tests/lib/bk11m/.BTSET.MAC}
���� lib/bk11m/.BTTIN.MAC
\listing{tests/lib/bk11m/.BTTIN.MAC}

@* ������� ��� MKDOS.

���� lib/mkdos/mkdos.inc
\listing{tests/lib/mkdos/mkdos.inc}
���� lib/mkdos/AFTER\$MKDOS.MAC
\listing{tests/lib/mkdos/AFTER$MKDOS.MAC}
���� lib/mkdos/MKDOS\$TAPE.MAC
\listing{tests/lib/mkdos/MKDOS$TAPE.MAC}
���� lib/mkdos/BACK\$TO\$MKDOS.MAC
\listing{tests/lib/mkdos/BACK$TO$MKDOS.MAC}

@* ������� ��� RAM-BIOS.

���� lib/ram-bios/ram-bios.inc
\listing{tests/lib/ram-bios/ram-bios.inc}
���� lib/ram-bios/MOV\$G.MAC
\listing{tests/lib/ram-bios/MOV$G.MAC}
���� lib/ram-bios/CHW\$G.MAC
\listing{tests/lib/ram-bios/CHW$G.MAC}
���� lib/ram-bios/CAT\$.MAC
\listing{tests/lib/ram-bios/CAT$.MAC}
���� lib/ram-bios/CAL\$G.MAC
\listing{tests/lib/ram-bios/CAL$G.MAC}
���� lib/ram-bios/EXIT\$.MAC
\listing{tests/lib/ram-bios/EXIT$.MAC}

@* ������.



