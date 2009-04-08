#include "App.h"
#include "DvcCollisionResult.h"
#include "PalmControl.h"
#include "GripControl.h"
#include <iostream>

using namespace std;

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
  controlInt = 0;
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
  
  //Enable all PD controllers
	StartFingerControl();

  DVC::REAL	t[4] = {2,0,-2,0.0};

  SetGripTorques(t);

  GoToPartCG();
    
  /*
    Example of how to move the palm.
    Because it is position controlled you have to move it very
    slowly, otherwise the joints will explode and dVC will crash.
  */
  DVC::Vector<DVC::REAL> basePos = GetPalmPos();
  SetPalmVelocity( 0 , 0.005 , 0);
  
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

/*
  This method is called after each timestep, but before rendering.
  This is the best place to write your code.  Not, you can also 
  create a PreStep method which will be called before each timestep.
*/
void App::PostStep(){
  bool gripInContact[4];
  
  for (unsigned int i=0; i < 4; i++)
    gripInContact[i] = false;

  DvcCollisionResult gripContact[4];

  /*
    The following code finds all the contact
    points in the simulation.

    The members of DvcCollisionResult are:
	
    Body *b1, *b2;
    REAL normalB1toB2[2];
    REAL contactLoc[2], b1ContactLoc[2], b2ContactLoc[2];
    REAL distance;
	
    b1 and b2 are the bodies in contact
    normalB1toB2 is the contact normal
    distance is the distance between B1 and B2 at the contact
    If distance is > 0, then it is a potential contact.
    Potential contact mean the bodies are close, but not touching.
    Negative distance implies penetration.
    When testing for a distance of zero, dont use == 0, use > 1e-6.
    contactLoc is the point of contact
    b1ContactLoc and b2ContactLoc are the contact locations on the body.
    For potential contacts, b1ContactLoc and b2ContactLoc might not be equal
    For real contacts, contactLoc = b1ContactLoc = b2ContactLoc.

    Get all the contacts from the previous step (including potential contacts)
  */
  std::vector<DvcCollisionResultPtr> contacts;
  if (!sim->GetContactLocations( contacts ))
    return;

  for (unsigned int i = 0; i < contacts.size(); i++){
    if (contacts[i]->distance > 1e-6) /* only look at real contacts, not potential */
      continue;

    std::string b1 = contacts[i]->b1->GetName(); /* Get the name of body 1*/
    std::string b2 = contacts[i]->b2->GetName(); /* Get the name of body 2*/

    /* Check for contact between the grippers and the part*/
    for (unsigned int j=0; j < 4; j++){
      if (b1 == *gripName[j] && b2 == *partName[selectedPart] ||
	  b1 == *partName[selectedPart] && b2 == *gripName[j]){
	gripInContact[j] = true;
	gripContact[j] = *contacts[i];
      }
    }
  }

	//Get the position of the hand
	DVC::Vector<DVC::REAL> handPosition = GetPalmPos();
	handX = handPosition[0];
	handY = handPosition[1];
	//Variable to play with the velocity of the hand
	double velocity = .01;

	//Move down
	if(controlInt == 0)
	{
		//Set the velocity of the hand
		SetPalmVelocity( 0 , -velocity , 0);
		//Set the locations where the fingers and joints should point
		OpenPalm();
		//If the hand has gotten low enough
		if( handY < .85)
			controlInt = 1;
	}
	//Close hand and move up
	else if(controlInt == 1)
	{
		SetPalmVelocity( 0 , velocity , 0);
		ClosePalm();
		if( handY > 1.45)
			controlInt = 2;
	}
	//Move to the left
	else if(controlInt == 2)
	{
		SetPalmVelocity( -velocity , 0 , 0);
		ClosePalm();
		if( handX < -2.9)
			controlInt = 3;
	}
	//Release the Controller and drop on first pedestal and move up
	else if(controlInt == 3)
	{
		SetPalmVelocity( 0 , velocity , 0);
		OpenPalm();
		if( handY > 2)
			controlInt = 4;
	}
	//Move the hand to the right
	else if(controlInt == 4)
	{
		SetPalmVelocity( velocity , 0 , 0);
		OpenPalm();
		if( handX > 1)
			controlInt = 5;
	}
	//Lower the hand
	else if(controlInt == 5)
	{
		SetPalmVelocity( 0 , -velocity , 0);
		OpenPalm();
		if( handY < .85)
			controlInt = 6;
	}
	//Move up and close the hand
	else if(controlInt == 6)
	{
		SetPalmVelocity( 0 , velocity , 0);
		ClosePalm();
		if( handY > 1.45)
			controlInt = 7;
	}
	//Move to the left
	else if(controlInt == 7)
	{
		SetPalmVelocity( -velocity , 0 , 0);
		ClosePalm();
		if( handX < -1.9)
			controlInt = 8;
	}
	
	//Release the Controller and drop on second pedestal and move up
	else if(controlInt == 8)
	{
		SetPalmVelocity( 0 , velocity , 0);	
		OpenPalm();
		if( handY > 2)
			controlInt = 9;
	}

	//Move the hand to the right
	else if(controlInt == 9)
	{
		SetPalmVelocity( velocity , 0 , 0);
		OpenPalm();
		if( handX > 2)
			controlInt = 10;
	}
	//Lower the hand and close
	else if(controlInt == 10)
	{
		SetPalmVelocity( 0 , -velocity , 0);
		OpenPalm();
		if( handY < .85)
			controlInt = 11;
	}

	//Move up and close the hand
	else if(controlInt == 11)
	{
		SetPalmVelocity( 0 , velocity , 0);
		ClosePalm();
		if( handY > 1.45)
			controlInt = 12;
	}
	//Move to the left
	else if(controlInt == 12)
	{
		SetPalmVelocity( -velocity , 0 , 0);
		ClosePalm();
		if( handX < -1.0)
			controlInt = 13;
	}	
	//Slowly lower the block onto the third pedestal
	else if(controlInt == 13)
	{
		SetPalmVelocity( 0 , -.0005 , 0);
		ClosePalm();
		if( handY < 1.40)
			controlInt = 14;
	}
	//Release the Controller and drop on second pedestal and move up
	else if(controlInt == 14)
	{
		SetPalmVelocity( 0 , velocity , 0);
		OpenPalm();
		if( handY > 3)
		{
			controlInt = 15;
			//Stop movement of the palm
			SetPalmVelocity( 0 , 0 , 0);
		}
	}
}


  void App::GoToPartCG(){

  DVC::Vector<DVC::REAL> partQ = part[selectedPart]->GetQ();

  for (unsigned int i=0; i<4; i++)
  gripController[i]->SetPDTarget(partQ[0], partQ[1]);
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

void App::ClosePalm()
{
		gripController[3]->SetPDTarget(handX-.2, handY-1.5);
		gripController[2]->SetPDTarget(handX+1, handY-.1);
		gripController[1]->SetPDTarget(handX+.2, handY-1.5);
		gripController[0]->SetPDTarget(handX-1, handY-.1);
}

void App::OpenPalm()
{
		gripController[3]->SetPDTarget(handX+1, handY-3);
		gripController[2]->SetPDTarget(handX+1, handY-.1);
		gripController[1]->SetPDTarget(handX-1, handY-3);
		gripController[0]->SetPDTarget(handX-1, handY-.1);
}

void App::StartFingerControl()
{
		gripController[3]->TogglePD(true);
		gripController[2]->TogglePD(true);
		gripController[1]->TogglePD(true);
		gripController[0]->TogglePD(true);
}