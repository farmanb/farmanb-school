//------------------------------
// 
// APP.CPP - PART A
// 
//------------------------------
//
//
// INCLUDES
//===================================
#include "App.h"
#include "DvcCollisionResult.h"
#include <iostream>
using namespace std;

// part = object to pick up
// palm = black link
// grip = 4 links
// gripController = pointers to 4 grip controllers

//
//
// APP CONSTRUCTOR
//===================================
App::App(){
  // INITIALIZE OBJECTS IN SCENE
  part = 0;		// object to pick up
  palm = 0;		// black object link (hand)
  grip = new DynamicalBody*[4];		// 4 links
  gripController = new GripControl*[4];	// 4 controllers for the link
  
  //SET CONTROLLERS TO ZERO
  for (unsigned int i = 0; i < 4; i++){
    grip[i] = 0;
    gripController[i] = 0;
  }
  
  // these names must be the same ones used in the xml file
  // ATTACH POINTERS TO STRINGS
  palmName = new std::string("palm");
  gripName = new std::string*[4];
  gripName[0] = new std::string("grip1");
  gripName[1] = new std::string("grip2");
  gripName[2] = new std::string("grip3");
  gripName[3] = new std::string("grip4");
  partName = new std::string("part");
}


//
//
// APP DESTRUCTOR - DELETE APP
//===================================
App::~App(){
  // DELETE POINTERS TO STRINGS
  delete partName;

  // DELETE GRIP CONTROLLERS
  for(unsigned int i=0; i<4; i++){
    if (gripController[i]){
      sim->RemoveAllBodyControllersByName(*gripName[i]);
      delete gripController[i];
    }
    grip[i] = 0;
    delete gripName[i];
  }
  delete gripController;
  delete gripName;
  delete grip;
}


//
//
// INITIALIZE - TURNS OFF COLLISION
// BETWEEN PIECES OF GOAL
//===================================
bool App::Init(){
	state = 1;
	count = 0;

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

  /*Enable all PD controllers*/
  for (unsigned int i=0; i<4; i++)
    gripController[i]->TogglePD(true);

  //GoToPartCG();
  return true;
}


//
//
// GET BODIES
// THIS FUNCTION GETS KINEMATICALBODY
// POINTERS TO EACH PIECE OF THE GOAL
//===================================
bool App::GetBodies(){
  if (part && grip[0] && grip[1] &&
      grip[2] && grip[3] && palm){
    return true;
  }

  if (!palm){
    if (!sim->GetBodyByNameMutable(*palmName, palm))
      return false;
  }

  if (!part){
    if (!sim->GetBodyByNameMutable(*partName, part));
  }
  
  for (int i = 0; i < 4; i++){
    if (!grip[i]){
      if (!sim->GetBodyByNameMutable(*gripName[i],grip[i]))
	return false;
    }
  }

  return true;
}

//
//
// ADD CONTROLLER - ATTACH POINTER CONTROLLER TO BODIES
//===================================
bool App::AddControllers(){
  if (!GetBodies())
    return false;
  
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
    sim->SetBodyControllerByName(*gripName[3], *gripController[3]);
}


//
//
// POST STEP - CALLED AFTER TIMESTEP, BEFORE RENDERING
//===================================
/*
  This method is called after each timestep, but before rendering.
  This is the best place to write your code.  Not, you can also 
  create a PreStep method which will be called before each timestep.
*/
void App::PostStep(){

	// MY CODE
	if (state == 1) {
		if (count > 20) {
			count = 0;
			state = 2;
		}
		gripController[0]->SetPDTarget(0, 2);
		gripController[1]->SetPDTarget(0, 0);
		gripController[2]->SetPDTarget(1, 2);
		gripController[3]->SetPDTarget(1, 0);
		count++;
	}
	else if (state == 2) {
		if (count > 35) {
			count = 0;
			state = 3;
		}
		gripController[0]->SetPDTarget(0, 2);
		gripController[1]->SetPDTarget(0, 0);
		gripController[2]->SetPDTarget(1, 0);
		gripController[3]->SetPDTarget(0, 0);
		count++;
	}
	else if (state == 3) {
		if (count > 40) {
			count = 0;
			state = 4;
		}
		gripController[0]->SetPDTarget(0, 1);
		gripController[1]->SetPDTarget(0.5, 1);
		gripController[2]->SetPDTarget(1, 1);
		gripController[3]->SetPDTarget(0, 1);
		count++;
	}
	else if (state == 4) {
		if (count > 100) {
			count = 0;
			state = 5;
		}
		gripController[0]->SetPDTarget(-1, 1);
		gripController[1]->SetPDTarget(-0.5, 0.5);
		gripController[2]->SetPDTarget(0, 1);
		gripController[3]->SetPDTarget(-0.5, 0.5);
		count++;
	}
	else if (state == 5) {
		if (count > 25) {
			count = 0;
			state = 6;
		}
		gripController[0]->SetPDTarget(-1, 1);
		gripController[1]->SetPDTarget(-0.5, 1);
		gripController[2]->SetPDTarget(0, 1);
		gripController[3]->SetPDTarget(0.5, 0);
		count ++;
	}
	else if (state == 6) {
		gripController[0]->SetPDTarget(-1, 2);
		gripController[1]->SetPDTarget(-0.5, 2);
		gripController[2]->SetPDTarget(0, 2);
		gripController[3]->SetPDTarget(0.5, 2);

	}


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

    Get all the contacts from the previous step (including potential contacts) */

  // GET CONTACTS
  std::vector<DvcCollisionResultPtr> contacts;
  if (!sim->GetContactLocations( contacts ))
    return;

  // FOR EACH CONTACT
  for (unsigned int i = 0; i < contacts.size(); i++){
	/* only look at real contacts, not potential */
	if (contacts[i]->distance > 1e-6) 
      continue;

    std::string b1 = contacts[i]->b1->GetName(); /* Get the name of body 1*/
    std::string b2 = contacts[i]->b2->GetName(); /* Get the name of body 2*/

    /* Check for contact between the grippers and the part*/
	// scroll through 4 grip names to see if anyone is in contact
    for (unsigned int j=0; j < 4; j++){
      if (b1 == *gripName[j] && b2 == *partName || b1 == *partName && b2 == *gripName[j]){
			// set contact to true
			gripInContact[j] = true;
			// save a pointer to contact
			gripContact[j] = *contacts[i];
      }
    }
  }

  // GO THROUGH EACH LINK TO PART CONTACT ARRAY
  for (unsigned int i=0; i<4; i++){
	// MADE CONTACT
    if (gripInContact[i]){
		// GET CONTACT POINT
		/* 
		Now you have the contact: gripContact[i]
		Note, the grip might have more than one contact point with the part.
		The above code will only save the last contact...
		*/
		/*gripContact[i].contactLoc[0];*/
		/*gripContact[i].contactLoc[1];*/
		/*gripContact[i].normalB1toB2[0];*/  /*Y component of contact normal in world frame*/
		/*gripContact[i].normalB1toB2[1];*/  /*Y component of contact normal in world frame*/
	

		// MY CODE
		//gripController[i]->SetPDTarget(gripContact[i].contactLoc[0], gripContact[i].contactLoc[1];
    }
    /*
      The following code is commented out, but demonstrates
      how to get the vertices of the part body.
      The verts are in the part's frame.
      To get the verts in the world frame, you must
      get the part location ( part->GetQ() ) and transform
      the verts using translation and rotation.
    */
	/*
	  // DEFINE VERTICES OF BODY
      const PolygonRepresentation * rep = static_cast<const PolygonRepresentation*>(part->GetModel()->GetGeomRepresentation());
      const std::vector< DVC::Vector<REAL> > & verts = rep->GetPolyVerts();
      for (unsigned int i = 0; i < verts.size(); ++i)
      {
		REAL vertX = verts[i][0];
		REAL vertY = verts[i][1];
      }
	*/
  }
}


//
//
// GoToPartCG - EXAMPLE FORCE CONTROLLER
// CG = center of gravity
//===================================
void App::GoToPartCG(){

  DVC::Vector<DVC::REAL> partQ = part->GetQ();

  /* Grip */
  for (unsigned int i=0; i<4; i++)
    gripController[i]->SetPDTarget(partQ[0], partQ[1]);
}
