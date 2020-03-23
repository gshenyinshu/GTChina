      ******************************************************************
      *                                                                *
      *         I D E N T I F I C A T I O N   D I V I S I O N          *
      *                                                                *
      ******************************************************************

       IDENTIFICATION     DIVISION.

       PROGRAM-ID.        MIP02.
       AUTHOR.            ITPlus.
       INSTALLATION.      ITPlus.
       DATE-WRITTEN.      2003.08.21.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *                    M   I   P   0   2                           *
      *                                                                *
      *  PROGRAM TYPE   -  ONLINE COBOL                                *
      *                                                                *
      *  FUNCTION       -  DBt~?a?s?vi~Úç  {çþ~                      *
      *                                                                *
      *  TRANSACTION    -  MI02                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; MIP02                       *
      *                                                                *
      *  INPUT PARMS    -  COMMUNICATION AREA     -   4000 BYTE        *
      *                                                                *
      *  OUTPUT PARMS   -  NONE                                        *
      *                                                                *
      *  TABLES         -                                              *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  I/O FILES      -  NONE                                        *
      *                                                                *
      *  SWITCHES       -  S-CICS-RETURN                               *
      *                    LOW-VALUES    PSEUDO RETURN                 *
      *                    HIGH-VALUES   CICS RETURN                   *
      *                                                                *
      *  EXITS          -  NORMAL   - RETURN TO CICS                   *
      *                                                                *
      *                 -  ABNORMAL - NONE                             *
      *                                                                *
      *  SPECIAL LOGIC  -  NONE                                        *
      *                                                                *
      *  MODIFICATIONS  -                                              *
      *                                                                *
      *  DATE        S.E           DESCRIPTION                         *
      *  ==========  ============  ==================================  *
      *  2003/08/21  ITPlus        INITIAL WRITTEN                     *
      ******************************************************************

       EJECT

      ******************************************************************
      *                                                                *
      *            E N V I R O N M E N T   D I V I S I O N             *
      *                                                                *
      ******************************************************************

       ENVIRONMENT DIVISION.

      ******************************************************************
      *                                                                *
      *                   D A T A   D I V I S I O N                    *
      *                                                                *
      ******************************************************************

       DATA DIVISION.

      ******************************************************************
      *                                                                *
      *                 W O R K I N G   S T O R A G E                  *
      *                                                                *
      ******************************************************************

       WORKING-STORAGE                 SECTION.

       01  WS-START                    PIC X(40)
           VALUE 'MIP02 - WORKING STORAGE BEGINS HERE'.

      ******************************************************************
      *                                                                *
      *                    A C C U M U L A T O R S                     *
      *                                                                *
      ******************************************************************

       01  ACCUMULATORS.

           05  A-ERROR-COUNT           PIC S9(04) COMP SYNC VALUE +0.
               88  A-ERROR-COUNT-ZERO             VALUE +0.
               88  A-ERROR-COUNT-ONE              VALUE +1.

           05  A-SPACE-COUNT           PIC S9(04) COMP SYNC VALUE +0.
               88  A-SPACE-COUNT-ZERO             VALUE +0.
               88  A-SPACE-COUNT-ONE              VALUE +1.

      ******************************************************************
      *                                                                *
      *                       C O N S T A N T S                        *
      *                                                                *
      ******************************************************************

       01  CONSTANTS.

           05  C-RIV010-LEN           PIC S9(04) VALUE  +352 COMP.      
           05  C-RGV010-LEN           PIC S9(04) VALUE  +122 COMP.      

           05  C-PGM-MIP02            PIC  X(08) VALUE 'MIP02'.
           05  C-PGM-MI02             PIC  X(08) VALUE 'MI02'.
           05  C-PGM-SSSHE            PIC  X(08) VALUE 'SSSHE'.
           05  C-COMM-LNTH            PIC S9(04) COMP SYNC VALUE +4000.

      *                                *********************************
      *                                *      USER  MESSAGE  CODES
      *                                *********************************

           05  C-MSG-AS00008           PIC  X(07) VALUE 'AS00008'.
           05  C-MSG-BR00021           PIC  X(07) VALUE 'BR00021'.
           05  C-MSG-DB10302           PIC  X(07) VALUE 'DB10302'.

      *                                ***********         ************
      *                                *       COMMON  CONSTANT       *
      *                                ***********         ************

           COPY SSYBC.

      *                                ***********         ************
      *                                *       SQL RETURN CODE        *
      *                                ***********         ************

           COPY SSYBI.

      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************

       01  SWITCHES.

           05  S-CICS-RETURN           PIC  X(01) VALUE LOW-VALUES.
               88 S-CICS-RETURN-ON                VALUE HIGH-VALUES.

           05  S-ERROR                 PIC  X(01) VALUE LOW-VALUES.
               88 S-ERROR-ON                      VALUE HIGH-VALUES.

           05  S-PROCESS               PIC  X(01) VALUE LOW-VALUES.
               88 S-DO-NOT-PROCESS                VALUE HIGH-VALUES.

           05  S-FETCH                 PIC  X(01) VALUE LOW-VALUES.
               88 S-DO-NOT-FETCH                  VALUE HIGH-VALUES.

           05  S-START                 PIC  X(01) VALUE LOW-VALUES.
               88 S-START-ON                      VALUE HIGH-VALUES.

      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************
       01  WORKAREAS.

      *                                *************       ************
      *                                *   INDEX/INDICATE  WORK AREA  *
      *                                *************       ************

           05  W-RC                    PIC ---9.

           05  W-NUM-4-ED              PIC ZZZ9.

           05  W-RESID-BUSNID          PIC  X(13)  VALUE SPACE.
           05  W-TXTP-CD               PIC  X(02)  VALUE SPACE.
           05  W-ASS-YYMM-FR           PIC  X(06)  VALUE SPACE.
           05  W-RTN-TP                PIC  X(01)  VALUE SPACE.
           05  W-RTN-SERIAL-NO         PIC S9(04)  VALUE ZERO COMP.
           05  W-SERIAL-NO             PIC S9(04)  VALUE ZERO COMP.

           05  W-NOTFND-RTN-DT         PIC  X(01).
           05  W-NOTFND-LAST-FG        PIC  X(01).

           05  W-LAST-FG               PIC  X(01) VALUE SPACE.
           05  W-RTN-METHOD            PIC  X(01) VALUE SPACE.
           05  W-RTN-DT                PIC  X(06).

           05  W-DB-NO-CNT.
               10  W-ENTRY-DUP-CNT      PIC S9(09) COMP-3 VALUE ZERO.
               10  W-ELEC-DUP-CNT       PIC S9(09) COMP-3 VALUE ZERO.
               10  W-MEDIA-DUP-CNT      PIC S9(09) COMP-3 VALUE ZERO.
               10  W-SUBMT-DUP-CNT      PIC S9(09) COMP-3 VALUE ZERO.
               10  W-ENTRY-NORM-CNT     PIC S9(09) COMP-3 VALUE ZERO.
               10  W-ELEC-NORM-CNT      PIC S9(09) COMP-3 VALUE ZERO.
               10  W-MEDIA-NORM-CNT     PIC S9(09) COMP-3 VALUE ZERO.
               10  W-SUBMT-NORM-CNT     PIC S9(09) COMP-3 VALUE ZERO.
               10  W-ENTRY-ERR-CNT      PIC S9(09) COMP-3 VALUE ZERO.
               10  W-ELEC-ERR-CNT       PIC S9(09) COMP-3 VALUE ZERO.
               10  W-MEDIA-ERR-CNT      PIC S9(09) COMP-3 VALUE ZERO.
               10  W-SUBMT-ERR-CNT      PIC S9(09) COMP-3 VALUE ZERO.

      *****************************************************************
      *                                                               *
      *                 M O D U L E         A R E A                   *
      *                                                               *
      *****************************************************************
      *                                ********************************
      *                                *    wi?E?V  }Ý¤?            *
      *                                ********************************

           COPY                        SSYHE.

      *                                *************       ************ 
      *                                *      COMMON WORKING AREA     * 
      *                                *************       ************ 
           COPY                        SSYBG.                           
                                                                        
                                                                        
      *                                ***********         ************
      *                                *  HANDLE CONDITION CONSTANTS 1*
      *                                ***********         ************

           COPY                        SSYBE.

      *****************************************************************
      *
      *                 V S A M    I O    A R E A
      *
      *****************************************************************

      *                                ***********         ************
      *                                *        MSG VSAM LAYOUT
      *                                ***********         ************
           COPY                        SUY01.

      *                                *************       ************ 
      *                                *     DBt~?a?s?vi~Úç  JA?z   * 
      *                                *************       ************ 
           COPY                        RGYI1.                           
                                                                        
      *                                *************       ************ 
      *                                *      ??[¦¼/  v?i?  JA?z    * 
      *                                *************       ************ 
           COPY                        RGYI2.                           
                                                                        
      *                                ***********         ************
      *                                *  PROGRAM SELF COMM AREA      *
      *                                ***********         ************

450    COPY QMY00.

80     COPY MYY00.

        05 W-COMM-PGM-RR  REDEFINES W-RETURN-PRIVATE.                   

           10  W-CM-RESID-BUSNID           PIC  X(13).
           10  W-CM-TXPAYER-TP             PIC  X(01).
           10  W-CM-RTN-TP                 PIC  X(01).
           10  W-CM-ASS-YYMM-FR            PIC  X(06).

           10  W-CM-RESID-BUSNID-O         PIC  X(13).
           10  W-CM-TXPAYER-TP-O           PIC  X(01).
           10  W-CM-RTN-TP-O               PIC  X(01).
           10  W-CM-ASS-YYMM-FR-O          PIC  X(06).

           10  W-CM-GB                     PIC  X(01).

      ******************************************************************
      *                                                                *
      *                    D B 2   W O R K   A R E A                   *
      *                                                                *
      ******************************************************************
                                                                        
      *                                ***********         ************ 
      *                                *    SQL COMMUNICATION AREA    * 
      *                                ***********         ************ 
           EXEC SQL  INCLUDE  SQLCA                                     
           END-EXEC.                                                    
                                                                        
      *                                ***********         ************ 
      *                                *    DCL FOR DRIA.TRIAA        * 
      *                                ***********         ************ 
           EXEC SQL  INCLUDE RIOAA                                      
           END-EXEC.                                                    
                                                                        
      *                                ***********         ************ 
      *                                *    DCL FOR DTIA.TTIAA        * 
      *                                ***********         ************ 
           EXEC SQL  INCLUDE TIOAA                                      
           END-EXEC.                                                    
                                                                        
      *                                ***********         ************ 
      *                                *    DCL FOR DTAA.TTAAA        * 
      *                                ***********         ************ 
           EXEC SQL  INCLUDE TAOAA                                      
           END-EXEC.                                                    
                                                                        
030922*                                ***********         ************
      *   t~?a?sÙ·ia                 *    DCL FOR DRWB.TRWBO        *
      *                                ***********         ************
           EXEC SQL  INCLUDE RWOBO
           END-EXEC.

      *****************************************************************
      *                                                               *
      *           E N D   O F  W O R K I N G  S T O R A G E           *
      *                                                               *
      *****************************************************************

       01  WS-END                      PIC X(40)
           VALUE 'MIP02 - WORKING STORAGE ENDS HERE'.
       EJECT

      ******************************************************************
      *                                                                *
      *                 L I N K A G E   S E C T I O N                  *
      *                                                                *
      ******************************************************************

       LINKAGE                         SECTION.

       01  DFHCOMMAREA.

      *                                *********************************
      *                                *    PROGRAM SELF COMM AREA     *
      *                                *********************************

           05  L-COMM-AREA             PIC  X(4000).

      ******************************************************************
      *                                                                *
      *              P R O C E D U R E   D I V I S I O N               *
      *                                                                *
      ******************************************************************

       PROCEDURE DIVISION.

      ******************************************************************
      *                                                                *
      *                  I N I T I A L I Z A T I O N                   *
      *                                                                *
      *    -?v?/?vJA~Ý¹¦Ú?p¬¸ç¹vDATA??  u?l?m/                 *
      *                                                                *
      ******************************************************************

       INITIALIZATION                  SECTION.

           MOVE DFHCOMMAREA            TO W-COMM-AREA.

      ******************************************************************
      *                                                                *
      *                  M  A  I  N  L  I  N  E                        *
      *                                                                *
      ******************************************************************

       MAINLINE                        SECTION.

           PERFORM S0100-MAIN-PROCESS.

       EJECT
      ******************************************************************
      *                                                                *
      *                    F I N A L I Z A T I O N                     *
      *                                                                *
      *        - CICS RETURN                                           *
      *                                                                *
      ******************************************************************

       FINALIZATION                    SECTION.

      * MESSAGE{çþ~
           IF  W-COMM-MSG   =  SPACE

               PERFORM S9000-READ-SUV010

           END-IF.

      * ERROR  CHECK
           IF  NOT A-ERROR-COUNT-ZERO AND
               W-COMM-RC  =  SPACES   OR  LOW-VALUE

               MOVE 'RC01'             TO W-COMM-RC

           END-IF.

      * COMMAREA MOVE
           MOVE W-COMM-AREA            TO DFHCOMMAREA.

           PERFORM S9900-RETURN.

       EJECT
      ******************************************************************
      *                     S U B R O U T I N E S                      *
      ******************************************************************
      ******************************************************************
      *                                                                *
      *               S 0 1 0 0 - M A I N - P R O C E S S              *
      *                                                                *
      ******************************************************************

       S0100-MAIN-PROCESS SECTION.

           EVALUATE  W-CM-GB
      *?7?7
               WHEN  'U'
                     PERFORM  S0200-UPDATE-PROCESS

      *Úß½¦
               WHEN  'D'
                     PERFORM  S0300-DELETE-PROCESS

      * ERROR
               WHEN  OTHER
                     ADD  1               TO A-ERROR-COUNT
                     MOVE 'PROCESS-ERR'   TO W-COMM-MSG

           END-EVALUATE.

           MOVE  'Y'               TO W-COMM-END-FG.

       S0100-MAIN-PROCESS-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *               S 0 2 0 0 - U P D A T E - P R O C E S S          *
      *                                                                *
      ******************************************************************

       S0200-UPDATE-PROCESS   SECTION.

           INITIALIZE        RIV010-REC.                                
                                                                        
           PERFORM S2800-RIV010-VSAM-READ.                              
                                                                        
           PERFORM S3100-RIV010-VSAM-WRITE.                             
                                                                        
           IF  A-ERROR-COUNT-ZERO

               IF  W-RETURN-NORMAL                                      
                                                                        
                   PERFORM S3000-RIV010-VSAM-DELETE                     
                                                                        
                   IF  A-ERROR-COUNT-ZERO
                       PERFORM S2400-RGV010-CHANGE                      
                   END-IF
                                                                        
                   IF  A-ERROR-COUNT-ZERO
                       MOVE C-MSG-BR00021        TO W-MSG-ID            
                   END-IF
                                                                        
               ELSE                                                     
                                                                        
                   ADD  C-ONE                    TO A-ERROR-COUNT
                   MOVE C-MSG-AS00008            TO W-MSG-ID            
                   MOVE 'RC01'                   TO W-COMM-RC
      *           ?~p?s?/?/»·l~m/?.                                  
                                                                        
               END-IF                                                   

           END-IF.                                                      
                                                                        
       S0200-UPDATE-PROCESS-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *             S 0 3 0 0 - D E L E T E - P R O C E S S            *
      *                                                                *
      ******************************************************************
                                                                        
       S0300-DELETE-PROCESS  SECTION.                                   
                                                                        
           INITIALIZE        RIV010-REC                                 
                             RGV010-REC                                 
                                                                        
030922     PERFORM S0500-RTNDT-FG-CHECK.                                
                                                                        
           PERFORM S3000-RIV010-VSAM-DELETE.                            
                                                                        
           IF  A-ERROR-COUNT-ZERO
               PERFORM S2500-RGV010-DELETE                              

030922         IF  W-NOTFND-LAST-FG  NOT =  '1'     AND
  .                W-NOTFND-RTN-DT   NOT =  '1'
  .
  .                PERFORM S4200-SELECT-TRWBO
  .
030922         END-IF

           END-IF.
                                                                        
           IF  A-ERROR-COUNT-ZERO
               MOVE C-MSG-DB10302          TO W-MSG-ID                  
      *       Úß½¦h/  ¼¬o¦¸6ù°l~m/?.                                  
           END-IF.
                                                                        
       S0300-DELETE-PROCESS-EXIT.                                       
           EXIT.                                                        
           EJECT                                                        
                                                                        
030922******************************************************************
      *                                                                *
      *            S 0 5 0 0 - R T N D T - F G - C H E C K             *
      *                                                                *
      ******************************************************************

       S0500-RTNDT-FG-CHECK         SECTION.

           INITIALIZE        RIV010-REC.

           PERFORM S2800-RIV010-VSAM-READ.

           MOVE RIV010-RTN-DT(1:6)    TO W-RTN-DT.
           MOVE RIV010-RTN-METHOD     TO W-RTN-METHOD.
           MOVE RIV010-LAST-FG        TO W-LAST-FG.

           IF  RIV010-LAST-FG  =  '1'
               MOVE SPACES        TO W-NOTFND-LAST-FG
           ELSE
               IF  RIV010-LAST-FG  =  '2'
                   MOVE SPACES        TO W-NOTFND-LAST-FG
               ELSE
                   MOVE '1'           TO W-NOTFND-LAST-FG
               END-IF
           END-IF.

           IF  W-RTN-DT   =  SPACES   OR  LOW-VALUES
               MOVE  '1'          TO W-NOTFND-RTN-DT
           ELSE
               MOVE  SPACES       TO W-NOTFND-RTN-DT
           END-IF.

       S0500-RTNDT-FG-CHECK-EXIT.
           EXIT.
           EJECT
      ***************************************************************** 
      *     D   B  / V S A M       P  R  O  C  E  S  S                * 
      ***************************************************************** 
      ******************************************************************
      *                                                                *
      *            S 2 4 0 0 - R G V 0 1 0 - C H A N G E               *
      *                                                                *
      ******************************************************************
                                                                        
       S2400-RGV010-CHANGE    SECTION.                                  
                                                                        
           PERFORM  S5000-GET-SYSTEM-DATA.

           INITIALIZE    RGV010-REC.                                    
                                                                        
           MOVE  W-CM-ASS-YYMM-FR-O    TO RGV010-BEF-ASS-YYMM-FR.       
           MOVE  W-COMM-TXTP-CD        TO RGV010-BEF-TXTP-CD.           
           MOVE  W-CM-RESID-BUSNID-O   TO RGV010-BEF-RESID-BUSNID.      
           MOVE  W-CM-RTN-TP-O         TO RGV010-BEF-RTN-TP.            
           MOVE  W-COMM-RTN-SERIAL-NO  TO RGV010-BEF-RTN-SERIAL-NO.     
           MOVE  W-COMM-SERIAL-NO      TO RGV010-BEF-SERIAL-NO.         
           MOVE  W-CM-TXPAYER-TP-O     TO RGV010-BEF-TXPAYER-TP.        
                                                                        
           MOVE  W-CM-RESID-BUSNID-O   TO RGV010-BEF-TXPAYER-ID         
                                                                        
           PERFORM S2900-RGV010-VSAM-READ.                              
                                                                        
           MOVE  W-CM-ASS-YYMM-FR   TO RGV010-AFT-ASS-YYMM-FR           
           MOVE  W-COMM-TXTP-CD     TO RGV010-AFT-TXTP-CD               
           MOVE  W-CM-RESID-BUSNID  TO RGV010-AFT-RESID-BUSNID          
           MOVE  W-CM-RTN-TP        TO RGV010-AFT-RTN-TP                
           MOVE  W-COMM-RTN-SERIAL-NO  TO RGV010-AFT-RTN-SERIAL-NO      
           MOVE  W-COMM-SERIAL-NO   TO RGV010-AFT-SERIAL-NO             
           MOVE  W-CM-TXPAYER-TP    TO RGV010-AFT-TXPAYER-TP            
           MOVE  W-CM-RESID-BUSNID  TO RGV010-AFT-TXPAYER-ID            
                                                                        
           MOVE  'C'                TO RGV010-PROCESS-TP                
                                                                        
           MOVE  W-DB2DATE(1:4)     TO RGV010-PROCESS-DT(1:4)           
           MOVE  W-DB2DATE(6:2)     TO RGV010-PROCESS-DT(5:2)           
           MOVE  W-DB2DATE(9:2)     TO RGV010-PROCESS-DT(7:2)           
                                                                        
           MOVE  W-COMM-TXOFF-CD    TO RGV010-TXOFF-CD                  
           MOVE  W-COMM-OFFCRCD-RTN TO RGV010-TX-OFFCR-CD               
           MOVE  C-CHAR-ONE         TO RGV010-PROCESS-RSN               
                                                                        
           IF  A-ERROR-COUNT-ZERO
               IF  W-RETURN-NORMAL                                      
                                                                        
                   PERFORM S3300-RGV010-VSAM-REWRITE                    
                                                                        
               ELSE                                                     
                                                                        
                   PERFORM S3200-RGV010-VSAM-WRITE                      
                                                                        
               END-IF                                                   
           END-IF.                                                      
                                                                        
       S2400-RGV010-CHANGE-EXIT.                                        
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 2 5 0 0 - R G V 0 1 0 - D E L E T E               *
      *                                                                *
      ******************************************************************
                                                                        
       S2500-RGV010-DELETE    SECTION.                                  
                                                                        
           INITIALIZE    RGV010-REC.                                    
                                                                        
           MOVE  W-CM-ASS-YYMM-FR-O    TO RGV010-BEF-ASS-YYMM-FR.       
           MOVE  W-COMM-TXTP-CD        TO RGV010-BEF-TXTP-CD.           
           MOVE  W-CM-RESID-BUSNID-O   TO RGV010-BEF-RESID-BUSNID.      
           MOVE  W-CM-RTN-TP-O         TO RGV010-BEF-RTN-TP.            
           MOVE  W-COMM-RTN-SERIAL-NO  TO RGV010-BEF-RTN-SERIAL-NO.     
           MOVE  W-COMM-SERIAL-NO      TO RGV010-BEF-SERIAL-NO.         
           MOVE  W-CM-TXPAYER-TP-O     TO RGV010-BEF-TXPAYER-TP.        
                                                                        
           MOVE  W-CM-RESID-BUSNID-O   TO RGV010-BEF-TXPAYER-ID         
                                                                        
           PERFORM S2900-RGV010-VSAM-READ.                              
                                                                        
           IF  A-ERROR-COUNT-ZERO
               IF  W-RETURN-NORMAL                                      
                                                                        
                   PERFORM S3350-RGV010-VSAM-DELETE                     
                                                                        
               END-IF                                                   
           END-IF.
                                                                        
       S2500-RGV010-DELETE-EXIT.                                        
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 2 6 0 0 - R I V 0 1 0 - K E Y - S E T             *
      *                                                                *
      ******************************************************************
                                                                        
       S2600-RIV010-KEY-SET   SECTION.                                  
                                                                        
           MOVE  W-COMM-TXOFF-CD        TO RIV010-TXOFF-CD-KEY.         
           MOVE  W-COMM-OFFCRCD-RTN     TO RIV010-TX-OFFCR-CD-KEY.      
           MOVE  W-CM-ASS-YYMM-FR-O     TO RIV010-ASS-YYMM-FR.          
           MOVE  W-COMM-TXTP-CD         TO RIV010-TXTP-CD.              
           MOVE  W-CM-RESID-BUSNID-O    TO RIV010-RESID-BUSNID.         
           MOVE  W-CM-RTN-TP-O          TO RIV010-RTN-TP.               
           MOVE  W-COMM-RTN-SERIAL-NO   TO RIV010-RTN-SERIAL-NO.        
           MOVE  W-COMM-SERIAL-NO       TO RIV010-SERIAL-NO.            
           MOVE  W-CM-TXPAYER-TP-O      TO RIV010-TXPAYER-TP.           
                                                                        
       S2600-RIV010-KEY-SET-EXIT.                                       
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *           S 2 7 0 0 - R I V 0 1 0 - K E Y - C H A N G E        *
      *                                                                *
      ******************************************************************
                                                                        
       S2700-RIV010-KEY-CHANGE SECTION.                                 
                                                                        
           MOVE  W-COMM-TXOFF-CD        TO RIV010-TXOFF-CD-KEY.         
           MOVE  W-COMM-OFFCRCD-RTN     TO RIV010-TX-OFFCR-CD-KEY.      
           MOVE  W-CM-ASS-YYMM-FR       TO RIV010-ASS-YYMM-FR.          
           MOVE  W-COMM-TXTP-CD         TO RIV010-TXTP-CD.              
           MOVE  W-CM-RESID-BUSNID      TO RIV010-RESID-BUSNID.         
           MOVE  W-CM-RTN-TP            TO RIV010-RTN-TP.               
           MOVE  W-COMM-RTN-SERIAL-NO   TO RIV010-RTN-SERIAL-NO.        
           MOVE  W-COMM-SERIAL-NO       TO RIV010-SERIAL-NO.            
           MOVE  W-CM-TXPAYER-TP        TO RIV010-TXPAYER-TP.           
                                                                        
           IF  RIV010-RESID-BUSNID(11:3) NOT = SPACE   OR               
               RIV010-RESID-BUSNID(1:1) IS ALPHABETIC  OR               
               RIV010-TXTP-CD  =  '10'                 OR               
               RIV010-TXTP-CD  =  '21'                 OR               
               RIV010-TXTP-CD  =  '23'                                  

               MOVE  RIV010-RESID-BUSNID    TO RIV010-TXPAYER-ID        

           ELSE                                                         

               MOVE  RIV010-RESID-BUSNID    TO BUSNID  OF TTAAA         
               PERFORM  S4000-TTAAA-SELECT

               IF  SQLCODE          =  C-SQL-NOTFND

                   MOVE  RIV010-RESID-BUSNID   TO RESID      OF TTIAA   
                   MOVE  RIV010-TXPAYER-TP     TO TXPAYER-TP OF TTIAA   
                   PERFORM  S4100-TTIAA-SELECT

                   IF  SQLCODE      =  C-SQL-NORMAL
                       MOVE  RIV010-RESID-BUSNID  TO RIV010-TXPAYER-ID  
                   END-IF

               END-IF

           END-IF.                                                      
                                                                        
       S2700-RIV010-KEY-CHANGE-EXIT.                                    
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 2 8 0 0 - R I V 0 1 0 - R E A D                   *
      *                                                                *
      ******************************************************************
                                                                        
       S2800-RIV010-VSAM-READ   SECTION.                                
                                                                        
           PERFORM S2600-RIV010-KEY-SET.                                
                                                                        
           EXEC CICS READ     FILE      ('RIV010')                      
                              INTO      (RIV010-REC)                    
                              LENGTH    (C-RIV010-LEN)                  
                              RIDFLD    (RIV010-KEY)                    
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD  C-ONE                    TO A-ERROR-COUNT
               MOVE W-RETURN-CODE            TO W-RC
               MOVE W-RC                     TO W-COMM-SQL
               MOVE 'ABEND-RIV01-READ'       TO W-COMM-MSG              
           END-IF.                                                      
                                                                        
       S2800-RIV010-VSAM-READ-EXIT.                                     
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 2 9 0 0 - R G V 0 1 0 - V S A M - R E A D       *
      *                                                                *
      ******************************************************************
                                                                        
       S2900-RGV010-VSAM-READ   SECTION.                                
                                                                        
           EXEC CICS READ     FILE      ('RGV010')                      
                              INTO      (RGV010-REC)                    
                              LENGTH    (C-RGV010-LEN)                  
                              RIDFLD    (RGV010-KEY)                    
                              UPDATE                                    
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL OR W-RETURN-NOTFND                       
               CONTINUE                                                 
           ELSE                                                         
               ADD  C-ONE                    TO A-ERROR-COUNT
               MOVE W-RETURN-CODE            TO W-RC
               MOVE W-RC                     TO W-COMM-SQL
               MOVE 'ABEND-RGV010-READ'      TO W-COMM-MSG              
           END-IF.                                                      
                                                                        
       S2900-RGV010-VSAM-READ-EXIT.                                     
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 3 0 0 0 - R I V 0 1 0 - D E L E T E               *
      *                                                                *
      ******************************************************************
                                                                        
       S3000-RIV010-VSAM-DELETE     SECTION.                            
                                                                        
           PERFORM S2600-RIV010-KEY-SET.                                
                                                                        
           EXEC CICS DELETE   FILE      ('RIV010')                      
                              RIDFLD    (RIV010-KEY)                    
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD  C-ONE                    TO A-ERROR-COUNT
               MOVE W-RETURN-CODE            TO W-RC
               MOVE W-RC                     TO W-COMM-SQL
               MOVE 'ABEND-RIV010-DELETE'    TO W-COMM-MSG              
           END-IF.                                                      
                                                                        
       S3000-RIV010-VSAM-DELETE-EXIT.                                   
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 3 1 0 0 - R I V 0 1 0 - W R I T E                 *
      *                                                                *
      ******************************************************************
                                                                        
       S3100-RIV010-VSAM-WRITE          SECTION.                        
                                                                        
           PERFORM S2700-RIV010-KEY-CHANGE.                             
                                                                        
           EXEC CICS WRITE    FILE      ('RIV010')                      
                              FROM      (RIV010-REC)                    
                              LENGTH    (C-RIV010-LEN)                  
                              RIDFLD    (RIV010-KEY)                    
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
               CONTINUE                                                 
           ELSE                                                         
               IF   W-RETURN-CODE  =  14  OR  15                        
                    ADD  C-ONE                    TO A-ERROR-COUNT
                    MOVE C-MSG-AS00008            TO W-MSG-ID
                    MOVE 'RC01'                   TO W-COMM-RC
               ELSE                                                     
                    ADD  C-ONE                    TO A-ERROR-COUNT
                    MOVE W-RETURN-CODE            TO W-RC
                    MOVE W-RC                     TO W-COMM-SQL
                    MOVE 'ABEND-RIV01-WRITE'      TO W-COMM-MSG
               END-IF                                                   
           END-IF.                                                      
                                                                        
       S3100-RIV010-VSAM-WRITE-EXIT.                                    
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 3 2 0 0 - R G V 0 1 0 - W R I T E                 *
      *                                                                *
      ******************************************************************
                                                                        
       S3200-RGV010-VSAM-WRITE          SECTION.                        
                                                                        
           EXEC CICS WRITE    FILE      ('RGV010')                      
                              FROM      (RGV010-REC)                    
                              LENGTH    (C-RGV010-LEN)                  
                              RIDFLD    (RGV010-KEY)                    
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD  C-ONE                    TO A-ERROR-COUNT
               MOVE W-RETURN-CODE            TO W-RC
               MOVE W-RC                     TO W-COMM-SQL
               MOVE 'ABEND-RGV010-WRITE  '   TO W-COMM-MSG              
           END-IF.                                                      
                                                                        
       S3200-RGV010-VSAM-WRITE-EXIT.                                    
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *           S 3 3 0 0 - R G V 0 1 0 - R E W R I T E              *
      *                                                                *
      ******************************************************************
                                                                        
       S3300-RGV010-VSAM-REWRITE      SECTION.                          
                                                                        
           EXEC CICS REWRITE  FILE      ('RGV010')                      
                              FROM      (RGV010-REC)                    
                              LENGTH    (C-RGV010-LEN)                  
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD  C-ONE                    TO A-ERROR-COUNT
               MOVE W-RETURN-CODE            TO W-RC
               MOVE W-RC                     TO W-COMM-SQL
               MOVE 'ABEND-RGV010-REWRITE'   TO W-COMM-MSG              
           END-IF.                                                      
                                                                        
       S3300-RGV010-VSAM-REWRITE-EXIT.                                  
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *           S 3 3 5 0 - R G V 0 1 0 - D E L E T E                *
      *                                                                *
      ******************************************************************
                                                                        
       S3350-RGV010-VSAM-DELETE       SECTION.                          
                                                                        
           EXEC CICS DELETE   FILE      ('RGV010')                      
      *                       RIDFLD    (RGV010-KEY)                    
                              RESP      (W-RETURN-CODE)                 
           END-EXEC.                                                    
                                                                        
                                                                        
           IF  W-RETURN-NORMAL                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD  C-ONE                    TO A-ERROR-COUNT
               MOVE W-RETURN-CODE            TO W-RC
               MOVE W-RC                     TO W-COMM-SQL
               MOVE 'ABEND-RGV010-DELETE '   TO W-COMM-MSG              
           END-IF.                                                      
                                                                        
       S3350-RGV010-VSAM-DELETE-EXIT.                                   
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                  S 4 0 0 0 - T T A A A - S E L E C T           *
      *                                                                *
      ******************************************************************

       S4000-TTAAA-SELECT             SECTION.

           EXEC SQL                                                     
                SELECT  TRADE_NM                                        
                  INTO  :TTAAA.TRADE-NM                                 
                  FROM  DTAA.TTAAA                                      
                 WHERE  BUSNID      = :TTAAA.BUSNID                     
                   AND  LAST_FG     = 'Y'                               
           END-EXEC.                                                    

           IF  SQLCODE = C-SQL-NORMAL  OR  C-SQL-NOTFND
               CONTINUE
           ELSE
               ADD  +1                    TO A-ERROR-COUNT
               MOVE SQLCODE               TO W-RC
               MOVE W-RC                  TO W-COMM-SQL
               MOVE 'S4000-TTAAA-SEL-ERR' TO W-COMM-MSG
           END-IF.

       S4000-TTAAA-SELECT-EXIT.
           SKIP1
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                  S 4 1 0 0 - T T I A A - S E L E C T           *
      *                                                                *
      ******************************************************************

       S4100-TTIAA-SELECT             SECTION.

           EXEC SQL                                                     
                SELECT  NM                                              
                  INTO  :TTIAA.NM                                       
                  FROM  DTIA.TTIAA                                      
                 WHERE  RESID       = :TTIAA.RESID                      
                   AND  TXPAYER_TP  = :TTIAA.TXPAYER-TP                 
           END-EXEC.                                                    

           IF  SQLCODE = C-SQL-NORMAL  OR  C-SQL-NOTFND
               CONTINUE
           ELSE
               ADD  +1                    TO A-ERROR-COUNT
               MOVE SQLCODE               TO W-RC
               MOVE W-RC                  TO W-COMM-SQL
               MOVE 'S4100-TTIAA-SEL-ERR' TO W-COMM-MSG
           END-IF.

       S4100-TTIAA-SELECT-EXIT.
           SKIP1
           EXIT.
           EJECT
030922******************************************************************
      *                                                                *
      *            S 4 2 0 0 - S E L E C T - T R W B O                 *
      *                                                                *
      ******************************************************************

       S4200-SELECT-TRWBO     SECTION.

           MOVE W-RTN-DT                  TO ASS-YYMM-FR   OF TRWBO.
           MOVE W-COMM-OFFCRCD-RTN        TO TX-OFFCR-CD   OF TRWBO.
           MOVE W-COMM-TXTP-CD            TO TXTP-CD       OF TRWBO.
           MOVE W-COMM-RTN-TP             TO RTN-TP        OF TRWBO.
           IF   W-COMM-TXTP-CD             =  '31'
                IF  W-COMM-SERIAL-NO       >  1
                    MOVE   '4'            TO RTN-TP        OF TRWBO
                END-IF
           END-IF.
           MOVE W-COMM-TXOFF-CD           TO TXOFF-CD      OF TRWBO.

           MOVE ZERO                      TO W-DB-NO-CNT.

           EXEC  SQL
                SELECT  ENTRY_DUP_CNT,
                        ELEC_DUP_CNT,
                        MEDIA_DUP_CNT,
                        SUBMT_DUP_CNT,
                        ENTRY_NORM_CNT,
                        ELEC_NORM_CNT,
                        MEDIA_NORM_CNT,
                        SUBMT_NORM_CNT,
                        ENTRY_ERR_CNT,
                        ELEC_ERR_CNT,
                        MEDIA_ERR_CNT,
                        SUBMT_ERR_CNT
                  INTO
                        :W-ENTRY-DUP-CNT,
                        :W-ELEC-DUP-CNT,
                        :W-MEDIA-DUP-CNT,
                        :W-SUBMT-DUP-CNT,
                        :W-ENTRY-NORM-CNT,
                        :W-ELEC-NORM-CNT,
                        :W-MEDIA-NORM-CNT,
                        :W-SUBMT-NORM-CNT,
                        :W-ENTRY-ERR-CNT,
                        :W-ELEC-ERR-CNT,
                        :W-MEDIA-ERR-CNT,
                        :W-SUBMT-ERR-CNT

                  FROM  DRWB.TRWBO

                  WHERE  TX_OFFCR_CD     = :TRWBO.TX-OFFCR-CD
                    AND  TXOFF_CD        = :TRWBO.TXOFF-CD
                    AND  TXTP_CD         = :TRWBO.TXTP-CD
                    AND  ASS_YYMM_FR     = :TRWBO.ASS-YYMM-FR
                    AND  RTN_TP          = :TRWBO.RTN-TP

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL

               PERFORM S4300-UPDATE-TRWBO

           ELSE

               ADD  +1                    TO A-ERROR-COUNT
               MOVE SQLCODE               TO W-RC
               MOVE W-RC                  TO W-COMM-SQL
               MOVE 'S4200-TRWBO-SEL-ERR' TO W-COMM-MSG

           END-IF.


       S4200-SELECT-TRWBO-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 4 3 0 0 - U P D A T E - T R W B O                 *
      *                                                                *
      ******************************************************************

       S4300-UPDATE-TRWBO     SECTION.

           IF   W-LAST-FG    =  '2'

                IF  W-RTN-METHOD =   '1'
                    COMPUTE W-ENTRY-DUP-CNT      =
                            W-ENTRY-DUP-CNT      - 1
                ELSE
                IF  W-RTN-METHOD =   '9'
                    COMPUTE W-ELEC-DUP-CNT       =
                            W-ELEC-DUP-CNT       - 1
                ELSE
                IF  W-RTN-METHOD =   '2'
                    COMPUTE W-MEDIA-DUP-CNT      =
                            W-MEDIA-DUP-CNT      - 1
                ELSE
                IF  W-RTN-METHOD =   '3' OR '8'
                    COMPUTE W-SUBMT-DUP-CNT      =
                            W-SUBMT-DUP-CNT      - 1
                END-IF
                END-IF
                END-IF
                END-IF
           END-IF.
           IF   W-ENTRY-DUP-CNT      <=  ZERO  AND
                W-ELEC-DUP-CNT       <=  ZERO  AND
                W-MEDIA-DUP-CNT      <=  ZERO  AND
                W-SUBMT-DUP-CNT      <=  ZERO  AND
                W-ENTRY-NORM-CNT     <=  ZERO  AND
                W-ELEC-NORM-CNT      <=  ZERO  AND
                W-MEDIA-NORM-CNT     <=  ZERO  AND
                W-SUBMT-NORM-CNT     <=  ZERO  AND
                W-ENTRY-ERR-CNT      <=  ZERO  AND
                W-ELEC-ERR-CNT       <=  ZERO  AND
                W-MEDIA-ERR-CNT      <=  ZERO  AND
                W-SUBMT-ERR-CNT      <=  ZERO

                PERFORM  S4400-DELETE-TRWBO
           ELSE

           EXEC  SQL
                UPDATE  DRWB.TRWBO
                  SET
                     ENTRY_DUP_CNT        = :W-ENTRY-DUP-CNT,
                     ELEC_DUP_CNT         = :W-ELEC-DUP-CNT,
                     MEDIA_DUP_CNT        = :W-MEDIA-DUP-CNT,
                     SUBMT_DUP_CNT        = :W-SUBMT-DUP-CNT
                  WHERE  TX_OFFCR_CD     = :TRWBO.TX-OFFCR-CD
                    AND  TXOFF_CD        = :TRWBO.TXOFF-CD
                    AND  TXTP_CD         = :TRWBO.TXTP-CD
                    AND  ASS_YYMM_FR     = :TRWBO.ASS-YYMM-FR
                    AND  RTN_TP          = :TRWBO.RTN-TP

           END-EXEC

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               ADD  +1                    TO A-ERROR-COUNT
               MOVE SQLCODE               TO W-RC
               MOVE W-RC                  TO W-COMM-SQL
               MOVE 'S4300-TRWBO-UPD-ERR' TO W-COMM-MSG
           END-IF
           END-IF.


       S4300-UPDATE-TRWBO-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 4 4 0 0 - D E L E T E - T R W B O                 *
      *                                                                *
      ******************************************************************

       S4400-DELETE-TRWBO     SECTION.

           EXEC  SQL
                DELETE FROM  DRWB.TRWBO
                  WHERE  TX_OFFCR_CD     = :TRWBO.TX-OFFCR-CD
                    AND  TXOFF_CD        = :TRWBO.TXOFF-CD
                    AND  TXTP_CD         = :TRWBO.TXTP-CD
                    AND  ASS_YYMM_FR     = :TRWBO.ASS-YYMM-FR
                    AND  RTN_TP          = :TRWBO.RTN-TP

           END-EXEC

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               ADD  +1                    TO A-ERROR-COUNT
               MOVE SQLCODE               TO W-RC
               MOVE W-RC                  TO W-COMM-SQL
               MOVE 'S4400-TRWBO-DEL-ERR' TO W-COMM-MSG
           END-IF.

       S4400-DELETE-TRWBO-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 5 0 0 0 - G E T - S Y S T E M - D A T A           *
      *                                                                *
      ******************************************************************
                                                                        
       S5000-GET-SYSTEM-DATA SECTION.                                   
                                                                        
           EXEC CICS ASKTIME                                            
                     ABSTIME (W-ABSTIME)                                
           END-EXEC.                                                    
                                                                        
           EXEC CICS FORMATTIME                                         
                     ABSTIME (W-ABSTIME)                                
                     YYYYMMDD(W-DB2DATE)                                
                     TIME    (W-TIME)                                   
                     DATESEP                                            
                     TIMESEP                                            
           END-EXEC.                                                    
                                                                        
       S5000-GET-SYSTEM-DATA-EXIT.                                      
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                   S 9 0 0 0 - R E A D - S U V 0 1              *
      *                                                                *
      ******************************************************************

       S9000-READ-SUV010               SECTION.

           EXEC CICS READ     FILE     ('SUV010')
                              INTO     (W-MESSAGE)
                              RIDFLD   (W-MSG-ID)
                              RESP     (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               MOVE W-MSG-CONTENTS     TO W-COMM-MSG
           ELSE
               MOVE 'MESSAGE NOT-FOUND'
                                       TO W-COMM-MSG

           END-IF.

       S9000-READ-SUV010-EXIT.
           EXIT.
      ******************************************************************
      *                                                                *
      *                   S 9 9 0 0 - R E T U R N                      *
      *                                                                *
      *                     - RETURN TO CICS                           *
      *                                                                *
      ******************************************************************

       S9900-RETURN                    SECTION.

           EXEC CICS RETURN
           END-EXEC.

       S9900-RETURN-EXIT.
           EXIT.
      *****************************************************************
      *                                                               *
      *      ?/?~?/?j?a?/?~Èßwawe»·l~m/  ..END OF PROGRAM           *
      *                                                               *
      *****************************************************************
