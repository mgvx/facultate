#pragma once
#include <string>

using namespace std;

class Exception : public exception
{
public:
	Exception(string s) :msg(s) {}
	~Exception() {};
	const char * what()
	{
		return msg.c_str();
	}
private:
	string msg;
};

/*
throw Exception("...");

#include <qmessagebox.h>
try {
	...
} catch (Exception &e) {
	QMessageBox::critical(this, "...", QString(e.what()), QMessageBox::Ok, QMessageBox::Ok);
}
*/

/*
void show()
{
LPCWSTR prog = L"notepad.exe";
LPCWSTR link = L"export.csv";
ShellExecute(NULL, NULL, prog, link, NULL, SW_SHOWNORMAL);
}*/
