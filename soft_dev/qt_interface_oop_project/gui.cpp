#include "gui.h"

gui::gui(Controller &c, QWidget *parent)
	: QWidget(parent), con(c)
{
	ui.setupUi(this);
	QWidget::setWindowTitle(QString::fromStdString("MERGE!"));
	connectSignalsAndSlots();
	populateList();
}

gui::~gui()
{

}

void gui::populateList() {
	ui.list->clear();
	for (auto it : con.getAll()) {
		QString s = QString::fromStdString(it.toString());
		ui.list->addItem(new QListWidgetItem(s));
	}
}

void gui::connectSignalsAndSlots()
{
	QObject::connect(ui.list, SIGNAL(itemSelectionChanged()), this, SLOT(listItemChanged()));
	QObject::connect(ui.addButton, SIGNAL(clicked()), this, SLOT(addObject()));
	QObject::connect(ui.remButton, SIGNAL(clicked()), this, SLOT(deleteObject()));
}

int gui::getListSelectedIndex() {
	auto v = ui.list->selectedItems();
	if (v.size() == 0)
		return -1;
	return ui.list->row(v[0]);
}

void gui::listItemChanged()
{
	auto v = con.getAll();
		int idx = this->getListSelectedIndex();
	if (idx == -1 || idx >= v.size())
		return;

	Object x = v[idx];
	ui.nameEdit->setText(QString::fromStdString(x.getName()));
	ui.numEdit->setText(QString::fromStdString(to_string(x.getNum())));
}

void gui::addObject() {
	string name = ui.nameEdit->text().toStdString();
	int num = ui.numEdit->text().toInt();
	Object t(name, num);
	con.addObject(t);
}

void gui::deleteObject() {
	string name = ui.nameEdit->text().toStdString();
	int num = ui.numEdit->text().toInt();
	Object t(name, num);
	con.remObject(t);
}
