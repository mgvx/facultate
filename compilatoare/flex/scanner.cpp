#include<iostream>
#include<vector>
#include<string>
#include<stdio.h>
#include"lab3.h"
using namespace std;

extern int yylex();
extern int yylineno();
extern FILE* yyin;
extern char* yytext;

vector<int> pif, pif_val, symb_val, cons_val;
vector<string> symb, cons;
int symx = 400;
int consx = 600;

void printall() {
	printf("\nPIF TABLE\n");
	for(int i=0;i<pif.size();i++)
		cout<<pif[i]<<" "<<pif_val[i]<<"\n";
    fclose(yyin);

	printf("\nSYMBOL TABLE\n");
	for(int i=0; i<symb.size();i++)
		cout<<symb[i]<<" "<<symb_val[i]<<"\n";

	printf("\nCONSTS TABLE\n");
	for(int i=0; i<cons.size();i++)
		cout<<cons[i]<<" "<<cons_val[i]<<"\n";
}

void add_symbol(int x, string s) {
	for(int i=0; i<symb.size();i++){
		if(s==symb[i])
			return;
	}
	symb.push_back(s);
	symb_val.push_back(symx);
	symx++;
}

void add_constant(int x, string s) {
	for(int i=0; i<cons.size();i++){
		if(s==cons[i])
			return;
	}
	cons.push_back(s);
	cons_val.push_back(consx);
	consx++;
}

int main() {
	int x;
	yyin = fopen("../utils/p1.cpp", "r");
	yylex();
	x=yylex();
	while(x){
		pif.push_back(x);
		if (x==100){
			pif_val.push_back(1);
			add_symbol(x,yytext);
		}
		else if (x==101){
			pif_val.push_back(1);
			add_constant(x,yytext);
		}
		else {
			pif_val.push_back(0);
		}
		x=yylex();
	}
	printall();
	return 0;
}
