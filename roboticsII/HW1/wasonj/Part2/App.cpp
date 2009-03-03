#include "App.h"

App::App() : DVC_AppGL(){ 
  
  batBody = 0;
  ballBody = 0;
  goalBackBody = 0;
  goalFrontBody = 0;
  goalSide1Body = 0;
  goalSide2Body = 0;
  goalBottomBody = 0;
  batController = 0;

  /*these names must be the same 
    ones used in the xml file*/
  batName = new std::string("bat");
  ballName = new std::string("ball");
  goalBack = new std::string("goalBack");
  goalFront = new std::string("goalFront");
  goalSide1 = new std::string("goalSide1");
  goalSide2 = new std::string("goalSide2");
  goalBottom = new std::string("goalBottom");
}

App::~App() { 
  delete batName;
  delete ballName;
  if (batController)
    delete batController;
  delete goalBack;
  delete goalFront;
  delete goalSide1;
  delete goalSide2;
  delete goalBottom;
}

bool App::Init(){
 
  if (!DVC_AppGL::Init()){
    printf("Error: App::Init: AppGui failed to initialize.\n");
    return false;
  }

  /*Get pointers to the pieces of the goal 
   If these don't get selected, collision can't
  be turned off and dvc WILL crash.  This is 
  a fatal error.*/
  if (!GetGoal()){
    printf("Error:  App::Init: AppGui failed to initialize.\n");
    return false;
  }

  /* Turn off collision between the pieces of the goal*/
  goalFrontBody->AddBodyNotToCollideWith(goalSide1Body);
  goalFrontBody->AddBodyNotToCollideWith(goalSide2Body);
  goalFrontBody->AddBodyNotToCollideWith(goalBottomBody);
  goalFrontBody->AddBodyNotToCollideWith(goalBackBody);
  
  goalBackBody->AddBodyNotToCollideWith(goalBottomBody);
  goalBackBody->AddBodyNotToCollideWith(goalSide1Body);
  goalBackBody->AddBodyNotToCollideWith(goalSide2Body);
  goalBackBody->AddBodyNotToCollideWith(goalFrontBody);
  
  goalSide1Body->AddBodyNotToCollideWith(goalBottomBody);
  goalSide1Body->AddBodyNotToCollideWith(goalBackBody);
  goalSide1Body->AddBodyNotToCollideWith(goalSide2Body);
  goalSide1Body->AddBodyNotToCollideWith(goalFrontBody);

  goalSide2Body->AddBodyNotToCollideWith(goalBottomBody);
  goalSide2Body->AddBodyNotToCollideWith(goalBackBody);
  goalSide2Body->AddBodyNotToCollideWith(goalFrontBody);
  goalSide2Body->AddBodyNotToCollideWith(goalSide1Body);

  goalBackBody->AddBodyNotToCollideWith(goalSide1Body);
  goalBackBody->AddBodyNotToCollideWith(goalSide2Body);
  goalBackBody->AddBodyNotToCollideWith(goalFrontBody);
  goalBackBody->AddBodyNotToCollideWith(goalBottomBody);
  
	AddGoalController();

  return true;
}

void App::FlushAppSettings(){
  DVC_AppGL::FlushAppSettings();
  
  /* Check for the bat.  If it isn't found,
     the simulation will not work.
     (Fatal Error.)
  */
  if (!GetBat()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", batName->c_str());
    assert(GetBat());
  }

  if (!AddBatController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }

  
}

KinematicalBody *App::GetBat(){
  if (batBody)
    return batBody;
  
  if (!sim->GetBodyByNameMutable(*batName, batBody)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", batName->c_str());
    return NULL;
  }

  return batBody;
}

/* This function gets KinematicalBody pointers
   to each piece of the goal.
 */
bool App::GetGoal(){
  if (!goalBackBody){
    if(!sim->GetBodyByNameMutable(*goalBack, goalBackBody)){
      printf("Error: App::GetGoal: Could not get body from simulator: %s\n", goalBack->c_str());
      return false;
    }
  }
  if (!goalFrontBody){
    if(!sim->GetBodyByNameMutable(*goalFront, goalFrontBody)){
      printf("Error: App::GetGoal: Could not get body from simulator: %s\n", goalFront->c_str());
      return false;
    }
  }
  if(!goalSide1Body){
    if(!sim->GetBodyByNameMutable(*goalSide1, goalSide1Body)){
      printf("Error: App::GetGoal: Could not get body from simulator: %s\n", goalSide1->c_str());
      return false;
    }
  }
  if (!goalSide2Body){
    if(!sim->GetBodyByNameMutable(*goalSide2, goalSide2Body)){
      printf("Error: App::GetGoal: Could not get body from simulator: %s\n", goalSide2->c_str());
      return false;
    }
  }
  if (!goalBottomBody){
    if(!sim->GetBodyByNameMutable(*goalBottom, goalBottomBody)){
      printf("Error: App::GetGoal: Could not get body from simulator: %s\n", goalBottom->c_str());
      return false;
    }
  }
  return true;
}

bool App::AddBatController(){
  if (!GetBat())
    return false;

  /* Delete the old controller */
  if (batController)
    delete batController;


  sim->RemoveAllBodyControllersByName(*batName);

  batController = new BatController(GetBat(),1.35,0);

  return sim->SetBodyControllerByName(*batName, *batController);
}

bool App::AddGoalController() {

	
	
	goalBackC=new GoalController(goalBackBody,0,0,0,5*pi);
	if (!sim->SetBodyControllerByName(*goalBack,*goalBackC))
		return false;

	goalFrontC=new GoalController(goalFrontBody,0,0,0,5*pi);
		if (!sim->SetBodyControllerByName(*goalFront,*goalFrontC))
		return false;

	goalSide1C=new GoalController(goalSide1Body,0,0,0,5*pi);
	if (!sim->SetBodyControllerByName(*goalSide1,*goalSide1C))
		return false;

	goalSide2C=new GoalController(goalSide2Body,0,0,0,5*pi);
	if (!sim->SetBodyControllerByName(*goalSide2,*goalSide2C))
		return false;

	goalBottomC=new GoalController(goalBottomBody,0,0,0,5*pi);
	if (!sim->SetBodyControllerByName(*goalBottom,*goalBottomC))
		return false;



	//goalBackBody = 0;
	//goalFrontBody = 0;
	//goalSide1Body = 0;
	//goalSide2Body = 0;
	//goalBottomBody = 0;

	return true;

}
