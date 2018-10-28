%{
	#include<stdio.h>
	int yyerror(char *s);
	int yylex(void);
	extern int yydebug;
	extern FILE* yyin;

%}

%start program

%token id
%token assign_op
%token uop
%token logical_op
%token rel_op
%token op
%token incl
%token namesp
%token end
%token number
%token t_main
%token t_type
%token t_while
%token t_if
%token t_else
%token t_in
%token t_out
%token t_cin
%token t_cout


%%

program	: antet t_main comp_stmt { printf("corect\n"); }
	;

antet	: incl  namesp		{ ; }
	;

comp_stmt : '{' stmt_list '}'  { ; }
	;

stmt_list :			{ ; }
	  | stmt stmt_list	{ ; }
	  ;

stmt :	comp_stmt	{ ; }
     |	decl		{ ; }
     |  input		{ ; }
     |	output		{ ; }
     |	if_r		{ ; }
     |	loop		{ ; }
     |	end		{ ; }
     |	assign		{ ; }
     ;

decl :	t_type id ';'	{ ; }
	;

assign : id assign_op expr ';' { ; }
	| id uop ';'		{ ; }
	| uop id ';'		{ ; }
	;

loop	: t_while '(' cond ')' stmt	{ ; }
	;

cond	: cond logical_op cond	{ ; }
	| expr rel_op expr { ; }
	;

expr	:	 expr op expr  { ; }
	| number	{ ; }
	| id { ; }
	;

if_r	: t_if '(' cond ')' stmt else_r	{ ; }
	;

else_r	:		{ ; }
	|t_else stmt  { ; }
	;

output : t_cout out_r ';'		{ ; }
	;

out_r	:			{ ; }
	| t_out expr out_r	{ ; }
	| t_out '\n' { ; }
	;
input : t_cin in_r ';'		{ ; }
	;

in_r	:			{ ; }
	| t_in id in_r		{ ; }
	;



%%
 int main()
{
 yyin = fopen("lab1/p3.cpp", "r");
 
 return(yyparse());
 printf("corect\n");
}

int yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}
