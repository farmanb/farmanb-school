#include "AppGL.h"
#include "HandControl.h"
class BallController;
class GripControl;

class App : public DVC_AppGL{
 public:
  App();
  ~App();
  
  bool Init();
  void PostStep();

 private:
  bool GetBodies();
  bool AddControllers();
  void GoToPartCG();
  
  std::string **gripName,
    *partName, *palmName,
    *ballName;

  DynamicalBody *part, **grip,
    *palm, *ball;
  GripControl **gripController;
  BallController *ballController;
  HandControl *handController;
  bool shot;
};
