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
  GoalController(KinematicalBody * body, REAL goalX) : PositionController(body){  
    const DVC::Vector<REAL>& pos = body->GetPos();
    m_x = pos[0] - 5;
    m_y = pos[1];
    m_z = pos[2];
    m_quat = DVC::Quaternion(body->GetQuat());
  }

  ~GoalController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x + 5 / 1.88 * t;
    outPos(1) = m_y;
    outPos(2) = m_z;
    outQuat = m_quat; // DVC::Quaternion(0,0,cos((pi+(4*t))/2),sin((pi+(4*t))/2));
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
