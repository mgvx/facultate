#ifndef GUI_H
#define GUI_H

#include <QtWidgets/QWidget>
#include "ui_gui.h"

#include "controller.h"

class gui : public QWidget, public Observer
{
	Q_OBJECT

public:
	gui(Controller &c, QWidget *parent = 0);
	~gui();
	void update() {
		populateList();
	}

private:
	Ui::guiClass ui;
	Controller &con;

	void populateList();
	int getListSelectedIndex();
	void connectSignalsAndSlots();

private slots:
	void listItemChanged();
	void addObject();
	void deleteObject();
};

#endif // GUI_H
