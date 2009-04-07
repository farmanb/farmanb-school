#include <cmath>

/*DVC includes*/
#include "GripControl.h"
#include "Vector.h"


GripControl::GripControl(){
  m_torque = 0.0;
}

void GripControl::GetForce(DVC::REAL t, 
			   DVC::Vector<DVC::REAL> & outForce, 
			   const DVC::Vector<DVC::REAL> & pos, 
			   const DVC::Vector<DVC::REAL> & nu) const{
  
  outForce[0] = 0; /*X force */
  outForce[1] = 0; /*Y force */
  outForce[2] = m_torque; /* Theta angular force*/  
}

//
//GripControl::GripControl(){
//  m_force[0] = m_force[1] = m_force[2] = 0;
//  m_pdEnabled = false;
//  m_pdTarget[0] = m_pdTarget[1] = 0;
//  
//  m_k = 500;
//  m_c = sqrt(m_k);
//}
//
//void GripControl::GetForce(DVC::REAL t, 
//			   DVC::Vector<DVC::REAL> & outForce, 
//			   const DVC::Vector<DVC::REAL> & pos, 
//			   const DVC::Vector<DVC::REAL> & nu) const{
//  
//  outForce[0] = 0; /*X force */
//  outForce[1] = 0; /*Y force */
//  outForce[2] = 0; /* Theta angular force*/
//  
//  /*If the PD controller is enabled, add the PD control force.
//   The PD controller is implemented as a spring with damping.*/
//  if (m_pdEnabled){
//    DVC::REAL springForce[2];
//    DVC::REAL dampingForce[2];
//    DVC::REAL springRestLength = 0;
//
//    DVC::REAL springEndX = m_pdTarget[0];
//    DVC::REAL springEndY = m_pdTarget[1];
//    
//    DVC::REAL posX = pos[0];
//    DVC::REAL posY = pos[1];
//
//    DVC::REAL springLength = dist(posX, posY, springEndX, springEndY);
//    DVC::REAL stretch = springLength - springRestLength;
//    DVC::REAL sinT = 0;
//    DVC::REAL cosT = 0;
//
//    if (springLength != 0){ /* They'll take away your birthday if you divide by 0...*/
//      /*sinT and cosT set the spring force in the direction
//	from the body's center of gravity to the spring's end point.*/
//      sinT = (posX - springEndX)/springLength;
//      cosT = (posY - springEndY)/springLength;
//    }
//    
//    springForce[0] = -m_k*stretch*sinT;
//    springForce[1] = -m_k*stretch*cosT;
//    dampingForce[0] = -m_c*nu[0];
//    dampingForce[1] = -m_c*nu[1];
//
//    outForce[0] = springForce[0] + dampingForce[0];
//    outForce[1] = springForce[1] + dampingForce[1];
//  }
//  
//}
//
//void GripControl::TogglePD(bool toggle){
//  m_pdEnabled = toggle;
//}
//
//bool GripControl::IsPDEnabled(){
//  return m_pdEnabled;
//}
//
//void GripControl::SetPDTarget(DVC::REAL x, DVC::REAL y){
//  m_pdTarget[0] = x;
//  m_pdTarget[1] = y;
//}
//
//void GripControl::SetK(DVC::REAL k){
//  m_k = k;
//}
//
//void GripControl::SetC(DVC::REAL c){
//  m_c = c;
//}
//
//DVC::REAL GripControl::dist(DVC::REAL x1, DVC::REAL y1, DVC::REAL x2, DVC::REAL y2) const{
//  DVC::REAL dx = x2-x1,
//    dy = y2-y1;
//  return sqrt(dx*dx + dy*dy);
//}

void GripControl::SetTorque(DVC::REAL t){
  m_torque = t;
}
