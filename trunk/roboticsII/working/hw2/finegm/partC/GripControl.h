#pragma once

#include "ForceController.h"

namespace DVC{
  template <class T>
    class Vector;
}
/*
class GripControl : public DVC::ForceController
{
public:
	GripControl();

	void GetForce(DVC::REAL t, 
		DVC::Vector<DVC::REAL> & outForce, 
		const DVC::Vector<DVC::REAL> & pos, 
		const DVC::Vector<DVC::REAL> & nu) const;
	void SetTorque(DVC::REAL t);

 private:
	DVC::REAL m_torque;

};*/

class GripControl : public DVC::ForceController {
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
  void SetTorque(DVC::REAL t);

 private:
  DVC::REAL dist(DVC::REAL x1, DVC::REAL y1, DVC::REAL x2, DVC::REAL y2) const;
  DVC::REAL m_k, m_c;

  DVC::REAL m_torque;

  DVC::REAL m_force[3];
  DVC::REAL m_pdTarget[2];
  bool m_pdEnabled;
};

