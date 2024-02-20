#pragma once

#include "AppGL.h"
#include "BatController.h"
#include "goalBottomController.h"
#include "goalSide2Controller.h"
#include "goalSide1Controller.h"
#include "goalBackController.h"
#include "goalFrontController.h"

class App : public DVC_AppGL {

 public:

  App();
  ~App();

  bool Init();

  void FlushAppSettings();

 protected:
  bool AddBatController();
  bool AddGoalBottomController();
  bool AddGoalSide2Controller();
  bool AddGoalSide1Controller();
  bool AddGoalBackController();
  bool AddGoalFrontController();
  
  KinematicalBody *GetBat();
  KinematicalBody *GetGoalBottomController();
  KinematicalBody *GetGoalSide2Controller();
  KinematicalBody *GetGoalSide1Controller();
  KinematicalBody *GetGoalBackController();
  KinematicalBody *GetGoalFrontController();
  bool GetGoal();


  KinematicalBody *batBody, *goalBody,
    *goalBackBody,
    *goalFrontBody,
    *goalSide1Body,
    *goalSide2Body,
    *goalBottomBody;
  DynamicalBody *ballBody;
  
  BatController *batController;
  goalBottomController *GoalBottomController;
  goalSide2Controller *GoalSide2Controller;
  goalSide1Controller *GoalSide1Controller;
  goalBackController *GoalBackController;
  goalFrontController *GoalFrontController;

  /*Add position controllers for 
    the ball and the goal here */
  
  std::string *batName,
    *ballName,
    *goalBack,
    *goalFront,
    *goalSide1,
    *goalSide2,
    *goalBottom;
    
};
