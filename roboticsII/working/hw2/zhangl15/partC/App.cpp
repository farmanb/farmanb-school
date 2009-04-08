#include "App.h"
#include "DvcCollisionResult.h"
#include "GripControl.h"
#include "PalmControl.h"
#include "BallController.h"
#define pi 3.1415926
#define RIGHT true
#define UP  true
#define LEFT false
#define DOWN false
#define VERTICAL true
#define HORIZONTAL false
App::App(){
  shot = false;
  part = 0;
  palm = 0;
  ball = 0;
  
  grip = new DynamicalBody*[4];
	part = new DynamicalBody*[4];
  gripController = new GripControl*[4];
  ballController = 0;

  for (unsigned int i = 0; i < 4; i++){
    grip[i] = 0;
		part[i] = 0;
    gripController[i] = 0;
  }
  
  palmName = new std::string("palm");
	partName = new std::string*[4];
  gripName = new std::string*[4];
  gripName[0] = new std::string("grip1");
  gripName[1] = new std::string("grip2");
  gripName[2] = new std::string("grip3");
  gripName[3] = new std::string("grip4");
  partName[0] = new std::string("part1");
	partName[1] = new std::string("part2");
	partName[2] = new std::string("part3");
	partName[3] = new std::string("part");
  ballName = new std::string("ball");

	pedInitial = 0;
	for(unsigned int i=0; i<3; i++)
	{
		partIntial[i] = 1.0 + i*1.0; //need initia
		partDone[i] = false;
		partGrab[i] = false;
		partGrab2[i] = false;
	}
	grabLevel = 0.75; 
	moveLevel = 1.45;
	releaseLevel = 1.25;
//	testrecord.open("/home/emma/hw2c.txt", ios::trunc|ios::out);
}

App::~App(){
  
  for(unsigned int i=0; i<4; i++){
    if (gripController[i]){
      sim->RemoveAllBodyControllersByName(*gripName[i]);
      delete gripController[i];
    }

    grip[i] = 0;
 		delete partName[i];   
    delete gripName[i];
  }
	//testrecord.close();
  delete palmController;
  delete partName;
  delete gripController;
  delete gripName;
  delete grip;
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
	K=0;
  selectedPart = 2;
	Grip2Normal();
 	Palm2Position(0.005, 0, moveLevel, VERTICAL, UP); 
isInitial = true;
  return true;
}

bool App::GetBodies(){
  if (part[0] && part[1] && part[2] && part[3] \
			&& grip[0] && grip[1] && grip[2] && grip[3] && palm && ball) {
    return true;
  }

  if (!ball){
    if(!sim->GetBodyByNameMutable(*ballName, ball))
      return false;
  }
  
  if (!palm){
    if (!sim->GetBodyByNameMutable(*palmName, palm))
      return false;
  }

  for (int i = 0; i < 4; i++){
    if (!grip[i]){
      if (!sim->GetBodyByNameMutable(*gripName[i],grip[i])) return false;
    }
		if (!part[i]){
			if (!sim->GetBodyByNameMutable(*partName[i],part[i])) return false;
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
  
  if (ballController){
    sim->RemoveAllBodyControllersByName(*ballName);
    delete ballController;
  }
  
  ballController = new BallController(ball);

  return sim->SetBodyControllerByName(*gripName[0], *gripController[0]) &&
    sim->SetBodyControllerByName(*gripName[1], *gripController[1]) &&
    sim->SetBodyControllerByName(*gripName[2], *gripController[2]) &&
    sim->SetBodyControllerByName(*gripName[3], *gripController[3]) &&
    sim->SetBodyControllerByName(*ballName, *ballController) &&
    sim->SetBodyControllerByName(*palmName, *palmController);
}

void App::PreStep()
{
  for (unsigned int i=0; i < 4; i++)
    {
      gripController[i]->SetTorque( m_torques[i]);
    }
}

/*
  This method is called after each timestep, but before rendering.
  This is the best place to write your code.  Not, you can also 
  create a PreStep method which will be called before each timestep.
*/
void App::PostStep(){

  /* 
     Make sure the ball only gets 'shot'
     once .
  */
  if (shot) ballController->ShouldShoot(false);
  DVC::REAL t = sim->GetSimTime();
  /* Reset the ball before t = 5 */
  if ((int)t % 4 < 1){
      DVC::REAL newQ[3];
      DVC::REAL newNu[3];
      newNu[0] = newNu[1] = newNu[2] = (DVC::REAL)0;
      newQ[0] = (DVC::REAL)-2;
      newQ[1] = (DVC::REAL).05;
      newQ[2] = (DVC::REAL)0;
      ball->SetNu(newNu);
      ball->SetQ(newQ);
      shot = false;
  }
  /* Shoot the ball at t ~ 5 */
  if (((int)t % 5) < 1 && t > 5){
    shot = true;
	 // shot = false;
   ballController->ShouldShoot(true);
	//ballController->ShouldShoot(false);
  }
    
  bool gripInContact[4] = {false};
	bool ballContact[4]={false};
	int contactCount[4] = {0};
  DvcCollisionResult gripContact[4];
  std::vector<DvcCollisionResultPtr> contacts;
	K=0;
  if (!sim->GetContactLocations( contacts )) return;
	if(selectedPart >= 0 && selectedPart <= 2)
	{
		DVC::Vector<DVC::REAL> palmP = GetPalmPos();
		DVC::Vector<DVC::REAL> partP = part[selectedPart]->GetQ();
		bool isPotential = false;
		for (unsigned int i = 0; i < contacts.size(); i++) {
			if (contacts[i]->distance > 1e-6) 
			{
				if(contacts[i]->distance > 1e-2) continue;
				else isPotential = true;
			}
			std::string b1 = contacts[i]->b1->GetName(); 
			std::string b2 = contacts[i]->b2->GetName(); 
//testrecord<<t<< " "<< b1<<" "<<b2<<endl;
			for (unsigned int j=0; j < 4; j++){

				if (!isPotential && ((b1 == *gripName[j] && b2 == *partName[selectedPart]) || (b1 == *partName[selectedPart] && b2 == *gripName[j]))) {
					gripInContact[j] = true;
					gripContact[j] = *contacts[i];
					contactCount[j] ++;
				}
				if ((b1 == *gripName[j] && b2 == *ballName) || \
						(b1 == *ballName && b2 == *gripName[j])) {
					ballContact[j] = true;
				}
			}
		}

		for (unsigned int i=0; i<4; i++) {
			if (ballContact[i])
			{
				K = 1440;
				DVC::Vector<DVC::REAL> gripNu = grip[i]->GetNu();
				PalmStop();
			//	testrecord <<"ball Contact, torque: "<<m_torques[i]<<" nux: "<<gripNu[0]<<" nuy: "<<gripNu[1]<<endl;
			}
		}
if(selectedPart == 2)
{
		if(isInitial)
		{
			Grip2Normal();
			if(Palm2Position(0.03,0,moveLevel,VERTICAL,UP)) return;
			isInitial = false;
		}
		if(!partDone[selectedPart] && !partGrab[selectedPart] && !partGrab2[selectedPart])
		{
			Grip2Normal();
			if(!Palm2Position(0.02, partIntial[selectedPart], 0, HORIZONTAL, RIGHT)) goto HANDLEBALL;
			Grip2PreGrab();
			if(!Palm2Position(0.02, 0, grabLevel, VERTICAL, DOWN)) goto HANDLEBALL;
			PalmStop();
			if(!Grip2Grab() || !SetGrab(15) || !gripInContact[1] || !gripInContact[3]) goto HANDLEBALL;
			partGrab[selectedPart] = true;
			Palm2Position(0.02, 0, moveLevel, VERTICAL, UP);
			Grip2Grab();
			SetGrab(15);
		}
		else if(!partDone[selectedPart] && !partGrab2[selectedPart])
		{
			Grip2Grab();
			SetGrab(15);
			if(!Palm2Position(0.02, 0, moveLevel, VERTICAL, UP)) goto HANDLEBALL;
			if(!Palm2Position(0.01, pedInitial, 0, HORIZONTAL, LEFT)) goto HANDLEBALL;
			partGrab2[selectedPart] = true;
			Palm2Position(0.002, 0, releaseLevel, VERTICAL, DOWN);
		}
		else if(!partDone[selectedPart])
		{
			Grip2Grab();
			SetGrab(15);
			if(!Palm2Position(0.002, 0, releaseLevel, VERTICAL, DOWN)) goto HANDLEBALL;
			PalmStop();
			if(!Grip2PreGrab() || gripInContact[1] || gripInContact[3]) goto HANDLEBALL;
			partDone[selectedPart] = true;
			Palm2Position(0.02, 0, moveLevel, VERTICAL, UP);
			Grip2Normal();
		}
		else
		{
			Grip2Normal();
			if(!Palm2Position(0.04, 0, moveLevel+0.5, VERTICAL, UP)) goto HANDLEBALL;
			PalmStop();
			selectedPart = selectedPart-2;;
			moveLevel+=0.5;
			releaseLevel+=0.4;
//			testrecord<<"Finish "<<selectedPart<<endl;
		}
}
else if(selectedPart == 0)
{
		if(!partDone[selectedPart] && !partGrab[selectedPart] && !partGrab2[selectedPart])
		{
			Grip2Normal();
			if(!Palm2Position(0.04, partIntial[selectedPart], 0, HORIZONTAL, RIGHT)) goto HANDLEBALL;
			Grip2PreGrab();
			if(!Palm2Position(0.04, 0, grabLevel, VERTICAL, DOWN)) goto HANDLEBALL;
			PalmStop();
			if(!Grip2Grab() || !SetGrab(15) || !gripInContact[1] || !gripInContact[3]) goto HANDLEBALL;
			partGrab[selectedPart] = true;
			Palm2Position(0.03, 0, moveLevel, VERTICAL, UP);
			Grip2Grab();
			SetGrab(15);
		}
		else if(!partDone[selectedPart] && !partGrab2[selectedPart])
		{
			Grip2Grab();
			SetGrab(15);
			if(!Palm2Position(0.03, 0, moveLevel, VERTICAL, UP)) goto HANDLEBALL;
			if(!Palm2Position(0.01, pedInitial, 0, HORIZONTAL, LEFT)) goto HANDLEBALL;
			partGrab2[selectedPart] = true;
			Palm2Position(0.003, 0, releaseLevel, VERTICAL, DOWN);
		}
		else if(!partDone[selectedPart])
		{
			Grip2Grab();
			SetGrab(15);
			if(!Palm2Position(0.003, 0, releaseLevel, VERTICAL, DOWN)) goto HANDLEBALL;
			PalmStop();
			Grip2PreGrab();
			if(gripInContact[1] || gripInContact[3]) goto HANDLEBALL;
			partDone[selectedPart] = true;
			Palm2Position(0.03, 0, moveLevel, VERTICAL, UP);
			Grip2Normal();
		}
		else
		{
			Grip2Normal();
			if(!Palm2Position(0.03, 0, moveLevel+0.4, VERTICAL, UP)) goto HANDLEBALL;
			PalmStop();
			selectedPart = selectedPart+1;
			moveLevel+=0.5;
			releaseLevel+=0.45;
//			testrecord<<"Finish "<<selectedPart<<endl;
		}
}
	else
	{
			Grip2Protect();
			if(!Palm2Position(0.02, -0.9, 0, HORIZONTAL, LEFT)) return;
			if(!Palm2Position(0.02, 0, 0.8, VERTICAL, DOWN)) return;
			PalmStop();
			Grip2Normal();
			return;
	}
}
HANDLEBALL:
        if((abs((palm->GetQ())[0]) < 0.05 && ((int)t%5>=3 || (int)t%5==0) && (ball->GetQ())[0]<0.2 &&partDone[selectedPart])) 
	{
		PalmStop();
	//	testrecord<<"Precaution:"<<endl;
		if(selectedPart!=2) 
		{
		   Palm2Position(0.01, 0, 1.59, VERTICAL, DOWN);
		   Grip2Protect();
		//   SetGrab2(30);
		}                                                         
	}
        return;

}

/*bool App::BallContactGrip()
{
	DVC::Vector<DVC::REAL> ballP = ball->GetQ();
	DVC::Vector<DVC::REAL> grip1P = grip1->GetQ();
	DVC::Vector<DVC::REAL> grip2P = grip2->GetQ();
	if()
}
*/
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

DVC::REAL App::Min(DVC::REAL x1, DVC::REAL x2)
{
	if (x1>x2) return x2;
	else return x1;
}
bool App::Palm2Position(DVC::REAL velocity, DVC::REAL x, DVC::REAL y, bool isVertical, bool isRightorUp)
{
	DVC::Vector<DVC::REAL> palmP = GetPalmPos();
	DVC::REAL tmp, k=0.9;
	if (isVertical)
	{
		if(isRightorUp)
		{
			if(y <= palmP[1]) return true;
                        tmp = k*(y-palmP[1])+0.005;
			SetPalmVelocity(0, Min(velocity, tmp),0);
		}
		else
		{
			if(y >= palmP[1]) return true;
			tmp = k*(palmP[1]-y)+0.005;
			SetPalmVelocity(0,-Min(velocity, tmp),0);
		}
	}
	else
	{
		if(isRightorUp)
		{
			if(x <= palmP[0]) return true;
			tmp = k*(x-palmP[0])+0.005;
			SetPalmVelocity(Min(velocity, tmp),0,0);
		}
		else
		{
			if(x >= palmP[0]) return true;
			tmp = k*(palmP[0]-x)+0.005;
			SetPalmVelocity(-Min(velocity, tmp),0,0);
		}
	}
	return false;
}


bool App::Grip2Normal()
{
	if (Grip2Position(-60,-10,60,10)) return true;
	else return false;
}

bool App::Grip2PreGrab() //need modifi for the 2
{
	if (Grip2Position(-60,-10,60,10)) return true;
	else return false;
}

bool App::Grip2Grab()
{
	if (Grip2Position(-40,70,40,-70)) return true;
	return false;
}

bool App::Grip2Protect()
{
	if (Grip2Position(-30,40,30,-40)) return true;
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

bool App::SetGrab2(DVC::REAL adjust)
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
	t[0] = PDGripControl2(angle0, a0, gripV0[2]/pi*180);
	t[1] = PDGripControl2(angle1, a1, gripV1[2]/pi*180);
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
	DVC::REAL m_k = 81, m_c;
	m_c = sqrt(m_k)	;
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

DVC::REAL App::PDGripControl2(DVC::REAL m_pdTarget, DVC::REAL m_Angle, DVC::REAL m_rvel)
{
	DVC::REAL m_k = 81, m_c;
	if(K != 0) m_k = K; 
	m_c = sqrt(m_k)	;
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

 
