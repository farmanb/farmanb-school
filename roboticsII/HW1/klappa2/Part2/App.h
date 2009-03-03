#pragma once

#include "AppGL.h"

#include "BatController.h"
#include "BackWallController.h"
#include "BottomWallController.h"
#include "FrontWallController.h"
#include "SideWallOneController.h"
#include "SideWallTwoController.h"

class App : public DVC_AppGL {

 public:

  App();
  ~App();

  bool Init();

  void FlushAppSettings();

 protected:
  bool AddBatController();
  bool AddBackWallController();
  bool AddFrontWallController();
  bool AddBottomWallController(); 
  bool AddSideWallOneController(); 
  bool AddSideWallTwoController(); 
  
  KinematicalBody *GetBat();
  KinematicalBody *GetBackWall();
  KinematicalBody *GetFrontWall();
  KinematicalBody *GetBottomWall();
  KinematicalBody *GetSideWallOne();
  KinematicalBody *GetSideWallTwo();
  bool GetGoal();


  KinematicalBody *batBody, *goalBody,
    *goalBackBody,
    *goalFrontBody,
    *goalSide1Body,
    *goalSide2Body,
    *goalBottomBody;
  DynamicalBody *ballBody;
  
  BatController *batController;
  BackWallController *backWallController;
  BottomWallController *bottomWallController;
  FrontWallController *frontWallController;
  SideWallOneController *sideWallOneController;
  SideWallTwoController *sideWallTwoController;

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
