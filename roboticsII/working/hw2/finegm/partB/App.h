#include "AppGL.h"

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
  int step;
  bool GetBodies();
  bool AddControllers();
  void GoToPartCG();
  DVC::Vector<DVC::REAL> palmPosition;

  DVC::REAL m_torques[4];  
  std::string **gripName,
    **partName, *palmName;

  KinematicalBody *palm;
  DynamicalBody **part, **grip;
  GripControl **gripController;
  PalmControl *palmController;
  int selectedPart;
};
