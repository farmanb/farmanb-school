

#include "GripControl.h"
#include "Vector.h"
#include <cstdio>


class HandControl {

	public:
		HandControl();
		~HandControl();

		bool Init(GripControl** gc,DVC::Vector<DVC::REAL>& pos);
		void SetHandTarget(DVC::Vector<DVC::REAL>& pos,DVC::REAL movetime,DVC::REAL simtime);
		void HandInvKin(DVC::Vector<DVC::REAL>& pos);
		void BalanceAngle(DVC::Vector<DVC::REAL>& pos);

		bool TimeStep(DVC::REAL simtime);

		bool StartScriptFile(std::string fname);
		void ScriptTimeStep(DVC::REAL simtime);

	private:
		GripControl **gripController;
		DVC::Vector<DVC::REAL> desPos;

		DVC::Vector<DVC::REAL> desVel;
		DVC::Vector<DVC::REAL> curPos;
		DVC::Vector<DVC::REAL> startPos;

		DVC::REAL movestarttime;
		DVC::REAL movetime;
		bool moving;

		int scriptpoint;
		int scriptpointcount;
		DVC::REAL lastscripttime;
		DVC::REAL nextscripttime;
		FILE* scriptfile;

};