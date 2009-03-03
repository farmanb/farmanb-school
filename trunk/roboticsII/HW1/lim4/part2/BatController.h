//------------------------------
// 
// BATCONTROLLER.H
// DEFINES BAT CONTROLLER
// 
//------------------------------
//
//
// INCLUDES
//===================================
#pragma once
#include "PositionController.h"
#include <cmath>
#include <iostream>
using namespace std;
#define pi 3.14159

//
//
// CLASS DEFINITION
//===================================
class BatController : public PositionController {
	
	// PUBLIC
	// ----------------
	public: 
  
	// @param body Pointer to position controlled body
	// @param x the x coordinate of body's center of gravity 
	// @param y the y coordinate of body's center of gravity
	// @param z the z coordinate of the body's center of gravity
	// @param quat the initial quaternion for the body
	// BAT CONTROLLER CONSTRUCTOR
	BatController(KinematicalBody * body, REAL x = 0, REAL y = 0, 
			REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
		m_x = x;
		m_y = y;
		m_z = z;
		m_quat = quat;
	}

	// BAT CONTROLLER DESTRUCTOR
	~BatController(){}

	// CONFIGURATION OF BAT CONTROLLER (NEW POSITION/ROTATION)
	void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
		outPos(0) = m_x;
		outPos(1) = m_y;
		outPos(2) = m_z;

		// ROTATES 180 DEGREES (PI RADIANS) per second
		outQuat = DVC::Quaternion(0,0,sin(-pi*t/2),cos(-pi*t/2));
		// original
		//outQuat = DVC::Quaternion(0,0,sin((pi+(90*t))/2),cos((pi+(90*t))/2));


		/* TEST
		// makes it stand up straight
		//outQuat = DVC::Quaternion(0,0,sin((pi/2+(0))/2),cos((pi/2+(0))/2));
		// make it flat
		//outQuat = DVC::Quaternion(0,0,sin((pi+(0))/2),cos((pi+(0))/2));

		//outQuat = DVC::Quaternion(0,0,sin(-pi*t/2),cos(-pi*t/2));

		// timer
		//if (t >= 1)
		//	outQuat = DVC::Quaternion(0, 0, sin((pi*(t-1)*2)/2), cos((pi*(t-1)*2)/2));
		//else
		//	outQuat = DVC::Quaternion(0,0,sin(pi/2),cos(pi/2));

		//cout<<t<<endl;
		//cout<<sin(pi/2)<<endl;
		*/
	}

	// UNKNOWN FUNCTION
	void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
	}




	// VARIABLES OF BAT CONTROLLER
	// ---------------------------
	REAL m_x, m_y, m_z;
	DVC::Quaternion m_quat;
};
