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

  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    outPos(0) = .5;
    outPos(1) = 0;
    outPos(2) = 0;
	double t1 = 1.185;
	t1=1.39;
	if(t>t1 && t<3.6){
		outQuat = DVC::Quaternion(0,0,cos((pi+(.05*90*(t-t1)))/2),sin((pi+(.05*90*(t-t1)))/2));
	}
	if(t>=3.6 && t<3.83){
		outQuat = DVC::Quaternion(0,0,cos(pi),sin(pi));
	}
	if(t>=3.82 && t<3.86){
		outQuat = DVC::Quaternion(0,0,cos((pi+(.1*90*(t-3.84)))/2),sin((pi+(.1*90*(t-3.84)))/2));
	}
	if(t>3.9 && t<5.98){
		outQuat = DVC::Quaternion(0,0,cos(pi),sin(pi));
	}
	if(t>=5.98 && t<6.){
		outQuat = DVC::Quaternion(0,0,cos((pi+(.1*90*(t-5.98)))/2),sin((pi+(.1*90*(t-5.98)))/2));
	}
	if(t>7.5){
		outQuat = DVC::Quaternion(0,0,cos((pi+(.1*90*(t-7.5)))/2),sin((pi+(.1*90*(t-7.5)))/2));
	}
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
