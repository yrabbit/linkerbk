/*8:*/
#line 120 "linker.w"

/*126:*/
#line 1815 "linker.w"

#include <string.h> 
#include <stdlib.h> 

#ifdef __linux__
#include <stdint.h> 
#endif

#include <argp.h> 

/*:126*/
#line 121 "linker.w"

#define GSD_MODULE_NAME 0
#define GSD_CSECT_NAME 1
#define GSD_INTERNAL_SYMBOL_NAME 2
#define GSD_TRANFER_ADDRESS 3
#define GSD_GLOBAL_SYMBOL_NAME 4
#define GSD_PSECT_NAME 5
#define GDS_IDENT 6
#define GSD_MAPPED_ARRAY 7
#define MAX_GLOBALS 1024
#define GLOBAL_WEAK_MASK 001
#define GLOBAL_DEFINITION_MASK 010
#define GLOBAL_RELOCATION_MASK 040
#define MAX_PROG_SECTIONS 254
#define PSECT_SAVE_MASK 0001
#define PSECT_ALLOCATION_MASK 0004
#define PSECT_ACCESS_MASK 0020
#define PSECT_RELOCATION_MASK 0040
#define PSECT_SCOPE_MASK 0100
#define PSECT_TYPE_MASK 0200
#define DEFAULT_SECTION_LEN 65536
#define INITIAL_SIMPLE_REF_LIST_SIZE 100
#define INITIAL_LIMIT_LIST_SIZE 5
#define RLD_CMD_INTERNAL_RELOCATION 01
#define RLD_CMD_GLOBAL_RELOCATION 02
#define RLD_CMD_INTERNAL_DISPLACED_RELOCATION 03
#define RLD_CMD_GLOBAL_DISPLACED_RELOCATION 04
#define RLD_CMD_GLOBAL_ADDITIVE_RELOCATION 05
#define RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION 06
#define RLD_CMD_LOCATION_COUNTER_DEFINITION 07
#define RLD_CMD_LOCATION_COUNTER_MODIFICATION 010
#define RLD_CMD_PROGRAM_LIMITS 011
#define RLD_CMD_PSECT_RELOCATION 012
#define RLD_CMD_PSECT_DISPLACED_RELOCATION 014
#define RLD_CMD_PSECT_ADDITIVE_RELOCATION 015
#define RLD_CMD_PSECT_ADDITIVE_DISPLACED_RELOCATION 016
#define RLD_CMD_COMPLEX_RELOCATION 017
#define MAX_COMPLEX_TERMS 20
#define INITIAL_COMPLEX_EXPR_LIST_SIZE 10
#define CREL_OP_NONE 000
#define CREL_OP_ADDITION 001
#define CREL_OP_SUBSTRACTION 002
#define CREL_OP_MULTIPLICATION 003
#define CREL_OP_DIVISION 004
#define CREL_OP_AND 005
#define CREL_OP_OR 006
#define CREL_OP_XOR 007
#define CREL_OP_NEG 010
#define CREL_OP_COM 011
#define CREL_OP_STORE_RESULT 012
#define CREL_OP_STORE_RESULT_DISP 013
#define CREL_OP_FETCH_GLOBAL 016
#define CREL_OP_FETCH_RELOCABLE 017
#define CREL_OP_FETCH_CONSTANT 020
#define VERSION "0.6" \

#define ERR_SYNTAX 1
#define ERR_CANTOPEN 2
#define ERR_CANTCREATE 3

#line 122 "linker.w"

/*119:*/
#line 1724 "linker.w"

const char*argp_program_version= "linkbk, "VERSION;
const char*argp_program_bug_address= "<yellowrabbit@bk.ru>";

/*:119*/
#line 123 "linker.w"

/*16:*/
#line 267 "linker.w"

typedef struct _BinaryBlock{
uint8_t one;
uint8_t zero;
uint16_t len;
}BinaryBlock;


/*:16*//*22:*/
#line 368 "linker.w"

typedef struct _GSD_Entry{
uint16_t name[2];
uint8_t flags;
uint8_t type;
uint16_t value;
}GSD_Entry;

/*:22*//*26:*/
#line 443 "linker.w"

typedef struct _GSymDefEntry{
uint16_t name[2];
uint8_t flags;
uint8_t sect;
uint16_t addr;
uint8_t obj_file;
}GSymDefEntry;


/*:26*//*34:*/
#line 544 "linker.w"

typedef struct _SectionDirEntry{
uint16_t name[2];
uint8_t flags;
uint16_t start;
int32_t min_addr;
uint16_t len;
uint16_t transfer_addr;
uint16_t last_load_addr;
uint8_t*text;
}SectionDirEntry;
/*:34*//*51:*/
#line 725 "linker.w"

typedef struct _SimpleRefEntry{
uint16_t link;
uint8_t type;
uint8_t sect;
uint16_t disp;
uint16_t constant;
uint16_t name[2];
uint8_t obj_file;
}SimpleRefEntry;
typedef struct _SimpleRefList{
uint16_t avail;
uint16_t poolmin;
SimpleRefEntry*pool;
int num_allocations;

}SimpleRefList;

/*:51*//*67:*/
#line 939 "linker.w"

typedef struct _LimListEntry{
uint16_t link;
uint8_t sect;
uint16_t disp;
}LimListEntry;
typedef struct _LimList{
LimListEntry*pool;
int num_limits;
int num_allocations;

}LimList;

/*:67*//*76:*/
#line 1027 "linker.w"

typedef struct _RLD_Entry{
struct{
uint8_t type:7;
uint8_t b:1;
}cmd;
uint8_t disp;
uint16_t value[2];
}RLD_Entry;

typedef struct _RLD_Const_Entry{
RLD_Entry ent;
uint16_t constant;
}RLD_Const_Entry;

/*:76*//*91:*/
#line 1248 "linker.w"

typedef struct _CurSectEntry{
uint16_t name[2];
uint8_t global_sect;
}CurSectEntry;

/*:91*//*96:*/
#line 1278 "linker.w"

typedef struct _ComplexTerm{
uint8_t code;
union{
uint16_t name[2];
struct{
uint8_t sect;
uint16_t disp;
}inter;
uint16_t constant;
}un;
}ComplexTerm;

typedef struct _ComplexExprEntry{
uint16_t link;
uint16_t disp;
uint8_t sect;
uint8_t obj_file;
uint8_t result_type;
uint8_t NumTerms;
ComplexTerm terms[MAX_COMPLEX_TERMS];
}ComplexExprEntry;

typedef struct _ComplexExpressionList{
uint16_t avail;
uint16_t poolmin;
uint16_t num_allocations;
ComplexExprEntry*pool;
}ComplexExpressionList;

/*:96*//*122:*/
#line 1750 "linker.w"

typedef struct _Arguments{
int verbosity;
char output_filename[FILENAME_MAX];
int max_filename_len;


char**objnames;

}Arguments;

/*:122*/
#line 124 "linker.w"

/*9:*/
#line 173 "linker.w"

static int cur_input;
static int num_start_addresses;

/*:9*//*18:*/
#line 313 "linker.w"

static uint8_t block_body[65536+1];

/*:18*//*27:*/
#line 453 "linker.w"

static GSymDefEntry GSymDef[MAX_GLOBALS];
static int NumGlobalDefs;

/*:27*//*31:*/
#line 525 "linker.w"

static int findGlobalSym(uint16_t*);

/*:31*//*35:*/
#line 555 "linker.w"

static SectionDirEntry SectDir[MAX_PROG_SECTIONS];
static int NumSections;
/*:35*//*37:*/
#line 580 "linker.w"

static int CurSect;

/*:37*//*47:*/
#line 676 "linker.w"

static int findSection(uint16_t*);


/*:47*//*52:*/
#line 743 "linker.w"

static SimpleRefList SRefList;
static int simpleRefIsEmpty(void);
/*:52*//*58:*/
#line 840 "linker.w"

static void addSimpleRef(RLD_Entry*);
static uint16_t delSimpleRef(uint16_t);

/*:58*//*65:*/
#line 933 "linker.w"

static int resolveGlobals(void);

/*:65*//*68:*/
#line 952 "linker.w"

static LimList LimitList;
static void addLimit(RLD_Entry*);
static void resolveLimit(void);

/*:68*//*92:*/
#line 1254 "linker.w"

static CurSectEntry curSections[MAX_PROG_SECTIONS];
static int NumCurSections;

/*:92*//*97:*/
#line 1308 "linker.w"

static ComplexExpressionList CExprList;
static int complexRefIsEmpty(void);
static void addComplexExpr(RLD_Entry*);
static uint16_t delComplexExpr(uint16_t);
/*:97*//*102:*/
#line 1383 "linker.w"

static uint16_t CurComplexExpr;
static void addComplexTerm(uint8_t,uint16_t*,uint8_t,uint16_t,uint16_t);

/*:102*//*108:*/
#line 1567 "linker.w"

static int resolveComplex(void);
static int resolveTerms(ComplexExprEntry*);
static uint16_t calcTerms(ComplexExprEntry*);

/*:108*//*114:*/
#line 1679 "linker.w"

static void handleGlobalSymbol(GSD_Entry*);
static void handleProgramSection(GSD_Entry*);
static void handleTextSection(uint8_t*,unsigned int);
static void handleRelocationDirectory(uint8_t*,int);

/*:114*//*117:*/
#line 1713 "linker.w"

static void handleOneFile(FILE*);
static void handleGSD(int);
static void fromRadix50(int,char*);

/*:117*//*120:*/
#line 1728 "linker.w"

static char argp_program_doc[]= "Link MACRO-11 object files";

/*:120*//*121:*/
#line 1739 "linker.w"

static struct argp_option options[]= {
{"output",'o',"FILENAME",0,"Output filename"},
{"verbose",'v',NULL,0,"Verbose output"},
{"length",'l',"LENGTH",0,"Max overlay file name length"},
{0}
};
static error_t parse_opt(int,char*,struct argp_state*);
static struct argp argp= {options,parse_opt,NULL,argp_program_doc};

/*:121*//*123:*/
#line 1761 "linker.w"

static Arguments config= {0,{0},14,NULL,};


/*:123*//*127:*/
#line 1826 "linker.w"

#define PRINTVERB(level, fmt, a...) (((config.verbosity) >= level) ? printf(\
  (fmt), ## a) : 0)
#define PRINTERR(fmt, a...) fprintf(stderr, (fmt), ## a)

/*:127*/
#line 125 "linker.w"

int
main(int argc,char*argv[])
{
/*10:*/
#line 177 "linker.w"

FILE*fobj,*fresult;
char ovrname[200];

/*:10*//*32:*/
#line 528 "linker.w"

char name[7];
/*:32*//*43:*/
#line 626 "linker.w"

char sect_name[7];
/*:43*/
#line 129 "linker.w"

const char*objname;
int i,j,not_resolved;

/*125:*/
#line 1803 "linker.w"

argp_parse(&argp,argc,argv,0,0,&config);

if(strlen(config.output_filename)==0){
PRINTERR("No output filename specified\n");
return(ERR_SYNTAX);
}
if(config.objnames==NULL){
PRINTERR("No input filenames specified\n");
return(ERR_SYNTAX);
}

/*:125*/
#line 133 "linker.w"

/*42:*/
#line 622 "linker.w"

NumSections= 0;
memset(SectDir,0,sizeof(SectDir));

/*:42*/
#line 134 "linker.w"

/*28:*/
#line 457 "linker.w"

NumGlobalDefs= 0;

/*:28*/
#line 135 "linker.w"

/*56:*/
#line 817 "linker.w"

SRefList.pool= (SimpleRefEntry*)malloc(sizeof(SimpleRefEntry)*
INITIAL_SIMPLE_REF_LIST_SIZE);
SRefList.num_allocations= 1;
SRefList.pool[0].link= 0;
SRefList.avail= 0;
SRefList.poolmin= 1;

/*:56*/
#line 136 "linker.w"

/*99:*/
#line 1321 "linker.w"

CExprList.pool= (ComplexExprEntry*)malloc(sizeof(ComplexExprEntry)*
INITIAL_COMPLEX_EXPR_LIST_SIZE);
CExprList.num_allocations= 1;
CExprList.pool[0].link= 0;
CExprList.avail= 0;
CExprList.poolmin= 1;

/*:99*/
#line 137 "linker.w"

/*70:*/
#line 985 "linker.w"

LimitList.pool= (LimListEntry*)malloc(sizeof(LimListEntry)*
INITIAL_LIMIT_LIST_SIZE);
LimitList.num_allocations= 1;
LimitList.num_limits= 0;

/*:70*/
#line 138 "linker.w"



cur_input= 0;
not_resolved= 1;
num_start_addresses= 0;
while((objname= config.objnames[cur_input])!=NULL){
/*11:*/
#line 181 "linker.w"

fobj= fopen(objname,"r");
if(fobj==NULL){
PRINTERR("Can't open %s\n",objname);
return(ERR_CANTOPEN);
}
/*:11*/
#line 145 "linker.w"

handleOneFile(fobj);

not_resolved= resolveGlobals();

not_resolved+= resolveComplex();
fclose(fobj);
++cur_input;
if(num_start_addresses>=2){
PRINTERR("Too many start addresses.\n");
return(1);
}
}
if(not_resolved==0){
/*33:*/
#line 530 "linker.w"

if(config.verbosity>=1){
PRINTVERB(1,"=Global Definitions:\n");
for(i= 0;i<NumGlobalDefs;++i){
fromRadix50(GSymDef[i].name[0],name);
fromRadix50(GSymDef[i].name[1],name+3);
fromRadix50(SectDir[GSymDef[i].sect].name[0],sect_name);
fromRadix50(SectDir[GSymDef[i].sect].name[1],sect_name+3);
PRINTVERB(1,"%s: %s/%o\n",name,sect_name,
GSymDef[i].addr);
}
}
/*:33*/
#line 159 "linker.w"

/*72:*/
#line 1004 "linker.w"

resolveLimit();
/*:72*/
#line 160 "linker.w"

/*13:*/
#line 219 "linker.w"

for(i= 0;i<NumSections;++i){
if(SectDir[i].transfer_addr!=1&&SectDir[i].len!=0){

fresult= fopen(config.output_filename,"w");
if(fresult==NULL){
PRINTERR("Can't create %s\n",config.output_filename);
return(ERR_CANTCREATE);
}
fwrite(SectDir[i].text+SectDir[i].min_addr,
SectDir[i].len-SectDir[i].min_addr,1,fresult);
fclose(fresult);
continue;
}
if(SectDir[i].len!=0&&SectDir[i].min_addr!=-1){
fromRadix50(SectDir[i].name[0],sect_name);
fromRadix50(SectDir[i].name[1],sect_name+3);

for(j= 5;j>=0;--j){
if(sect_name[j]!=' '){
sect_name[j+1]= 0;
break;
}
}
strncpy(ovrname,config.output_filename,
config.max_filename_len-strlen(sect_name)-3);
ovrname[config.max_filename_len-strlen(sect_name)-3]= '\0';
strcat(ovrname,"-");
strcat(ovrname,sect_name);
strcat(ovrname,".v");
fresult= fopen(ovrname,"w");
if(fresult==NULL){
PRINTERR("Can't create %s\n",ovrname);
return(ERR_CANTCREATE);
}
fwrite(SectDir[i].text+SectDir[i].min_addr,
SectDir[i].len-SectDir[i].min_addr,1,fresult);
fclose(fresult);
}
}

/*:13*/
#line 161 "linker.w"

}else{
/*12:*/
#line 187 "linker.w"

if(!simpleRefIsEmpty()){
printf("Unresolved simple refs:\n");
for(i= SRefList.pool[0].link;i!=0;i= SRefList.pool[i].link){
fromRadix50(SRefList.pool[i].name[0],name);
fromRadix50(SRefList.pool[i].name[1],name+3);
fromRadix50(SectDir[SRefList.pool[i].sect].name[0],sect_name);
fromRadix50(SectDir[SRefList.pool[i].sect].name[1],sect_name+3);
printf("i: %4d, name: %s, disp: %s/%o, file: %s\n",i,name,sect_name,
SRefList.pool[i].disp,config.objnames[SRefList.pool[i].obj_file]);
}
}
if(!complexRefIsEmpty()){
printf("Unresolved complex refs:\n");
for(i= CExprList.pool[0].link;i!=0;i= CExprList.pool[i].link){
for(j= 0;j<CExprList.pool[i].NumTerms;++j){
if(CExprList.pool[i].terms[j].code==
CREL_OP_FETCH_GLOBAL){
fromRadix50(CExprList.pool[i].terms[j].un.name[0],name);
fromRadix50(CExprList.pool[i].terms[j].un.name[1],
name+3);
printf("i: %4d, j: %2d, name: %s, file:"
" %s\n",i,j,name,
config.objnames[CExprList.pool[i].obj_file]);
}
}
}
}

/*:12*/
#line 163 "linker.w"

}
/*44:*/
#line 628 "linker.w"

PRINTVERB(1,"=Sections:\n");
for(i= 0;i<NumSections;++i){
fromRadix50(SectDir[i].name[0],sect_name);
fromRadix50(SectDir[i].name[1],sect_name+3);
PRINTVERB(1,"%s, addr: %p, len: %o, min addr: %o,"
" current start: %o\n",sect_name,
SectDir[i].text,SectDir[i].len,SectDir[i].min_addr,
SectDir[i].start);
if(SectDir[i].text!=NULL)
free(SectDir[i].text);
}

/*:44*/
#line 165 "linker.w"

/*100:*/
#line 1329 "linker.w"

if(config.verbosity>=2){
PRINTVERB(2,"=Complex Refs:\n avail: %d, poolmin: %d\n",
CExprList.avail,CExprList.poolmin);
for(i= CExprList.pool[0].link;i!=0;i= CExprList.pool[i].link){
fromRadix50(SectDir[CExprList.pool[i].sect].name[0],sect_name);
fromRadix50(SectDir[CExprList.pool[i].sect].name[1],sect_name+3);
PRINTVERB(2,"i: %4d, disp: %s/%o, file: %s\n",i,sect_name,
CExprList.pool[i].disp,config.objnames[CExprList.pool[i].obj_file]);
}
}
free(CExprList.pool);

/*:100*/
#line 166 "linker.w"

/*57:*/
#line 825 "linker.w"

if(config.verbosity>=2){
PRINTVERB(2,"=Simple Refs:\n avail: %d, poolmin: %d\n",
SRefList.avail,SRefList.poolmin);
for(i= SRefList.pool[0].link;i!=0;i= SRefList.pool[i].link){
fromRadix50(SRefList.pool[i].name[0],name);
fromRadix50(SRefList.pool[i].name[1],name+3);
fromRadix50(SectDir[SRefList.pool[i].sect].name[0],sect_name);
fromRadix50(SectDir[SRefList.pool[i].sect].name[1],sect_name+3);
PRINTVERB(2,"i: %4d, name: %s, disp: %s/%o, file: %s\n",i,name,sect_name,
SRefList.pool[i].disp,config.objnames[SRefList.pool[i].obj_file]);
}
}
free(SRefList.pool);

/*:57*/
#line 167 "linker.w"

/*71:*/
#line 991 "linker.w"

if(config.verbosity>=2){
PRINTVERB(2,"=Limit Refs:\n num_limits: %d\n",
LimitList.num_limits);
for(i= 0;i<LimitList.num_limits;++i){
fromRadix50(SectDir[LimitList.pool[i].sect].name[0],sect_name);
fromRadix50(SectDir[LimitList.pool[i].sect].name[1],sect_name+3);
PRINTVERB(2,"i: %4d, disp: %s/%o\n",i,sect_name,
LimitList.pool[i].disp);
}
}
free(LimitList.pool);
/*:71*/
#line 168 "linker.w"

return(0);
}

/*:8*//*17:*/
#line 276 "linker.w"

static void
handleOneFile(FILE*fobj){
BinaryBlock obj_header;
int first_byte,i;
unsigned int block_len;
char name[7];

/*93:*/
#line 1258 "linker.w"

NumCurSections= 0;
/*:93*/
#line 284 "linker.w"

while(!feof(fobj)){

do{
first_byte= fgetc(fobj);
if(first_byte==EOF)goto end;
}while(first_byte!=1);


ungetc(first_byte,fobj);
if(fread(&obj_header,sizeof(BinaryBlock),1,fobj)!=1){
PRINTERR("IO error: %s\n",config.objnames[cur_input]);
break;
}
if(obj_header.zero!=0)continue;
block_len= obj_header.len-4;
PRINTVERB(2,"Binary block found. Length:%o\n",block_len);


if(fread(block_body,block_len+1,1,fobj)!=1){
PRINTERR("IO error: %s\n",config.objnames[cur_input]);
break;
}
/*19:*/
#line 317 "linker.w"

PRINTVERB(2,"  Block type: %o, ",block_body[0]);
switch(block_body[0]){
case 1:
PRINTVERB(2,"GSD\n");
/*21:*/
#line 366 "linker.w"

handleGSD(block_len);
/*:21*/
#line 322 "linker.w"

break;
case 2:
PRINTVERB(2,"ENDGSD\n");
/*95:*/
#line 1264 "linker.w"

PRINTVERB(2,"=Sections recoding.\n");
for(i= 0;i<NumCurSections;++i){
fromRadix50(curSections[i].name[0],name);
fromRadix50(curSections[i].name[1],name+3);
PRINTVERB(2,"sect: %3d, %s, global sect: %d\n",i,name,
curSections[i].global_sect);
}

/*:95*/
#line 326 "linker.w"

break;
case 3:
PRINTVERB(2,"TXT\n");
/*112:*/
#line 1673 "linker.w"

handleTextSection(block_body,block_len);

/*:112*/
#line 330 "linker.w"

break;
case 4:
PRINTVERB(2,"RLD\n");
/*113:*/
#line 1676 "linker.w"

handleRelocationDirectory(block_body,block_len);

/*:113*/
#line 334 "linker.w"

break;
case 5:
PRINTVERB(2,"ISD\n");
break;
case 6:
PRINTVERB(2,"ENDMOD\n");
break;
case 7:
PRINTVERB(2,"Librarian header\n");
break;
case 8:
PRINTVERB(2,"Librarian end\n");
break;
default:
PRINTERR("Bad block type: %o : %s\n",
block_body[0],config.objnames[cur_input]);
}

/*:19*/
#line 307 "linker.w"

}
end:;
}

/*:17*//*23:*/
#line 376 "linker.w"

static void
handleGSD(int len){
int i,sect;
GSD_Entry*entry;
char name[7];

for(i= 2;i<len;i+= 8){
entry= (GSD_Entry*)(block_body+i);
/*24:*/
#line 435 "linker.w"

fromRadix50(entry->name[0],name);
fromRadix50(entry->name[1],name+3);

/*:24*/
#line 385 "linker.w"

PRINTVERB(2,"    Entry name: '%s', type: %o --- ",name,entry->type);
switch(entry->type){
case GSD_MODULE_NAME:

PRINTVERB(2,"ModuleName.\n");
PRINTVERB(1,"Module:%s\n",name);
break;
case GSD_CSECT_NAME:

PRINTVERB(2,"CSectName, flags:%o, length:%o.\n",
entry->flags,entry->value);
break;
case GSD_INTERNAL_SYMBOL_NAME:

PRINTVERB(2,"InternalSymbolName\n");
break;
case GSD_TRANFER_ADDRESS:

PRINTVERB(2,"TransferAddress, offset:%o.\n",entry->value);
/*40:*/
#line 600 "linker.w"

sect= findSection(entry->name);
SectDir[sect].transfer_addr= entry->value;
if(entry->value!=1)++num_start_addresses;

/*:40*/
#line 405 "linker.w"

break;
case GSD_GLOBAL_SYMBOL_NAME:

PRINTVERB(2,"GlobalSymbolName, flags:%o, value:%o.\n",
entry->flags,entry->value);
/*110:*/
#line 1667 "linker.w"

handleGlobalSymbol(entry);

/*:110*/
#line 411 "linker.w"

break;
case GSD_PSECT_NAME:

PRINTVERB(2,"PSectName, flags:%o, max length:%o.\n",
entry->flags,entry->value);
/*111:*/
#line 1670 "linker.w"

handleProgramSection(entry);

/*:111*/
#line 417 "linker.w"

break;
case GDS_IDENT:

PRINTVERB(2,"Ident.\n");
PRINTVERB(1,"  Ident: %s\n",name);
break;
case GSD_MAPPED_ARRAY:

PRINTVERB(2,"MappedArray, length:%o.\n",entry->value);
break;
default:
PRINTERR("Bad entry type: %o : %s\n",
entry->type,config.objnames[cur_input]);
}
}
}

/*:23*//*29:*/
#line 464 "linker.w"

static void
handleGlobalSymbol(GSD_Entry*entry){
char name[7];
int found_sym;

if(entry->flags&GLOBAL_DEFINITION_MASK){

if((found_sym= findGlobalSym(entry->name))!=-1){
fromRadix50(entry->name[0],name);
fromRadix50(entry->name[1],name+3);
PRINTERR("Global definition conflict: %s in %s"
" conflicts with %s.\n",name,
config.objnames[cur_input],
config.objnames[found_sym]);
exit(EXIT_FAILURE);
}
GSymDef[NumGlobalDefs].name[0]= entry->name[0];
GSymDef[NumGlobalDefs].name[1]= entry->name[1];
GSymDef[NumGlobalDefs].flags= entry->flags;
GSymDef[NumGlobalDefs].sect= CurSect;
GSymDef[NumGlobalDefs].addr= SectDir[CurSect].start+entry->value;
GSymDef[NumGlobalDefs].obj_file= cur_input;
++NumGlobalDefs;
}
if(config.verbosity>=2){
PRINTVERB(2,"        Flags: ");
if(entry->flags&GLOBAL_WEAK_MASK){
PRINTVERB(2,"Weak,");
}else{
PRINTVERB(2,"Strong,");
}
if(entry->flags&GLOBAL_DEFINITION_MASK){
PRINTVERB(2,"Definition,");
}else{
PRINTVERB(2,"Reference,");
}
if(entry->flags&GLOBAL_WEAK_MASK){
PRINTVERB(2,"Relative.\n");
}else{
PRINTVERB(2,"Absolute.\n");
}
}
}

/*:29*//*30:*/
#line 510 "linker.w"

static int findGlobalSym(uint16_t*name){
int found,i;

found= -1;
for(i= 0;i<NumGlobalDefs;++i){
if(name[0]==GSymDef[i].name[0]&&name[1]==GSymDef[i].name[1]){
found= i;
break;
}
}

return(found);
}

/*:30*//*36:*/
#line 565 "linker.w"

static void
handleProgramSection(GSD_Entry*entry){
/*48:*/
#line 680 "linker.w"

if(config.verbosity>=2){
PRINTVERB(2,"        Flags: ");
if(entry->flags&PSECT_SAVE_MASK){
PRINTVERB(2,"RootScope,");
}else{
PRINTVERB(2,"NonRootScope,");
}
if(entry->flags&PSECT_ALLOCATION_MASK){
PRINTVERB(2,"Overlay,");
}else{
PRINTVERB(2,"Concatenate,");
}
if(entry->flags&PSECT_ACCESS_MASK){
PRINTVERB(2,"ReadOnly,");
}else{
PRINTVERB(2,"ReadWrite,");
}
if(entry->flags&PSECT_RELOCATION_MASK){
PRINTVERB(2,"Relocable,");
}else{
PRINTVERB(2,"Absolute,");
}
if(entry->flags&PSECT_SCOPE_MASK){
PRINTVERB(2,"Global,");
}else{
PRINTVERB(2,"Local,");
}
if(entry->flags&PSECT_TYPE_MASK){
PRINTVERB(2,"Dref.\n");
}else{
PRINTVERB(2,"Iref.\n");
}
}

/*:48*/
#line 568 "linker.w"

CurSect= findSection(entry->name);
if(CurSect==-1){
/*46:*/
#line 660 "linker.w"

SectDir[NumSections].name[0]= entry->name[0];
SectDir[NumSections].name[1]= entry->name[1];
SectDir[NumSections].flags= entry->flags;
SectDir[NumSections].len= entry->value;

if(!(entry->flags&PSECT_TYPE_MASK)){
if(SectDir[NumSections].len&1)
++SectDir[NumSections].len;
}
SectDir[NumSections].min_addr= -1;
SectDir[NumSections].transfer_addr= 1;
SectDir[NumSections].text= (uint8_t*)calloc(1,DEFAULT_SECTION_LEN);
CurSect= NumSections;
++NumSections;

/*:46*/
#line 571 "linker.w"

}else{

SectDir[CurSect].start= SectDir[CurSect].len;
SectDir[CurSect].len+= entry->value;
}
/*94:*/
#line 1260 "linker.w"

curSections[NumCurSections].name[0]= SectDir[CurSect].name[0];
curSections[NumCurSections].name[1]= SectDir[CurSect].name[1];
curSections[NumCurSections++].global_sect= CurSect;
/*:94*/
#line 577 "linker.w"

}

/*:36*//*41:*/
#line 609 "linker.w"

static void
handleTextSection(uint8_t*block,unsigned int len){
uint16_t addr;

addr= block[2]+block[3]*256;
PRINTVERB(2,"  Load address: %o, Current section: %d.\n",addr,
CurSect);
memcpy(SectDir[CurSect].text+SectDir[CurSect].start+addr,block+4,len-4);
SectDir[CurSect].last_load_addr= SectDir[CurSect].start+addr;
}

/*:41*//*45:*/
#line 642 "linker.w"

static int
findSection(uint16_t*name){
int found,i;

found= -1;
for(i= 0;i<NumSections;++i){
if(SectDir[i].name[0]==name[0]&&SectDir[i].name[1]==
name[1]){
found= i;
break;
}
}

return(found);
}
/*:45*//*53:*/
#line 747 "linker.w"

static int
simpleRefIsEmpty(void){
return(SRefList.pool[0].link==0);
}

/*:53*//*54:*/
#line 754 "linker.w"

static void
addSimpleRef(RLD_Entry*ref){
SimpleRefEntry*new_entry;
SimpleRefEntry*new_memory;
uint16_t new_index;


if(SRefList.poolmin==INITIAL_SIMPLE_REF_LIST_SIZE*
SRefList.num_allocations){
++SRefList.num_allocations;
new_memory= (SimpleRefEntry*)realloc(SRefList.pool,
sizeof(SimpleRefEntry)*INITIAL_SIMPLE_REF_LIST_SIZE*
SRefList.num_allocations);
if(new_memory==NULL){
PRINTERR("No memory for simple ref list");
abort();
}
PRINTVERB(2,"Done SRefList allocation:%d\n",SRefList.num_allocations);
SRefList.pool= new_memory;
}

if(SRefList.avail!=0){
new_index= SRefList.avail;
SRefList.avail= SRefList.pool[SRefList.avail].link;
}else{

new_index= SRefList.poolmin;
++SRefList.poolmin;
}
new_entry= SRefList.pool+new_index;
new_entry->link= SRefList.pool[0].link;
SRefList.pool[0].link= new_index;


new_entry->obj_file= cur_input;
new_entry->name[0]= ref->value[0];
new_entry->name[1]= ref->value[1];
new_entry->disp= ref->disp-4+SectDir[CurSect].last_load_addr;
new_entry->sect= CurSect;
new_entry->type= ref->cmd.type;
if(new_entry->type==RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION||
new_entry->type==RLD_CMD_GLOBAL_ADDITIVE_RELOCATION){
new_entry->constant= ((RLD_Const_Entry*)ref)->constant;
}
}

/*:54*//*55:*/
#line 803 "linker.w"

static uint16_t
delSimpleRef(uint16_t ref_i){
uint16_t link;

link= SRefList.pool[ref_i].link;
SRefList.pool[ref_i].link= SRefList.avail;
SRefList.avail= ref_i;

return(link);
}

/*:55*//*60:*/
#line 847 "linker.w"

static int
resolveGlobals(void){
uint16_t ref,prev_ref,*dest_addr;
int global;

prev_ref= 0;
if(!simpleRefIsEmpty()){
for(ref= SRefList.pool[0].link;ref!=0;prev_ref= ref,ref= SRefList.pool[ref].link){
global= findGlobalSym(SRefList.pool[ref].name);
if(global==-1){
continue;
}
if(SRefList.pool[ref].type==
RLD_CMD_GLOBAL_RELOCATION){

/*61:*/
#line 905 "linker.w"

dest_addr= 
(uint16_t*)(SectDir[SRefList.pool[ref].sect].text+SRefList.pool[ref].disp);
*dest_addr= GSymDef[global].addr;

/*:61*/
#line 863 "linker.w"


SRefList.pool[prev_ref].link= delSimpleRef(ref);
ref= prev_ref;
continue;
}
if(SRefList.pool[ref].type==
RLD_CMD_GLOBAL_DISPLACED_RELOCATION){

/*63:*/
#line 920 "linker.w"

dest_addr= 
(uint16_t*)(SectDir[SRefList.pool[ref].sect].text+SRefList.pool[ref].disp);
*dest_addr= GSymDef[global].addr-(SRefList.pool[ref].disp+2);

/*:63*/
#line 872 "linker.w"

SRefList.pool[prev_ref].link= 
delSimpleRef(ref);

ref= prev_ref;
continue;
}
if(SRefList.pool[ref].type==
RLD_CMD_GLOBAL_ADDITIVE_RELOCATION){

/*62:*/
#line 912 "linker.w"

dest_addr= 
(uint16_t*)(SectDir[SRefList.pool[ref].sect].text+SRefList.pool[ref].disp);
*dest_addr= GSymDef[global].addr+
SRefList.pool[ref].constant;

/*:62*/
#line 882 "linker.w"

SRefList.pool[prev_ref].link= 
delSimpleRef(ref);

ref= prev_ref;
continue;
}
if(SRefList.pool[ref].type==
RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION){

/*64:*/
#line 928 "linker.w"

dest_addr= 
(uint16_t*)(SectDir[SRefList.pool[ref].sect].text+SRefList.pool[ref].disp);
*dest_addr= GSymDef[global].addr-(SRefList.pool[ref].disp+2)+
SRefList.pool[ref].constant;
/*:64*/
#line 892 "linker.w"

SRefList.pool[prev_ref].link= 
delSimpleRef(ref);

ref= prev_ref;
continue;
}
}
}
return(!simpleRefIsEmpty());
}

/*:60*//*69:*/
#line 958 "linker.w"

static void
addLimit(RLD_Entry*ref){
LimListEntry*new_entry;
LimListEntry*new_memory;


if(LimitList.num_limits==INITIAL_LIMIT_LIST_SIZE*
LimitList.num_allocations){
++LimitList.num_allocations;
new_memory= (LimListEntry*)realloc(LimitList.pool,sizeof(LimListEntry)
*INITIAL_LIMIT_LIST_SIZE*
LimitList.num_allocations);
if(new_memory==NULL){
PRINTERR("No memory for limit list");
abort();
}
PRINTVERB(2,"Done LimitList allocation:%d\n",LimitList.num_allocations);
LimitList.pool= new_memory;
}
new_entry= LimitList.pool+LimitList.num_limits;

new_entry->disp= ref->disp-4+SectDir[CurSect].last_load_addr;
new_entry->sect= CurSect;
++LimitList.num_limits;
}

/*:69*//*73:*/
#line 1006 "linker.w"

static void
resolveLimit(void){
int i;
uint16_t*dest_dir;

for(i= 0;i<LimitList.num_limits;++i){
dest_dir= (uint16_t*)(SectDir[LimitList.pool[i].sect].text+
LimitList.pool[i].disp);
dest_dir[0]= SectDir[LimitList.pool[i].sect].min_addr;
dest_dir[1]= SectDir[LimitList.pool[i].sect].len;
}
}

/*:73*//*77:*/
#line 1057 "linker.w"

static void
handleRelocationDirectory(uint8_t*block,int len){
RLD_Entry*entry;
RLD_Const_Entry*const_entry;
char gname[7];
uint16_t*value,*dest_addr;
int RLD_i,sect;

for(RLD_i= 2;RLD_i<len;){
entry= (RLD_Entry*)(block+RLD_i);
PRINTVERB(2,"    cmd: %o --- ",entry->cmd.type);
switch(entry->cmd.type){
case RLD_CMD_INTERNAL_RELOCATION:
PRINTVERB(2,"Internal Relocation.\n");
/*78:*/
#line 1136 "linker.w"

PRINTVERB(2,"      Disp: %o, +Const: %o.\n",entry->disp,entry->value[0]);
dest_addr= (uint16_t*)(SectDir[CurSect].text+
SectDir[CurSect].last_load_addr+entry->disp-4);
*dest_addr= SectDir[CurSect].start+entry->value[0];
RLD_i+= 4;
/*:78*/
#line 1072 "linker.w"

break;
case RLD_CMD_GLOBAL_RELOCATION:
PRINTVERB(2,"Global Relocation.\n");
/*80:*/
#line 1151 "linker.w"

fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Disp: %o, Name: %s.\n",entry->disp,gname);
addSimpleRef(entry);
RLD_i+= 6;
/*:80*/
#line 1076 "linker.w"

break;
case RLD_CMD_INTERNAL_DISPLACED_RELOCATION:
PRINTVERB(2,"Internal Displaced Relocation.\n");
/*79:*/
#line 1143 "linker.w"

PRINTVERB(2,"      Disp: %o, +Const: %o.\n",entry->disp,entry->value[0]);
dest_addr= (uint16_t*)(SectDir[CurSect].text+
SectDir[CurSect].last_load_addr+entry->disp-4);
*dest_addr= entry->value[0]-SectDir[CurSect].last_load_addr-
entry->disp+4-2;
RLD_i+= 4;
/*:79*/
#line 1080 "linker.w"

break;
case RLD_CMD_GLOBAL_DISPLACED_RELOCATION:
PRINTVERB(2,"Global Displaced Relocation.\n");
/*81:*/
#line 1158 "linker.w"

fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Disp: %o, Name: %s.\n",entry->disp,gname);
addSimpleRef(entry);
RLD_i+= 6;

/*:81*/
#line 1084 "linker.w"

break;
case RLD_CMD_GLOBAL_ADDITIVE_RELOCATION:
PRINTVERB(2,"Global Additive Relocation.\n");
/*82:*/
#line 1166 "linker.w"

const_entry= (RLD_Const_Entry*)entry;
fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Disp: %o, Name: %s, +Const: %o.\n",entry->disp,gname,
const_entry->constant);
addSimpleRef(entry);
RLD_i+= 8;

/*:82*/
#line 1088 "linker.w"

break;
case RLD_CMD_GLOBAL_ADDITIVE_DISPLACED_RELOCATION:
PRINTVERB(2,"Global Additive Displaced Relocation.\n");
/*83:*/
#line 1176 "linker.w"

const_entry= (RLD_Const_Entry*)entry;
fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Disp: %o, Name: %s, +Const: %o.\n",entry->disp,gname,
const_entry->constant);
addSimpleRef(entry);
RLD_i+= 8;

/*:83*/
#line 1093 "linker.w"

break;
case RLD_CMD_LOCATION_COUNTER_DEFINITION:
PRINTVERB(2,"Location Counter Definition.\n");
/*38:*/
#line 584 "linker.w"

const_entry= (RLD_Const_Entry*)entry;
fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Name: %s, +Const: %o.\n",gname,
const_entry->constant);
CurSect= findSection(entry->value);
if(SectDir[CurSect].min_addr==-1||
SectDir[CurSect].min_addr> (const_entry->constant+
SectDir[CurSect].start)){
SectDir[CurSect].min_addr= const_entry->constant+
SectDir[CurSect].start;
}
RLD_i+= 8;

/*:38*/
#line 1097 "linker.w"

break;
case RLD_CMD_LOCATION_COUNTER_MODIFICATION:
PRINTVERB(2,"Location Counter Modification.\n");
/*84:*/
#line 1186 "linker.w"

PRINTVERB(2,"      +Const: %o.\n",entry->value[0]);
RLD_i+= 4;

/*:84*/
#line 1101 "linker.w"

break;
case RLD_CMD_PROGRAM_LIMITS:
PRINTVERB(2,"Program Limits.\n");
/*85:*/
#line 1191 "linker.w"

PRINTVERB(2,"      Disp: %o.\n",entry->disp);
addLimit(entry);
RLD_i+= 2;

/*:85*/
#line 1105 "linker.w"

break;
case RLD_CMD_PSECT_RELOCATION:
PRINTVERB(2,"PSect Relocation.\n");
/*86:*/
#line 1197 "linker.w"

fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Disp: %o, Name: %s.\n",entry->disp,gname);
sect= findSection(entry->value);
dest_addr= (uint16_t*)(SectDir[CurSect].text+
SectDir[CurSect].last_load_addr+entry->disp-4);
*dest_addr= SectDir[sect].start;
RLD_i+= 6;

/*:86*/
#line 1109 "linker.w"

break;
case RLD_CMD_PSECT_DISPLACED_RELOCATION:
PRINTVERB(2,"PSect Displaced Relocation.\n");
/*87:*/
#line 1208 "linker.w"

fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Disp: %o, Name: %s.\n",entry->disp,gname);
sect= findSection(entry->value);
dest_addr= (uint16_t*)(SectDir[CurSect].text+
SectDir[CurSect].last_load_addr+entry->disp-4);
*dest_addr= SectDir[sect].start-SectDir[CurSect].last_load_addr-
entry->disp+4-2;
RLD_i+= 6;

/*:87*/
#line 1113 "linker.w"

break;
case RLD_CMD_PSECT_ADDITIVE_RELOCATION:
PRINTVERB(2,"PSect Additive Relocation.\n");
/*88:*/
#line 1220 "linker.w"

const_entry= (RLD_Const_Entry*)entry;
fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Name: %s, +Const: %o.\n",gname,
const_entry->constant);
sect= findSection(entry->value);
dest_addr= (uint16_t*)(SectDir[CurSect].text+
SectDir[CurSect].last_load_addr+entry->disp-4);
*dest_addr= SectDir[sect].start+const_entry->constant;
RLD_i+= 8;

/*:88*/
#line 1117 "linker.w"

break;
case RLD_CMD_PSECT_ADDITIVE_DISPLACED_RELOCATION:
PRINTVERB(2,"PSect Additive Displaced Relocation.\n");
/*89:*/
#line 1233 "linker.w"

const_entry= (RLD_Const_Entry*)entry;
fromRadix50(entry->value[0],gname);
fromRadix50(entry->value[1],gname+3);
PRINTVERB(2,"      Name: %s, +Const: %o.\n",gname,
const_entry->constant);
sect= findSection(entry->value);
dest_addr= (uint16_t*)(SectDir[CurSect].text+
SectDir[CurSect].last_load_addr+entry->disp-4);
*dest_addr= SectDir[sect].start-SectDir[CurSect].last_load_addr-
entry->disp+4-2+const_entry->constant;
RLD_i+= 8;

/*:89*/
#line 1121 "linker.w"

break;
case RLD_CMD_COMPLEX_RELOCATION:
PRINTVERB(2,"Complex Relocation.\n");
/*109:*/
#line 1588 "linker.w"

addComplexExpr(entry);
PRINTVERB(2,"      Disp: %o.\n        ",entry->disp);
for(RLD_i+= 2;block[RLD_i]!=CREL_OP_STORE_RESULT&&
block[RLD_i]!=CREL_OP_STORE_RESULT_DISP;++RLD_i){
switch(block[RLD_i]){
case CREL_OP_NONE:
addComplexTerm(CREL_OP_NONE,NULL,0,0,0);
break;
case CREL_OP_ADDITION:
PRINTVERB(2,"+ ");
addComplexTerm(CREL_OP_ADDITION,NULL,0,0,0);
break;
case CREL_OP_SUBSTRACTION:
PRINTVERB(2,"- ");
addComplexTerm(CREL_OP_SUBSTRACTION,NULL,0,0,0);
break;
case CREL_OP_MULTIPLICATION:
PRINTVERB(2,"* ");
addComplexTerm(CREL_OP_MULTIPLICATION,NULL,0,0,0);
break;
case CREL_OP_DIVISION:
PRINTVERB(2,"/ ");
addComplexTerm(CREL_OP_DIVISION,NULL,0,0,0);
break;
case CREL_OP_AND:
PRINTVERB(2,"and ");
addComplexTerm(CREL_OP_AND,NULL,0,0,0);
break;
case CREL_OP_OR:
PRINTVERB(2,"or ");
addComplexTerm(CREL_OP_OR,NULL,0,0,0);
break;
case CREL_OP_XOR:
PRINTVERB(2,"xor ");
addComplexTerm(CREL_OP_XOR,NULL,0,0,0);
break;
case CREL_OP_NEG:
PRINTVERB(2,"neg ");
addComplexTerm(CREL_OP_NEG,NULL,0,0,0);
break;
case CREL_OP_COM:
PRINTVERB(2,"com ");
addComplexTerm(CREL_OP_COM,NULL,0,0,0);
break;
case CREL_OP_FETCH_GLOBAL:
++RLD_i;
value= (uint16_t*)(block+RLD_i);
fromRadix50(value[0],gname);
fromRadix50(value[1],gname+3);
RLD_i+= 3;
PRINTVERB(2,"%s ",gname);
addComplexTerm(CREL_OP_FETCH_GLOBAL,value,0,0,0);
break;
case CREL_OP_FETCH_RELOCABLE:
value= (uint16_t*)(block+RLD_i+2);
PRINTVERB(2,"sect:%o/%o ",block[RLD_i+1],
value[0]);
addComplexTerm(CREL_OP_FETCH_RELOCABLE,NULL,block[RLD_i+
1],value[0],0);
RLD_i+= 3;
break;
case CREL_OP_FETCH_CONSTANT:
++RLD_i;
value= (uint16_t*)(block+RLD_i);
++RLD_i;
PRINTVERB(2,"%o ",*value);
addComplexTerm(CREL_OP_FETCH_CONSTANT,NULL,0,0,value[0]);
break;
default:
PRINTERR("Bad complex relocation opcode: %d.\n",
block[RLD_i]);
return;
}
}
addComplexTerm(block[RLD_i],NULL,0,0,0);
++RLD_i;
PRINTVERB(2,"\n");

/*:109*/
#line 1125 "linker.w"

break;
default:
PRINTERR("Bad RLD entry type: %o : %s\n",
entry->cmd.type,config.objnames[cur_input]);
return;
}
}
}

/*:77*//*98:*/
#line 1315 "linker.w"

static int
complexRefIsEmpty(void){
return(CExprList.pool[0].link==0);
}

/*:98*//*101:*/
#line 1343 "linker.w"

static void
addComplexExpr(RLD_Entry*ref){
ComplexExprEntry*new_entry;
ComplexExprEntry*new_memory;
uint16_t new_index;


if(CExprList.poolmin==INITIAL_SIMPLE_REF_LIST_SIZE*
CExprList.num_allocations){
++CExprList.num_allocations;
new_memory= (ComplexExprEntry*)realloc(CExprList.pool,
sizeof(ComplexExprEntry)*INITIAL_SIMPLE_REF_LIST_SIZE*
CExprList.num_allocations);
if(new_memory==NULL){
PRINTERR("No memory for complex ref list");
abort();
}
PRINTVERB(2,"Done CExprList allocation:%d\n",CExprList.num_allocations);
CExprList.pool= new_memory;
}

if(CExprList.avail!=0){
new_index= CExprList.avail;
CExprList.avail= CExprList.pool[CExprList.avail].link;
}else{

new_index= CExprList.poolmin;
++CExprList.poolmin;
}
new_entry= CExprList.pool+new_index;
new_entry->link= CExprList.pool[0].link;
CExprList.pool[0].link= new_index;


new_entry->obj_file= cur_input;
new_entry->disp= ref->disp-4+SectDir[CurSect].last_load_addr;
new_entry->sect= CurSect;
CurComplexExpr= new_index;
}
/*:101*//*103:*/
#line 1388 "linker.w"

static void
addComplexTerm(uint8_t code,uint16_t*name,uint8_t sect,uint16_t disp,
uint16_t constant){
ComplexTerm*term;

term= CExprList.pool[CurComplexExpr].terms+
(CExprList.pool[CurComplexExpr].NumTerms++);
term->code= code;
switch(code){
case CREL_OP_FETCH_GLOBAL:
term->un.name[0]= name[0];
term->un.name[1]= name[1];
break;
case CREL_OP_FETCH_RELOCABLE:
term->un.inter.sect= sect;
term->un.inter.disp= disp;
break;
case CREL_OP_FETCH_CONSTANT:
term->un.constant= constant;
default:
;
}
}

/*:103*//*104:*/
#line 1415 "linker.w"

static uint16_t
delComplexExpr(uint16_t ref_i){
uint16_t link;

link= CExprList.pool[ref_i].link;
CExprList.pool[ref_i].link= CExprList.avail;
CExprList.avail= ref_i;

return(link);
}

/*:104*//*105:*/
#line 1432 "linker.w"

static int
resolveComplex(void){
ComplexExprEntry*entry;
int prev,i;
uint16_t value,*dest_addr;

prev= 0;
for(i= CExprList.pool[0].link;i!=0;prev= i,i= 
CExprList.pool[i].link){
entry= CExprList.pool+i;

if(!resolveTerms(entry)){

value= calcTerms(entry);

if(entry->result_type==CREL_OP_STORE_RESULT){

dest_addr= (uint16_t*)(SectDir[entry->sect].text+
+entry->disp);
*dest_addr= value;
}else{

dest_addr= (uint16_t*)(SectDir[entry->sect].text+
+entry->disp);
*dest_addr= value-2-entry->disp;
}
CExprList.pool[prev].link= delComplexExpr(i);
i= prev;
}
}

return(!complexRefIsEmpty());
}
/*:105*//*106:*/
#line 1467 "linker.w"

static int
resolveTerms(ComplexExprEntry*entry){
int i,not_resolved,global;
uint16_t addr;

not_resolved= 0;
for(i= 0;i<entry->NumTerms;++i){
switch(entry->terms[i].code){
case CREL_OP_FETCH_GLOBAL:
global= findGlobalSym(entry->terms[i].un.name);
if(global==-1){
++not_resolved;
break;
}

entry->terms[i].code= CREL_OP_FETCH_CONSTANT;
entry->terms[i].un.constant= 
GSymDef[global].addr;
break;
case CREL_OP_FETCH_RELOCABLE:

global= curSections[entry->terms[i].un.inter.sect].global_sect;
addr= SectDir[global].start+
entry->terms[i].un.inter.disp;
entry->terms[i].un.constant= addr;
entry->terms[i].code= CREL_OP_FETCH_CONSTANT;
break;
default:;
}
}
return(not_resolved);
}

/*:106*//*107:*/
#line 1505 "linker.w"

static uint16_t
calcTerms(ComplexExprEntry*entry){
uint16_t stack[MAX_COMPLEX_TERMS];
uint16_t*sp;
ComplexTerm*term;
int i;

sp= stack;
for(i= 0;i<entry->NumTerms;++i){
term= entry->terms+i;
switch(term->code){
case CREL_OP_NONE:
break;
case CREL_OP_ADDITION:
*(sp-1)= *sp+*(sp-1);
--sp;
break;
case CREL_OP_SUBSTRACTION:
*(sp-1)= *(sp-1)-*sp;
--sp;
break;
case CREL_OP_MULTIPLICATION:
*(sp-1)= *sp**(sp-1);
--sp;
break;
case CREL_OP_DIVISION:
*(sp-1)= *(sp-1)/ *sp;
--sp;
break;
case CREL_OP_AND:
*(sp-1)= *sp&*(sp-1);
--sp;
break;
case CREL_OP_OR:
*(sp-1)= *sp|*(sp-1);
--sp;
break;
case CREL_OP_XOR:
*(sp-1)= *sp^*(sp-1);
--sp;
break;
case CREL_OP_NEG:
*sp= 0-*sp;
break;
case CREL_OP_COM:
*sp= ~*sp;
break;
case CREL_OP_STORE_RESULT:
case CREL_OP_STORE_RESULT_DISP:
entry->result_type= term->code;
break;
case CREL_OP_FETCH_CONSTANT:
*(++sp)= term->un.constant;
break;
default:
PRINTERR("Bad term code: %o\n",term->code);
}
}
return(*sp);
}

/*:107*//*116:*/
#line 1688 "linker.w"

static void fromRadix50(int n,char*name){
int i,x;

for(i= 2;i>=0;--i){
x= n%050;
n/= 050;
if(x<=032&&x!=0){
name[i]= x+'A'-1;
continue;
}
if(x>=036){
name[i]= x+'0'-036;
continue;
}
switch(x){
case 033:name[i]= '$';break;
case 034:name[i]= '.';break;
case 035:name[i]= '%';break;
case 000:name[i]= ' ';break;
}
}
name[3]= '\0';
}

/*:116*//*124:*/
#line 1767 "linker.w"

static error_t
parse_opt(int key,char*arg,struct argp_state*state){
Arguments*arguments;
arguments= (Arguments*)state->input;
switch(key){
case'l':
arguments->max_filename_len= atoi(arg);

if(arguments->max_filename_len<1+6+2)
arguments->max_filename_len= 1+1+6+2;
break;
case'v':
++arguments->verbosity;
break;
case'o':
if(strlen(arg)==0)
return(ARGP_ERR_UNKNOWN);
strncpy(arguments->output_filename,arg,FILENAME_MAX-1);
break;
case ARGP_KEY_ARG:

arguments->objnames= &state->argv[state->next-1];

state->next= state->argc;
break;
default:
break;
return(ARGP_ERR_UNKNOWN);
}
return(0);
}
/*:124*/
