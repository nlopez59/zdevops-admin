# IBM zDevops Quick Start
This repo provides the basic configuration files needed to edit and build a simple cobol program using VS Code with IBM's extensions and zOS host DevOps tool - IBM Dependency Based Build (DBB) and RSEAPI. 


## Prerequisites:
_On zOS_ 
- RACF OMVS User access to RSEAPI, z/UNIX with a Home Dir and an MVS HLQ to allocate PDSs 
- Opened firewall access between your PC and zOS.  This example is preconfigured with RSEAPI and Zowe basic authentication (user/password). 
- `/etc/profile` or a personal `.profile` like this example - does not include all zDevops tools:  
    
    ```
        # ======================================================================
        # JAVA 21
        # ======================================================================
            export JAVA_HOME=/usr/lpp/java/J21.0_64
            export PATH=$JAVA_HOME/bin:$JAVA_HOME/bin/classic:$PATH
            export LIBPATH=/usr/lib/java_runtime:$LIBPATH    
 
        # ======================================================================
        # Standard File Tagging support for Git
        # ======================================================================
        export _BPXK_AUTOCVT=ON
        export _CEE_RUNOPTS="$_CEE_RUNOPTS FILETAG(AUTOCVT,AUTOTAG) POSIX(ON)"
        export _TAG_REDIR_ERR=txt
        export _TAG_REDIR_IN=txt
        export _TAG_REDIR_OUT=txt
        export TERM=xterm

        # ======================================================================
        # DBB 
        # ref: https://www.ibm.com/docs/en/adffz/dbb/3.0.x?topic=customization-environment-variables
        # ======================================================================

        # DBB SMPE Install PATH (Set as Readonly)
            export DBB_HOME=/usr/lpp/IBM/dbb
            export PATH=$PATH:$DBB_HOME/bin
            export LIBPATH=$LIBPATH:$DBB_HOME/lib

        # DBB zBuilder Admin Configuration PATH (Set ReadWrite for zDevOps Admin Team, ReadOnly for others)         
            export DBB_BUILD=<personal_home_dir>/zdevops/conf/build
            export DBB_CONF=$DBB_BUILD

     ```

_On VS Code_:
- Install the Stack
    - latest version of VS Code 
    - (IBM IDZee or ADFz) extension pack from the marketplace   
    - Java Runtime (v21+) - see z Open Editor readme 
    - [Git] 

- Clone this repo and update 
    - [zowe.config.json](zowe.config.json) - with the RSEAPI port and zOS Host name - defaults provided for demo purposes at IBM labs 
    - [.vscode/setting ](.vscode/settings.json) - change the USS Home Dir and HLQ to match your env 
    - Save this repo in your company's git server and name it `zdevops`

- SSH into z/Unix and run the follow (assumes env vars are predefined):
    ``` sh
        mkdir -p zdevops/conf/build 
        cp $DBB_HOME/build/*.yaml/             zdevops/conf/build/ 
        cp $DBB_HOME/samples/languages/*.yaml  zdevops/conf/build/ 
        chtag -R -tc ISO8859-1 zdevops/conf/build/ 
    ```
- From VS code/Zowe explorer,  edit the personal USS file `~/zdevops/conf/build/Languages.yaml`
    - Add your zOS host Cobol compiler DSN `value:` to the  `name: SIGYCOMP` property and uncomment the related lines:

    ``` yaml
        # Cobol Compiler Data Sets. Example: COBOL.V6R1M0.SIGYCOMP
        #- name: SIGYCOMP
        #  value: 
    ```

Your ready to use test a DBB User Build VS provided in this repo's source dir.     


## User Build Basics  
* Edit the sample [source/sample.cbl](source/cobol/sample.cbl) cobol program using the VS Code/IBM Z Open Editor.
* Right click on the source code and select "Run IBM User Build with full load". Subsequent builds can use the "Run IBM User Build" option.
* View the build output logs in this project's `logs` folder.
* if the build was `Clean`, edit the sample test JCL [`source/jcl/sample.jcl`](source/jcl/sample.jcl#L4) and change the steplib to the $dbbHLQ defined in `.settings.json` (see above). Right click to `Submit` the job.  
* A popup, lower right, will help navigate you to the Jobs JES output in Zowe Explorer.


For additional information, contact your IBM zDevOps representative.

---




**Author:** Nelson Lopez, IBM zDevOps zLabConnect (Sept 2026) 