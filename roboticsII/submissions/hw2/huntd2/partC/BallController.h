#pragma once

#include "ForceController.h"

namespace DVC{
  template <class T>
    class Vector;
  class DynamicalBody;
}

class BallController : public DVC::ForceController{
 public:
  BallController(DVC::DynamicalBody *body);
  ~BallController();

  void ShouldShoot(bool);
  void GetForce(DVC::REAL t,
		DVC::Vector<DVC::REAL> &outForce,
		const DVC::Vector<DVC::REAL> &pos,
		const DVC::Vector<DVC::REAL> &nu) const;
  
 private:
  DVC::DynamicalBody *m_ball;
  bool m_shouldShoot;
};
