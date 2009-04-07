#include "PalmControl.h"

/* Constructor */
PalmControl::PalmControl(DVC::KinematicalBody *body) : DVC::PositionController(body){
    m_vel.resize(3);
    m_vel.set(0.0);
  }

/* Destructor */
PalmControl::~PalmControl(){}

void PalmControl::GetPosition(DVC::REAL t, DVC::Vector<DVC::REAL> &outPos) const{
  outPos = body->GetQ() + m_vel;
}

void PalmControl::GetPartialwrtTime(DVC::REAL t, DVC::REAL stepSize, 
		       DVC::Vector<DVC::REAL> &outPart) const{
  outPart[0] = m_vel(0)/stepSize;
  outPart[1] = m_vel(1)/stepSize;
  outPart[2] = m_vel(2)/stepSize;

  /*	
	outPart[0] = -yOffset * cos(alpha * (1.0 - cos(omega * t))) * alpha * sin(omega * t) * omega;
	outPart[1] = -yOffset * sin(alpha * (1.0 - cos(omega * t))) * alpha * sin(omega * t) * omega;
	outPart[2] = alpha * sin(omega * t) * omega;
  */
}

void PalmControl::SetVel(DVC::Vector<DVC::REAL> &vel){
  /* Sanity check */
  assert (vel.size() == m_vel.size());
  
  m_vel = vel;
}
