
%{
	#include<stdio.h>

%}

%option nounput yylineno

%%
[ \t\n\r]   ;
";" { return(102) ;}
"," return (103);
"(" return (104);
")" return (105);
"{" return (106);
"}" return (107);
"[" return (108);
"]" return 109;
"<<" return 110;
">>" return 111;
"!=" return 121;
">=" return 122;
"<=" return 123;
"<" return 112;
">" return 113;
"#" return 114;
"+" return 115;
"-" return 116;
"*" return 117;
"%" return 118;
"/" return 119;
"==" return 120;
"=" return 124;
"&&" return 125;
"||" return 126;
"include" return 127;
"iostream" return 128;
"using" return 129;
"main" return 130;
"return" return 131;
"namespace" return 132;
"cin" return 133;
"cout" return 134;
"if" return 135;
"else" return 136;
"while" return 137;
"int" return 138;
"float" return 139;
"std" return 140;
"endl" return 141;
"\"" return 142;
[a-zA-Z][a-zA-Z0-9_]* return 100;
[+-]?[1-9][0-9]*|0|[+-]?[1-9][0-9]*\.[0-9]*[1-9]|[+-]?0\.[0-9]*[1-9] return 101;
. printf("unidentified \n");


%%
int yywrap(void)
{
	return 1;
}
