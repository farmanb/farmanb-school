#pragma once

#include "AppGL.h"
#include "BatController.h"
#include "GoalController.h"

class App : public DVC_AppGL {

 public:

  App();
  ~App();

  bool Init();

  void FlushAppSettings();

 protected:
  bool AddBatController();
  bool AddGoalController();
  
  KinematicalBody *GetBat();
  bool GetGoal();


  KinematicalBody *batBody,
    *goalBackBody,
    *goalFrontBody,
    *goalSide1Body,
    *goalSide2Body,
    *goalBottomBody;
  DynamicalBody *ballBody;
  
  BatController *batController;
  KinematicalBody *goalBody[5];
  GoalController *goalController[5];
  /*Add position controllers for 
    the ball and the goal here */
  
  std::string *batName,
    *ballName,
    *goalBack,
    *goalFront,
    *goalSide1,
    *goalSide2,
    *goalBottom,
    *goalName[5];
    
};
