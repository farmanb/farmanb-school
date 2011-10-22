@echo off
setlocal

if (%COHERENCE_HOME%)==() (
   set COHERENCE_HOME=C:\Oracle\Middleware\coherence
)

set PROJ=C:\JDeveloper\mywork\Coherence
set CONFIG=%PROJ%

@rem set COH_OPTS=%COH_OPTS% -server -cp %COHERENCE_HOME%\lib\coherence.jar;%PROJ%;%PROJ%\UpdateOrder\classes
@rem set COH_OPTS=%COH_OPTS% -Dtangosol.coherence.cacheconfig=%CONFIG%\orders-cache-config.xml

"%JAVA_HOME%\bin\java" -cp %COHERENCE_HOME%\lib\coherence.jar;%PROJ%;%PROJ%\UpdateOrder\classes com.tangosol.net.DefaultCacheServer
@rem "%JAVA_HOME%\bin\java" %COH_OPTS% -Xms1g -Xmx1g -Xloggc: -Dtangosol.coherence.management.remote=true -Dtangosol.coherence.clusterport=7777 -Dtangosol.coherence.clusteraddress=231.1.1.1 com.tangosol.net.DefaultCacheServer %2 %3 %4 %5 %6 %7

:exit