#include "mainwindow.h"
#include <QApplication>
#include <QMessageBox>

int main(int argc, char *argv[])
{
    QApplication prog(argc, argv);
    Repository repo;
    Controller con {repo};
    MainWindow w{con};
    w.show();
    return prog.exec();
}
