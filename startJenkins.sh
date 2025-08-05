#!/bin/sh
# start the jenkins agent jvm remotely from jcl


 echo jenkinsStart.sh: 
##

. /etc/profile
 cd /tmp/jenkins
 java -jar agent.jar -url http://localhost:8080/ -secret 8780da5416a97de5cc58b9a7d5f060f72a757bbe1ecdda2f1c7e7c215d6c71f3 -name taz-zos  -webSocket  -workDir /tmp/jenkins