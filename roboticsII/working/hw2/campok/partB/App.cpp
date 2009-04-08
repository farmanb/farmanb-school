#include "App.h"
#include "DvcCollisionResult.h"

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
  
  delete gripController;
  delete gripName;
  delete grip;

}

bool App::Init(){

  timer = 0;
  x_ref = 0;
  y_ref = 0;
  state = 0;
  x0 = 0;
  y0 = 4;
  x1 = -1;
  y1 = 0;
  x2 = 0;
  y2 = 4;
  x3 = 1;
  y3 = 0;

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
  
  /*Enable all PD controllers*/
  for (unsigned int i=0; i<4; i++)
    gripController[i]->TogglePD(true);

  GoToPartCG();
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

/*
  This method is called after each timestep, but before rendering.
  This is the best place to write your code.  Not, you can also 
  create a PreStep method which will be called before each timestep.
*/
void App::PostStep(){

  bool gripInContact[4];
  

  std::cout<<"State: "<<state<<std::endl;
  if(state == 0){

	  x_ref = 0 ;
	  y_ref = 0;
	  
	  x0 = 0;
	  y0 = 2;
	  x1 = -1;
	  y1 = 0;
	  x2 = 0;
	  y2 = 2;
	  x3 = 1;
	  y3 = 0;
	
	  if (timer > 50){
		state++;
		timer = 0;
	  }
	
  }else if(state == 1){
	  
	  x_ref = 0 ;
	  y_ref = -.2;
	  x0 = 0;
	  y0 = 2;
	  x1 = -1;
	  y1 = 0;
	  x2 = 0;
	  y2 = 2;
	  x3 = 1;
	  y3 = 0;

	  if (timer > 50){
		state++;
		timer = 0;
	  }


  }else if(state == 2){

	   x_ref = 0 ;
	  y_ref = -.7;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > 50){
		state++;
		timer = 0;
	  }


  }else if(state == 3){
	std::cout<<"YREF: "<<y_ref<<std::endl;
	   x_ref = 0 ;
	  y_ref += .01;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > 50){
		state++;
		timer = 0;
	  }
	

  }else if(state == 4){

	  std::cout<<"XREF: "<<x_ref<<std::endl;
	  x_ref -=.02 ;
	  //y_ref += .01;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > (3*50)){
		state++;
		timer = 0;
	  }
	
	

  }else if(state == 5){
	  if(timer > 20){
		  y_ref = 0;
		  x0 = 0;
		  y0 = 2;
		  x1 = -1;
		  y1 = 1;
		  x2 = 0;
		  y2 = 2;
		  x3 = 1;
		  y3 = 1;
		  state++;
		  timer = 0;
	  }

	 
  }else if(state == 6){
		x_ref+=.02;

	   if (timer > (4*50)){
		state++;
		timer = 0;
	  }
	

  }else if(state == 7){

	  
	  y_ref = -.4;
	  x0 = 0;
	  y0 = 2;
	  x1 = -1;
	  y1 = 0;
	  x2 = 0;
	  y2 = 2;
	  x3 = 1;
	  y3 = 0;

	  if (timer > 50){
		state++;
		timer = 0;
	  }


  }else if(state == 8){

	  y_ref = -.7;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > 50){
		state++;
		timer = 0;
	  }


  }else if(state == 9){

	  std::cout<<"YREF: "<<y_ref<<std::endl;
	  // x_ref = 0 ;
	  y_ref += .01;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > 50){
		state++;
		timer = 0;
	  }


  }else if(state == 10){

	  std::cout<<"XREF: "<<x_ref<<std::endl;
	  x_ref -=.02 ;
	  //y_ref += .01;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > (2.8*50)){
		state++;
		timer = 0;
	  }

  }else if(state == 11){
	  if(timer > 20){
		  y_ref = 0;
		  x0 = 0;
		  y0 = 2;
		  x1 = -1;
		  y1 = 1;
		  x2 = 0;
		  y2 = 2;
		  x3 = 1;
		  y3 = 1;
		  state++;
		  timer = 0;
	  }

  }else if(state == 12){

	  x_ref+=.02;

	   if (timer > (3.7*50)){
		state++;
		timer = 0;
	  }

  }else if(state == 13){

	  y_ref = -.4;
	  x0 = 0;
	  y0 = 2;
	  x1 = -1;
	  y1 = 0;
	  x2 = 0;
	  y2 = 2;
	  x3 = 1;
	  y3 = 0;

	  if (timer > 50){
		state++;
		timer = 0;
	  }

  }else if(state == 14){
	   y_ref = -.7;
	   if(timer > 25){
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;
	   }
	  if (timer > 50){
		state++;
		timer = 0;
	  }

  }else if(state == 15){

	  std::cout<<"YREF: "<<y_ref<<std::endl;
	  // x_ref = 0 ;
	  y_ref += .01;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > 40){
		state++;
		timer = 0;
	  }

  }else if(state == 16){

	   std::cout<<"XREF: "<<x_ref<<std::endl;
	  x_ref -=.02 ;
	  //y_ref += .01;
	  x0 = -1;
	  y0 = 2;
	  x1 = 1;
	  y1 = 1;
	  x2 = 1;
	  y2 = 2;
	  x3 = -1;
	  y3 = 1;

	  if (timer > (2.9*50)){
		state++;
		timer = 0;
	  }

  }else if(state == 17){

	   if(timer > 300){
		  y_ref = 0;
		  x0 = 0;
		  y0 = 2;
		  x1 = -1;
		  y1 = 1;
		  x2 = 0;
		  y2 = 2;
		  x3 = 1;
		  y3 = 1;
		  state++;
		  timer = 0;
	  }
  }



  timer++;
  for (unsigned int i=0; i < 4; i++)
    gripInContact[i] = false;

  gripController[0]->SetPDTarget(x0+x_ref,y0+y_ref); //top left
  gripController[1]->SetPDTarget(x1+x_ref,y1+y_ref); //bottom left
  gripController[2]->SetPDTarget(x2+x_ref,y2+y_ref); // top right
  gripController[3]->SetPDTarget(x3+x_ref,y3+y_ref); //bottom right

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

  DVC::Vector<DVC::REAL> partQ = part[selectedPart]->GetQ();

  /* Grip */
  for (unsigned int i=0; i<4; i++)
    gripController[i]->SetPDTarget(partQ[0], partQ[1]);
}
