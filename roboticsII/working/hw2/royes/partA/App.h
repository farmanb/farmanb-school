#include "AppGL.h"
#include "GripControl.h"
//#include "PalmPositionController.h"

class App : public DVC_AppGL{
 public:
  App();
  ~App();
  
  bool Init();
  void PostStep();

 private:
  bool GetBodies();
  bool AddControllers();
  void GoToPartCG();
  
  std::string **gripName,
    *partName, *palmName;

  DynamicalBody *part, **grip, *palm;
  GripControl **gripController;
};
