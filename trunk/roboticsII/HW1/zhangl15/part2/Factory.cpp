#include "App.h"

extern "C" BASE_APP_API DVC_AppGL * CreateApp()
{
  return new App;
}

extern "C" BASE_APP_API void DestroyApp(DVC_AppGL * app)
{
  delete app;
}
