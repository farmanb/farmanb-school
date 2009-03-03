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
  GoalBottomController = 0;
  GoalSide2Controller = 0;
  GoalSide1Controller = 0;
  GoalBackController = 0;
  GoalFrontController = 0;


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
  if(GoalBottomController)
	  delete GoalBottomController;
  if(GoalSide2Controller)
	  delete GoalSide2Controller;
  if(GoalSide1Controller)
	  delete GoalSide1Controller;
  if(GoalBackController)
	  delete GoalBackController;
  if(GoalFrontController)
	  delete GoalFrontController;
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
  if (!GetGoalBottomController()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalBottom->c_str());
    assert(GetGoalBottomController());
  }

  if (!AddGoalBottomController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }
  if (!GetGoalSide2Controller()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalSide2->c_str());
    assert(GetGoalSide2Controller());
  }

  if (!AddGoalSide2Controller()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }
  if (!GetGoalSide1Controller()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalSide1->c_str());
    assert(GetGoalSide1Controller());
  }

  if (!AddGoalSide1Controller()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }
  if (!GetGoalBackController()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalBack->c_str());
    assert(GetGoalBackController());
  }

  if (!AddGoalBackController()){
    printf("App::FlushAppSettings(): Error!  Can not add bat position controller.\n");
    return;
  }
  if (!GetGoalFrontController()){
    printf("App::FlushAppSettings(): Error!  Can not find %s in simulation!\n", goalFront->c_str());
    assert(GetGoalFrontController());
  }

  if (!AddGoalFrontController()){
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

KinematicalBody *App::GetGoalBottomController(){
	if (goalBottomBody)
		return goalBottomBody;
  
	if (!sim->GetBodyByNameMutable(*goalBottom, goalBottomBody)){
		printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalBottom->c_str());
		return NULL;
	}

	return goalBottomBody;
}
KinematicalBody *App::GetGoalSide2Controller(){
	if (goalSide2Body)
		return goalSide2Body;
  
	if (!sim->GetBodyByNameMutable(*goalSide2, goalSide2Body)){
		printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalSide2->c_str());
		return NULL;
	}

	return goalSide2Body;
}
KinematicalBody *App::GetGoalSide1Controller(){
	if (goalSide1Body)
		return goalSide1Body;
  
	if (!sim->GetBodyByNameMutable(*goalSide1, goalSide1Body)){
		printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalSide1->c_str());
		return NULL;
	}

	return goalSide1Body;
}
KinematicalBody *App::GetGoalBackController(){
	if (goalBackBody)
		return goalBackBody;
  
	if (!sim->GetBodyByNameMutable(*goalBack, goalBackBody)){
		printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalBack->c_str());
		return NULL;
	}

	return goalBackBody;
}KinematicalBody *App::GetGoalFrontController(){
	if (goalFrontBody)
		return goalFrontBody;
  
	if (!sim->GetBodyByNameMutable(*goalFront, goalFrontBody)){
		printf("Error: App::GetBat: Could not get body from simulator: %s\n", goalFront->c_str());
		return NULL;
	}

	return goalFrontBody;
}
/* This function gets KinematicalBody pointers
   to each piece of the goal.
 */
bool App::GetGoal(){
 /* if (!goalBackBody){
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
  }*/
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
bool App::AddGoalBottomController(){
  if (!GetGoalBottomController())
    return false;

  /* Delete the old controller */
  if (GoalBottomController)
    delete GoalBottomController;


  sim->RemoveAllBodyControllersByName(*goalBottom);

  GoalBottomController = new goalBottomController(GetGoalBottomController());

  return sim->SetBodyControllerByName(*goalBottom, *GoalBottomController);
}
bool App::AddGoalSide2Controller(){
  if (!GetGoalSide2Controller())
    return false;

  /* Delete the old controller */
  if (GoalSide2Controller)
    delete GoalSide2Controller;


  sim->RemoveAllBodyControllersByName(*goalSide2);

  GoalSide2Controller = new goalSide2Controller(GetGoalSide2Controller());

  return sim->SetBodyControllerByName(*goalSide2, *GoalSide2Controller);
}
bool App::AddGoalSide1Controller(){
  if (!GetGoalSide1Controller())
    return false;

  /* Delete the old controller */
  if (GoalSide1Controller)
    delete GoalSide1Controller;


  sim->RemoveAllBodyControllersByName(*goalSide1);

  GoalSide1Controller = new goalSide1Controller(GetGoalSide1Controller());

  return sim->SetBodyControllerByName(*goalSide1, *GoalSide1Controller);
}
bool App::AddGoalBackController(){
  if (!GetGoalBackController())
    return false;

  /* Delete the old controller */
  if (GoalBackController)
    delete GoalBackController;


  sim->RemoveAllBodyControllersByName(*goalBack);

  GoalBackController = new goalBackController(GetGoalBackController());

  return sim->SetBodyControllerByName(*goalBack, *GoalBackController);
}
bool App::AddGoalFrontController(){
  if (!GetGoalFrontController())
    return false;

  /* Delete the old controller */
  if (GoalFrontController)
    delete GoalFrontController;


  sim->RemoveAllBodyControllersByName(*goalFront);

  GoalFrontController = new goalFrontController(GetGoalFrontController());

  return sim->SetBodyControllerByName(*goalFront, *GoalFrontController);
}