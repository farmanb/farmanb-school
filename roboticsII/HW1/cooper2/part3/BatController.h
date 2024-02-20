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
  BatController(KinematicalBody * body, REAL goalX) : PositionController(body){  
    m_x = 0;
    m_y = 0;
    m_z = 0;
    if (goalX <= 0 && goalX >= -5)
      m_speed = 3.66 + (3.988 - 3.66) / 5 * (goalX + 5);
    else
      m_speed = 3.988 + (5 - 3.988) / 2.5 * goalX;
    printf("%.3f", m_speed);
    REAL angle = 3 * pi / 4;
    m_quat = DVC::Quaternion(0, 0, sin(angle / 2), cos(angle / 2));
  }

  ~BatController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x;
    outPos(1) = m_y + m_speed * t;
    outPos(2) = m_z;
    outQuat = m_quat;
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z, m_speed;
  DVC::Quaternion m_quat;

};
