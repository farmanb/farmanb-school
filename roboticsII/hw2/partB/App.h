#include "AppGL.h"
#include "GripControl.h"

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
    *partName;

  DynamicalBody *part, **grip;
  GripControl **gripController;
};
