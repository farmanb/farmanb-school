//------------------------------
// 
// APP.H
// 
//------------------------------
//
//
// INCLUDES
//===================================
#pragma once
#include "AppGL.h"
#include "BatController.h"
#include "goalPositionController.h"

//
//
// DEFINE CLASS
//===================================
class App : public DVC_AppGL {
	
	// PUBLIC
	// ----------------
	public:
		// CONSTRUCTOR/DESTRUCTOR
		App();
		~App();

		// INITIALIZE
		bool Init();
		void FlushAppSettings();

	// PROTECTED
	// ----------------
	protected:
		// FUNCTIONS
		bool AddBatController();
  
		KinematicalBody *GetBat();
		bool GetGoal();

		// CREATE OBJECTS (bat, goal)
		KinematicalBody *batBody, *goalBody,
			*goalBackBody,
			*goalFrontBody,
			*goalSide1Body,
			*goalSide2Body,
			*goalBottomBody;
		
		// CREATE OBJECTS (ball)
		DynamicalBody *ballBody;
  
		// CONTROLLER (bat)
		BatController *batController;

		/*Add position controllers for 
		the ball and the goal here */
		/*!*/goalPositionController *goalFrontController;
		/*!*/goalPositionController *goalBackController;
		/*!*/goalPositionController *goalSide1Controller;
		/*!*/goalPositionController *goalSide2Controller;
		/*!*/goalPositionController *goalBottomController;

		/*!*/bool AddGoalController();

	
		// POINTERS TO NAMES OF OBJECTS
		std::string *batName,
			*ballName,
			*goalBack,
			*goalFront,
			*goalSide1,
			*goalSide2,
			*goalBottom;
};
