#pragma once

#include "AppGL.h"

class PalmControl;
class GripControl;

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
  void GoToPartCG();
  void WrapAroundPart();

  DVC::REAL m_torques[4];  
  std::string **gripName,
    *partName, *palmName;
  int controlInt;

  KinematicalBody *palm;
  PalmControl *palmController;
  DynamicalBody *part, **grip;
  GripControl **gripController;
};