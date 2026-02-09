//IBMUSERA JOB CLASS=A,MSGCLASS=H,MSGLEVEL=(1,1)
//*
//* Sample jcl to unit test POC build pf datbach cobol pgm  
//* Change the Jobcard and steplib to match your wazi-deploy Env HLQ 
//POC     EXEC PGM=DATBATCH
//STEPLIB  DD  DISP=SHR,DSN=IBMUSER.VSCODE6.LOAD
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//**********************************************************
