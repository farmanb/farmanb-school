#include "HandControl.h"
#include <cmath>

/*DVC includes*/

#include "Vector.h"


HandControl::HandControl() {
	scriptfile=0;

}

HandControl::~HandControl() {

}

bool HandControl::Init(GripControl** gc,DVC::Vector<DVC::REAL>& pos) {
	
	if (scriptfile) {
		fclose(scriptfile);
	}

	gripController=gc;

	HandInvKin(pos);
	desPos=pos;
	curPos=pos;

	scriptpoint=0;
	scriptpointcount=0;
	lastscripttime=0;
	nextscripttime=1.0;

	moving=false;
	return true;
}

void HandControl::SetHandTarget(DVC::Vector<DVC::REAL>& pos,DVC::REAL movetime_m,DVC::REAL simtime) {
	DVC::Vector<DVC::REAL> d_pos(7);
movetime=movetime_m;
	desPos=pos;
	startPos=curPos;
	//d_pos=desPos-curPos;
	
	//desVel=d_pos*(1/movetime);
	

	movestarttime=simtime;
	
	moving=true;
}


bool HandControl::TimeStep(DVC::REAL simtime) {


	if (scriptpointcount != 0) {

		ScriptTimeStep(simtime);
	}

	DVC::REAL mt;
	if (simtime> (movetime+movestarttime)) {
		moving=false;
		curPos=desPos;
		HandInvKin(curPos);
	}
	else {
		mt=(simtime-movestarttime)/movetime;

	

		curPos=(1-mt)*startPos+mt*desPos;
		HandInvKin(curPos);
	}
	
	
	
	return moving;
}

void HandControl::HandInvKin(DVC::Vector<DVC::REAL>& pos) {
	
	DVC::REAL x1,y1,theta1,x2,y2,theta2,theta3;

	x1=pos[0];
	y1=pos[1];
	theta1=pos[2];
	x2=pos[3];
	y2=pos[4];
	theta2=pos[5];
	theta3=pos[6];
	
	
	DVC::REAL p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, p2p_x, p2p_y, p4p_x, p4p_y, p24p_x, p24p_y, dp24, c1, s1, c2, s2, c13, s13, c4, s4, sA, cA, sB, cB;


	//Calc position of p1
	
	s1=sin(theta1); c1=cos(theta1);

	p1_x=-.15*s1+x1;
	p1_y=.15*c1+y1;

	s13=sin(theta1+theta3);
	c13=cos(theta1+theta3);
	p2_x=-.35*s1-.2*s13+x1;
	p2_y=.35*c1+.2*c13+y1;


	c2=cos(theta2);
	s2=sin(theta2);
	p4_x=-.15*s2+x2;
	p4_y=.15*c2+y2;
	
	p2p_x=-.35*s1-.4*s13+x1;
	p2p_y=.35*c1+.4*c13+y1;

	p4p_x=-.35*s2+x2;
	p4p_y=.35*c2+y2;

	dp24=sqrt(pow(p2p_x-p4p_x,2)+pow(p2p_y-p4p_y,2));

	p24p_x=p2p_x-p4p_x;
	p24p_y=p2p_y-p4p_y;

	sA=-p24p_x/dp24;
	cA=p24p_y/dp24;

	cB=(pow(dp24,2))/(2*.4*dp24);
	sB=-sqrt(1-pow(cB,2));

	s4=sA*cB+cA*sB;
	c4=cA*cB-sA*sB;

	p3_x=p4p_x-.2*s4;
	p3_y=p4p_y+.2*c4;

	gripController[1]->SetPDTarget(p1_x,p1_y);
	gripController[0]->SetPDTarget(p2_x,p2_y);
	gripController[2]->SetPDTarget(p3_x,p3_y);
	gripController[3]->SetPDTarget(p4_x,p4_y);
	
}

void HandControl::BalanceAngle(DVC::Vector<DVC::REAL>& pos) {

	DVC::REAL x1,y1,theta1,x2,y2,theta2,theta3;

	x1=pos[0];
	y1=pos[1];
	theta1=pos[2];
	x2=pos[3];
	y2=pos[4];
	theta2=pos[5];
	theta3=pos[6];
	
	
	DVC::REAL p1_x, p1_y,  p4_x, p4_y, p14_x, p14_y, d14, c1, s1, c2, s2, sA, cA, sP, cP, alpha, phi, d;


	//Calc position of p1
	
	s1=sin(theta1); c1=cos(theta1);

	p1_x=-.35*s1+x1;
	p1_y=.35*c1+y1;

	
	

	c2=cos(theta2);
	s2=sin(theta2);
	p4_x=-.35*s2+x2;
	p4_y=.35*c2+y2;

	p14_x=p4_x-p1_x;
	p14_y=p4_y-p1_y;

	d14=sqrt(pow(p14_x,2)+pow(p14_y,2));
	d=(d14-.4)/2;

	phi=acos(d/.4)*d/abs(d);
	
	alpha=atan2(-p14_x,p14_y);

	pos[6]=phi+alpha-theta1;

}

bool HandControl::StartScriptFile(std::string fname) {
	scriptfile=fopen(fname.c_str(),"r");
	
	if (!scriptfile) {
		printf("Could not open file\n");
		return false;
	}

	fscanf(scriptfile,"%i\n",&scriptpointcount);

	return true;
}

void HandControl::ScriptTimeStep(DVC::REAL simtime) {
	char line[1024];
			double t;
			double x1,y1,theta1,x2,y2,theta2,theta3;

			


	if ((simtime > nextscripttime) && (scriptpoint < scriptpointcount)) {
		scriptpoint++;
		
		  
			

			fgets(line,1023,scriptfile);

			int readcount=0;

			readcount=sscanf(line,"%lf,%lf,%lf,%lf,%lf,%lf,%lf,%lf",&t,&x1,&y1,&theta1,&x2,&y2,&theta2,&theta3);

			if (readcount < 6) {
				printf("Script format error\n");
			}

			DVC::Vector<DVC::REAL> pos(7);
			pos[0]=x1;
			pos[1]=y1;
			pos[2]=theta1;
			pos[3]=x2;
			pos[4]=y2;
			pos[5]=theta2;
			if (readcount > 7) {
				pos[6]=theta3;
			}
			else {
				BalanceAngle(pos);
			}

			SetHandTarget(pos,t,simtime);
			lastscripttime=simtime;
			nextscripttime=simtime+t;

		

	}

	
	

}