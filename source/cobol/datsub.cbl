       ID DIVISION.                                                     
       PROGRAM-ID. DATSUB.                                              
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
       LINKAGE SECTION.                                                         
       01  SEED_RND           PIC 9(5).                                
       01  RETURN_RND         PIC 9(5).                                
                                                                        
       PROCEDURE DIVISION USING SEED_RND RETURN_RND.                    
           DISPLAY 'DATSUB: Num Gen  v2a'.        
           COMPUTE RETURN_RND = SEED_RND * 5
           EXIT PROGRAM.
                        
       END PROGRAM DATSUB.                             