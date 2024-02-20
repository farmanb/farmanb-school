#include "App.h"
//#include "PositionController.h"

App::App() : DVC_AppGL(){ 
  
  batBody = 0;
  ballBody = 0;
  goalBackBody = 0;
  goalFrontBody = 0;
  goalSide1Body = 0;
  goalSide2Body = 0;
  goalBottomBody = 0;
  batController = 0;
  backWallController = 0;
  frontWallController = 0;
  bottomWallController = 0;
  sideWallOneController = 0;
  sideWallTwoController = 0;

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
  if(backWallController)
	  delete backWallController;
  if(frontWallController)
	  delete frontWallController;
  if(bottomWallController)
	  delete bottomWallController;
  if(sideWallOneController)
	  delete sideWallOneController;
  if(sideWallTwoController)
	  delete sideWallTwoController;
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

  if (!GetBackWall()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalBack->c_str());
    assert(GetBackWall());
  }

  if (!AddBackWallController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }

  if (!GetFrontWall()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalFront->c_str());
    assert(GetFrontWall());
  }

  if (!AddFrontWallController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }

  if (!GetBottomWall()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalBottom->c_str());
    assert(GetBottomWall());
  }

  if (!AddBottomWallController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }

  if (!GetSideWallOne()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalSide1->c_str());
    assert(GetSideWallOne());
  }

  if (!AddSideWallOneController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }

  if (!GetSideWallTwo()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalSide2->c_str());
    assert(GetSideWallTwo());
  }
  if (!AddSideWallTwoController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }
}

KinematicalBody *App::GetBat(){
  if (batBody)
  {
	  batBody->SetQuat(DVC::Quaternion(0,0,0,1));
	  return batBody;
  }
  
  if (!sim->GetBodyByNameMutable(*batName, batBody)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", batName->c_str());
    return NULL;
  }

  return batBody;
}

KinematicalBody *App::GetBackWall(){
  if (goalBackBody)
  {
	  return goalBackBody;
  }
  
  if (!sim->GetBodyByNameMutable(*goalBack, goalBackBody)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalBack->c_str());
    return NULL;
  }

  return goalBackBody;
}

KinematicalBody *App::GetFrontWall(){
  if (goalFrontBody)
  {
	  return goalFrontBody;
  }
  
  if (!sim->GetBodyByNameMutable(*goalFront, goalFrontBody)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalFront->c_str());
    return NULL;
  }

  return goalFrontBody;
}
KinematicalBody *App::GetBottomWall(){
  if (goalBottomBody)
  {
	  return goalBottomBody;
  }
  
  if (!sim->GetBodyByNameMutable(*goalBottom, goalBottomBody)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalBottom->c_str());
    return NULL;
  }

  return goalBottomBody;
}
KinematicalBody *App::GetSideWallOne(){
  if (goalSide1Body)
  {
	  return goalSide1Body;
  }
  
  if (!sim->GetBodyByNameMutable(*goalSide1, goalSide1Body)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalSide1->c_str());
    return NULL;
  }

  return goalSide1Body;
}
KinematicalBody *App::GetSideWallTwo(){
  if (goalSide2Body)
  {
	  return goalSide2Body;
  }
  
  if (!sim->GetBodyByNameMutable(*goalSide2, goalSide2Body)){
    printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalSide2->c_str());
    return NULL;
  }

  return goalSide2Body;
}

/* This function gets KinematicalBody pointers
   to each piece of the goal.
 */
bool App::GetGoal(){
/*  if (!goalBackBody){
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
  } */
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

bool App::AddBackWallController(){
  if (!GetBackWall())
    return false;

  /* Delete the old controller */
  if (backWallController)
    delete backWallController;


  sim->RemoveAllBodyControllersByName(*goalBack);

   backWallController = new BackWallController(GetBackWall());

  return sim->SetBodyControllerByName(*goalBack, *backWallController);
}

bool App::AddBottomWallController(){
  if (!GetBottomWall())
    return false;

  /* Delete the old controller */
  if (bottomWallController)
    delete bottomWallController;


  sim->RemoveAllBodyControllersByName(*goalBottom);

   bottomWallController = new BottomWallController(GetBottomWall());

  return sim->SetBodyControllerByName(*goalBottom, *bottomWallController);
}

bool App::AddFrontWallController(){
  if (!GetFrontWall())
    return false;

  /* Delete the old controller */
  if (frontWallController)
    delete frontWallController;


  sim->RemoveAllBodyControllersByName(*goalFront);

   frontWallController = new FrontWallController(GetFrontWall());

  return sim->SetBodyControllerByName(*goalFront, *frontWallController);
}

bool App::AddSideWallOneController(){
  if (!GetSideWallOne())
    return false;

  /* Delete the old controller */
  if (sideWallOneController)
    delete sideWallOneController;


  sim->RemoveAllBodyControllersByName(*goalSide1);

   sideWallOneController = new SideWallOneController(GetSideWallOne());

  return sim->SetBodyControllerByName(*goalSide1, *sideWallOneController);
}

bool App::AddSideWallTwoController(){
  if (!GetSideWallTwo())
    return false;

  /* Delete the old controller */
  if (sideWallTwoController)
    delete sideWallTwoController;


  sim->RemoveAllBodyControllersByName(*goalSide2);

   sideWallTwoController = new SideWallTwoController(GetSideWallTwo());

  return sim->SetBodyControllerByName(*goalSide2, *sideWallTwoController);
}