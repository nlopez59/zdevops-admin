# This is a sample zOS USS .profile for a DevOps POC (IBM)  model v4
#    - Review and update based on the smp/e install paths for your ENv

# Path of the devops admin repo cloned in USS.  Change the path to match your path.   
   export ZDEVOPS_HOME=/u/ibmuser/zdevops-admin               

# DBB  v3+  (IDzEE v17)
    # Chg the DBB_HOME to you install path 
    export DBB_HOME=/usr/lpp/IBM/idz/usr/lpp/IBM/dbb

    # all customized config files are part of the admin repo 
    export DBB_CONF=$ZDEVOPS_HOME/conf/build
    export DBB_BUILD=$ZDEVOPS_HOME/conf/build

    export PATH=$DBB_HOME/bin:$PATH
    export LIBPATH=$LIBPATH:$DBB_HOME/lib
    
    # add db2 classes for DBB metadata schema - Review the path on your env 
      ## export CLASSPATH=/usr/lpp/db2d10/jdbc/classes/db2jcc4.jar:$CLASSPATH
      ## export CLASSPATH=/usr/lpp/db2d10/jdbc/classes/db2jcc_license_cisuz.jar:$CLASSPATH
   
#Java 11- Or latest 
   export JAVA_HOME=/usr/lpp/java/java11/current_64
   export PATH=$JAVA_HOME/bin:$PATH

# Wazi-deploy  v3+
    #ZOAU
    export ZOAU_HOME=/usr/lpp/IBM/zoautil
    export PATH=$ZOAU_HOME/bin:$PATH
    export LIBPATH=$ZOAU_HOME/lib:$LIBPATH

    #Python Packages 
    export PATH=/usr/lpp/IBM/cyp/v3r11/pyz/bin:$PATH
    export LIBPATH=/usr/lpp/IBM/cyp/v3r11/pyz/lib:$LIBPATH

 
# Chg to the Git client.  Rocket Git Or IBM's Git see smpe install 
    ## export PATH=$PATH:/rsusr/ported/bin
    ## export LIBPATH=$LIBPATH:/rsusr/ported/lib
    ## export LIBPATH=$LIBPATH:/rsusr/ported/lib/perl5/5.24.0/s390/CORE

#Common Vars:
    # common encoding
    export _BPXK_AUTOCVT=ON
    export _CEE_RUNOPTS='FILETAG(AUTOCVT,AUTOTAG) POSIX(ON)'
    export _TAG_REDIR_ERR=txt
    export _TAG_REDIR_IN=txt
    export _TAG_REDIR_OUT=txt
    export PATH=.:/usr/bin:/bin:/usr/sbin:$PATH  