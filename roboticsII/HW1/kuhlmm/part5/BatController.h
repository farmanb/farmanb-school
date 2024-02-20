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
  }

  ~BatController(){}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = m_x;
	outPos(1) = m_y+ .2*(sin(5*pi*t)+.5*sin(5*pi*2*t) + .33333*sin(5*pi*3*t) + .25*sin(5*pi*4*t) + .2*sin(5*pi*5*t) + .1666*sin(5*pi*6*t) +.1429*sin(5*pi*7*t)) ;
    outPos(2) = m_z;
    //outQuat = DVC::Quaternion(0,0,cos((pi+(90*t))/2),sin((pi+(90*t))/2));//original
	//outQuat = DVC::Quaternion(0,0,cos((pi-.75*pi/4+(7*t))/2),sin((pi-.75*pi/4+(7*t))/2));//first parabolic movement, overshot
	//outQuat = DVC::Quaternion(0,0,cos((pi-.77*pi/4+(7*t))/2),sin((pi-.77*pi/4+(7*t))/2)); //goal!
	//outQuat = DVC::Quaternion(0,0,cos((pi-.77*pi/4+(7*t))/2),sin((pi-.77*pi/4+(7*t))/2)); //goal!
	outQuat = DVC::Quaternion(0,0,cos(pi/2),sin(pi/2));
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
