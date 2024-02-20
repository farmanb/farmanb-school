#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class BatController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param x the x coordinate of body's center of gravity 
  // @param y the y coordinate of body's center of gravity
  // @param z the z coordinate of the body's center of gravity
  // @param quat the initial quaternion for the body
  BatController(KinematicalBody * body, REAL x = 0, REAL y = 0, 
		REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
    m_x = x;
    m_y = y;
    m_z = z;
    m_quat = quat;
    initialangle = -120;
    omega = 80;
  }

  ~BatController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    REAL center_x = -2;
    REAL center_y = 0;
    REAL radius = 2;
    
    REAL direction = (initialangle + omega*t)*pi/180; 
    outPos(0) = center_x + radius * cos(direction);
    outPos(1) = center_y + radius * sin(direction);
    outPos(2) = m_z;
    outQuat = DVC::Quaternion(0,0,sin(direction/2),cos(direction/2));
    }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }
  REAL initialangle, omega;
  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
