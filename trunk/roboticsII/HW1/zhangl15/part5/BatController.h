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
  BatController(KinematicalBody * body, DynamicalBody * ballbody, REAL x = 0, REAL y = 0, 
		REAL z = 0, DVC::Quaternion quat = DVC::Quaternion(0,0,cos((pi)/2),sin((pi)/2))) : PositionController(body){  
    m_x = x;
    m_y = y;
    m_z = z;
    m_quat = quat;
    initialangle = 0;
    pball = ballbody;
//    fp = fopen("recorddirection.txt", "w");
  }

  ~BatController(){/*fclose(fp);*/}

  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{
    REAL center_x = -2;
    REAL center_y = 0;
    REAL radius = 2;
    DVC::Vector<REAL> ballPos;
    DVC::Vector<REAL> vball;
    REAL omega;
    REAL frequency, magnitude;
    frequency = 25;
    magnitude = 2;
    
    
    static int count = 0;
    count = (count+1)%4;
    switch (count) {
     case 0:
           omega = 100;
           break;
     case 1:
           omega = -100;
           break;
     case 2:
           omega = -100;
          break;
     case 3:
          omega = 100;
          break;
     default:
          ;
     }
    ballPos = pball->GetPos();
    vball = pball->GetNu();
    static REAL olddirection = initialangle;
    if(vball(1) > 0 && count == 0)
    {
       if(vball(0) > 0)
       {
          olddirection = 1;
       }
       if(vball(0) < 0)
       { 
         olddirection = -1;
       }
     }
    
    REAL direction = (olddirection + omega*0.01)*pi/180; 
 //   fprintf(fp, "vballx: %.2f, vbally: %.2f, olddirection: %.1f direction: %.1f count: %d\n",vball(0), vball(1), olddirection, direction, count);
    olddirection = direction*180/pi;
    outPos(0) = center_x + radius * cos(direction);
    outPos(1) = center_y + radius * sin(direction);
    outPos(2) = m_z;
    outQuat = DVC::Quaternion(0,0,sin(direction/2),cos(direction/2));
    }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }
  REAL initialangle;
  REAL m_x, m_y, m_z;
  DVC::Quaternion m_quat;
  DynamicalBody *pball;
//FILE *fp;
};
