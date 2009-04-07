#include "AppGL.h"

class BallController;
class GripControl;
class PalmControl;
#include <fstream>
#include <iostream>
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
	DVC::REAL PDGripControl2(DVC::REAL m_pdTarget, DVC::REAL m_Angle, DVC::REAL m_rvel);
	bool SetGrab(DVC::REAL adjust);
	bool SetGrab2(DVC::REAL adjust);
	bool Grip2Grab();
	bool Grip2PreGrab();
	bool Grip2Normal();
	bool Grip2Protect();
 	bool Palm2Position(DVC::REAL velocity, DVC::REAL x, DVC::REAL y, bool isVertical, bool isRightorUp);
	bool PalmStop();
	DVC::REAL Min(DVC::REAL x1, DVC::REAL x2);
 private:
  bool GetBodies();
  bool AddControllers();
  //void GoToPartCG();

  DVC::REAL m_torques[4];  
  std::string **gripName,
    **partName, *palmName,
    *ballName;

  KinematicalBody *palm;
  DynamicalBody **part, **grip,
    *ball;
  GripControl **gripController;
  PalmControl *palmController;
  BallController *ballController;
  bool shot;
//	ofstream testrecord;
	DVC::REAL partIntial[3]; //need initia
	DVC::REAL pedInitial;
	DVC::REAL grabLevel;
	DVC::REAL releaseLevel;
	DVC::REAL moveLevel;
	bool partDone[3];
	bool partGrab[3];
	bool partGrab2[3];
	int selectedPart;
int K;
bool isInitial;
};
