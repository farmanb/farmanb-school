#include "App.h"
#include "DvcCollisionResult.h"
#include "PalmControl.h"
#include "GripControl.h"

App::App(){
  palm = 0;
  state=0;

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
  
  /*Enable all PD controllers
  for (unsigned int i=0; i<4; i++)
  gripController[i]->TogglePD(true);*/

  DVC::REAL	t[4] = {2,0,-2,0.0};

  SetGripTorques(t);

  /*GoToPartCG();*/
    
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
	
    
      const PolygonRepresentation * rep = static_cast<const PolygonRepresentation*>(part[0]->GetModel()->GetGeomRepresentation());
      const std::vector< DVC::Vector<REAL> > & verts = rep->GetPolyVerts();
      for (unsigned int i = 0; i < verts.size(); ++i)
      {
      REAL vertX = verts[i][0];
      REAL vertY = verts[i][1];
      }

	  DVC::REAL pedestalX[3];

	  //pedestal 1 x
	  pedestalX[0]= -3;
	
	  //pedestal 2 x
	  pedestalX[1] = -2;
	
	  //pedestal 1 x
	  pedestalX[2] = -1;


	DVC::REAL tq[4];

	tq[0] = 0;
	tq[1] = 0;
	tq[2] = 0;
	tq[3] = 0;
	
	SetGripTorques(tq);
	
	//state 0 pick up first part
	if (palm->GetQ()[1] > part[selectedPart]->GetQ()[0] && state == 0)
	{
		SetPalmVelocity(0,-.01,0);
	}
	//stop once it gets there
	if (palm->GetQ()[1] < .9 && state ==0)
	{
		SetPalmVelocity(0,0,0);

		tq[0] = 110;
		tq[1] = 145;
		tq[2] = -110;
		tq[3] = -145;

		SetGripTorques(tq);

		
			state =1;
		
		SetPalmVelocity(0,0,0);
	}

	//state 1
	if(state ==1)
	{
		tq[0] = 110;
		tq[1] = 145;
		tq[2] = -110;
		tq[3] = -145;

		SetGripTorques(tq);


		if(part[selectedPart]->GetQ()[1] < 1.4)
		{
			SetPalmVelocity(0,.01,0);
		}
		else
		{
			state = 2;
		}
	}
	

	//state 2
	if(state == 2)
	{
		tq[0] = 110;
		tq[1] = 145;
		tq[2] = -110;
		tq[3] = -145;

		SetGripTorques(tq);

		if(part[selectedPart]->GetQ()[0] > pedestalX[selectedPart] )
		{
			SetPalmVelocity(-.01,0,0);
		}
		else
		{
			state = 3;
		}
	}

	//state 3
	if(state ==3)
	{
		tq[0] = 110;
		tq[1] = 145;
		tq[2] = -110;
		tq[3] = -145;

		SetGripTorques(tq);
		
		

		if(part[selectedPart]->GetQ()[1]+verts[3][1] > .55)
		{
			SetPalmVelocity(0,-.001,0);
		}
		else
		{
			state = 4;
		}
	}
	//state 4
	if(state ==4)
	{
		std::cout << "4 " << part[0]->GetQ()[0] << " " << part[0]->GetQ()[1] << std::endl;

		SetPalmVelocity(0,0,0);
		
		if(selectedPart==0)
		{
			SetPalmVelocity(0,.01,0);
		}
		if(selectedPart >=1)
		{
			SetPalmVelocity(0,.001,0);
		}

		if(palm->GetQ()[1] > 2)
		{
			SetPalmVelocity(0,0,0);
			if(selectedPart==2)
			{
				state = 20;
			}
			else
			{
				state = 5;
			}
		}
	}

	//state 5
	if(state ==5)
	{
	//	std::cout << "4 " << palm->GetQ()[0] << " " << palm->GetQ()[1] << std::endl;	

		if(palm->GetQ()[0] < part[selectedPart+1]->GetQ()[0]-.8)
		{
			SetPalmVelocity(.01,0,0);
		}

		if(palm->GetQ()[0] > part[selectedPart+1]->GetQ()[0]-.8 &&
			palm->GetQ()[0] < part[selectedPart+1]->GetQ()[0])
		{
			SetPalmVelocity(.001,0,0);
		}

		if(palm->GetQ()[0] > part[selectedPart+1]->GetQ()[0])
		{
			
				SetPalmVelocity(0,0,0);
			
			state=7;
			selectedPart++;
		}
	}
	if(state == 7)
	{
		if(selectedPart ==1)
		{
			tq[0] = -2;
			tq[1] = 0;
			tq[2] = 1;
			tq[3] = 0;

			SetGripTorques(tq);
		}
		if(selectedPart ==2)
		{
			tq[0] = -1;
			tq[1] = -3;
			tq[2] = 0;
			tq[3] = 0;

			SetGripTorques(tq);
		}
		SetPalmVelocity(0,-.001,0);
	
		//stop once it gets there
		if (palm->GetQ()[1] < .9 && state ==7)
		{
			SetPalmVelocity(0,0,0);

			tq[0] = 110;
			tq[1] = 145;
			tq[2] = -110;
			tq[3] = -145;

			SetGripTorques(tq);

			state =1;
		
			SetPalmVelocity(0,0,0);
		}
	}

  }
}

/*
  void App::GoToPartCG(){

  DVC::Vector<DVC::REAL> partQ = part[selectedPart]->GetQ();

  for (unsigned int i=0; i<4; i++)
  gripController[i]->SetPDTarget(partQ[0], partQ[1]);
  }
*/

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