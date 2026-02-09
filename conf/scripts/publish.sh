#!/bin/sh

# mod njl 11/24 - partial support pf Artifactory. Tested with CodeStation
# UCD Server ver  7.2.1.2.1127228 (MyUCD server)
# buztool Ref: https://www.ibm.com/docs/en/devops-deploy/7.2.1?topic=czcv-creating-zos-component-versions-from-zos-unix-system-services
# tbd Jfrog repo:  https://eu.artifactory.swg-devops.com/ui/repos/tree/General/sys-dat-team-generic-local/Azure/poc-workspace???

ucd_version=$1
ucd_Component_Name=$2
MyWorkDir=$3
ArtifactoryMode=$4

buzTool=/u/ibmuser/ibm-ucd/agent/bin/buztool.sh
pub=$zScripts/utils/dbb-ucd-packaging.groovy  

artProp=""   # default is codestation 
if [ -z "$ArtifactoryMode" ]; then 
    artStore="UCD CodeStation"     
    artProp=" --ucdV2PackageFormat"    
else
    artStore="jFroj_v2Pack" 
    artProp=" -prop $MyWorkDir/artifactoryProps  -ppf $MyWorkDir/artifactoryMapping --ucdV2PackageFormat"    
fi

echo "**************************************************************"
echo "**  Started:  publish.sh (V4a) Pack&Pub on HOST/USER: $(uname -Ia) $USER"
echo "**                           Version/Build_ID:" $ucd_version
echo "**                                 Component:" $ucd_Component_Name 
echo "**                                   workDir:" $MyWorkDir   
echo "**                              BuzTool Path:" $buzTool 
echo "**                          Packaging Script:" $pub 
echo "**                            Artifact Store:" $artStore                   

cli="sh groovyz $pub  --buztool $buzTool --workDir $MyWorkDir  --component $ucd_Component_Name --versionName $ucd_version $artProp"
echo "[publish.sh] Running groovy cli:"
echo " " $cli

groovyz $pub  --buztool $buzTool --workDir $MyWorkDir  --component $ucd_Component_Name --versionName $ucd_version $artProp
exit $?
