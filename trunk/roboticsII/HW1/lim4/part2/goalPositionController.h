#pragma once

#include "PositionController.h"
#include <cmath>
#include <iostream>
using namespace std;

#define pi 3.14159

class goalPositionController : public PositionController {

public:

	// @param body Pointer to position controlled body
	// @param x the x coordinate of body's center of gravity 
	// @param y the y coordinate of body's center of gravity
	// @param z the z coordinate of the body's center of gravity
	// @param quat the initial quaternion for the body
	// GOAL CONTROLLER CONSTRUCTOR
	goalPositionController(KinematicalBody * body, REAL x = 0, REAL y = 0, 
		REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
		
		DVC::Vector<REAL> bodyPos = body->GetPos(); 
		m_x = bodyPos(0);
		m_y = bodyPos(1);
		m_z = bodyPos(2);
		m_quat = quat;

		m_body = body;
	}

	// GOAL CONTROLLER DESTRUCTOR
	~goalPositionController(){}

	// CONFIGURATION OF BAT CONTROLLER (NEW POSITION/ROTATION)
	void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
		//outPos(0) = m_x;
		//outPos(1) = m_y;
		//outPos(2) = m_z;
		
		DVC::Vector<REAL> bodyPos = m_body->GetPos();
		outPos(0) = bodyPos(0) - cos(5*t)/12;
		outPos(1) = bodyPos(1) + sin(5*t)/12;
		outPos(2) = m_z;
		outQuat = DVC::Quaternion(0,0,sin(pi/2), cos(pi/2));

		// ROTATES 180 DEGREES (PI RADIANS) per second
		//outQuat = DVC::Quaternion(0,0,sin(-pi*t/2),cos(-pi*t/2));
		// original
		//outQuat = DVC::Quaternion(0,0,sin((pi+(90*t))/2),cos((pi+(90*t))/2));
	}


	// UNKNOWN FUNCTION
	void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
	}


	// VARIABLES OF GOAL CONTROLLER
	// ---------------------------
	REAL m_x, m_y, m_z;
	DVC::Quaternion m_quat;
	KinematicalBody *m_body;
};