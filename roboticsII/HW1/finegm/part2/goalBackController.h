#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class goalBackController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param x the x coordinate of body's center of gravity 
  // @param y the y coordinate of body's center of gravity
  // @param z the z coordinate of the body's center of gravity
  // @param quat the initial quaternion for the body
  goalBackController(KinematicalBody * body, REAL x = 11, REAL y = .954978, 
		REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
    m_x = x;
    m_y = y;
    m_z = z;
    m_quat = quat;
  }

  ~goalBackController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x + 5*cos((pi) + (3*t)/2);
    outPos(1) = m_y + 5*sin((pi) + (3*t)/2);
    outPos(2) = m_z + 5*cos((pi) + (3*t)/2);
    outQuat = DVC::Quaternion(0,0,0,1);
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
