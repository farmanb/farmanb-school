#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class GoalBackController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param x the x coordinate of body's center of gravity 
  // @param y the y coordinate of body's center of gravity
  // @param z the z coordinate of the body's center of gravity
  // @param quat the initial quaternion for the body
  GoalBackController(KinematicalBody * body, REAL x = 0, REAL y = 0, 
		REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
    m_xback = x;
    m_yback = y;
    m_zback = z;
    m_quatback = quat;
  }

  ~GoalBackController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = 11+2*cos(10*t);
    outPos(1) = .954978+2*sin(10*t);
    outPos(2) = 0;
	outQuat = DVC::Quaternion(0,0,cos(pi),sin(pi));

  }

  REAL m_xback, m_yback, m_zback;
  DVC::Quaternion m_quatback;

};
