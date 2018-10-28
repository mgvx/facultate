#include "gui.h"
#include <QtWidgets/QApplication>

#include "observer.h"
#include "test.h"

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	Test test;
	Repository repo;
	Controller con{ repo };
	/*
	gui w{ con };
	w.show();
	*/

	vector <gui *> windows;
	for (int i = 0; i < 3; i++) 
	{
		gui* w = new gui{ con };
		w->show();
		repo.attach((Observer*)w);
		windows.push_back(w);
	}

	return a.exec();
}
