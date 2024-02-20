#pragma once

#include "PositionController.h"
#include <cmath>
#define pi 3.14159



class GoalController : public PositionController {
  
 public: 
  
  // @param body Pointer to position controlled body
  // @param pos  the initial position for the body
  // @param quat the initial quaternion for the body
  // @param index used to denote different piece of the goal
  GoalController(KinematicalBody * body, DVC::Vector<REAL> pos, DVC::Quaternion quat, int index, DynamicalBody *ball) : PositionController(body){  
    m_x = pos(0);
    m_y = pos(1);
    m_z = pos(2);
    m_quat = quat;
    m_Pos = pos;
    pBall = ball;   
    goalIndex = index;
   // char filename[100];
   // sprintf(filename, "recode_%d\n", goalIndex);
 //   fp = fopen(filename, "w");
  }

  ~GoalController(){}


  /* Implement Me */
  void GetConfiguration(REAL t, DVC::Vector<REAL> & outPos, DVC::Quaternion & outQuat) const{

	static REAL oldPositionGoal[5];
	static int  countTerm_z[5];
	static int  isNotFirst[5];    
        DVC::Vector<REAL> ballpos = pBall->GetPos();
        DVC::Vector<REAL> ballnu = pBall->GetNu();
        REAL velocity = 1.5;
        REAL range = 6;
        REAL intersection = 0;
        REAL tball;
        REAL newpos;
        REAL range1, range2, range3, range4;
        range1 = m_x + range;
        range2 = m_x;
        range3 = m_x - range;
        range4 = m_x;
        REAL adjustment;
        switch(goalIndex) {
        case 0:
             adjustment = -1;
             break;
        case 1:
             adjustment = 1;
             break;
        case 2:
        case 3:
        case 4:
             adjustment = 0;
             break;
        default:;
        }
        if(ballpos(1) > 2 && ballnu(0) > 0)
        {
          if(ballnu(1) > 0)
            {
               tball = ballnu(1)/9.81 + sqrt(2/9.81*(sqrt(ballnu(1)*ballnu(1)/2/9.81) + ballpos(1) -2)); 
            }
          else
          {
           tball = sqrt(2/9.81*(sqrt(ballnu(1)*ballnu(1)/2/9.81) + ballpos(1) -2)) + ballnu(1)/9.81; 
          }
          intersection = tball*ballnu(0) + ballpos(0);
          if(intersection <= m_x + adjustment + range + 1 && intersection >= m_x +adjustment  - range -1)
          { 
        	REAL distance2go;
        	if(oldPositionGoal[goalIndex] + adjustment  > intersection)
       		{
        		if(countTerm_z[goalIndex] == 0 || countTerm_z[goalIndex] == 3)
			{
          			distance2go = m_x + range - oldPositionGoal[goalIndex] + m_x + range -(intersection - adjustment);  
        		}
			else
			{   
          			distance2go = oldPositionGoal[goalIndex] - intersection + adjustment;
        		}
		}
		else
       		{
        		if(countTerm_z[goalIndex] == 1 || countTerm_z[goalIndex] == 2)
			{
         			 distance2go = oldPositionGoal[goalIndex] - (m_x -range) + (intersection - adjustment) - (m_x-range);  
        		}
			else
			{   
        			  distance2go = intersection - adjustment - oldPositionGoal[goalIndex];
       			 }
		}
		velocity = distance2go/tball;
		if(tball <= 0.02 || distance2go <= 0.25 ) velocity = 0;

//        fprintf(fp, "velocity: %.2f, intersection: %.2f, tball: %.2f, distance2go:%.2f, ballx, %.2f, bally: %.2f,  t: %.2f\n", velocity, intersection, tball, distance2go, ballpos(0), ballpos(1), t);
         }
       }
       if(isNotFirst[goalIndex] == 0 )
       {
           oldPositionGoal[goalIndex] = m_x;
           isNotFirst[goalIndex] = 1;
           countTerm_z[goalIndex] = 0;
        }
        switch(countTerm_z[goalIndex]) {
        case 0:
             newpos = oldPositionGoal[goalIndex] + velocity*0.01;
             if(newpos >= range1) countTerm_z[goalIndex]  = (countTerm_z[goalIndex]+1)%4;
             break;
        case 1:
             newpos = oldPositionGoal[goalIndex] - velocity*0.01;
             if(newpos <= range2) countTerm_z[goalIndex]  = (countTerm_z[goalIndex]+1)%4;
             break;
        case 2:
             newpos = oldPositionGoal[goalIndex] - velocity*0.01;
             if(newpos <= range3) countTerm_z[goalIndex]  = (countTerm_z[goalIndex]+1)%4;
             break;
        case 3:
             newpos = oldPositionGoal[goalIndex] + velocity*0.01;
             if(newpos >= range4) countTerm_z[goalIndex]  = (countTerm_z[goalIndex]+1)%4;
             break;
        default:
              ;
        }
        oldPositionGoal[goalIndex] = newpos;
        outPos(0) = newpos;
        outPos(1) = m_y;
	outPos(2) = m_z;                                                                
        outQuat = m_quat; //Quaternion
        
  }

  void GetPartialwrtTime(REAL t, REAL stepSize, Vector<REAL> & outPart) const {
  }



  DynamicalBody *pBall;
  REAL m_x, m_y, m_z;
  int goalIndex;
  DVC::Vector<REAL> m_Pos;
  DVC::Quaternion m_quat;
};
