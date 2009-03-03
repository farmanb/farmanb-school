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


  KinematicalBody *batBody, *goalBody,
    *goalBackBody,
    *goalFrontBody,
    *goalSide1Body,
    *goalSide2Body,
    *goalBottomBody;
  DynamicalBody *ballBody;
  
  BatController *batController;
  GoalController *goalBackC, *goalFrontC, *goalSide1C, *goalSide2C, *goalBottomC;

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
