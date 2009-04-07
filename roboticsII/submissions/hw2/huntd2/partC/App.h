#include "AppGL.h"

class BallController;
class GripControl;
class PalmControl;

class App : public DVC_AppGL{
 public:
  App();
  ~App();
  
  bool Init();
  void PostStep();
  void PreStep();
  
  bool SetGripTorques(DVC::REAL torques[4]);
  void SetPalmVelocity(DVC::REAL x,DVC::REAL y, DVC::REAL rot);
  const DVC::Vector<DVC::REAL>& GetPalmPos();

 private:
  bool GetBodies();
  bool AddControllers();
  //void GoToPartCG();

  DVC::REAL m_torques[4];  
  std::string **gripName,
    *partName, *palmName,
    *ballName;

  KinematicalBody *palm;
  DynamicalBody *part, **grip,
    *ball;
  GripControl **gripController;
  PalmControl *palmController;
  BallController *ballController;
  bool shot;
  int state;
  DVC::REAL temp;
};
