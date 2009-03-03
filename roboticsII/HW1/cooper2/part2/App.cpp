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
  goalBaseCont = 0;
  goalFrontCont = 0;
  goalBackCont = 0;
  goalSide1Cont = 0;
  goalSide2Cont = 0;

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
  if (goalBaseCont) {
    delete goalBaseCont;
    delete goalFrontCont;
    delete goalBackCont;
    delete goalSide1Cont;
    delete goalSide2Cont;
  }
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

  if (!AddGoalControllers()) {
    printf("App::FlushAppSettings(): Error! Cannot add goal position controllers.\n");
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

  batController = new BatController(GetBat());

  return sim->SetBodyControllerByName(*batName, *batController);
}

bool App::AddGoalControllers()
{
  if (!GetGoal())
    return false;

  if (goalBaseCont) {
    delete goalBaseCont;
    delete goalFrontCont;
    delete goalBackCont;
    delete goalSide1Cont;
    delete goalSide2Cont;
  }

  sim->RemoveAllBodyControllersByName(*goalBack);
  sim->RemoveAllBodyControllersByName(*goalFront);
  sim->RemoveAllBodyControllersByName(*goalSide1);
  sim->RemoveAllBodyControllersByName(*goalSide2);
  sim->RemoveAllBodyControllersByName(*goalBottom);

  goalBaseCont = new GoalController(goalBottomBody);
  goalFrontCont = new GoalController(goalFrontBody);
  goalBackCont = new GoalController(goalBackBody);
  goalSide1Cont = new GoalController(goalSide1Body);
  goalSide2Cont = new GoalController(goalSide2Body);

  return sim->SetBodyControllerByName(*goalBack, *goalBackCont) &&
    sim->SetBodyControllerByName(*goalFront, *goalFrontCont) &&
    sim->SetBodyControllerByName(*goalSide1, *goalSide1Cont) &&
    sim->SetBodyControllerByName(*goalSide2, *goalSide2Cont) &&
    sim->SetBodyControllerByName(*goalBottom, *goalBaseCont);
}
