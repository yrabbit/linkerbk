\input cwebmac-ru

\def\version{0.1}
\font\twentycmcsc=cmcsc10 at 20 truept

\datethis

@*Введение.
\vskip 120pt
\centerline{\twentycmcsc link}
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
	FILE *fobj;
	int cur_input;
	const char *objname;

	@<Разобрать командную строку@>@;
	/* Поочередно обрабатываем все заданные объектные файлы */
	while ((objname = config.objnames[cur_input++]) != NULL) {
		fobj = fopen(objname,"r");
		if (fobj== NULL) {
			printerr("Can't open ");
			printerr(objname);
			return(ERR_CANTOPEN);
		}
		fclose(fobj);
	}
}

@ @<Данные программы@>=

@ @<Собственные типы данных@>=

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
	{ 0 }@/
};
static error_t parse_opt(int, char*, struct argp_state*);@!
static struct argp argp = {options, parse_opt, NULL, argp_program_doc};

@ Эта структура используется для получения результатов разбора параметров командной строки.
@<Собственные...@>=
typedef struct _Arguments {
	char output_filename[FILENAME_MAX]; /* Имя файла с тектом */
	char **objnames;		    /* Имена объектных файлов
					 objnames[?] == NULL --> конец имен*/
} Arguments;

@ @<Глобальные...@>=
static Arguments config = { {0}, NULL, };


@ Задачей данного простого парсера является заполнение структуры |Arguments| из указанных
параметров командной строки.
@c
static error_t 
parse_opt(int key, char *arg, struct argp_state *state) {
 Arguments *arguments;
	arguments = (Arguments*)state->input;
 switch (key) {
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
@d ERR_SYNTAX 1
@d ERR_CANTOPEN 2
@<Разобрать ком...@>=
	argp_parse(&argp, argc, argv, 0, 0, &config);@|
	/* Проверка параметров */
	if (strlen(config.output_filename) == 0) {
		printerr("No output filename specified\n");
		return(ERR_SYNTAX);
	}
	if (config.objnames == NULL) {
		printerr("No input filenames specified\n");
		return(ERR_SYNTAX);
	}

@ @<Включение ...@>=
#include <string.h>
#include <stdlib.h>

#include <argp.h>

@ @<Глобальные...@>=
static void printerr(const char*);

@ @c
static void
printerr(const char *str) {
	fprintf(stderr, str);
}


