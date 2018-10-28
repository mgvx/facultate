#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtCore/QFile>
#include <QtCore/QTextStream>
#include <QMessageBox>
using namespace std;

MainWindow::MainWindow(Controller &c, QWidget *parent) : con(c), QWidget(parent)
{
    this->initGUI();
    this->populateRepoList();
    this->populateAdoptList();
}
MainWindow::~MainWindow(){}

void MainWindow::initGUI()
{
    //General layout of the window
    QHBoxLayout* layout = new QHBoxLayout{this};

    // Prepare left side components - vertical layout with:
    QWidget* leftWidget = new QWidget{};
    QVBoxLayout* leftSide = new QVBoxLayout{ leftWidget };

    // list
    this->repoList = new QListWidget{};
    // set the selection model
    this->repoList->setSelectionMode(QAbstractItemView::SingleSelection);

    // song data
    QWidget* catDataWidget = new QWidget{};
    QFormLayout* formLayout = new QFormLayout{catDataWidget};
    this->nameEdit = new QLineEdit{};
    this->breedEdit = new QLineEdit{};
    this->ageEdit = new QLineEdit{};
    this->linkEdit = new QLineEdit{};
    formLayout->addRow("&Name:", nameEdit);
    formLayout->addRow("&Breed:", breedEdit);
    formLayout->addRow("&Age:", ageEdit);
    formLayout->addRow("&Link:", linkEdit);

    // buttons
    QWidget* buttonsWidget = new QWidget{};
    QGridLayout* gridLayout = new QGridLayout{ buttonsWidget };
    this->addButton = new QPushButton("Add");
    this->deleteButton = new QPushButton("Delete");
    gridLayout->addWidget(addButton, 0, 0);
    gridLayout->addWidget(deleteButton, 0, 1);

    // add everything to the left layout
    leftSide->addWidget(new QLabel{"All Cats"});
    leftSide->addWidget(repoList);
    leftSide->addWidget(catDataWidget);
    leftSide->addWidget(buttonsWidget);

    // middle component: just two button - to add the songs from the reposiotory to the playlist
    QWidget* middleWidget = new QWidget{};
    QVBoxLayout* vLayoutMiddle = new QVBoxLayout{ middleWidget };
    this->adoptCatButton = new QPushButton{ ">> Adopt" };
	this->unadoptCatButton = new QPushButton{ "<< Unadopt" };
    QWidget* upperPart = new QWidget{};
	QWidget* lowerPart = new QWidget{};
    QVBoxLayout* vLayoutUpperPart = new QVBoxLayout{ upperPart };

	vLayoutUpperPart->addWidget(this->adoptCatButton);
	vLayoutUpperPart->addWidget(this->unadoptCatButton);
	vLayoutMiddle->addWidget(upperPart);
	vLayoutMiddle->addWidget(lowerPart);

    // right component
    QWidget* rightWidget = new QWidget{};
    QVBoxLayout* rightSide = new QVBoxLayout{ rightWidget };

    adoptList = new QListWidget{};
    QWidget* adoptListButtonsWidget = new QWidget{};
    QHBoxLayout* adoptListButtonsLayout = new QHBoxLayout{ adoptListButtonsWidget };
	this->showHtmlButton = new QPushButton("Show HTML");
	this->showCsvButton = new QPushButton("Show CSV");
    adoptListButtonsLayout->addWidget(showHtmlButton, 0, 0);
	adoptListButtonsLayout->addWidget(showCsvButton, 0, 0);

    // add everything to the right layout
    rightSide->addWidget(new QLabel{ "Adopt List" });
    rightSide->addWidget(adoptList);
    rightSide->addWidget(adoptListButtonsWidget);

    // add the three layouts to the main layout
    layout->addWidget(leftWidget);
    layout->addWidget(middleWidget);
    layout->addWidget(rightWidget);

    this->connectSignalsAndSlots();
}

void MainWindow::connectSignalsAndSlots()
{
    QObject::connect(this->repoList, SIGNAL(itemSelectionChanged()), this, SLOT(listItemChanged()));

    QObject::connect(this->addButton, SIGNAL(clicked()), this, SLOT(addCat()));
    QObject::connect(this->deleteButton, SIGNAL(clicked()), this, SLOT(deleteCat()));
    QObject::connect(this->adoptCatButton, SIGNAL(clicked()), this, SLOT(adoptCat()));
	QObject::connect(this->unadoptCatButton, SIGNAL(clicked()), this, SLOT(unadoptCat()));
	QObject::connect(this->showHtmlButton, SIGNAL(clicked()), this, SLOT(showHtml()));
	QObject::connect(this->showCsvButton, SIGNAL(clicked()), this, SLOT(showCsv()));
}

void MainWindow::populateRepoList()
{
	this->cats.clear();
	for (auto s : this->con.getAllCats())
	{
		if (s.getAdopt() == 0)
			this->cats.push_back(s);
	}
    if (this->repoList->count() > 0)
        this->repoList->clear();
    for (int i = 0; i < this->cats.size(); ++i)
    {
        QString itemInList = QString::fromStdString(this->cats[i].getName()+" of breed "+ this->cats[i].getBreed() +", "+ to_string(this->cats[i].getAge())+" years old");
        this->repoList->addItem(itemInList);
    }
    if (this->cats.size() > 0)
        this->repoList->setCurrentRow(0);
}

void MainWindow::populateAdoptList()
{
	this->adopts.clear();
	for (auto s : this->con.getAllCats())
	{
		if (s.getAdopt() != 0)
			this->adopts.push_back(s);
	}
    if (this->adoptList->count() > 0)
        this->adoptList->clear();
    for (int i = 0; i < this->adopts.size(); ++i)
    {
        if(this->adopts[i].getAdopt()!=0)
        {
        QString itemInList = QString::fromStdString(this->adopts[i].getName()+" of breed "+ this->adopts[i].getBreed() +", "+ to_string(this->adopts[i].getAge())+" years old");
        this->adoptList->addItem(itemInList);
        }
    }
}


void MainWindow::addCat()
{
    std::string name = this->nameEdit->text().toStdString();
    std::string breed = this->breedEdit->text().toStdString();
    int age = this->ageEdit->text().toInt();
    std::string source = this->linkEdit->text().toStdString();
    try
    {
        this->con.addCat(name, breed, age, source);
        this->cats = this->con.getAllCats();
        this->populateRepoList();
    }
    catch (CatException& e)
    {
        QMessageBox messageBox;
        messageBox.critical(0, "Error", QString::fromStdString(e.what()));
    }
	this->populateRepoList();
}

void MainWindow::deleteCat()
{
    std::string name = this->nameEdit->text().toStdString();
    try
    {
        this->con.remCat(name);
        this->cats = this->con.getAllCats();
        this->populateRepoList();
    }
    catch (CatException& e)
    {
        QMessageBox messageBox;
        messageBox.critical(0, "Error", QString::fromStdString(e.what()));
    }
	this->populateRepoList();
}

int MainWindow::getRepoListSelectedIndex()
{
    if (this->repoList->count() == 0)
        return -1;
    QModelIndexList index = this->repoList->selectionModel()->selectedIndexes();
    if (index.size() == 0)
    {
        this->nameEdit->clear();
        this->breedEdit->clear();
        this->ageEdit->clear();
        this->linkEdit->clear();
        return -1;
    }
    int idx = index.at(0).row();
    return idx;
}

int MainWindow::getAdoptListSelectedIndex()
{
	if (this->adoptList->count() == 0)
		return -1;
	QModelIndexList index = this->adoptList->selectionModel()->selectedIndexes();
	if (index.size() == 0)
		return -1;
	int idx = index.at(0).row();
	return idx;
}

void MainWindow::listItemChanged()
{
    int idx = this->getRepoListSelectedIndex();
    if (idx == -1 || idx >= this->cats.size())
        return;
    if (idx >= this->cats.size())
        return;

    Cat s = this->cats[idx];
    this->nameEdit->setText(QString::fromStdString(s.getName()));
    this->breedEdit->setText(QString::fromStdString(s.getBreed()));
    this->ageEdit->setText(QString::fromStdString(to_string(s.getAge())));
    this->linkEdit->setText(QString::fromStdString(s.getPhoto()));
}

void MainWindow::adoptCat()
{
    int idx = this->getRepoListSelectedIndex();
    if (idx == -1 || idx >= this->cats.size())
        return;
    if (idx >= this->cats.size())
        return;

    Cat s = this->cats[idx];
    this->con.adoptCat(s.getName(),1);
    this->populateRepoList();
    this->populateAdoptList();
}

void MainWindow::unadoptCat()
{
	int idx = this->getAdoptListSelectedIndex();
	if (idx == -1 || idx >= this->adopts.size())
		return;
	if (idx >= this->adopts.size())
		return;

	Cat s = this->adopts[idx];
	this->con.adoptCat(s.getName(), 0);
	this->populateRepoList();
	this->populateAdoptList();
}

void MainWindow::showHtml()
{
	this->con.show_html();
}
void MainWindow::showCsv()
{
	this->con.show_csv();
}
