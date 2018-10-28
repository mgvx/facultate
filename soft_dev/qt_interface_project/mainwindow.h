#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QListWidget>
#include <QFormLayout>
#include <QLineEdit>
#include <QPushButton>
#include <QLabel>
#include "controller.h"

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    explicit MainWindow(Controller &c, QWidget *parent = 0);
    ~MainWindow();
    void initGUI();

private:
    Controller &con;
    std::vector<Cat> cats;
	std::vector<Cat> adopts;

    QListWidget* repoList;
    QListWidget* adoptList;

    QLineEdit* nameEdit;
    QLineEdit* breedEdit;
    QLineEdit* ageEdit;
    QLineEdit* linkEdit;

    QPushButton* addButton;
    QPushButton* deleteButton;
    QPushButton* adoptCatButton;
	QPushButton* unadoptCatButton;
	QPushButton* showHtmlButton;
	QPushButton* showCsvButton;

    void populateRepoList();
    void populateAdoptList();

    int getRepoListSelectedIndex();
	int getAdoptListSelectedIndex();

    void connectSignalsAndSlots();

private slots:
	void listItemChanged();
    void addCat();
    void deleteCat();
	void showHtml();
	void showCsv();

	void adoptCat();
    void unadoptCat();
};

#endif // MAINWINDOW_H
