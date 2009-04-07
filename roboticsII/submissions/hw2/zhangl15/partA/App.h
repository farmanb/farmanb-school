#pragma once

#include "AppGL.h"
#include <fstream>
#include <iostream>
class PalmControl;
class GripControl;
using namespace std;
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
	bool Grip2Position(DVC::REAL angle0, DVC::REAL angle1, DVC::REAL angle2, DVC::REAL angle3);
	DVC::REAL PDGripControl(DVC::REAL m_pdTarget, DVC::REAL m_Angle, DVC::REAL m_rvel);
	DVC::REAL AngleConvert(DVC::REAL theta);
	DVC::REAL FormatAngle(DVC::REAL x, DVC::REAL y, DVC::REAL theta);
	bool SetGrab(DVC::REAL adjust);
	bool Grip2Grab();
	bool Grip2PreGrab();
	bool Grip2Normal();
	bool Palm2Position(DVC::REAL velocity, DVC::REAL x, DVC::REAL y, bool isVertical, bool isRightorUp);
	bool PalmStop();
  
 private:
  bool GetBodies();
  bool AddControllers();
  //void GoToPartCG();

  DVC::REAL m_torques[4];  
  std::string **gripName,
    *partName, *palmName;
	//ofstream testrecord;
  KinematicalBody *palm;
  PalmControl *palmController;
  DynamicalBody *part, **grip;
  GripControl **gripController;
	REAL palmIX, palmIY;
	int status;
};
