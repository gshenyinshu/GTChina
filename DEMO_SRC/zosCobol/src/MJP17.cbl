      ******************************************************************
      *                                                                *
      *         I D E N T I F I C A T I O N   D I V I S I O N          *
      *                                                                *
      ******************************************************************
                                                                        
       IDENTIFICATION     DIVISION.                                     
                                                                        
       PROGRAM-ID.        MJP17.                                        
       AUTHOR.            ITPlus.                                       
       INSTALLATION.      ITPlus.                                       
       DATE-WRITTEN.      2003.07.29.                                   
       DATE-COMPILED.                                                   
                                                                        
      ******************************************************************
      *                                                                *
      *                    M   J   P   1   7                           *
      *                                                                *
      *  PROGRAM TYPE   -  ONLINE COBOL                                *
      *                                                                *
      *  FUNCTION       - ?vi~Úç  Úß½¦                               *
      *                                                                *
      *  TRANSACTION    -  MJ17                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; MJP17                       *
      *                                                                *
      *  INPUT PARMS    -  COMMUNICATION AREA     -   4000 BYTE        *
      *                                                                *
      *  OUTPUT PARMS   -  NONE                                        *
      *                                                                *
      *  TABLES         -  NONE                                        *
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
      *  2003/07/29  ITPlus        INITIAL WRITTEN                     *
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
           VALUE 'MJP17 - WORKING STORAGE BEGINS HERE'.                 
                                                                        
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
                                                                        
           05  C-PGM-MJP17            PIC  X(08) VALUE 'MJP17'.         
           05  C-PGM-MJ17             PIC  X(08) VALUE 'MJ17'.          
           05  C-PGM-SSSAV            PIC  X(08) VALUE 'SSSAV'.         
           05  C-PGM-SSSAP            PIC  X(08) VALUE 'SSSAP'.         
           05  C-PGM-SSSHE            PIC  X(08) VALUE 'SSSHE'.         
           05  C-PGM-SSSDC            PIC  X(08) VALUE 'SSSDC'.         
           05  C-PGM-SSSDA            PIC  X(08) VALUE 'SSSDA'.         
           05  C-PGM-QSPC2            PIC  X(08) VALUE 'QSPC2'.         
           05  C-PGM-MDSBW            PIC  X(08) VALUE 'MDSBW'.         
           05  C-PGM-MFS02            PIC  X(08) VALUE 'MFS02'.         
           05  C-PGM-MGSHI            PIC  X(08) VALUE 'MGSHI'.         
           05  C-PGM-MGSS2            PIC  X(08) VALUE 'MGSS2'.         
           05  C-PGM-MGSS3            PIC  X(08) VALUE 'MGSS3'.         
           05  C-COMM-LNTH            PIC S9(04) COMP SYNC VALUE +4000. 
                                                                        
           05  C-TRAN-ID-MJ17          PIC  X(04)  VALUE    'MJ17'.     
           05  C-PGM-MJP17             PIC  X(08)  VALUE    'MJP17'.    
                                                                        
           05  C-RGY02-LNTH            PIC S9(04)  COMP SYNC            
                                                   VALUE     +3611.     
                                                                        
           05  C-RGY04-LNTH            PIC S9(04)  COMP SYNC            
                                                   VALUE     +3037.     
                                                                        
           05  C-PGM-SSSAK             PIC  X(05)  VALUE    'SSSAK'.    
           05  C-PGM-RGS02             PIC  X(05)  VALUE    'RGS02'.    
           05  C-PGM-RGS03             PIC  X(05)  VALUE    'RGS03'.    
           05  C-PGM-RGS04             PIC  X(05)  VALUE    'RGS04'.    
                                                                        
      *                                *********************************
      *                                *      USER  MESSAGE  CODES      
      *                                *********************************
                                                                        
           05  C-MSG-AB50006           PIC  X(07) VALUE 'AB50006'.      
           05  C-MSG-CB58022           PIC  X(07) VALUE 'CB58022'.      
           05  C-MSG-DR00014           PIC  X(07) VALUE 'DR00014'.      
           05  C-MSG-DR00019           PIC  X(07) VALUE 'DR00019'.      
           05  C-MSG-DR00021           PIC  X(07) VALUE 'DR00021'.      
                                                                        
      *                                ***********         ************ 
      *                                *       COMMON  CONSTANT       * 
      *                                ***********         ************ 
                                                                        
           COPY SSYBC.                                                  
                                                                        
      *                                ***********         ************ 
      *                                *       SQL RETURN CODE        * 
      *                                ***********         ************ 
                                                                        
           COPY SSYBI.                                                  
                                                                        
      *                                ***********         ************ 
      *                                *     HANDLE AID IDENTIFER     * 
      *                                ***********         ************ 
                                                                        
           COPY DFHAID.                                                 
                                                                        
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
                                                                        
      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************
       01  WORKAREAS.                                                   
                                                                        
      *                                *************       ************ 
      *                                *   INDEX/INDICATE  WORK AREA  * 
      *                                *************       ************ 
                                                                        
           05  W-LINK-PGM              PIC  X(08).                      
           05  W-RC                    PIC ---9.                        
           05  W-INDEX                 PIC S9(04) COMP.                 
                                                                        
           05  W-DISTR-TXOFF-CD        PIC X(03).                       
           05  W-TXOFF-CD              PIC X(03).                       
           05  W-TX-OFFCR-CD           PIC X(04).                       
           05  W-RTN-STAT-CD           PIC X(01).                       
           05  W-TXOFF-CD-ENTRY        PIC X(03).                       
           05  W-RTN-METHOD            PIC X(01).                       
           05  W-BAL-BEPAY-TX          PIC S9(15) COMP-3.               
           05  W-ASS-STDAMT            PIC S9(15) COMP-3.               
                                                                        
           05  W-VALID                 PIC X(04).                       
                                                                        
           05  W-ERR-CNT               PIC S9(4) COMP.                  
           05  W-DB-ISRT-CNT           PIC S9(4) COMP.                  
                                                                        
           05  W-MAX-DEL-SERIAL-NO     PIC S9(4) COMP.                  
                                                                        
       01  W-LINK-AREA.                                                 
                                                                        
           05  L-ASS-YYMM-FR           PIC  X(06).                      
           05  L-TXTP-CD               PIC  X(02).                      
           05  L-RESID-BUSNID          PIC  X(13).                      
           05  L-RTN-TP                PIC  X(01).                      
           05  L-RTN-SERIAL-NO         PIC S9(04) COMP.                 
           05  L-SERIAL-NO             PIC S9(04) COMP.                 
           05  L-TXPAYER-TP            PIC  X(01).                      
           05  L-RTN-TP-GB             PIC  X(02).                      
           05  L-RTN-DT                PIC  X(08).                      
           05  L-DISTR-TXOFF-CD        PIC  X(03).                      
           05  L-TXOFF-CD              PIC  X(03).                      
           05  L-TX-OFFCR-CD           PIC  X(04).                      
           05  L-BOOK-NO               PIC S9(04) COMP.                 
           05  L-SEQNO                 PIC S9(04) COMP.                 
           05  L-RETURN-CODE           PIC  X(02).                      
           05  L-RETURN-CODE1          PIC  X(05).                      
                                                                        
       01  W-L-AREA.                                                    
                                                                        
           05  W-L-ASS-YYMM-FR         PIC  X(06).                      
           05  W-L-TXTP-CD             PIC  X(02).                      
           05  W-L-RESID-BUSNID        PIC  X(13).                      
           05  W-L-RTN-TP              PIC  X(01).                      
           05  W-L-RTN-SERIAL-NO       PIC S9(04) COMP.                 
           05  W-L-SERIAL-NO           PIC S9(04) COMP.                 
           05  W-L-TXPAYER-TP          PIC  X(01).                      
           05  W-L-RTN-TP-GB           PIC  X(02).                      
           05  W-L-RTN-DT              PIC  X(08).                      
           05  W-L-DISTR-TXOFF-CD      PIC  X(03).                      
           05  W-L-TXOFF-CD            PIC  X(03).                      
           05  W-L-TX-OFFCR-CD         PIC  X(04).                      
           05  W-L-BOOK-NO             PIC S9(04) COMP.                 
           05  W-L-SEQNO               PIC S9(04) COMP.                 
           05  W-L-TRAN                PIC  X(04).                      
           05  W-L-USERID              PIC  X(08).                      
                                                                        
           05  W-L-RETURN              PIC  X(04).                      
           05  W-L-MSG                 PIC  X(60).                      
                                                                        
      ***************************************************************** 
      *                                                               * 
      *                 M O D U L E         A R E A                   * 
      *                                                               * 
      ***************************************************************** 
      *                                ******************************** 
      *                                *    wi?E?V  }Ý¤?            * 
      *                                ******************************** 
                                                                        
           COPY                        SSYHE.                           
                                                                        
      *                                ******************************** 
      *                                *  ?a[~  EDIT                * 
      *                                ******************************** 
                                                                        
           COPY                        SSYAV.                           
                                                                        
      *                                ******************************** 
      *                                *     DATE  CHECK              * 
      *                                ******************************** 
                                                                        
           COPY                        SSYDC.                           
                                                                        
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
                                                                        
      *                                *************       *************
      *                                *       ?~??    VSAM FILE     *
      *                                *************       *************
           COPY                        RGY02.                           
                                                                        
      *                                *************       *************
      *                                *       wa[s~?[?VSAM FILE     *
      *                                *************       *************
           COPY                        RGY04.                           
                                                                        
      *                                *************       *************
      *                                * (SUB) ?vi~ÚçJE¤°ia?A  FILE  *
      *                                *************       *************
           COPY                        ADY2P.                           
                                                                        
      *                                ***********         ************ 
      *                                *  PROGRAM SELF COMM AREA      * 
      *                                ***********         ************ 
                                                                        
       COPY QMY00.                                                      
                                                                        
       COPY MYY00.                                                      
                                                                        
        05 W-COMM-PGM-RR  REDEFINES W-RETURN-PRIVATE.                   
                                                                        
           10  W-CM-DELETE-OK                  PIC  X(01).              
                                                                        
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
                                                                        
      *           ******************************************************
020424*           *        DRSA.TRSEA     (u3?v?~??           TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE RSOEA                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DROA.TROAZ     (wah/?~??           TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE ROOAZ                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DRNA.TRNA1     ([~pß¹~??           TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE RNOA1                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DTAA.TTAAA     (?/?3?/             TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE TAOAA                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DRWA.TRWAG     (»·??J?JP           TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE RWOAG                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DRWA.TRWBH     (?vi~ÚçÚß½¦?7v~     TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE RWOBH                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DRWA.TRWCA     (?vi~wiwa}?         TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE RWOCA                                      
           END-EXEC.                                                    
                                                                        
      *           ******************************************************
      *           *        DRIA.TRIAA     (?vi~             TABLE ) 
      *           ******************************************************
                                                                        
           EXEC SQL  INCLUDE RIOAA                                      
           END-EXEC.                                                    
                                                                        
      ***************************************************************** 
      *                                                               * 
      *           E N D   O F  W O R K I N G  S T O R A G E           * 
      *                                                               * 
      ***************************************************************** 
                                                                        
       01  WS-END                      PIC X(40)                        
           VALUE 'MJP17 - WORKING STORAGE ENDS HERE'.                   
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
                                                                        
           PERFORM S2000-RETURN.                                        
                                                                        
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
                                                                        
           EVALUATE  W-COMM-STEP                                        
               WHEN  1                                                  
                     PERFORM S0200-ONE-PROCESS                          
                                                                        
      * ERROR                                                           
               WHEN  OTHER                                              
                     ADD  +1           TO A-ERROR-COUNT                 
                     MOVE 'STEP-ERR'   TO W-COMM-MSG                    
                                                                        
           END-EVALUATE.                                                
                                                                        
       S0100-MAIN-PROCESS-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                S 0 2 0 0 - O N E - P R O C E S S               *
      *                                                                *
      ******************************************************************
                                                                        
       S0200-ONE-PROCESS  SECTION.                                      
                                                                        
           MOVE SPACE                  TO W-CM-DELETE-OK.               
                                                                        
           MOVE W-COMM-ASS-YYMM-FR     TO ASS-YYMM-FR    OF TRIAA.      
           MOVE W-COMM-TXTP-CD         TO TXTP-CD        OF TRIAA.      
                                                                        
           IF  W-COMM-RES-BUSN-TP  =  '1'                               
                                                                        
               MOVE W-COMM-BUSNID      TO RESID-BUSNID   OF TRIAA       
           ELSE                                                         
               MOVE W-COMM-RESID-TXPAYER                                
                                       TO RESID-BUSNID   OF TRIAA       
           END-IF                                                       
                                                                        
           MOVE W-COMM-RTN-TP          TO RTN-TP         OF TRIAA.      
           MOVE W-COMM-RTN-SERIAL-NO   TO RTN-SERIAL-NO  OF TRIAA.      
           MOVE W-COMM-SERIAL-NO       TO SERIAL-NO      OF TRIAA.      
           MOVE W-COMM-TXPAYER-TP      TO TXPAYER-TP     OF TRIAA.      
                                                                        
           PERFORM S1700-TRIAA-SELECT.                                  
                                                                        
      *?/Kai¬»a?V  JE¤°i¬»ao?  ?/?/  Úß½¦wih/(wah/?,u3?v?,[~pß½?æ¦?)
           IF  RFND-GB OF TRIAA  >  SPACE                               
                                                                        
040510         IF  TXTP-CD OF TRIAA  =  '41' OR '31' OR                 
040630                                  '10' OR '21' OR '23'            
                                                                        
                   PERFORM S0250-DELETE-CHECK                           
               ELSE                                                     
                   ADD  1                  TO A-ERROR-COUNT             
                   MOVE 'RC01'             TO W-COMM-RC                 
                   MOVE C-MSG-DR00014      TO W-MSG-ID                  
      *           JE¤°i¬¼7o?  ?/?/?~t/?~  Úß½¦h/  wih/l?}?l~m/?.      
                                                                        
               END-IF                                                   
                                                                        
           ELSE                                                         
                                                                        
               PERFORM S0250-DELETE-CHECK                               
                                                                        
           END-IF.                                                      
                                                                        
       S0200-ONE-PROCESS-EXIT.                                          
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 0 2 5 0 - D E L E T E - C H E C K                *
      *                                                                *
      ******************************************************************
                                                                        
       S0250-DELETE-CHECK    SECTION.                                   
                                                                        
           IF  W-COMM-FAST-FLAG        =  'A'  OR                       
041123        (W-COMM-TXTP-CD          =  '43' AND                      
041123         W-COMM-SERIAL-NO        =  1)
      * (?a[?  ?/Kai¬»a  ?V  ?vi~Úç  Úß½¦?~LOG.wah/hau?  ?/{7?)     
                                                                        
      *?/h?Ka?7?7                                                     
               PERFORM  S0260-HISTORY-CALL                              
                                                                        
               IF  W-L-RETURN          =  SPACE  OR LOW-VALUE           
                                                                        
                   PERFORM  S0300-DELETE-PROCESS                        
                                                                        
               ELSE                                                     
                   ADD  1             TO  A-ERROR-COUNT                 
                   MOVE W-L-RETURN    TO  W-COMM-RC                     
                   MOVE W-L-MSG       TO  W-COMM-MSG                    
               END-IF                                                   
                                                                        
           ELSE                                                         
                                                                        
               PERFORM  S0300-DELETE-PROCESS                            
                                                                        
           END-IF.                                                      
                                                                        
           IF  NOT A-ERROR-COUNT-ZERO                                   
                                                                        
               EXEC CICS SYNCPOINT ROLLBACK                             
               END-EXEC                                                 
                                                                        
           END-IF.                                                      
                                                                        
       S0250-DELETE-CHECK-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 0 2 6 0 - H I S T O R Y - C A L L                *
      *                                                                *
      ******************************************************************
                                                                        
       S0260-HISTORY-CALL    SECTION.                                   
                                                                        
           INITIALIZE  W-L-AREA.                                        
                                                                        
           MOVE W-COMM-ASS-YYMM-FR     TO W-L-ASS-YYMM-FR.              
           MOVE W-COMM-TXTP-CD         TO W-L-TXTP-CD.                  
                                                                        
           IF  W-COMM-RES-BUSN-TP  =  '1'                               
                                                                        
               MOVE W-COMM-BUSNID      TO W-L-RESID-BUSNID              
           ELSE                                                         
               MOVE W-COMM-RESID-TXPAYER                                
                                       TO W-L-RESID-BUSNID              
           END-IF.                                                      
                                                                        
           MOVE W-COMM-RTN-TP          TO W-L-RTN-TP.                   
           MOVE W-COMM-RTN-SERIAL-NO   TO W-L-RTN-SERIAL-NO.            
           MOVE W-COMM-SERIAL-NO       TO W-L-SERIAL-NO.                
           MOVE W-COMM-TXPAYER-TP      TO W-L-TXPAYER-TP.               
           MOVE W-COMM-RTN-TP-GB       TO W-L-RTN-TP-GB.                
           MOVE W-COMM-RTN-DT          TO W-L-RTN-DT.                   
           MOVE W-DISTR-TXOFF-CD       TO W-L-DISTR-TXOFF-CD.           
           MOVE W-TXOFF-CD             TO W-L-TXOFF-CD.                 
           MOVE W-TX-OFFCR-CD          TO W-L-TX-OFFCR-CD.              
           MOVE W-COMM-BOOK-NO         TO W-L-BOOK-NO.                  
           MOVE W-COMM-SEQNO           TO W-L-SEQNO.                    
           MOVE W-COMM-USERID          TO W-L-USERID.                   
           MOVE C-TRAN-ID-MJ17         TO W-L-TRAN.                     
                                                                        
           EXEC  SQL SET CURRENT PACKAGESET = 'NTA'                     
           END-EXEC.                                                    
                                                                        
           EVALUATE  W-L-TXTP-CD                                        
                                                                        
      *[~p?                                                           
               WHEN  '10'                                               
               WHEN  '21'                                               
               WHEN  '23'                                               
                     CALL  C-PGM-MDSBW  USING W-L-AREA                  
                                                                        
      *u3?v                                                           
               WHEN  '31'                                               
               WHEN  '65'                                               
               WHEN  '66'                                               
                     CALL  C-PGM-MFS02  USING W-L-AREA                  
                                                                        
      *wah/                                                           
               WHEN  '41'                                               
                     CALL  C-PGM-MGSHI  USING W-L-AREA                  
                                                                        
      *Êß[~[?                                                         
               WHEN  '42'                                               
                     CALL  C-PGM-MGSS2  USING W-L-AREA                  
                                                                        
      *?a[?                                                           
               WHEN  '43'                                               
                     CALL  C-PGM-MGSS3  USING W-L-AREA                  
                                                                        
           END-EVALUATE.                                                
                                                                        
           EXEC  SQL SET CURRENT PACKAGESET = '   '                     
           END-EXEC.                                                    
                                                                        
       S0260-HISTORY-CALL-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 0 3 0 0 - D E L E T E - P R O C E S S            *
      *                                                                *
      ******************************************************************
                                                                        
       S0300-DELETE-PROCESS  SECTION.                                   
                                                                        
           MOVE W-COMM-TXTP-CD         TO W-VALID(1:2).                 
           MOVE W-COMM-RTN-TP-GB       TO W-VALID(3:2).                 
                                                                        
           PERFORM S1000-CALL-DATA-MOVE.                                
                                                                        
           EXEC  SQL SET CURRENT PACKAGESET = 'NTA'                     
           END-EXEC.                                                    
                                                                        
           IF  W-VALID  =  '1000' OR '2100' OR '2300' OR                
                           '3100' OR '3111' OR '3400' OR                
                           '4213' OR '4214' OR '4215' OR                
                           '4300' OR '4509' OR '4510' OR                
                           '4521' OR '4522' OR '4523' OR                
                           '4600' OR '5300' OR                          
                           '6500' OR '6600' OR                          
                           '4320'                                       
                                                                        
      * RGS03 SUB-PGM CALL (iA[¦¤~h?v¬æ/?s  ?/æÖ[?~s)                 
               CALL  C-PGM-RGS03  USING W-LINK-AREA                     
           ELSE                                                         
               IF  W-VALID  =  '1001' OR '2200' OR '3102' OR            
                               '3103' OR '3104' OR '3105' OR            
                               '3200' OR '3300' OR '3600' OR            
                               '4112'                                   
                                                                        
      * RGS02 SUB-PGM CALL (iA[¦¤~h?v¬æ/?s  t~?/æÖ  [?~s)             
                   CALL  C-PGM-RGS02  USING W-LINK-AREA                 
               ELSE                                                     
      * RGS04 SUB-PGM CALL (wah/h/C~[?)                               
                   CALL  C-PGM-RGS04  USING W-LINK-AREA                 
                                                                        
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
           EXEC  SQL SET CURRENT PACKAGESET = '   '                     
           END-EXEC.                                                    
                                                                        
           IF  L-RETURN-CODE  =  SPACE                                  
                                                                        
               PERFORM S1100-INSERT-DATA-MOVE                           
               PERFORM S1400-TRWBH-INSERT                               
                                                                        
               IF  A-ERROR-COUNT  =  ZERO                               
                                                                        
                   PERFORM S0400-DELETE-PROCESS-1                       
                                                                        
               END-IF                                                   
                                                                        
           ELSE                                                         
               IF  L-RETURN-CODE  =  '04'                               
                                                                        
                   ADD  1                    TO A-ERROR-COUNT           
                   MOVE 'RC01'               TO W-COMM-RC               
                   MOVE C-MSG-DR00019        TO W-MSG-ID                
      *         ?a?7?vi~Úçh/  »æ?/t/?~  Úß½¦}??a  ?4ù°l~m/?.        
               ELSE                                                     
                   IF  L-RETURN-CODE  =  '05'                           
                                                                        
                       ADD  1                TO A-ERROR-COUNT           
                       MOVE 'RC01'           TO W-COMM-RC               
                       MOVE C-MSG-DR00021    TO W-MSG-ID                
      *               Bah/?/?v??wah/ÚÝ[?h/  »æ?/t/?~  Úß½¦}??a  ?4ù°l~
                   ELSE                                                 
                       ADD  +1               TO A-ERROR-COUNT           
                       MOVE 'RC01'           TO W-COMM-RC               
                                                                        
                       STRING 'S0000-DELETE-PROCESS: '                  
                               L-RETURN-CODE  L-RETURN-CODE1            
                       DELIMITED  BY  SIZE  INTO  W-COMM-MSG            
                       END-STRING                                       
                                                                        
                   END-IF                                               
                                                                        
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
031104*?~??DBÚß½¦                                                   
           IF  A-ERROR-COUNT-ZERO                                       
               IF  W-COMM-TXTP-CD          =  '41' OR '42' OR '43' OR   
                                              '45' OR '46' OR '53'      
                   PERFORM  S1750-TROAZ-DELETE                          
               END-IF                                                   
                                                                        
040513         IF  W-COMM-TXTP-CD          =  '10' OR '21' OR '23'      
                   PERFORM  S1760-TRNA1-DELETE                          
               END-IF                                                   
                                                                        
040224         IF  W-COMM-TXTP-CD          =  '31' OR '65' OR '66'      
                   PERFORM  S1800-TRSEA-DELETE                          
               END-IF                                                   
           END-IF.                                                      
                                                                        
       S0300-DELETE-PROCESS-EXIT.                                       
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *           S 0 4 0 0 - D E L E T E - P R O C E S S - 1          *
      *                                                                *
      ******************************************************************
                                                                        
       S0400-DELETE-PROCESS-1  SECTION.                                 
                                                                        
           PERFORM S1200-ACCNT-DELETE                                   
                                                                        
           IF  A-ERROR-COUNT  =  ZERO                                   
                                                                        
               PERFORM S1500-TRWAG-UPDATE                               
                                                                        
           END-IF.                                                      
                                                                        
      **  ?vi~wiwa}°»~  u¬Úp}?  ?/?/¹¦  ma}aÚçl?  ?vi~Úç              
      **  Úß½¦?~  ?vi~wiwa}?n~  Úß½¦o?n~?s  v?i?}?                    
      **   97/05/15  - [¦¸bi¬¼7Ê¶  ?/?a?/}?  uÝ¹?                     
                                                                        
           IF  A-ERROR-COUNT  =  ZERO                                   
                                                                        
               MOVE W-COMM-ASS-YYMM-FR     TO ASS-YYMM-FR    OF TRWCA   
               MOVE W-COMM-TXTP-CD         TO TXTP-CD        OF TRWCA   
                                                                        
               IF  W-COMM-RES-BUSN-TP  =  '1'                           
                                                                        
                   MOVE W-COMM-BUSNID      TO RESID-BUSNID   OF TRWCA   
               ELSE                                                     
                   MOVE W-COMM-RESID-TXPAYER                            
                                           TO RESID-BUSNID   OF TRWCA   
               END-IF                                                   
                                                                        
               MOVE W-COMM-RTN-TP          TO RTN-TP         OF TRWCA   
               MOVE W-COMM-RTN-SERIAL-NO   TO RTN-SERIAL-NO  OF TRWCA   
               MOVE W-COMM-SERIAL-NO       TO SERIAL-NO      OF TRWCA   
               MOVE W-COMM-TXPAYER-TP      TO TXPAYER-TP     OF TRWCA   
                                                                        
               PERFORM S1600-TRWCA-DELETE                               
                                                                        
           END-IF.                                                      
                                                                        
           IF  A-ERROR-COUNT  =  ZERO                                   
                                                                        
               PERFORM S0500-02-04-DELETE                               
                                                                        
           END-IF.                                                      
                                                                        
           IF  A-ERROR-COUNT  =  ZERO                                   
                                                                        
               MOVE 'Y'                TO W-CM-DELETE-OK                
      *       Úß½¦h/  ¼¬  o¦¸6ù°l~m/?.                                
                                                                        
           END-IF.                                                      
                                                                        
       S0400-DELETE-PROCESS-1-EXIT.                                     
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 0 5 0 0 - 0 2 - 0 4 - D E L E T E                *
      *                                                                *
      ******************************************************************
                                                                        
       S0500-02-04-DELETE             SECTION.                          
                                                                        
      ** ==>> RGY02 DELETE(2004.06.17 u3?vhau?ia  ?/{7?)              
                                                                        
           PERFORM S0600-VSAM-RGY02-READ.                               
                                                                        
           IF  W-RETURN-NORMAL                                          
                                                                        
               PERFORM S0700-DELETE-RGY02-FILE                          
                                                                        
           END-IF.                                                      
                                                                        
      ** ==>> RGY04 DELETE( [~p?[?we?~l?  ½¦æ¦?/ 2003.06.25 )         
                                                                        
           IF (A-ERROR-COUNT  =  ZERO) AND                              
              (W-COMM-TXTP-CD  NOT = '10' OR '21' OR '23')              
                                                                        
               PERFORM S0800-VSAM-RGY04-READ                            
                                                                        
               IF  W-RETURN-NORMAL                                      
                                                                        
                   PERFORM S0900-DELETE-RGY04-FILE                      
                                                                        
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
       S0500-02-04-DELETE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 0 6 0 0 - V S A M - R G Y 0 2 - R E A D          *
      *                                                                *
      ******************************************************************
                                                                        
       S0600-VSAM-RGY02-READ       SECTION.                             
                                                                        
           IF  W-COMM-RES-BUSN-TP  =  '1'                               
                                                                        
               MOVE W-COMM-BUSNID      TO RGV02-RESID-BUSNID            
           ELSE                                                         
               MOVE W-COMM-RESID-TXPAYER                                
                                       TO RGV02-RESID-BUSNID            
           END-IF                                                       
                                                                        
           MOVE W-COMM-TXTP-CD         TO RGV02-TXTP-CD.                
           MOVE W-COMM-ASS-YYMM-FR     TO RGV02-ASS-YYMM-FR.            
                                                                        
           MOVE W-COMM-RTN-TP          TO RGV02-RTN-TP.                 
           MOVE W-COMM-RTN-SERIAL-NO   TO RGV02-RTN-SERIAL-NO.          
           MOVE W-COMM-SERIAL-NO       TO RGV02-SERIAL-NO.              
           MOVE W-COMM-TXPAYER-TP      TO RGV02-TXPAYER-TP.             
                                                                        
           EXEC CICS   READ        FILE   ('RGV020')                    
                                   INTO   (RGV02-REC)                   
                                   LENGTH (C-RGY02-LNTH)                
                                   RIDFLD (RGV02-KEY)                   
                                   RESP   (W-RETURN-CODE)               
                                   UPDATE                               
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL   OR                                     
               W-RETURN-NOTFND                                          
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               IF  W-RETURN-INVREQ                                      
                                                                        
                   EXEC CICS UNLOCK  FILE('RGV020') END-EXEC            
                                                                        
                   PERFORM S0600-VSAM-RGY02-READ                        
               ELSE                                                     
                   ADD  +1               TO A-ERROR-COUNT               
                   MOVE 'RC01'           TO W-COMM-RC                   
                   MOVE 'S0600-VSAM-RGY02-READ '                        
                                         TO W-COMM-MSG                  
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
       S0600-VSAM-RGY02-READ-EXIT.                                      
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *        S 0 7 0 0 - D E L E T E - R G Y 0 2 - F I L E           *
      *                                                                *
      ******************************************************************
                                                                        
       S0700-DELETE-RGY02-FILE        SECTION.                          
                                                                        
           EXEC  CICS      DELETE      FILE   ('RGV020')                
                                       RESP   (W-RETURN-CODE)           
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               ADD  +1                 TO A-ERROR-COUNT                 
               MOVE 'RC01'             TO W-COMM-RC                     
               MOVE 'S0700-DELETE-RGY02-FILE '                          
                                       TO W-COMM-MSG                    
           END-IF.                                                      
                                                                        
       S0700-DELETE-RGY02-FILE-EXIT.                                    
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *          S 0 8 0 0 - V S A M - R G Y 0 4 - R E A D             *
      *                                                                *
      ******************************************************************
                                                                        
       S0800-VSAM-RGY04-READ       SECTION.                             
                                                                        
           IF  W-COMM-RES-BUSN-TP  =  '1'                               
                                                                        
               MOVE W-COMM-BUSNID      TO RGV040-RESID-BUSNID           
           ELSE                                                         
               MOVE W-COMM-RESID-TXPAYER                                
                                       TO RGV040-RESID-BUSNID           
           END-IF                                                       
                                                                        
           MOVE W-COMM-TXTP-CD         TO RGV040-TXTP-CD.               
           MOVE W-COMM-ASS-YYMM-FR     TO RGV040-ASS-YYMM-FR.           
                                                                        
           MOVE W-COMM-RTN-TP          TO RGV040-RTN-TP.                
           MOVE W-COMM-RTN-SERIAL-NO   TO RGV040-RTN-SERIAL-NO.         
           MOVE W-COMM-SERIAL-NO       TO RGV040-SERIAL-NO.             
           MOVE W-COMM-TXPAYER-TP      TO RGV040-TXPAYER-TP.            
                                                                        
           EXEC CICS   READ        FILE   ('RGV040')                    
                                   INTO   (RGV040-REC)                  
                                   LENGTH (C-RGY04-LNTH)                
                                   RIDFLD (RGV040-KEY)                  
                                   RESP   (W-RETURN-CODE)               
                                   UPDATE                               
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL    OR                                    
               W-RETURN-NOTFND                                          
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               IF  W-RETURN-INVREQ                                      
                                                                        
                   EXEC CICS UNLOCK  FILE('RGV040') END-EXEC            
                                                                        
                   PERFORM S0800-VSAM-RGY04-READ                        
               ELSE                                                     
                   ADD  +1               TO A-ERROR-COUNT               
                   MOVE 'RC01'           TO W-COMM-RC                   
                   MOVE 'S0800-VSAM-RGY04-READ '                        
                                         TO W-COMM-MSG                  
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
       S0800-VSAM-RGY04-READ-EXIT.                                      
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *        S 0 9 0 0 - D E L E T E - R G Y 0 4 - F I L E           *
      *                                                                *
      ******************************************************************
                                                                        
       S0900-DELETE-RGY04-FILE        SECTION.                          
                                                                        
           EXEC  CICS      DELETE      FILE   ('RGV040')                
                                       RESP   (W-RETURN-CODE)           
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               ADD  +1                 TO A-ERROR-COUNT                 
               MOVE 'RC01'             TO W-COMM-RC                     
               MOVE 'S0900-DELETE-RGY04-FILE '                          
                                       TO W-COMM-MSG                    
           END-IF.                                                      
                                                                        
       S0900-DELETE-RGY04-FILE-EXIT.                                    
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *           S 1 0 0 0 - C A L L - D A T A - M O V E              *
      *                                                                *
      ******************************************************************
                                                                        
       S1000-CALL-DATA-MOVE           SECTION.                          
                                                                        
           MOVE W-COMM-ASS-YYMM-FR     TO L-ASS-YYMM-FR.                
           MOVE W-COMM-TXTP-CD         TO L-TXTP-CD.                    
                                                                        
           IF  W-COMM-RES-BUSN-TP  =  '1'                               
                                                                        
               MOVE W-COMM-BUSNID      TO L-RESID-BUSNID                
           ELSE                                                         
               MOVE W-COMM-RESID-TXPAYER                                
                                       TO L-RESID-BUSNID                
           END-IF.                                                      
                                                                        
           MOVE W-COMM-RTN-TP          TO L-RTN-TP.                     
           MOVE W-COMM-RTN-SERIAL-NO   TO L-RTN-SERIAL-NO.              
           MOVE W-COMM-SERIAL-NO       TO L-SERIAL-NO.                  
           MOVE W-COMM-TXPAYER-TP      TO L-TXPAYER-TP.                 
           MOVE W-COMM-RTN-TP-GB       TO L-RTN-TP-GB.                  
           MOVE W-COMM-RTN-DT          TO L-RTN-DT.                     
           MOVE W-DISTR-TXOFF-CD       TO L-DISTR-TXOFF-CD.             
           MOVE W-TXOFF-CD             TO L-TXOFF-CD.                   
           MOVE W-TX-OFFCR-CD          TO L-TX-OFFCR-CD.                
           MOVE W-COMM-BOOK-NO         TO L-BOOK-NO.                    
           MOVE W-COMM-SEQNO           TO L-SEQNO.                      
           MOVE SPACE                  TO L-RETURN-CODE                 
                                          L-RETURN-CODE1.               
                                                                        
       S1000-CALL-DATA-MOVE-EXIT.                                       
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *           S 1 1 0 0 - I N S E R T - D A T A - M O V E          *
      *                                                                *
      ******************************************************************
                                                                        
       S1100-INSERT-DATA-MOVE         SECTION.                          
                                                                        
           IF  W-COMM-RES-BUSN-TP  =  '1'                               
                                                                        
               MOVE W-COMM-BUSNID      TO RESID-BUSNID      OF TRWBH    
           ELSE                                                         
               MOVE W-COMM-RESID-TXPAYER                                
                                       TO RESID-BUSNID      OF TRWBH    
           END-IF.                                                      
                                                                        
           MOVE W-COMM-TXTP-CD         TO TXTP-CD           OF TRWBH.   
           MOVE W-COMM-ASS-YYMM-FR     TO ASS-YYMM-FR       OF TRWBH.   
           MOVE W-COMM-RTN-TP          TO RTN-TP            OF TRWBH.   
           MOVE W-COMM-RTN-SERIAL-NO   TO RTN-SERIAL-NO     OF TRWBH.   
           MOVE W-COMM-SERIAL-NO       TO SERIAL-NO         OF TRWBH.   
           MOVE W-COMM-TXPAYER-TP      TO TXPAYER-TP        OF TRWBH.   
                                                                        
           PERFORM S0000-TRWBH-MAX.                                     
                                                                        
KWON       MOVE W-MAX-DEL-SERIAL-NO    TO DEL-SERIAL-NO     OF TRWBH.   
                                                                        
           MOVE W-COMM-RTN-TP-GB       TO RTN-TP-GB         OF TRWBH.   
           MOVE W-COMM-RTN-DT          TO RTN-DT            OF TRWBH.   
           MOVE W-DISTR-TXOFF-CD       TO DISTR-TXOFF-CD    OF TRWBH.   
           MOVE W-TXOFF-CD             TO TXOFF-CD          OF TRWBH.   
           MOVE W-TX-OFFCR-CD          TO TX-OFFCR-CD       OF TRWBH.   
                                                                        
           MOVE W-COMM-BOOK-NO         TO BOOK-NO           OF TRWBH.   
           MOVE W-COMM-SEQNO           TO SEQNO             OF TRWBH.   
                                                                        
           MOVE W-COMM-TXOFF-CD        TO TXOFF-CD-DEL      OF TRWBH.   
           MOVE W-COMM-TX-OFFCR-CD     TO TX-OFFCR-CD-DEL   OF TRWBH.   
                                                                        
           PERFORM S8000-GET-SYSTEM-DATA.                               
                                                                        
           MOVE W-DB2DATE(1:4)         TO DEL-DT       OF TRWBH(1:4).   
           MOVE W-DB2DATE(6:2)         TO DEL-DT       OF TRWBH(5:2).   
           MOVE W-DB2DATE(9:2)         TO DEL-DT       OF TRWBH(7:2).   
                                                                        
           MOVE W-NETNAME              TO TERMINAL-ID       OF TRWBH.   
                                                                        
           MOVE W-COMM-USERID          TO LOGON-ID          OF TRWBH.   
           MOVE +0                     TO ASS-STDAMT-PREV   OF TRWBH.   
           MOVE W-ASS-STDAMT           TO ASS-STDAMT        OF TRWBH.   
           MOVE 'O'                    TO DEL-CS            OF TRWBH.   
                                                                        
           IF  W-COMM-TXTP-CD  =  '10' OR '21' OR '23'                  
                                                                        
               MOVE W-TXOFF-CD-ENTRY   TO ENTRY-TXOFF-CD    OF TRWBH    
           ELSE                                                         
               MOVE W-TXOFF-CD         TO ENTRY-TXOFF-CD    OF TRWBH    
                                                                        
           END-IF.                                                      
                                                                        
           MOVE W-RTN-METHOD           TO RTN-METHOD        OF TRWBH.   
           MOVE W-BAL-BEPAY-TX         TO BAL-BEPAY-TX      OF TRWBH.   
                                                                        
       S1100-INSERT-DATA-MOVE-EXIT.                                     
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *               S 1 2 0 0 - A C C N T - D E L E T E              *
      *                                                                *
      ******************************************************************
                                                                        
       S1200-ACCNT-DELETE  SECTION.                                     
                                                                        
           MOVE L-TXTP-CD              TO W-ADP2P-TXTP-CD.              
           MOVE L-ASS-YYMM-FR          TO W-ADP2P-ASS-YYMM-FR.          
           MOVE L-RESID-BUSNID         TO W-ADP2P-RESID-BUSNID.         
           MOVE L-RTN-TP               TO W-ADP2P-RTN-TP.               
           MOVE L-TXPAYER-TP           TO W-ADP2P-TXPAYER-TP.           
           MOVE L-RTN-SERIAL-NO        TO W-ADP2P-RTN-SERIAL-NO.        
           MOVE L-SERIAL-NO            TO W-ADP2P-SERIAL-NO.            
           MOVE L-TXOFF-CD             TO W-ADP2P-TXOFF-CD.             
           MOVE L-TX-OFFCR-CD          TO W-ADP2P-TX-OFFCR-CD.          
           MOVE 'D'                    TO W-ADP2P-PROC-GUBUN.           
           MOVE '2'                    TO W-ADP2P-ACCT-GUBUN.           
           MOVE 'MJP17'                TO W-ADP2P-CALL-PGM-NM.          
           MOVE 'TRIAA'                TO W-ADP2P-ACCT-DB-NM.           
                                                                        
           PERFORM S1300-ADP2P-CALL-PROC.                               
                                                                        
KWON       IF  W-ADP2P-RESULT-STATUS = '1' OR '2' OR '6' OR 'E'         
                                                                        
               ADD  +1                    TO A-ERROR-COUNT              
               MOVE W-ADP2P-RESULT-STATUS TO W-COMM-RC                  
               MOVE 'S0000-ACCNT-DEL '    TO W-COMM-MSG                 
                                                                        
           END-IF.                                                      
                                                                        
       S1200-ACCNT-DELETE-EXIT.                                         
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 1 3 0 0 - A D P 2 P - C A L L - P R O C           *
      *                                                                *
      ******************************************************************
                                                                        
       S1300-ADP2P-CALL-PROC  SECTION.                                  
                                                                        
           EXEC  SQL  SET   CURRENT    PACKAGESET  =  'NTA'             
           END-EXEC.                                                    
                                                                        
           EXEC   CICS  LINK    PROGRAM  ('ADP2P')                      
                                COMMAREA (W-ADP2P-AREA)                 
                                LENGTH   (C-COMMAREA-LNTH)              
                                RESP     (W-RETURN-CODE)                
           END-EXEC.                                                    
                                                                        
           EXEC   SQL   SET    CURRENT  PACKAGESET = '  '               
           END-EXEC.                                                    
                                                                        
       S1300-ADP2P-CALL-PROC-EXIT.                                      
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 0 0 0 0 - T R W B H - M A X                     *
      *                                                                *
      ******************************************************************
                                                                        
       S0000-TRWBH-MAX                 SECTION.                         
                                                                        
           EXEC SQL SELECT  MAX(DEL_SERIAL_NO)                          
                      INTO  :W-MAX-DEL-SERIAL-NO                        
                      FROM  DRWB.TRWBH                                  
                      WHERE RESID_BUSNID  = :TRWBH.RESID-BUSNID         
                        AND TXTP_CD       = :TRWBH.TXTP-CD              
                        AND ASS_YYMM_FR   = :TRWBH.ASS-YYMM-FR          
                        AND RTN_TP        = :TRWBH.RTN-TP               
                        AND RTN_SERIAL_NO = :TRWBH.RTN-SERIAL-NO        
                        AND SERIAL_NO     = :TRWBH.SERIAL-NO            
                        AND TXPAYER_TP    = :TRWBH.TXPAYER-TP           
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL                                   
                                                                        
               ADD  +1                       TO W-MAX-DEL-SERIAL-NO     
           ELSE                                                         
               IF  SQLCODE = C-SQL-NOTFND OR                            
                   SQLCODE = C-SQL-RETRIEVE-NULL                        
                                                                        
                   MOVE +1                   TO W-MAX-DEL-SERIAL-NO     
               ELSE                                                     
                   ADD  +1                   TO A-ERROR-COUNT           
                   MOVE SQLCODE              TO W-RC                    
                   MOVE W-RC                 TO W-COMM-SQL              
                   MOVE 'S0000-TRWBH-MAX '   TO W-COMM-MSG              
                                                                        
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
       S0000-TRWBH-MAX-EXIT.                                            
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *               S 1 4 0 0 - T R W B H - I N S E R T              *
      *                                                                *
      ******************************************************************
                                                                        
       S1400-TRWBH-INSERT  SECTION.                                     
                                                                        
           EXEC SQL                                                     
                   INSERT INTO  DRWB.TRWBH                              
                      (RESID_BUSNID           ,                         
                       TXTP_CD                ,                         
                       ASS_YYMM_FR            ,                         
                       RTN_TP                 ,                         
                       RTN_SERIAL_NO          ,                         
                       SERIAL_NO              ,                         
                       TXPAYER_TP             ,                         
                       DEL_SERIAL_NO          ,                         
                       RTN_TP_GB              ,                         
                       RTN_DT                 ,                         
                       DISTR_TXOFF_CD         ,                         
                       TXOFF_CD               ,                         
                       TX_OFFCR_CD            ,                         
                       BOOK_NO                ,                         
                       SEQNO                  ,                         
                       DEL_DT                 ,                         
                       TXOFF_CD_DEL           ,                         
                       TX_OFFCR_CD_DEL        ,                         
                       TERMINAL_ID            ,                         
                       LOGON_ID               ,                         
                       ASS_STDAMT_PREV        ,                         
                       ASS_STDAMT             ,                         
                       DEL_CS                 ,                         
                       ENTRY_TXOFF_CD         ,                         
                       RTN_METHOD             ,                         
                       BAL_BEPAY_TX                                     
                      )                                                 
                 VALUES                                                 
                     (:TRWBH.RESID-BUSNID           ,                   
                      :TRWBH.TXTP-CD                ,                   
                      :TRWBH.ASS-YYMM-FR            ,                   
                      :TRWBH.RTN-TP                 ,                   
                      :TRWBH.RTN-SERIAL-NO          ,                   
                      :TRWBH.SERIAL-NO              ,                   
                      :TRWBH.TXPAYER-TP             ,                   
                      :TRWBH.DEL-SERIAL-NO          ,                   
                      :TRWBH.RTN-TP-GB              ,                   
                      :TRWBH.RTN-DT                 ,                   
                      :TRWBH.DISTR-TXOFF-CD         ,                   
                      :TRWBH.TXOFF-CD               ,                   
                      :TRWBH.TX-OFFCR-CD            ,                   
                      :TRWBH.BOOK-NO                ,                   
                      :TRWBH.SEQNO                  ,                   
                      :TRWBH.DEL-DT                 ,                   
                      :TRWBH.TXOFF-CD-DEL           ,                   
                      :TRWBH.TX-OFFCR-CD-DEL        ,                   
                      :TRWBH.TERMINAL-ID            ,                   
                      :TRWBH.LOGON-ID               ,                   
                      :TRWBH.ASS-STDAMT-PREV        ,                   
                      :TRWBH.ASS-STDAMT             ,                   
                      :TRWBH.DEL-CS                 ,                   
                      :TRWBH.ENTRY-TXOFF-CD         ,                   
                      :TRWBH.RTN-METHOD             ,                   
                      :TRWBH.BAL-BEPAY-TX                               
                     )                                                  
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE  =  C-SQL-NORMAL OR                              
               SQLCODE  =  C-SQL-DUP                                    
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               ADD  +1                     TO A-ERROR-COUNT             
               MOVE SQLCODE                TO W-RC                      
               MOVE W-RC                   TO W-COMM-SQL                
               MOVE 'S1400-TRWBH-INSERT '  TO W-COMM-MSG                
                                                                        
           END-IF.                                                      
                                                                        
       S1400-TRWBH-INSERT-EXIT.                                         
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *               S 1 5 0 0 - T R W A G - U P D A T E              *
      *                                                                *
      ******************************************************************
                                                                        
       S1500-TRWAG-UPDATE  SECTION.                                     
                                                                        
           MOVE TX-OFFCR-CD OF TRWBH   TO TX-OFFCR-CD OF TRWAG.         
           MOVE TXOFF-CD    OF TRWBH   TO TXOFF-CD    OF TRWAG.         
           MOVE TXTP-CD     OF TRWBH   TO TXTP-CD     OF TRWAG.         
           MOVE RTN-DT      OF TRWBH   TO ASS-YYMM-FR OF TRWAG.         
           MOVE RTN-TP      OF TRWBH   TO RTN-TP      OF TRWAG.         
                                                                        
           IF  TXTP-CD      OF TRWBH  =  '31'                           
                                                                        
               IF  SERIAL-NO   OF TRWBH  >  1                           
                                                                        
                   MOVE '4'            TO RTN-TP      OF TRWAG          
                                                                        
               END-IF                                                   
                                                                        
           END-IF.                                                      
                                                                        
           IF  W-RTN-STAT-CD = '2'                                      
                                                                        
               MOVE -1                 TO W-ERR-CNT                     
           ELSE                                                         
               MOVE ZERO               TO W-ERR-CNT                     
                                                                        
           END-IF.                                                      
                                                                        
           EXEC  SQL                                                    
                 UPDATE  DRWA.TRWAG                                     
                    SET  DEL_CNT_DB      =  DEL_CNT_DB  +  1,           
                         ERR_CNT         =  ERR_CNT + :W-ERR-CNT,       
                         DB_ISRT_CNT     =  DB_ISRT_CNT -  1            
                  WHERE  TX_OFFCR_CD     = :TRWAG.TX-OFFCR-CD           
                    AND  TXOFF_CD        = :TRWAG.TXOFF-CD              
                    AND  TXTP_CD         = :TRWAG.TXTP-CD               
                    AND  ASS_YYMM_FR     = :TRWAG.ASS-YYMM-FR           
                    AND  RTN_TP          = :TRWAG.RTN-TP                
                                                                        
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE  =  C-SQL-NORMAL  OR                             
               SQLCODE  =  C-SQL-NOTFND                                 
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               ADD  +1                       TO A-ERROR-COUNT           
               MOVE SQLCODE                  TO W-RC                    
               MOVE W-RC                     TO W-COMM-SQL              
               MOVE 'S1500-TRWAG-UPDATE '    TO W-COMM-MSG              
                                                                        
           END-IF.                                                      
                                                                        
       S1500-TRWAG-UPDATE-EXIT.                                         
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *               S 1 6 0 0 - T R W C A - D E L E T E              *
      *                                                                *
      ******************************************************************
                                                                        
       S1600-TRWCA-DELETE  SECTION.                                     
                                                                        
           EXEC SQL                                                     
                    DELETE                                              
                      FROM  DRWC.TRWCA                                  
                     WHERE  RESID_BUSNID  = :TRWCA.RESID-BUSNID         
                       AND  TXTP_CD       = :TRWCA.TXTP-CD              
                       AND  ASS_YYMM_FR   = :TRWCA.ASS-YYMM-FR          
                       AND  RTN_TP        = :TRWCA.RTN-TP               
                       AND  RTN_SERIAL_NO = :TRWCA.RTN-SERIAL-NO        
                       AND  SERIAL_NO     = :TRWCA.SERIAL-NO            
                       AND  TXPAYER_TP    = :TRWCA.TXPAYER-TP           
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE  =  C-SQL-NORMAL  OR                             
               SQLCODE  =  C-SQL-NOTFND                                 
                                                                        
               CONTINUE                                                 
           ELSE                                                         
               ADD  +1                       TO A-ERROR-COUNT           
               MOVE SQLCODE                  TO W-RC                    
               MOVE W-RC                     TO W-COMM-SQL              
               MOVE 'S1600-TRWCA-DELETE '    TO W-COMM-MSG              
                                                                        
           END-IF.                                                      
                                                                        
       S1600-TRWCA-DELETE-EXIT.                                         
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 1 7 0 0 - T R I A A - S E L E C T               *
      *                                                                *
      ******************************************************************
                                                                        
       S1700-TRIAA-SELECT              SECTION.                         
                                                                        
           EXEC SQL SELECT  TXOFF_CD,                                   
                            TX_OFFCR_CD,                                
                            DISTR_TXOFF_CD,                             
                            RTN_STAT_CD,                                
                            RFND_GB,                                    
                            RTN_PROC_TP,                                
                            MATCH_CREATE_FG,                            
                            COMP_CNT,                                   
                            COMP_END_FG,                                
                            TXTP_CD,                                    
                            TXOFF_CD_ENTRY,                             
                            RTN_METHOD,                                 
                            BAL_BEPAY_TX,                               
                            ASS_STDAMT                                  
                      INTO  :TRIAA.TXOFF-CD,                            
                            :TRIAA.TX-OFFCR-CD,                         
                            :TRIAA.DISTR-TXOFF-CD,                      
                            :TRIAA.RTN-STAT-CD,                         
                            :TRIAA.RFND-GB,                             
                            :TRIAA.RTN-PROC-TP,                         
                            :TRIAA.MATCH-CREATE-FG,                     
                            :TRIAA.COMP-CNT,                            
                            :TRIAA.COMP-END-FG,                         
                            :TRIAA.TXTP-CD,                             
                            :TRIAA.TXOFF-CD-ENTRY,                      
                            :TRIAA.RTN-METHOD,                          
                            :TRIAA.BAL-BEPAY-TX,                        
                            :TRIAA.ASS-STDAMT                           
                      FROM  DRIA.TRIAA                                  
                      WHERE RESID_BUSNID  = :TRIAA.RESID-BUSNID         
                        AND TXTP_CD       = :TRIAA.TXTP-CD              
                        AND ASS_YYMM_FR   = :TRIAA.ASS-YYMM-FR          
                        AND RTN_TP        = :TRIAA.RTN-TP               
                        AND RTN_SERIAL_NO = :TRIAA.RTN-SERIAL-NO        
                        AND SERIAL_NO     = :TRIAA.SERIAL-NO            
                        AND TXPAYER_TP    = :TRIAA.TXPAYER-TP           
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL                                   
                                                                        
               MOVE TXOFF-CD       OF TRIAA  TO W-TXOFF-CD              
               MOVE TX-OFFCR-CD    OF TRIAA  TO W-TX-OFFCR-CD           
               MOVE DISTR-TXOFF-CD OF TRIAA  TO W-DISTR-TXOFF-CD        
               MOVE RTN-STAT-CD    OF TRIAA  TO W-RTN-STAT-CD           
               MOVE TXOFF-CD-ENTRY OF TRIAA  TO W-TXOFF-CD-ENTRY        
               MOVE RTN-METHOD     OF TRIAA  TO W-RTN-METHOD            
               MOVE BAL-BEPAY-TX   OF TRIAA  TO W-BAL-BEPAY-TX          
               MOVE ASS-STDAMT     OF TRIAA  TO W-ASS-STDAMT            
           ELSE                                                         
               ADD  +1                       TO A-ERROR-COUNT           
               MOVE SQLCODE                  TO W-RC                    
               MOVE W-RC                     TO W-COMM-SQL              
               MOVE 'S1700-TRIAA-SELECT '    TO W-COMM-MSG              
                                                                        
           END-IF.                                                      
                                                                        
       S1700-TRIAA-SELECT-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 1 7 5 0 - T R O A Z - D E L E T E               *
      *                                                                *
      ******************************************************************
                                                                        
       S1750-TROAZ-DELETE              SECTION.                         
                                                                        
           EXEC SQL DELETE                                              
                      FROM  DROA.TROAZ                                  
                      WHERE RESID_BUSNID  = :TRIAA.RESID-BUSNID         
                        AND TXTP_CD       = :TRIAA.TXTP-CD              
                        AND ASS_YYMM_FR   = :TRIAA.ASS-YYMM-FR          
                        AND RTN_TP        = :TRIAA.RTN-TP               
                        AND RTN_SERIAL_NO = :TRIAA.RTN-SERIAL-NO        
                        AND SERIAL_NO     = :TRIAA.SERIAL-NO            
                        AND TXPAYER_TP    = :TRIAA.TXPAYER-TP           
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL  OR                               
               SQLCODE = C-SQL-NOTFND                                   
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
               ADD  +1                       TO A-ERROR-COUNT           
               MOVE SQLCODE                  TO W-RC                    
               MOVE W-RC                     TO W-COMM-SQL              
               MOVE 'S1750-TROAZ-DELETE '    TO W-COMM-MSG              
                                                                        
           END-IF.                                                      
                                                                        
       S1750-TROAZ-DELETE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 1 7 6 0 - T R N A 1 - D E L E T E               *
      *                                                                *
      ******************************************************************
                                                                        
       S1760-TRNA1-DELETE              SECTION.                         
                                                                        
           EXEC SQL DELETE                                              
                      FROM  DRNA.TRNA1                                  
                      WHERE RESID_BUSNID  = :TRIAA.RESID-BUSNID         
                        AND TXTP_CD       = :TRIAA.TXTP-CD              
                        AND ASS_YYMM_FR   = :TRIAA.ASS-YYMM-FR          
                        AND RTN_TP        = :TRIAA.RTN-TP               
                        AND RTN_SERIAL_NO = :TRIAA.RTN-SERIAL-NO        
                        AND SERIAL_NO     = :TRIAA.SERIAL-NO            
                        AND TXPAYER_TP    = :TRIAA.TXPAYER-TP           
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL  OR                               
               SQLCODE = C-SQL-NOTFND                                   
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
               ADD  +1                       TO A-ERROR-COUNT           
               MOVE SQLCODE                  TO W-RC                    
               MOVE W-RC                     TO W-COMM-SQL              
               MOVE 'S1760-TRNA1-DELETE '    TO W-COMM-MSG              
                                                                        
           END-IF.                                                      
                                                                        
       S1760-TRNA1-DELETE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 1 8 0 0 - T R S E A - D E L E T E               *
      *                                                                *
      ******************************************************************
                                                                        
       S1800-TRSEA-DELETE              SECTION.                         
                                                                        
           EXEC SQL DELETE                                              
                      FROM  DRSE.TRSEA                                  
                      WHERE RESID_BUSNID  = :TRIAA.RESID-BUSNID         
                        AND TXTP_CD       = :TRIAA.TXTP-CD              
                        AND ASS_YYMM_FR   = :TRIAA.ASS-YYMM-FR          
                        AND RTN_TP        = :TRIAA.RTN-TP               
                        AND RTN_SERIAL_NO = :TRIAA.RTN-SERIAL-NO        
                        AND SERIAL_NO     = :TRIAA.SERIAL-NO            
                        AND TXPAYER_TP    = :TRIAA.TXPAYER-TP           
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL  OR                               
               SQLCODE = C-SQL-NOTFND                                   
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
               ADD  +1                       TO A-ERROR-COUNT           
               MOVE SQLCODE                  TO W-RC                    
               MOVE W-RC                     TO W-COMM-SQL              
               MOVE 'S1800-TRSEA-DELETE '    TO W-COMM-MSG              
                                                                        
           END-IF.                                                      
                                                                        
       S1800-TRSEA-DELETE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 8 0 0 0 - G E T - S Y S T E M - D A T A           *
      *                                                                *
      ******************************************************************
                                                                        
       S8000-GET-SYSTEM-DATA SECTION.                                   
                                                                        
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
                                                                        
           EXEC CICS ASSIGN                                             
                     NETNAME (W-NETNAME)                                
           END-EXEC.                                                    
                                                                        
       S8000-GET-SYSTEM-DATA-EXIT.                                      
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                 S 9 0 0 0 - R E A D - S U V 0 1 0              *
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
      *                   S 2 0 0 0 - R E T U R N                      *
      *                                                                *
      *                     - RETURN TO CICS                           *
      *                                                                *
      ******************************************************************
                                                                        
       S2000-RETURN                    SECTION.                         
                                                                        
           EXEC CICS RETURN                                             
           END-EXEC.                                                    
                                                                        
       S2000-RETURN-EXIT.                                               
           EXIT.                                                        
      ***************************************************************** 
      *                                                               * 
      *      ?/?~?/?j?a?/?~Èßwawe»·l~m/  ..END OF PROGRAM           * 
      *                                                               * 
      ***************************************************************** 
