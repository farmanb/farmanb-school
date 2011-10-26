@echo off
@setlocal

if (%COHERENCE_HOME%) == () (
  set COHERENCE_HOME=C:\Oracle\Middleware\coherence
)

@rem set PROJ=C:\JDeveloper\mywork\Coherence
set PROJ=..\
set CONFIG=%PROJ%\UpdateOrder\Coherence.Schemas

"%JAVA_HOME%\bin\java" -cp %CONFIG%;%COHERENCE_HOME%\lib\coherence.jar;%PROJ%;%PROJ%\UpdateOrder\classes com.tangosol.net.DefaultCacheServer

:exit