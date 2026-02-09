#!/bin/sh
#
## Set vars
    unset _TAG_REDIR_ERR  _TAG_REDIR_OUT    # Some pipelines dont like zOS Encoding when transmitting stdout/stderr - shut it down 

    MyWorkDir=$1
    MyWorkSpace=$2
    MyRepo=$3
    MyBranch=$4                             # can be a branch name or tag ref
#
## Cleanup ref  
    # Strip any 'MyBranchs/heads/...'    
    if [[ $MyBranch = *"refs/heads/"* ]]; then 
        MyBranch=${MyBranch##*"refs/heads/"}    
    fi   

#
## Info 
    echo "**************************************************************"
    echo "**   Started:   clone.sh v5  on HOST/USER: $(uname -Ia)/$USER"
    echo "**                            MyWorkDir:" $MyWorkDir
    echo "**                          MyWorkSpace:" $MyWorkSpace
    echo "**                                 Repo:" $MyRepo    
    echo "**                             MyBranch:" $MyBranch
    echo "**                            Git Version: $(git --version)"
    echo "**"

## clone 
    git config --global  advice.detachedHead false  # suppress warnings in stderr when cloning by tag (may depecated in newer release)
    git clone -b $MyBranch $MyRepo $MyWorkDir/$MyWorkSpace  2>&1