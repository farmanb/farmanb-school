#pragma once

#include <QMainWindow>

namespace prog{
  namespace qt{
  class MainWindow : public QMainWindow{
      Q_OBJECT
	public:
      MainWindow();
      ~MainWindow();
    };
  }
}
