#include <QApplication>

#include "MainWindow.h"

/**
 *Entry point into the program.
 */
int main(int argc, char **argv){
  QApplication app(argc, argv);

  prog::qt::MainWindow window;
  window.show();
  
  return app.exec();
}
