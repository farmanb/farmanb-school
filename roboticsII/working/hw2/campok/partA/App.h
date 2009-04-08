#include "AppGL.h"
#include "GripControl.h"

class App : public DVC_AppGL{
 public:
  App();
  ~App();
  DVC::REAL x_ref;
  DVC::REAL y_ref;
   DVC::REAL x0, y0, x1, y1, x2, y2, x3, y3;
  int state;
  int timer;
  //1 - attempting surround
  //2 - push in left arm
  //3 - close form
  //4 - lift
  //5 - return
  //6 - release
  bool Init();
  void PostStep();

 private:
  bool GetBodies();
  bool AddControllers();
  void GoToPartCG();
  
  std::string **gripName,
    *partName, *palmName;

  DynamicalBody *part, **grip, *palm;
  GripControl **gripController;
};
