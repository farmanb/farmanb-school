#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class GoalBottomController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param x the x coordinate of body's center of gravity 
  // @param y the y coordinate of body's center of gravity
  // @param z the z coordinate of the body's center of gravity
  // @param quat the initial quaternion for the body
  GoalBottomController(KinematicalBody * body, REAL x = 0, REAL y = 0, 
		REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
    m_xbottom = x;
    m_ybottom = y;
    m_zbottom = z;
    m_quatbottom = quat;
  }

  ~GoalBottomController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = 10+2*cos(10*t);
    outPos(1) = 0+2*sin(10*t);
    outPos(2) = 0;
	outQuat = DVC::Quaternion(0,0,cos(pi),sin(pi));
  }

  REAL m_xbottom, m_ybottom, m_zbottom;
  DVC::Quaternion m_quatbottom;

};
