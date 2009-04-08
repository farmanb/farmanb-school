#include "BallController.h"
#include "DynamicalBody.h"

#include <cmath>

#define pi 3.14159

BallController::BallController(DVC::DynamicalBody *body){
  m_shouldShoot = false;
  m_ball = body;
}

BallController::~BallController(){
}

void BallController::ShouldShoot(bool val){
  m_shouldShoot = val;
}

void BallController::GetForce(DVC::REAL t,
		DVC::Vector<DVC::REAL> &outForce,
		const DVC::Vector<DVC::REAL> &pos,
			      const DVC::Vector<DVC::REAL> &nu) const{
  outForce[0] = 0; /* x-component of the force */
  outForce[1] = 0; /* y-component of the force */
  outForce[1] = 0;
  
  if (m_shouldShoot){
    DVC::REAL mass = m_ball->GetMass();
    /*
      Norm of the force vector
     */
      DVC::REAL force = mass * 30;
      /*
	Apply the force at a 45 degree angle.
       */
      outForce[0] = force * cos(pi/4);
      outForce[1] = force * sin(pi/4);
  }
  
    
}
