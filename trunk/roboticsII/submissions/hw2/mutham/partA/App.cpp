#include "App.h"
#include "DvcCollisionResult.h"
#include "GripControl.h"
#include "PalmControl.h"

App::App(){
  part = 0;
  palm = 0;
 
  grip = new DynamicalBody*[4];
  gripController = new GripControl*[4];
  palmController = new PalmControl(palm);
  int phase = 0;

  for (unsigned int i = 0; i < 4; i++){
    grip[i] = 0;
    gripController[i] = 0;
  }

  
  
  palmName = new std::string("palm");
  gripName = new std::string*[4];
  gripName[0] = new std::string("grip1");
  gripName[1] = new std::string("grip2");
  gripName[2] = new std::string("grip3");
  gripName[3] = new std::string("grip4");
  partName = new std::string("part");



}

App::~App(){
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
    Enable all PD controllers 
    for (unsigned int i=0; i<4; i++)
		gripController[i]->TogglePD(true);

    GoToPartCG();*/

  DVC::REAL	t[4] = {2, 0, -2,0.0};

  SetGripTorques(t);

  /* 
     Example of how to move the base
     Because it is position controlled you have to move it very
     slowly, or else the joints will explode and dVC will crash.
  */
  DVC::Vector<DVC::REAL> basePos = GetPalmPos();
  SetPalmVelocity( 0.003 , -0.005 , 0);
  
  return true;
}

bool App::GetBodies(){
  if (part && grip[0] && grip[1] &&
      grip[2] && grip[3] && palm){
    return true;
  }

  if (!palm){
    if (!sim->GetBodyByNameMutable(*palmName, palm))
      return false;
  }

  if (!part)
    {
      if (!sim->GetBodyByNameMutable(*partName, part))
	return false;
    }
  
  for (int i = 0; i < 4; i++){
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

void App::PreStep()
{
 /* for (unsigned int i=0; i < 4; i++)
    {
      gripController[i]->SetTorque( m_torques[i]);
    }*/
}
/*
  This method is called after each timestep, but before rendering.
  This is the best place to write your code.  Not, you can also 
  create a PreStep method which will be called before each timestep.
*/
void App::PostStep(){
  bool gripInContact[4];
  bool grip2ground;
  DVC::REAL temptorque = 1;

  Vector <DVC::REAL> pos;
  palmController->GetPosition(temptorque, pos);
  std::cout << pos[0] << " " << pos[1] << std::endl;
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

 if(double(pos[0]) < -.45){
	gripController[0]->SetTorque(0);
	gripController[1]->SetTorque(0);
	gripController[2]->SetTorque(30);
	gripController[3]->SetTorque(-19.9);
	SetPalmVelocity( 0.001, 0, 0);
  }
 else{
 
  for (unsigned int i = 0; i < contacts.size(); i++){
    if (contacts[i]->distance > 1e-6) /* only look at real contacts, not potential */
      continue;

    std::string b1 = contacts[i]->b1->GetName(); /* Get the name of body 1*/
	std::cout<<b1;
    std::string b2 = contacts[i]->b2->GetName(); /* Get the name of body 2*/
    
	std::cout<<b2 <<std::endl;
	/* Check for contact between the grippers and the part*/
    for (unsigned int j=0; j < 4; j++){
      if (b1 == *gripName[j] && b2 == *partName || b1 == *partName && b2 == *gripName[j]){
		gripInContact[j] = true;
		gripContact[j] = *contacts[i];
	  }

	  if (b1 == "grip2" && b2 == "ground" || b1 == "ground" && b2 == "grip2")
		  grip2ground = true;
	  else
		  grip2ground = false;
		  
	}
  }

  if(gripInContact[3] == true && gripInContact[0] == false && gripInContact[1] == false){
	  gripController[2]->SetTorque(-50);
	  gripController[3]->SetTorque(-50);
	  SetPalmVelocity( 0 , 0.001 , 0);
  }
  else if(gripInContact[3] == true && gripInContact[0] == true && gripInContact[1] == false){
	  gripController[0]->SetTorque(60);
	  gripController[1]->SetTorque(60);
	  gripController[2]->SetTorque(-60);
	  gripController[3]->SetTorque(-60);
	  SetPalmVelocity( -0.005 , 0.005 , 0.0);
  }
  else if(gripInContact[0] == true && gripInContact[1] == true && gripInContact[2] == true && gripInContact[3] == true){
	  SetPalmVelocity(-.005, 0.005, 0.02);
	  temptorque = gripController[0]->GetTorque();
	  std::cout<< temptorque << std::endl;
	  gripController[0]->SetTorque(temptorque - 20);
	  temptorque = gripController[1]->GetTorque();
	  gripController[1]->SetTorque(temptorque - 20);
	  temptorque = gripController[2]->GetTorque();
	  gripController[2]->SetTorque(temptorque + 20);
	  temptorque = gripController[3]->GetTorque();
	  gripController[3]->SetTorque(temptorque + 20);
  }
 }

  for (unsigned int i=0; i<4; i++){
    if (gripInContact[i]){
      /* 
	 Now you have the contact: gripContact[i]
	 Note, the grip might have more than one contact point with the part.
	 The above code will only save the last contact...
      */

      
      gripContact[i].contactLoc[0];
      gripContact[i].contactLoc[1];
      gripContact[i].normalB1toB2[0];  /*Y component of contact normal in world frame*/
      gripContact[i].normalB1toB2[1];  /*Y component of contact normal in world frame*/
	  
	}

    /*
      The following code is commented out, but demonstrates
      how to get the vertices of the part body.
      The verts are in the part's frame.
      To get the verts in the world frame, you must
      get the part location ( part->GetQ() ) and transform
      the verts using translation and rotation.
    */
	
    
      const PolygonRepresentation * rep = static_cast<const PolygonRepresentation*>(part->GetModel()->GetGeomRepresentation());
      const std::vector< DVC::Vector<REAL> > & verts = rep->GetPolyVerts();
      for (unsigned int i = 0; i < verts.size(); ++i)
      {
      REAL vertX = verts[i][0];
      REAL vertY = verts[i][1];
      }    
  }
}
//
//void App::GoToPartCG(){
//
//DVC::Vector<DVC::REAL> partQ = part->GetQ();
//
//  /* Grip */
//  for (unsigned int i=0; i<4; i++)
//    gripController[i]->SetPDTarget(partQ[0], partQ[1]);
//}
