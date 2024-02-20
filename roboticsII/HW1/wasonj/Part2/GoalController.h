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
  GoalController(KinematicalBody * body, REAL x = 0, REAL y = 0, 
		REAL z = 0, REAL circlespeed = 0) : PositionController(body){  
    
	DVC::Quaternion quat = body->GetQuat();
	DVC::Vector<REAL> initpos(3);
		initpos=body->GetPos();

	m_x = x + initpos(0);
    m_y = y + initpos(1);
    m_z = z + initpos(2);
    m_quat = quat;
	m_circlespeed=circlespeed;
  }

  ~GoalController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x + 2-2*cos(m_circlespeed*t);
    outPos(1) = m_y + 2*sin(m_circlespeed*t);
    outPos(2) = m_z;
    outQuat = m_quat;
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z, m_circlespeed;
  DVC::Quaternion m_quat;

};
