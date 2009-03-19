#include "PositionController.h"

namespace DVC{
  template <class T>
    class Vector;
}

class PalmControl : public DVC::PositionController{
 public:

  PalmControl(DVC::KinematicalBody *body);
  ~PalmControl();
  void GetPosition(DVC::REAL t, DVC::Vector<DVC::REAL> &outPos) const;
  void GetPartialwrtTime(DVC::REAL t, DVC::REAL stepSize, 
			 DVC::Vector<DVC::REAL> &outPart) const;
  void SetVel(DVC::Vector<DVC::REAL>&);

 private:
  DVC::Vector<DVC::REAL> m_vel;
  DVC::REAL m_step;
};
