%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#define YYSTYPE char*
	int yyerror(char *s);
	int yylex(void);
	extern int yydebug;
	extern FILE* yyin;

	extern char yytext[];
	char *yylval;
	const char *before[100];
	const char *after[100];
	int n=-1;
	int i;

%}

%start program

%token id
%token assign_op
%token uop
%token logical_op
%token relational_op
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

program	: antet t_main comp_stmt { n+=1; before[n]="data ends\ncode segment\nstart:\n";

																					for(i=0;i<n;i++) printf("%s",before[i]);}
	;

antet	: incl  namesp		{n+=1; before[n]="assume cs:code,ds:data\ndata segment\n";}
	;

comp_stmt : '{' stmt_list '}'  { ;}
	;

stmt_list :			{ ;}
	  | stmt stmt_list	{ ;}
	  ;

stmt :	comp_stmt	{ ;}
     |	decl		{ ;}
     |  input		{ ;}
     |	output		{ ;}
     |	if_r		{ ;}
     |	end		{ ;}
     |	assign		{ ;}
     ;

decl :	t_type id ';'	{  n+=1; before[n]=" t dw ";
													n+=1; before[n] = yylval; }
	;

assign : id assign_op expr ';' { n+=1; before[n]="";}
	| id uop ';'		{ ;}
	| uop id ';'		{ ;}
	;


cond	: expr relational_op expr {n+=1; before[n]="\nmov ax, ";
																	n+=1; before[n]=$1;
																	n+=1; before[n]="\nmov bx, ";
																	n+=1; before[n]=$3;
																	n+=1; before[n]="\ncmp ax,bx\n jle label";
																	}
	;

expr	: id		{ ;}
	| expr op expr  { ;}
	| number	{ ;}
	;

if_r	: t_if '(' cond ')' stmt	{n+=1; before[n]="\nmov ax, ";
																n+=1; before[n]=$1;
																n+=1; before[n]="\nmov bx,";
																n+=1; before[n]=$4;
																n+=1; before[n]="\ncmp ax,bx\n .label\n";}
	;

output : t_cout out_r ';'		{ n+=1; before[n]="\ncall writeOutput\nmov ";
																n+=1; before[n]=$3;
																n+=1; before[n]=",bx\n";
																}

out_r	:			{ ;}
	| t_out expr out_r	{ ;}
	| t_out '\n'	{ ;}
	;
input : t_cin in_r ';'		{		n+=1; before[n]="\ncall readInput\nmov ";
																n+=1; before[n]=$3;
																n+=1; before[n]=",bx\n";
																}
	;

in_r	:			{ ;}
	| t_in id in_r		{ ;}
	;


%%
 int main()
{
 yyin = fopen("lab1/p1.cpp", "r");
 printf("\n");
 return(yyparse());
}

int yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}
