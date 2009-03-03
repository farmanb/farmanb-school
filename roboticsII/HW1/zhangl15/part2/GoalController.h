#pragma once

#include "PositionController.h"
#include <cmath>
#define pi 3.14159

class GoalController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param pos  the initial position for the body
  // @param quat the initial quaternion for the body
  // @param index used to denote different piece of the goal
  GoalController(KinematicalBody * body, DVC::Vector<REAL> pos, DVC::Quaternion quat, int index) : PositionController(body){  
    m_x = pos(0);
    m_y = pos(1);
    m_z = pos(2);
    m_quat = quat;

    omega = 90;     //angular velocity, in degrees
    center_x = 1;   //circle center
    center_y = 1;
    radius = 9;       //circle radius
    goalIndex = index; 
  }

  ~GoalController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    
  switch(goalIndex)
{
case 0:	 outPos(0) = center_x + radius*cos(omega*t*(pi)/180) - cos(omega*t*(pi)/180);    //x,y coordinate of goalFront
     	 outPos(1) = center_y + radius*sin(omega*t*(pi)/180) - sin(omega*t*(pi)/180);
    	 break;
case 1:	 outPos(0) = center_x + radius*cos(omega*t*(pi)/180) + cos(omega*t*(pi)/180);   //x,y coordinate of goalBack
    	 outPos(1) = center_y + radius*sin(omega*t*(pi)/180) + sin(omega*t*(pi)/180);
    	 break;
case 2:
case 3:	 outPos(0) = center_x + radius*cos(omega*t*(pi)/180);       //x,y coordinate of goalSide1, goalSide2
    	 outPos(1) = center_y + radius*sin(omega*t*(pi)/180);
    	 break;
case 4:	 outPos(0) = center_x + radius*cos(omega*t*(pi)/180) + sin(omega*t*(pi)/180); //x,y coordinate of goalBottom
    	 outPos(1) = center_y + radius*sin(omega*t*(pi)/180) - cos(omega*t*(pi)/180);
    	 break;
default:;
}
	outPos(2) = m_z;                                                                
        outQuat = DVC::Quaternion(0, 0, sin(omega*t*(pi)/180/2), cos(omega*t*(pi)/180/2)); //Quaternion
}

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  REAL radius, center_x, center_y;
  REAL omega,l;
  int goalIndex;
  DVC::Quaternion m_quat;
};
