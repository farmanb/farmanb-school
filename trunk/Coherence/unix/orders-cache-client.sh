#!/bin/sh

if [${COHERENCE_HOME} == ""]; then
    COHERENCE_HOME=~/Oracle/Middleware/coherence
fi

PROJ=~/JDeveloper/mywork/Coherence
CONFIG=${PROJ}/UpdateOrder/Coherence.Schemas

${JAVA_HOME}/bin/java -cp ${CONFIG}:${COHERENCE_HOME}/lib/coherence.jar:${PROJ}:${PROJ}/UpdateOrder/classes -Dtangosol.coherence.distributed.localstorage=false com.tangosol.net.CacheFactory
