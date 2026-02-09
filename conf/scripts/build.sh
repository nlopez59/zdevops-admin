#!/bin/sh
# required args 
  ciWorkDir=$1
  MyWorkSpace=$2
  MyApp=$3
  BuildMode="$4 $5 $6 $7 " #DBB Build modes:  --impactBuild,  --reset, --fullBuild, '--fullBuild --scanOnly'

# 
  zAppBuild="$ZDEVOPS_HOME/dbb-zappbuild/build.groovy"


# Run the build under the DBB Daemon Java STC  for perform boost
  runDBB="groovyz  -DBB_DAEMON_HOST 127.0.0.1 -DBB_DAEMON_PORT 8180 $zAppBuild  -l UTF-8 --workspace $ciWorkDir/$MyWorkSpace --application $MyApp  -outDir $ciWorkDir/$MyWorkSpace  --hlq $USER.PIPELINE    $BuildMode"


echo "**************************************************************"
echo "**  ./build.sh v5 HOST/USER: $(uname -Ia)/$USER"
echo "**                        ciWorkDir:" $ciWorkDir
echo "**                      MyWorkSpace:" $MyWorkSpace
echo "**                            MyApp:" $MyApp
echo "**    	             DBB Build Mode:" $BuildMode
echo "**               DBB zAppBuild Path:" $zAppBuild
echo "**                         DBB_HOME:" $DBB_HOME
echo "**               DBB Tookit Version: $(head -n 1 $DBB_HOME/bin/version.properties)"
echo "** "

echo "\n** Git Status for $ciWorkDir/$MyWorkSpace:"
git -C $ciWorkDir/$MyWorkSpace status

echo $runDBB 
$runDBB 

if [ "$?" -ne "0" ]; then
  echo [build.sh] DBB Build Error. Check the build log for details
  exit 
fi

##
## Fail if "nothing to build" condition and throw an error to stop pipeline
if [ ! -s $ciWorkDir/$MyWorkSpace/buildList.txt ]; then
   	echo [build.sh] *** Build Error:  No source changes detected. Stopping pipeline.  RC=12
   	exit 12    
fi
exit 0 



