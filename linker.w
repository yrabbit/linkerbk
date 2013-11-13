\input cwebmac	%-ru

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

	@<Разобрать командную строку@>@;
	@<Создаём файл результата@>@;

	/* Поочередно обрабатываем все заданные объектные файлы */
	cur_input = 0;
	while ((objname = config.objnames[cur_input]) != NULL) {
		@<Открыть объектный файл@>@;
		handle_one_file(fresult, fobj);
		fclose(fobj);
		++cur_input;
	}
	fclose(fresult);
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

@ @<Создаём файл результата@>=
	fresult = fopen(config.output_filename, "w");
	if (fresult == NULL) {
		PRINTERR("Can't create %s\n", config.output_filename);
		return(ERR_CANTCREATE);
	}

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
	uint8_t len[2]; /* length of block */
} BinaryBlock;


@ Обработать один объектный файл.
@c
static void
handle_one_file(FILE *fresult, FILE *fobj) {
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
		block_len = obj_header.len[0] + obj_header.len[1] * 256 - 4;
		PRINTVERB(2, "Binary block found. Length:%d\n", block_len);

		/* Читаем тело блока с котрольной суммой */
		if (fread(block_body, block_len + 1, 1, fobj) != 1) {
			PRINTERR("IO error: %s\n", config.objnames[cur_input]);
			break;
		}
	}
end:;
}

@ Буффер для тела блока.
@<Глобальные...@>=
static uint8_t block_body[65536 + 1];

@ @<Глобальные...@>=
static void handle_one_file(FILE *, FILE *);

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

