//------------------------------
// 
// APP.CPP
// DESCRIBES FUNCTIONS GIVEN IN APP.H
// 
//------------------------------
//
//
// INCLUDES
//===================================
#include "App.h"

//
//
// APP CONSTRUCTOR
//===================================
App::App() : DVC_AppGL(){ 
	// INITIALIZE OBJECTS IN SCENE
	batBody = 0;
	ballBody = 0;
	goalBackBody = 0;
	goalFrontBody = 0;
	goalSide1Body = 0;
	goalSide2Body = 0;
	goalBottomBody = 0;
	batController = 0;
    
	/*!*/
	//SET GOAL CONTROLLERS TO ZERO
	goalFrontController = 0;
	goalBackController = 0;
	goalSide1Controller = 0;
	goalSide2Controller = 0;
	goalBottomController = 0;
	
	// these names must be the same ones used in the xml file
	// ATTACH POINTERS TO STRINGS
	batName = new std::string("bat");
	ballName = new std::string("ball");
	goalBack = new std::string("goalBack");
	goalFront = new std::string("goalFront");
	goalSide1 = new std::string("goalSide1");
	goalSide2 = new std::string("goalSide2");
	goalBottom = new std::string("goalBottom");
}

//
//
// APP DESTRUCTOR - DELETE APP
//===================================
App::~App() { 
	// DELETE POINTERS TO STRINGS
	delete batName;
	delete ballName;
	if (batController)
		delete batController;
	delete goalBack;
	delete goalFront;
	delete goalSide1;
	delete goalSide2;
	delete goalBottom;

	/*!*/
	// DELETE GOAL CONTROLLERS 
	if (goalFrontController)
		delete goalFrontController;
	if (goalBackController)
		delete goalBackController;
	if (goalSide1Controller)
		delete goalSide1Controller;
	if (goalSide2Controller)
		delete goalSide2Controller;
	if (goalBottomController)
		delete goalBottomController;		
}

//
//
// INITIALIZE - TURNS OFF COLLISION
// BETWEEN PIECES OF GOAL
//===================================
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

//
//
// CHECK ERRORS
//===================================
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

	// if get goal
	// if addgoalcontroller
	if (!GetGoal()){
		printf("App::FlushAppSettings(): Erro! Can not find %s in simulation!\n", goalFront->c_str());
		assert(GetGoal());
	}
	if (!AddGoalController()){
		printf("App::FlushAppSettings(): Error!  Can not add goal position controller.\n");
		return;
	}
}

//
//
// GET BAT
//===================================
KinematicalBody *App::GetBat(){
	if (batBody)
		return batBody;
	  
	if (!sim->GetBodyByNameMutable(*batName, batBody)){
		printf("Error: App::GetBat: Could not get body from simulator: %s\n", batName->c_str());
		return NULL;
	}

	return batBody;
}


//
//
// GET GOAL
// THIS FUNCTION GETS KINEMATICALBODY
// POINTERS TO EACH PIECE OF THE GOAL
//===================================
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

//
//
// ADD BAT CONTROLLER - ATTACH POINTER CONTROLLER TO BODY
//===================================
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

/*!*/
//
//
// ADD GOAL CONTROLLER - ATTACH POINTER CONTROLLER TO GOAL
//===================================
bool App::AddGoalController() {

	if (!GetGoal())
		return false;

	// DELETE GOAL CONTROLLERS 
	if (goalFrontController)
		delete goalFrontController;
	if (goalBackController)
		delete goalBackController;
	if (goalSide1Controller)
		delete goalSide1Controller;
	if (goalSide2Controller)
		delete goalSide2Controller;
	if (goalBottomController)
		delete goalBottomController;

	sim->RemoveAllBodyControllersByName(*goalBack);
	sim->RemoveAllBodyControllersByName(*goalFront);
	sim->RemoveAllBodyControllersByName(*goalSide1);
	sim->RemoveAllBodyControllersByName(*goalSide2);
	sim->RemoveAllBodyControllersByName(*goalBottom);

	goalBackController = new goalPositionController(goalBackBody);
	goalFrontController = new goalPositionController(goalFrontBody);
	goalSide1Controller = new goalPositionController(goalSide1Body);
	goalSide2Controller = new goalPositionController(goalSide2Body);
	goalBottomController = new goalPositionController(goalBottomBody);

	return sim->SetBodyControllerByName(*goalBack, *goalBackController) && sim->SetBodyControllerByName(*goalFront, *goalFrontController) &&
		sim->SetBodyControllerByName(*goalSide1, *goalSide1Controller) && sim->SetBodyControllerByName(*goalSide2, *goalSide2Controller) && 
		sim->SetBodyControllerByName(*goalBottom, *goalBottomController);
}
