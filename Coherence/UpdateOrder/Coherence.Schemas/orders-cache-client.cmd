setlocal

if (%COHERENCE_HOME%)==() (
   set COHERENCE_HOME=C:\Oracle\Middleware\coherence
)

set PROJ=C:\JDeveloper\mywork\Coherence
set CONFIG=%PROJ%\UpdateOrder\Coherence.Schemas

@rem set COH_OPTS=%COH_OPTS% -server -cp %COHERENCE_HOME%\lib\coherence.jar;%PROJ%;%PROJ%\UpdateOrder\classes
@rem set COH_OPTS=%COH_OPTS% -Dtangosol.coherence.cacheconfig=%CONFIG%\orders-cache-config.xml

"%JAVA_HOME%\bin\java" -cp %CONFIG%;%COHERENCE_HOME%\lib\coherence.jar;%PROJ%;%PROJ%\UpdateOrder\classes -Dtangosol.coherence.distributed.localstorage=false com.tangosol.net.CacheFactory

:exit