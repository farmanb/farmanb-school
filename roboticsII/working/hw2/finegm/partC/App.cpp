#include "App.h"
#include "DvcCollisionResult.h"
#include "GripControl.h"
#include "PalmControl.h"
#include "BallController.h"
#include <iostream>

using namespace std;

App::App(){
  step = 0;
  shot = false;
  part = 0;
  palm = 0;
  ball = 0;
  
  grip = new DynamicalBody*[4];
  gripController = new GripControl*[4];
  ballController = 0;

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
  ballName = new std::string("ball");
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

  /*Enable all PD controllers*/
  /*
    for (unsigned int i=0; i<4; i++)
    gripController[i]->TogglePD(true);*/

    GoToPartCG();
  

  DVC::REAL	t[4] = {2,0,-2,0.0};

  SetGripTorques(t);

  /* 
     Example of how to move the base
     Because it is position controlled you have to move it very
     slowly, or else the joints will explode and dVC will crash.
  */
  DVC::Vector<DVC::REAL> basePos = GetPalmPos();
  SetPalmVelocity( 0 , 0.005 , 0);

  return true;
}

bool App::GetBodies(){
  if (part && grip[0] && grip[1] &&
      grip[2] && grip[3] && palm && ball){
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
  bool gripInContact[4];
  
  for (unsigned int i=0; i < 4; i++)
    gripInContact[i] = false;

  DvcCollisionResult gripContact[4];

  /* 
     Make sure the ball only gets 'shot'
     once .
  */
  if (shot)
    ballController->ShouldShoot(false);
  
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
    ballController->ShouldShoot(true);
  }
    
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
      if (b1 == *gripName[j] && b2 == *partName ||
	  b1 == *partName && b2 == *gripName[j]){
	gripInContact[j] = true;
	gripContact[j] = *contacts[i];
      }
    }
  }

  palmPosition = GetPalmPos();
  if(step == 0){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0,.01,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-.6,palmPosition[1]-.2);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+.6,palmPosition[1]-.2);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-1.5);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1.5);
		

		if(palmPosition[1] > 1.5){
			SetPalmVelocity(0,0,0);
			step = 1;
		}
	}
  if(step == 1){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0.01,0,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-.6,palmPosition[1]-.2);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+.6,palmPosition[1]-.2);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-1.5);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1.5);
		

		if(palmPosition[0] > 1){
			SetPalmVelocity(0,0,0);
			step = 2;
		}
	}
  if(step == 2){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0,-.01,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-.6,palmPosition[1]-.2);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+.6,palmPosition[1]-.2);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-1.5);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1.5);

		if(palmPosition[1] < .92){
			SetPalmVelocity(0,0,0);
			step = 3;
		}
	}
	if(step == 3){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0,0,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-2,palmPosition[1]-3.127);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+2,palmPosition[1]-3.127);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-4.127);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-4.127);

		if(palmPosition[1] < .92){
			SetPalmVelocity(0,0,0);
			step = 4;
		}
	}
	if(step == 4){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0,.009,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-2,palmPosition[1]-3.127);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+2,palmPosition[1]-3.127);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-4.127);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-4.127);

		if(palmPosition[1] > 1.5){
			SetPalmVelocity(0,0,0);
			step = 5;
		}
	}
	if(step == 5){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(-.009,0,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-2,palmPosition[1]-3.127);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+2,palmPosition[1]-3.127);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-4.127);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-4.127);

		if(palmPosition[0] < 0){
			SetPalmVelocity(0,0,0);
			step = 6;
		}
	}
	if(step == 6){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0,-.009,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-2,palmPosition[1]-3.127);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+2,palmPosition[1]-3.127);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-4.127);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]+1,palmPosition[1]-4.127);

		if(palmPosition[1] < 1.43){
			SetPalmVelocity(0,0,0);
			step = 7;
		}
	}
	if(step == 7){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(-.01,0,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-1,palmPosition[1]);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+1,palmPosition[1]);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]+1,palmPosition[1]);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]-1,palmPosition[1]);
		

		if(palmPosition[0] < -.25){
			SetPalmVelocity(0,0,0);
			step = 8;
		}
	}
    if(step == 8){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(-.01,0,.04);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+1,palmPosition[1]+1);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]+1,palmPosition[1]+1);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1);
		

		if(palmPosition[0] < -.5){
			SetPalmVelocity(0,0,0);
			step = 9;
		}
	}
	if(step == 9){
		//cout << "x=" << palmPosition[0] << ", y=" << palmPosition[1] << endl;
		SetPalmVelocity(0,-.009,0);
		gripController[0]->TogglePD(true);
		gripController[0]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1);
		gripController[2]->TogglePD(true);
		gripController[2]->SetPDTarget(palmPosition[0]+1,palmPosition[1]+1);
		gripController[3]->TogglePD(true);
		gripController[3]->SetPDTarget(palmPosition[0]+1,palmPosition[1]+1);
		gripController[1]->TogglePD(true);
		gripController[1]->SetPDTarget(palmPosition[0]-1,palmPosition[1]-1);
		

		if(palmPosition[1] < 1){
			SetPalmVelocity(0,0,0);
			step = 10;
		}
	}

  for (unsigned int i=0; i<4; i++){
    if (gripInContact[i]){
      /* 
	 Now you have the contact: gripContact[i]
	 Note, the grip might have more than one contact point with the part.
	 The above code will only save the last contact...
      */

      
      /*gripContact[i].contactLoc[0];*/
      /*gripContact[i].contactLoc[1];*/
      /*gripContact[i].normalB1toB2[0];*/  /*Y component of contact normal in world frame*/
      /*gripContact[i].normalB1toB2[1];*/  /*Y component of contact normal in world frame*/
	  
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

void App::GoToPartCG(){

  DVC::Vector<DVC::REAL> partQ = part->GetQ();
  
  for (unsigned int i=0; i<4; i++)
    gripController[i]->SetPDTarget(partQ[0], partQ[1]);
}
