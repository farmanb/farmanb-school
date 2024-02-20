#pragma once

#include "AppGL.h"
#include "BatController.h"
#include "GoalBackController.h"
#include "GoalBottomController.h"
#include "GoalSide1Controller.h"
#include "GoalSide2Controller.h"
#include "GoalFrontController.h"

class App : public DVC_AppGL {

 public:

  App();
  ~App();

  bool Init();

  void FlushAppSettings();

 protected:
  bool AddBatController();
  bool AddGoalFrontController();
  bool AddGoalBackController();
  bool AddGoalSide1Controller();
  bool AddGoalSide2Controller();
  bool AddGoalBottomController();
  
  KinematicalBody *GetBat();
  KinematicalBody *GetGoalFront();
  KinematicalBody *GetGoalBack();
  KinematicalBody *GetGoalSide1();
  KinematicalBody *GetGoalSide2();
  KinematicalBody *GetGoalBottom();
  bool GetGoal();


  KinematicalBody *batBody, *goalBody,
    *goalBackBody,
    *goalFrontBody,
    *goalSide1Body,
    *goalSide2Body,
    *goalBottomBody;
  DynamicalBody *ballBody;
  
  BatController *batController;
  GoalFrontController *goalFrontController;
  GoalBackController *goalBackController;
  GoalSide1Controller *goalSide1Controller;
  GoalSide2Controller *goalSide2Controller;
  GoalBottomController *goalBottomController;

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
