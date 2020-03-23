"      S9200-START-JAPA3        SECTION.                                
"                                                                       
"          MOVE    I-TX-SRVC-TP               TO RCVE-TX-SRVC-TP.       
"          MOVE    I-RCVE-NO-TXOFF            TO H-RCVE-NO-TXOFF.       
"          MOVE    I-RCVE-NO-YY               TO H-RCVE-NO-YY.          
"          MOVE    I-RCVE-NO-SEQNO            TO H-RCVE-NO-SEQNO.       
"                                                                       
"     *u¬¤°»z?                                                       
"          MOVE    I-ISSUE-DT                 TO H-ISSUE-DT.            
"                                                                       
"     *»¦K/?h?                                                       
"          MOVE    I-EXPIRE-DT                TO H-EXPIRE-DT.           
"                                                                       
"     *u¬¤?wih/?»¦                                                   
"          MOVE    I-BUSNID-DISTR-CS          TO H-BUSNID-DISTR-CS.     
"                                                                       
"     *{çþ~ÚÖHa                                                       
           MOVE   'ZZ'                        TO  H-TREAT-STAUS.
           IF  I-TX-SRVC-TP = 'B1001'
               MOVE   '13'                    TO  H-TREAT-STAUS
           END-IF.
           MOVE   TS-DATA                     TO  H-ERR-DOCU.
           MOVE   SPACE                       TO  H-ERR-TP.
"                                                                       
020711     MOVE 'JAA3'            TO   W-START-TRN.                     
PYM        EXEC CICS START    TRANSID (W-START-TRN)                     
"                             INTERVAL(0)                               
"                             FROM    (HTS-AREA)                        
"                             LENGTH  (LENGTH OF HTS-AREA)              
"                             RESP    (W-RETURN-CODE)                   
020711     END-EXEC.                                          
