#pragma once

#include "PositionController.h"
#include <cmath>

#define pi 3.14159

class GoalController : public PositionController {

public:

GoalController(KinematicalBody * body, REAL x = 10, REAL y = 1, 
		REAL z = -1, DVC::Quaternion quat = DVC::Quaternion(0,0,0,sin((pi)/2))) : PositionController(body){ 
			DVC::Vector<REAL> bodyPos = body->GetPos();

			//std::cout << std::endl << bodyPos(0) << " " << bodyPos(1) << " " << bodyPos(2) << std::endl;

    m_x = bodyPos(0);
    m_y = bodyPos(1);
    m_z = bodyPos(2);
    m_quat = quat;

	}

~GoalController(){};
	
	  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
	  DVC::Vector<REAL> bodyPos = body->GetPos();

  //circular motion part 2
	
    outPos(0) = bodyPos(0)+.06*cos(t);
    outPos(1) = bodyPos(1)+.03*sin(t);
    outPos(2) = bodyPos(2);
    outQuat = DVC::Quaternion(0,0,0,1);

	//part 4 move goal x still knock ball in
	   outPos(0) = bodyPos(0)+.01*cos(t);
    outPos(1) = bodyPos(1);
    outPos(2) = bodyPos(2);
    outQuat = DVC::Quaternion(0,0,0,1);
	
  }
  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};

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
    outPos(1) = m_y;
    outPos(2) = m_z;
	//part 1 -4
    outQuat = DVC::Quaternion(0,0,cos((pi+(90*t/20.500002))/2),sin((pi+(90*t/20.50002))/2));
	//part 5
	//outQuat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2));

  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }

  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;

};
