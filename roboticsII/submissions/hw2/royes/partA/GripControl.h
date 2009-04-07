#pragma once

#include "ForceController.h"
#include "PositionController.h"

namespace DVC{
  template <class T>
    class Vector;
}
/*
class positionController : public DVC::PositionController, public DVC::Dynamics2D {

public:

	positionController(DVC::KinematicalBody * body, DVC::REAL x = 10, DVC::REAL y = 1, 
		DVC::REAL z = -1) : DVC::PositionController(body){ 

			DVC::Vector<DVC::REAL> outPos;

			//DVC::Vector<DVC::REAL> bodyPos = body->GetPositionController()->GetPosition(t,outPos);
		//	body->GetPositionController()->GetPosition(GetSimTime(),outPos);

			//std::cout << std::endl << bodyPos(0) << " " << bodyPos(1) << " " << bodyPos(2) << std::endl;

    m_x = outPos(0);
    m_y = outPos(1);
    m_z = outPos(2);
	}

~positionController(){};
	
	
void GetConfiguration(DVC::REAL t, DVC::Vector<DVC::REAL> & outPos) const{
	//  DVC::Vector<DVC::REAL> bodyPos = body->GetPositionController()->GetPosition(t,outPos);

	body->GetPositionController()->GetPosition(GetSimTime(),outPos);
  
	//part 4 move goal x still knock ball in
	   outPos(0) = outPos(0)+.01*cos(t);
    outPos(1) = outPos(1);
    outPos(2) = outPos(2);
   
  }
  DVC::REAL m_x, m_y, m_z;
};
*/
class GripControl : public DVC::ForceController {//, public DVC::PositionController {
 public:
  GripControl();
  
  void GetForce(DVC::REAL t, 
		DVC::Vector<DVC::REAL> & outForce, 
		const DVC::Vector<DVC::REAL> & pos, 
		const DVC::Vector<DVC::REAL> & nu) const;

  void TogglePD(bool toggle);
  void SetPDTarget(DVC::REAL x, DVC::REAL y);
  bool IsPDEnabled();
  void SetK(DVC::REAL k);
  void SetC(DVC::REAL c);
  void setForce(DVC::REAL x, DVC::REAL y);
  
void GripControl::SetTorque(DVC::REAL t);


 private:
  DVC::REAL dist(DVC::REAL x1, DVC::REAL y1, DVC::REAL x2, DVC::REAL y2) const;
  DVC::REAL m_k, m_c;

  DVC::Vector<DVC::REAL> myForce;
  DVC::REAL m_force[3];
  DVC::REAL m_pdTarget[2];

  DVC::REAL m_torque;
  bool m_pdEnabled;
  bool use_force;
};

 