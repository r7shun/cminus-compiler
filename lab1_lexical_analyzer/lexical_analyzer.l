%option noyywrap

%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "lab1_lexical_analyzer/lexical_analyzer.h"
#include "common/common.h"


#ifndef LAB1_ONLY
#include "syntax_analyzer.h"
#endif

int files_count;
int lines;
int pos_start;
int pos_end ;
int  cmFlag;

void readyylval() {
	#ifndef LAB1_ONLY
	yylval.type_node = newSyntaxTreeNode(yytext);
	#endif
}

void readnumyylval() {
	#ifndef LAB1_ONLY
	yylval.type_node = newSyntaxTreeNodeFromNum(atoi(yytext));
	#endif
}


/*****************end*****************/

%}


digit       [0-9]
NUM         {digit}+
letter      [a-zA-Z]
ID          {letter}+


/*****************声明和选项设置  end*****************/


%%

 /******************TODO*********************/
 /****请在此补全所有flex的模式与动作  start******/
 /* should return token type!!! not just set a global varibale int type and 
  * let type = TYPE, misunderstand of yytex().
  */

\+          { readyylval(); return ADD; }
\-          { readyylval(); return SUB; }
\*          { readyylval(); return MUL; }
\/          { readyylval(); return DIV; }
\<\=        { readyylval(); return LTE; }
\<          { readyylval(); return LT; }
\>\=        { readyylval(); return GTE; }
\>          { readyylval(); return GT; }
\=\=        { readyylval(); return EQ; }
\!\=        { readyylval(); return NEQ; }
\=          { readyylval(); return ASSIN; }
\;          { readyylval(); return SEMICOLON; }
\,          { readyylval(); return COMMA; }
\(          { readyylval(); return LPARENTHESE; }
\)          { readyylval(); return RPARENTHESE; }
\[\]        { readyylval(); return ARRAY; }
\[          { readyylval(); return LBRACKET;}
\]          { readyylval(); return RBRACKET;}
\{          { readyylval(); return LBRACE;}
\}          { readyylval(); return RBRACE;}
else        { readyylval(); return ELSE;}
if          { readyylval(); return IF; }
int         { readyylval(); return INT; }
return      { readyylval(); return RETURN; }
void        { readyylval(); return VOID; }
while       { readyylval(); return WHILE;}
{ID}        { readyylval(); return IDENTIFIER; }
{NUM}       { readnumyylval(); return NUMBER; }
[ \t]       { 
				#ifdef LAB1_ONLY
					return BLANK;
				#endif
			}	
\n          {  
				lines++; 
				#ifdef LAB1_ONLY
					return EOL;
				#endif
			}
\r 			{  
				lines++;
				#ifdef LAB1_ONLY
					return EOL;
				#endif
			}
.           { return ERROR;}
\/\*        {   //cmFlag is the state varible, handle all kinds of comments
                cmFlag = 0;
                pos_end += strlen(yytext);
                char c;
                do {
                    c = input();
                    pos_end++;
                    if (c == '\n') {
                        pos_end = 1;
                        lines++;
                    }
                    if (cmFlag == 0 && c == '*') cmFlag = 1;
                    else if (cmFlag == 1 && c == '*') cmFlag = 1;
                    else if (cmFlag == 1 && c == '/') cmFlag = 2;
                    else cmFlag = 0;
                } while (cmFlag != 2);
                #ifdef LAB1_ONLY
					return COMMENT;
				#endif
            }




 /****请在此补全所有flex的模式与动作  end******/
%%
/****************C代码 start*************/

/// \brief analysize a *.cminus file
///
///	\param input_file_name
/// \param output_file_name
void analyzer(char* input_file_name, char* output_file_name){
	char input_path[256] = "./testcase/";
	strcat(input_path, input_file_name);
	char output_path[256] = "./tokens/";
	strcat(output_path, output_file_name);
	if (!(yyin = fopen(input_path,"r"))){
		printf("[ERR] No input file\n");
		exit(1);
	}
	printf("[START]: Read from: %s\n", input_file_name);
	FILE *fp = fopen(output_path,"w+");

	int token;
    lines = 1;
    pos_start = 1;
    pos_end = 1;
    //int kk = 0;
	while(token = yylex()){
		switch(token){
			case ERROR:
                	pos_end += strlen(yytext);
	        	fprintf(fp, "[ERR]: unable to analysize %s at %d line, from %d to %d\n", yytext, lines, pos_start, pos_end); 
                	pos_start = pos_end;
				break;
			case COMMENT: 
				//try TA-IMPL
				/***************************************************************/
				//int kk = 0;
				/**************************************************************/
				/*在case中间不能进行新设变量，所以我把int kk; 提前到了case前面*/
				/*这是原因的链接
				https://blog.csdn.net/qq_37600027/article/details/89503824
				*/
				/*
				for (kk = 0; kk < strlen(yytext); kk++) {
					if (yytext[kk] == '\n') {
						pos_start = pos_end = 1;
						lines++;
					}
					else {
						pos_end++;
					}
				}
				*/
				/* if it is a single line comment, pos_end changes and
				 * pos_start should change, too */
                pos_start = pos_end;
               	break;
			case BLANK:
              			  pos_start++;
              			  pos_end++;
				break;
			case EOL:
               			 pos_start = 1;
                		 pos_end = 1;
                		 
				break;
			case NUMBER:
				pos_end += strlen(yytext);
				fprintf(fp, "%d\t%d\t%d\t%d\t%d\n",atoi(yytext), token, lines, pos_start, pos_end);
				pos_start = pos_end;
				break;
			default:
                pos_end += strlen(yytext);
                fprintf(fp, "%s\t%d\t%d\t%d\t%d\n",yytext, token, lines, pos_start, pos_end);
            	pos_start = pos_end;
        }

	}
	fclose(fp);
	printf("[END]: Analysis completed.\n");
}


/// \brief process all *.cminus file
///
/// note that: use relative path for all i/o operations
int lex_main(int argc, char **argv){
	/***************************************************************/
	//char filename[10][256];
	/***************************************************************/
	char filename[100][256];//the number of testcases is more than 10
	char output_file_name[256];
	const char suffix[] = ".tokens";
	files_count = getAllTestcase(filename);
	for (int i = 0; i < files_count; i++){
            /* copy input filename's prefix to output filenames and add suffix */
            int j;
            for (j = 0; j < strlen(filename[i])-7; j++) 
                output_file_name[j] = filename[i][j];
            output_file_name[j] = '\0';
            //strncpy(output_file_name, filename[i], strlen(filename[i])-7);
            strcat(output_file_name, suffix);
			analyzer(filename[i],output_file_name);
	}
	return 0;
}
/****************C代码 end*************/
