       ID DIVISION.
      * model adov1 is active on zOS (poc-waas) in my IBM Cloud acct       
      * Bug Fix Hint: Seed value cant be 0
       PROGRAM-ID. DATBATCH.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WK-AREA1.       
          05  seed          PIC 9(5) value is 0.
          05  rnd-num       PIC 9(5) value is 0.
          05  num1          PIC 9(3) value is 0.
        
       COPY DATDEPND.
      *
       PROCEDURE DIVISION.
           DISPLAY 'DATBATCH.CBL: ADOV1 DEMO v6.'  
           DISPLAY 'DATDEPND.CPY: WS-VER    =' WS-VER.            

      * Static routine to randomize a seed value.
      *    CALL "DATSUB" USING  seed, rnd-num.

           PERFORM VARYING num1 FROM 0 BY 1 UNTIL num1 > rnd-num                
                    perform show_num1                
           END-PERFORM.
           STOP RUN.
      * Display a counter 
       show_num1.
           display 'LOOPING: The Value of num1=' num1.
         
