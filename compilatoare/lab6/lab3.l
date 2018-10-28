
%{
	#define YYSTYPE char*
	#include"y.tab.h"
	extern char *yylval;

%}



%%
[ \t\n\r]*   ;
";" return ';';
"\\n" return '\n';
"\\r" ;
"{" return '{';
"}" return '}';
"int main()" ;return t_main;
"int"  return t_type;
"(" return '(';
")" return ')';
"float" return t_type;
"while" return t_while;
"#include<iostream>" return incl;
"using namespace std;" return namesp;
"if" return t_if;
"else" return t_else;
"cin" return t_cin;
"cout" return t_cout;
">>"	return t_in;
"<<"	return t_out;
"++" return uop;
"--" return uop;
"!=" return relational_op;
">=" return relational_op;
"<=" return relational_op;
"<" return relational_op;
">" return relational_op;
"+" return op;
"-" return op;
"*" return op;
"%" return op;
"/" return op;
"==" return relational_op;
"=" return assign_op;

"&&" return logical_op;
"||" return logical_op;
"return "[0-9]*";" return end;
[a-zA-Z][a-zA-Z]* { yylval=strdup(yytext); return id;}
[+-]?[1-9][0-9]*|0|[+-]?[1-9][0-9]*\.[0-9]*[1-9]|[+-]?0\.[0-9]*[1-9] { yylval=strdup(yytext); return number;}
. printf("unidentified  \n");


%%
int yywrap(void)
{
	return 1;
}
