%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common/common.h"
#include "syntax_tree/SyntaxTree.h"

#include "lab1_lexical_analyzer/lexical_analyzer.h"

// external functions from lex
extern int yylex();
extern int yyparse();
extern int yyrestart();
extern FILE * yyin;

// external variables from lexical_analyzer module
extern int lines;
extern char * yytext;

// Global syntax tree.
SyntaxTree * gt;

void yyerror(const char * s);
%}


/* declared types */
%union {
/********** TODO: Fill in this union structure *********/
		/******************************************************************************/
		//SyntaxTreeNode * type_node;
		/******************************************************************************/
		struct _SyntaxTreeNode * type_node;//issues 
}

/********** TODO: Your token definition here ***********/
%token <type_node>   ERROR    258   
%token <type_node>	ADD    259   
%token <type_node>	SUB    260   
%token <type_node>	MUL    261   
%token <type_node>	DIV    262   
%token <type_node>	LT    263   
%token <type_node>	LTE    264   
%token <type_node>	GT    265   
%token <type_node>	GTE    266   
%token <type_node>	EQ    267   
%token <type_node>	NEQ    268   
%token <type_node>	ASSIN    269   
%token <type_node>	SEMICOLON    270   
%token <type_node>	COMMA    271   
%token <type_node>	LPARENTHESE    272   
%token <type_node>	RPARENTHESE    273   
%token <type_node>	LBRACKET    274   
%token <type_node>	RBRACKET    275   
%token <type_node>	LBRACE    276   
%token <type_node>	RBRACE    277   
%token <type_node>	ELSE    278   
%token <type_node>	IF    279   
%token <type_node>	INT    280   
%token <type_node>	RETURN    281   
%token <type_node>	VOID    282   
%token <type_node>	WHILE    283   
%token <type_node>	IDENTIFIER    284   
%token <type_node>	NUMBER    285   
%token <type_node>	ARRAY    286   
%token <type_node>	LETTER    287   

%type <type_node> program declaration_list declaration var_declaration
%type <type_node> type_specifier fun_declaration params param_list param
%type <type_node> compound_stmt local_declarations statement_list statement
%type <type_node> expression_stmt selection_stmt iteration_stmt return_stmt
%type <type_node> expression var simple_expression relop additive_expression
%type <type_node> addop term mulop factor call args arg_list


%right ASSIN
%left ADD SUB
%left MUL DIV
%left LPARENTHESE RPARENTHESE

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
/* compulsory starting symbol */
%start program

%%
/*************** TODO: Your rules here *****************/
program: declaration_list {
		$$ = newSyntaxTreeNode("program");
		gt->root = $$;
		SyntaxTreeNode_AddChild($$, $1);
	}
;

declaration_list: declaration_list declaration {
		$$ = newSyntaxTreeNode("declaration-list");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
	} 
	| declaration {
		$$ = newSyntaxTreeNode("declaration-list");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

declaration: var_declaration {
		$$ = newSyntaxTreeNode("declaration");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| fun_declaration {
		$$ = newSyntaxTreeNode("declaration");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

var_declaration: type_specifier IDENTIFIER SEMICOLON {
		$$ = newSyntaxTreeNode("var-declaration");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
	| type_specifier IDENTIFIER LBRACKET NUMBER RBRACKET SEMICOLON {
		$$ = newSyntaxTreeNode("var-declaration");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
		SyntaxTreeNode_AddChild($$, $5);
		SyntaxTreeNode_AddChild($$, $6);
	}
;

type_specifier: INT {
		$$ = newSyntaxTreeNode("type-specifier");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| VOID {
		$$ = newSyntaxTreeNode("type-specifier");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

fun_declaration: type_specifier IDENTIFIER LPARENTHESE params RPARENTHESE compound_stmt {
		$$ = newSyntaxTreeNode("fun-declaration");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
		SyntaxTreeNode_AddChild($$, $5);
		SyntaxTreeNode_AddChild($$, $6);
	}
;

params: param_list {
		$$ = newSyntaxTreeNode("params");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| VOID {
		$$ = newSyntaxTreeNode("params");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

param_list: param_list COMMA param {
		$$ = newSyntaxTreeNode("param-list");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);	
	}
	| param {
		$$ = newSyntaxTreeNode("param-list");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

param: type_specifier IDENTIFIER {
		$$ = newSyntaxTreeNode("param");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
	}
	| type_specifier IDENTIFIER ARRAY { //NOT [ & ], BUT []
		$$ = newSyntaxTreeNode("param");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
;

compound_stmt: LBRACE local_declarations statement_list RBRACE {
		$$ = newSyntaxTreeNode("compound-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
	}
;

local_declarations: local_declarations var_declaration {
		$$ = newSyntaxTreeNode("local-declarations");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
	}
	| /* EMPTY */ {
		$$ = newSyntaxTreeNode("local-declarations");
		SyntaxTreeNode * e = newSyntaxTreeNode("epsilon");
		SyntaxTreeNode_AddChild($$, e);
	}
;

statement_list: statement_list statement{
		$$ = newSyntaxTreeNode("statement-list");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
	} 
	| /* empty */{
		$$ = newSyntaxTreeNode("statement-list");
		SyntaxTreeNode * e = newSyntaxTreeNode("epsilon");
		SyntaxTreeNode_AddChild($$, e);
	}
;

statement: expression_stmt {
		$$ = newSyntaxTreeNode("statement");
		SyntaxTreeNode_AddChild($$, $1);
	} 
	| compound_stmt {
		$$ = newSyntaxTreeNode("statement");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| selection_stmt {
		$$ = newSyntaxTreeNode("statement");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| iteration_stmt {
		$$ = newSyntaxTreeNode("statement");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| return_stmt {
		$$ = newSyntaxTreeNode("statement");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

expression_stmt: expression SEMICOLON {
		$$ = newSyntaxTreeNode("expression-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
	}
	| SEMICOLON {
		$$ = newSyntaxTreeNode("expression-stmt");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

selection_stmt: IF LPARENTHESE expression RPARENTHESE statement %prec LOWER_THAN_ELSE {
		$$ = newSyntaxTreeNode("selection-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
		SyntaxTreeNode_AddChild($$, $5);
	}
	| IF LPARENTHESE expression RPARENTHESE statement ELSE  statement {
		$$ = newSyntaxTreeNode("selection-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
		SyntaxTreeNode_AddChild($$, $5);
		SyntaxTreeNode_AddChild($$, $6);
		SyntaxTreeNode_AddChild($$, $7);
	}
;

iteration_stmt: WHILE LPARENTHESE expression RPARENTHESE statement {
		$$ = newSyntaxTreeNode("iteration-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
		SyntaxTreeNode_AddChild($$, $5);
	}
;

return_stmt: RETURN SEMICOLON {
		$$ = newSyntaxTreeNode("return-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
	}
	| RETURN expression SEMICOLON {
		$$ = newSyntaxTreeNode("return-stmt");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
;

expression: var ASSIN expression {
		$$ = newSyntaxTreeNode("expression");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	} 
	| simple_expression {
		$$ = newSyntaxTreeNode("expression");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

var: IDENTIFIER {
		$$ = newSyntaxTreeNode("var");
		SyntaxTreeNode_AddChild($$, $1);
	} 
	| IDENTIFIER LBRACKET expression RBRACKET {
		$$ = newSyntaxTreeNode("var");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
	}
;

simple_expression: additive_expression relop additive_expression {
		$$ = newSyntaxTreeNode("simple-expression");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
	| additive_expression {
		$$ = newSyntaxTreeNode("simple-expression");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

relop: LTE {
		$$ = newSyntaxTreeNode("relop");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| LT {
		$$ = newSyntaxTreeNode("relop");
		SyntaxTreeNode_AddChild($$, $1);
	} 
	| GT {
		$$ = newSyntaxTreeNode("relop");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| GTE {
		$$ = newSyntaxTreeNode("relop");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| EQ {
		$$ = newSyntaxTreeNode("relop");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| NEQ {
		$$ = newSyntaxTreeNode("relop");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

additive_expression: additive_expression addop term {
		$$ = newSyntaxTreeNode("additive-expression");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
	 | term {
		$$ = newSyntaxTreeNode("additive-expression");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

addop: ADD {
		$$ = newSyntaxTreeNode("addop");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| SUB {
		$$ = newSyntaxTreeNode("addop");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

term: term mulop factor {
		$$ = newSyntaxTreeNode("term");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	} 
	| factor {
		$$ = newSyntaxTreeNode("term");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

mulop: MUL {
		$$ = newSyntaxTreeNode("mulop");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| DIV {
		$$ = newSyntaxTreeNode("mulop");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

factor: LPARENTHESE expression RPARENTHESE {
		$$ = newSyntaxTreeNode("factor");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
	| var {
		$$ = newSyntaxTreeNode("factor");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| call {
		$$ = newSyntaxTreeNode("factor");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| NUMBER {
		$$ = newSyntaxTreeNode("factor");
		SyntaxTreeNode_AddChild($$, $1);
	}
;

call: IDENTIFIER LPARENTHESE args RPARENTHESE {
		$$ = newSyntaxTreeNode("call");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, $4);
	}
;

args: arg_list {
		$$ = newSyntaxTreeNode("args");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| /*empty*/ {
		$$ = newSyntaxTreeNode("args");
		SyntaxTreeNode * e = newSyntaxTreeNode("epsilon");
		SyntaxTreeNode_AddChild($$, e);
	}
;

arg_list: arg_list COMMA expression {
		$$ = newSyntaxTreeNode("arg-list");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
	| expression {
		$$ = newSyntaxTreeNode("arg-list");
		SyntaxTreeNode_AddChild($$, $1);
	}
;




%%

void yyerror(const char * s)
{
	// TODO: variables in Lab1 updates only in analyze() function in lexical_analyzer.l
	//       You need to move position updates to show error output below
	//fprintf(stderr, "%s:%d syntax error for %s\n", s, yylineno, yytext);
	fprintf(stderr, "%s:%d syntax error for %s\n", s, lines, yytext);
}

/// \brief Syntax analysis from input file to output file
///
/// \param input basename of input file
/// \param output basename of output file
void syntax(const char * input, const char * output)
{
	gt = newSyntaxTree();

	char inputpath[256] = "./testcase/";
	char outputpath[256] = "./syntree/";
	strcat(inputpath, input);
	strcat(outputpath, output);

	if (!(yyin = fopen(inputpath, "r"))) {
		fprintf(stderr, "[ERR] Open input file %s failed.", inputpath);
		exit(1);
	}
	yyrestart(yyin);
	printf("[START]: Syntax analysis start for %s\n", input);
	FILE * fp = fopen(outputpath, "w+");
	if (!fp)	return;

	// yyerror() is invoked when yyparse fail. If you still want to check the return value, it's OK.
	// `while (!feof(yyin))` is not needed here. We only analyze once.
	lines = 1;
	yyparse();

	printf("[OUTPUT] Printing tree to output file %s\n", outputpath);
	printSyntaxTree(fp, gt);
	deleteSyntaxTree(gt);
	gt = 0;

	fclose(fp);
	printf("[END] Syntax analysis end for %s\n", input);
}

/// \brief starting function for testing syntax module.
///
/// Invoked in test_syntax.c
int syntax_main(int argc, char ** argv)
{	/******************************************************************************************/
	//char filename[10][256];
	/******************************************************************************************/
	char filename[100][256];//number of testcases is more than 10
	char output_file_name[256];
	const char * suffix = ".syntax_tree";
	int fn = getAllTestcase(filename);
	for (int i = 0; i < fn; i++) {
			int name_len = strstr(filename[i], ".cminus") - filename[i];
			strncpy(output_file_name, filename[i], name_len);
			strcpy(output_file_name+name_len, suffix);
			syntax(filename[i], output_file_name);
	}
	return 0;
}
