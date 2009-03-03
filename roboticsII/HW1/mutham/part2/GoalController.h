#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class GoalController : public PositionController {
 public: 
  
  // @param body Pointer to position controlled body
  // @param x the x coordinate of body's center of gravity 
  // @param y the y coordinate of body's center of gravity
  // @param z the z coordinate of the body's center of gravity
  // @param quat the initial quaternion for the body
  GoalController(KinematicalBody * body, REAL x, REAL y, 
	  REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2), sin((pi)/2))) : PositionController(body){  
    m_x = x + 5;
    m_y = y;
    m_z = z;
    m_quat = quat;
	back = body;
  }

  ~GoalController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x+cos(pi*t);
    outPos(1) = m_y+sin(pi*t);
    outPos(2) = m_z;
    outQuat = DVC::Quaternion(0,0,0,1);
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }
  KinematicalBody * back;
  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
