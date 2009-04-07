#include "App.h"
#include "DvcCollisionResult.h"
#include "PalmControl.h"
#include "GripControl.h"
//#include <fstream>
//#include <iostream>
#define pi 3.1415926
#define RIGHT true
#define UP  true
#define LEFT false
#define DOWN false
#define VERTICAL true
#define HORIZONTAL false
App::App(){
  palm = 0;

  /*
    Allocate memory for the parts, grips and
    grip controllers.
  */
  part = new DynamicalBody*[3];
  grip = new DynamicalBody*[4];
  gripController = new GripControl*[4];
  
  /*
    Initialize the grips and gripControllers to 0.
   */
  for (unsigned int i = 0; i < 4; i++){
    grip[i] = 0;
    gripController[i] = 0;
  }

  /*
    Initialize the parts to 0.
  */
  for (unsigned int i=0; i<3; i++){
    part[i] = 0;
  }
  
  palmName = new std::string("palm");
  gripName = new std::string*[4];
  partName = new std::string*[4];
  gripName[0] = new std::string("grip1");
  gripName[1] = new std::string("grip2");
  gripName[2] = new std::string("grip3");
  gripName[3] = new std::string("grip4");
  partName[0] = new std::string("part1");
  partName[1] = new std::string("part2");
  partName[2] = new std::string("part3");
//	testrecord.open("/home/emma/hw2b.txt", ios::trunc|ios::out);
	for(unsigned int i=0; i<3; i++)
	{
		partIntial[i] = i*1.0; //need initia
		pedIntial[i] = i-3.0;
		partDone[i] = false;
		partGrab[i] = false;
		partGrab2[i] = false;
	}
	grabLevel = 0.75; 
	moveLevel = 1.75;
	releaseLevel = 1.3;
}

App::~App(){
  for (unsigned int i=0; i<3;i++){
    delete partName[i];
  }
  delete partName;
  
  for(unsigned int i=0; i<4; i++){
    if (gripController[i]){
      sim->RemoveAllBodyControllersByName(*gripName[i]);
      delete gripController[i];
    }

    grip[i] = 0;
    
    delete gripName[i];
  }

  delete palmController;

  delete gripController;
  delete gripName;
  delete grip;
//	testrecord.close();
}

bool App::Init(){
  if (!DVC_AppGL::Init()){
    return false;
  }
  
  if (!GetBodies()){
    printf("Error: App::Init:  AppGui failed to initialize.\n");
    return false;
  }

  for (unsigned int i=0; i<4; i++){
    for (unsigned int j=i; j<4; j++){
      grip[i]->AddBodyNotToCollideWith(grip[j]);
      grip[i]->AddBodyNotToCollideWith(palm);
    }
  }
  
  if (!AddControllers()){
    printf("Error:  App::Init: AppGui failed to initialize.\n");
    return false;
  }

  /*
    Select the part we wish to pick up.
   */
  selectedPart = 0;
	Grip2Normal();
 	Palm2Position(0.005, partIntial[selectedPart], 0, HORIZONTAL, RIGHT); 
  return true;
}

bool App::GetBodies(){
  if (!palm){
    if (!sim->GetBodyByNameMutable(*palmName, palm))
      return false;
  }

  for (unsigned int i=0; i<3; i++){
    if (!part[i]){
      if (!sim->GetBodyByNameMutable(*partName[i], part[i]))
			return false;
    }
  }
  
  for (unsigned int i = 0; i < 4; i++){
    if (!grip[i]){
      if (!sim->GetBodyByNameMutable(*gripName[i],grip[i]))
			return false;
    }
  }

  return true;
}

bool App::AddControllers(){
  if (!GetBodies())
    return false;

  if (palmController){
    sim->RemoveAllBodyControllersByName(*palmName);
  }
  
  palmController = new PalmControl(palm);  

  for (int i = 0; i < 4; i++){
    if (gripController[i]){
      sim->RemoveAllBodyControllersByName(*gripName[i]);
      delete gripController[i];
    }
    gripController[i] = new GripControl();
  }
  
  return sim->SetBodyControllerByName(*gripName[0], *gripController[0]) &&
    sim->SetBodyControllerByName(*gripName[1], *gripController[1]) &&
    sim->SetBodyControllerByName(*gripName[2], *gripController[2]) &&
    sim->SetBodyControllerByName(*gripName[3], *gripController[3]) &&
    sim->SetBodyControllerByName(*palmName, *palmController);
}

void App::PreStep(){
  for (unsigned int i=0; i<4; i++){
    gripController[i]->SetTorque(m_torques[i]);
  }
}


void App::PostStep() {

  bool gripInContact[4] = {false};
  DvcCollisionResult gripContact[4];
	int contactCount[4] = {0};
 	std::vector<DvcCollisionResultPtr> contacts;
	
	if(selectedPart <= 2)
	{
		DVC::Vector<DVC::REAL> palmP = GetPalmPos();
		DVC::Vector<DVC::REAL> partP = part[selectedPart]->GetQ();

		if (!sim->GetContactLocations( contacts )) return;

		for (unsigned int i = 0; i < contacts.size(); i++) {
			if (contacts[i]->distance > 1e-6) continue;
			std::string b1 = contacts[i]->b1->GetName(); 
			std::string b2 = contacts[i]->b2->GetName(); 
			for (unsigned int j=0; j < 4; j++){
				if ((b1 == *gripName[j] && b2 == *partName[selectedPart]) || (b1 == *partName[selectedPart] && b2 == *gripName[j])) {
					gripInContact[j] = true;
					gripContact[j] = *contacts[i];
					contactCount[j] ++;
				}
			}
		}

		if(!partDone[selectedPart] && !partGrab[selectedPart] && !partGrab2[selectedPart])
		{
			Grip2Normal();
			if(!Palm2Position(0.01, partIntial[selectedPart], 0, HORIZONTAL, RIGHT)) return;
			Grip2PreGrab();
			if(!Palm2Position(0.01, 0, grabLevel, VERTICAL, DOWN)) return;
			PalmStop();
			if(!Grip2Grab() || !SetGrab(15) || !gripInContact[1] || !gripInContact[3]) return;
			partGrab[selectedPart] = true;
			Palm2Position(0.01, 0, moveLevel, VERTICAL, UP);
			Grip2Grab();
			SetGrab(15);
		}
		else if(!partDone[selectedPart] && !partGrab2[selectedPart])
		{
			Grip2Grab();
			SetGrab(15);
			if(!Palm2Position(0.01, 0, moveLevel, VERTICAL, UP)) return;
			if(!Palm2Position(0.01, pedIntial[selectedPart], 0, HORIZONTAL, LEFT)) return;
			partGrab2[selectedPart] = true;
			Palm2Position(0.005, 0, releaseLevel, VERTICAL, DOWN);
		}
		else if(!partDone[selectedPart])
		{
			Grip2Grab();
			SetGrab(15);
			if(!Palm2Position(0.005, 0, releaseLevel, VERTICAL, DOWN)) return;
			PalmStop();
			if(!Grip2PreGrab() || gripInContact[1] || gripInContact[3]) return;
			partDone[selectedPart] = true;
			Palm2Position(0.01, 0, moveLevel, VERTICAL, UP);
			Grip2Normal();
		}
		else
		{
			Grip2Normal();
			if(!Palm2Position(0.005, 0, moveLevel, VERTICAL, UP)) return;
			PalmStop();
			selectedPart = selectedPart+1;
//			testrecord<<"Finish "<<selectedPart<<endl;
		}
	}
	else
	{
//		testrecord<<"Finish final"<<selectedPart<<endl;
		PalmStop();
		Grip2Normal();
	}
}


DVC::REAL App::FormatAngle(DVC::REAL x, DVC::REAL y, DVC::REAL theta)
{
	DVC::REAL angle;
	if(x*y == 0)
	{
		if(y>0)
		{
			angle = 90;
		}
		if(y<0)
		{
			angle = -90;
		}
		if(x>0)
		{
			angle = 0;
		}
		if(x<0)
		{
			angle = 180;
		}
	}
	else
	{
		angle = AngleConvert(theta/pi*180);
	}
	return angle;
}

DVC::REAL App::AngleConvert(DVC::REAL theta)
{
	while (theta > 180) theta -= 360;
	while (theta <= -180) theta += 360;
	return theta;
}

bool App::PalmStop()
{
	SetPalmVelocity(0,0,0);
	return true;
}
bool App::Palm2Position(DVC::REAL velocity, DVC::REAL x, DVC::REAL y, bool isVertical, bool isRightorUp)
{
	DVC::Vector<DVC::REAL> palmP = GetPalmPos();
	if (isVertical)
	{
		if(isRightorUp)
		{
			if(y <= palmP[1]) return true;
			SetPalmVelocity(0,velocity,0);
		}
		else
		{
			if(y >= palmP[1]) return true;
			SetPalmVelocity(0,-velocity,0);
		}
	}
	else
	{
		if(isRightorUp)
		{
			if(x <= palmP[0]) return true;
			SetPalmVelocity(velocity,0,0);
		}
		else
		{
			if(x >= palmP[0]) return true;
			SetPalmVelocity(-velocity,0,0);
		}
	}
	return false;
}

bool App::Grip2Normal()
{
	if (Grip2Position(-60,0,60,0)) return true;
	else return false;
}

bool App::Grip2PreGrab() //need modifi for the 2
{
	if (Grip2Position(-60,0,60,0)) return true;
	else return false;
}

bool App::Grip2Grab()
{
	if (Grip2Position(-40,70,40,-70)) return true;
	return false;
}

bool App::SetGrab(DVC::REAL adjust)
{
  m_torques[0] += adjust;
	m_torques[1] += adjust;
	m_torques[2] -= adjust;
	m_torques[3] -= adjust;
 	return true;
}


bool App::Grip2Position(DVC::REAL angle0, DVC::REAL angle1, DVC::REAL angle2, DVC::REAL angle3)
{
	DVC::Vector<DVC::REAL> gripQ0 = grip[0]->GetQ();
	DVC::Vector<DVC::REAL> gripQ1 = grip[1]->GetQ();
	DVC::Vector<DVC::REAL> gripQ2 = grip[2]->GetQ();
	DVC::Vector<DVC::REAL> gripQ3 = grip[3]->GetQ();
	DVC::Vector<DVC::REAL> gripV0 = grip[0]->GetNu();
	DVC::Vector<DVC::REAL> gripV1 = grip[1]->GetNu();
	DVC::Vector<DVC::REAL> gripV2 = grip[2]->GetNu();
	DVC::Vector<DVC::REAL> gripV3 = grip[3]->GetNu();
	DVC::REAL t[4];
	DVC::REAL a0, a1, a2, a3;

	a0 = FormatAngle(gripQ0[0], gripQ0[1], gripQ0[2]); 
	a1 = FormatAngle(gripQ1[0], gripQ1[1], gripQ1[2]); 
	a2 = FormatAngle(gripQ2[0], gripQ2[1], gripQ2[2]); 
	a3 = FormatAngle(gripQ3[0], gripQ3[1], gripQ3[2]); 
	t[0] = PDGripControl(angle0, a0, gripV0[2]/pi*180);
	t[1] = PDGripControl(angle1, a1, gripV1[2]/pi*180);
	t[2] = PDGripControl(angle2, a2, gripV2[2]/pi*180);	
	t[3] = PDGripControl(angle3, a3, gripV3[2]/pi*180);
	SetGripTorques(t);

//	testrecord<<"***GRIP: "<<gripQ0[0]<<" "<<gripQ0[1]<<" "<<gripQ0[2]<<endl;
	if(gripV0[2] < 1e-3 && gripV1[2] < 1e-3 && gripV2[2] < 1e-3 && gripV3[2] < 1e-3 && \
		 gripV0[1] < 1e-3 && gripV1[1] < 1e-3 && gripV2[1] < 1e-3 && gripV3[1] < 1e-3)
	{
		return true;
	}
	return false;
}

DVC::REAL App::PDGripControl(DVC::REAL m_pdTarget, DVC::REAL m_Angle, DVC::REAL m_rvel)
{
	DVC::REAL m_k = 81, m_c = sqrt(m_k);
	m_k *= 0.01;
	m_c *= 0.01;
	DVC::REAL outTorque = 0;
	DVC::REAL springTorque;
	DVC::REAL dampingTorque;
	DVC::REAL stretch = AngleConvert(m_pdTarget - m_Angle);

  if (stretch != 0){ /* They'll take away your birthday if you divide by 0...*/
  	springTorque= (m_k) * stretch;
    dampingTorque = -(m_c) * m_rvel;
 		outTorque = springTorque + dampingTorque;
	}
	//testrecord<<"Target: "<<m_pdTarget<<" Angle: "<<m_Angle<< " Stretch: "<<stretch<<" RVEL: "<<m_rvel<<" TORQUE: "<<outTorque<<endl;
	return outTorque;
}
 

bool App::SetGripTorques(DVC::REAL torques[4]){
  for (int i=0; i< 4; i++){
    m_torques[i] = torques[i];
  }

  return true;
}

void App::SetPalmVelocity(DVC::REAL x,DVC::REAL y, DVC::REAL rot){
  if (palmController){
    DVC::Vector<DVC::REAL> q(3);
    q[0] = x;
    q[1] = y;
    q[2] = rot;
    palmController->SetVel(q);
  }
}

const DVC::Vector<DVC::REAL>& App::GetPalmPos(){
  return palm->GetQ();
}
