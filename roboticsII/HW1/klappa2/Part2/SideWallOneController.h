#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class SideWallOneController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param x the x coordinate of body's center of gravity 
  // @param y the y coordinate of body's center of gravity
  // @param z the z coordinate of the body's center of gravity
  // @param quat the initial quaternion for the body
  SideWallOneController(KinematicalBody * body, REAL x = 10, REAL y = 1, 
		REAL z = 1, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
    m_x = x;
    m_y = y;
    m_z = z;
    m_quat = quat;
  }

  ~SideWallOneController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x + 2*cos((pi+(4*t))/2);
    outPos(1) = m_y + 2*sin((pi+(4*t))/2);
    outPos(2) = m_z;
    outQuat = DVC::Quaternion(0,0,0,1);


  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
