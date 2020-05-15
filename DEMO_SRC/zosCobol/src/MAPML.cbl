      ******************************************************************
      *                                                                *
      *         I D E N T I F I C A T I O N   D I V I S I O N          *
      *                                                                *
      ******************************************************************
                                                                        
       IDENTIFICATION     DIVISION.                                     
                                                                        
       PROGRAM-ID.        MAPML.                                        
       AUTHOR.            ITPlus.                                          
       INSTALLATION.      ITPlus.                                          
       DATE-WRITTEN.      2004.07.21                                    
       DATE-COMPILED.     2004.07.21                                    
                                                                        
      ******************************************************************
      *                                                                *
      *                    M   A   P   M   L                           *
      *                                                                *
      *  PROGRAM TYPE   -  ONLINE COBOL                                *
      *                                                                *
      *  FUNCTION       - u3?v?/?sma{/ma?~?/we?S?-?~K?               *
      *                                                                *
      *  TRANSACTION    -                                              *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; MAPML                       *
      *                                                                *
      *  INPUT PARMS    -  COMMUNICATION AREA     -   4000 BYTE        *
      *                                                                *
      *  OUTPUT PARMS   -  INQUIRY                                     *
      *                                                                *
      *  TABLES         -  DBAA.TBAAA (u3?vma{/ma?~?/TABLE )         *
      *                 -  DRIA.TRIAA (?vi~TABLE )                   *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  I/O FILES      -  SUY01      (MSG VSAM FILE)                  *
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
      *  DATE        S.E.          DESCRIPTION                         *
      *  ==========  ============= ==================================  *
      *  2004/07/21  ITPlus           INITIAL WRITTEN                     *
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
           VALUE 'MAPML - WORKING STORAGE BEGINS HERE'.                 
                                                                        
      ******************************************************************
      *                                                                *
      *                    A C C U M U L A T O R S                     *
      *                                                                *
      ******************************************************************
                                                                        
       01  ACCUMULATORS.                                                
                                                                        
           05  A-ERROR-COUNT           PIC S9(04) COMP SYNC VALUE +0.   
               88  A-ERROR-COUNT-ZERO             VALUE +0.             
               88  A-ERROR-COUNT-ONE              VALUE +1.             
                                                                        
           05  A-FETCH-COUNT           PIC S9(04) COMP SYNC VALUE +0.   
                                                                        
      ******************************************************************
      *                                                                *
      *                       C O N S T A N T S                        *
      *                                                                *
      ******************************************************************
                                                                        
       01  CONSTANTS.                                                   
                                                                        
           05  C-PGM-SSSHE            PIC X(08) VALUE 'SSSHE'.          
           05  C-PGM-QSPC2            PIC X(08) VALUE 'QSPC2'.          
           05  C-MIL                  PIC S9(7) COMP VALUE +1000000.    
           05  C-SEVENTY              PIC S9(2) COMP VALUE +70.         
                                                                        
      *                                *------------------------------- 
      *                                *  USER  MESSAGE     CODES       
      *                                *------------------------------- 
                                                                        
           05  C-MSG-CA00020           PIC  X(07) VALUE 'CA00020'.      
           05  C-MSG-CS00001           PIC  X(07) VALUE 'CS00001'.      
                                                                        
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
                                                                        
           05  S-READNEXT              PIC X(01)  VALUE LOW-VALUES.     
               88  S-READNEXT-ON                  VALUE HIGH-VALUES.    
                                                                        
           05  S-READNEXT-A            PIC X(01)  VALUE LOW-VALUES.     
               88  S-READNEXT-ON-A                VALUE HIGH-VALUES.    
                                                                        
      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************
       01  WORK-AREAS.                                                  
                                                                        
           05  W-ABEND-FG             PIC  X(01)  VALUE SPACES.         
           05  W-ABSTIME              PIC  S9(15) COMP SYNC VALUE +0.   
           05  W-I                    PIC  S9(04) COMP VALUE ZERO.      
           05  W-IQ                   PIC  S9(04) COMP VALUE ZERO.      
           05  W-K                    PIC  S9(04) COMP VALUE ZERO.      
           05  W-COUNT                PIC  S9(04) COMP VALUE ZERO.      
           05  W-LEN                  PIC  S9(04) COMP VALUE 1712.      
           05  W-SQL                  PIC  ---9   VALUE ZERO.           
           05  W-ASS-YYMM-FR          PIC  X(06)  VALUE SPACE.          
           05  W-IT-CNT               PIC  9(02)  COMP VALUE ZERO.      
           05  W-YYYY-A               PIC  9(04).                       
           05  W-YYYY-B               PIC  9(04).                       
           05  W-YYYY                 PIC  X(04).                       
           05  W-YYYY1      REDEFINES W-YYYY.                           
               10  W-YYYY-RE          PIC  9(04).                       
           05  W-YYYY2                PIC  9(04).                       
           05  W-BUSN-YEAR-TABLE      OCCURS 3 TIMES.                   
               10  W-BUSN-YEAR        PIC  X(04).                       
           05  W-SEQNO                PIC  S9(04) COMP VALUE ZERO.      
           05  W-AMT                  PIC  S9(15) COMP-3.               
           05  W-AMT1                 PIC  S9(15) COMP-3.               
           05  W-LINK-PGM             PIC  X(08).                       
           05  W-CDB-YEAR              PIC  9(04) VALUE ZERO.           
           05  W-CDB-YYMM              PIC  9(04) VALUE ZERO.           
           05  W-BUSNSECT-NM           PIC  X(30) VALUE SPACES.         
           05  W-DETAIL-NM             PIC  X(50) VALUE SPACES.         
                                                                        
       01 W-QSPC2-AREA.                                                 
           10  FILLER                 PIC  X(239) VALUE SPACE.          
           10  W-COMM-SSPC2.                                            
      *                                     PROGRAM-ID                  
               15  W-SSPC2-PROGRAM-ID       PIC  X(08)  VALUE SPACES.   
      *                                    {7Úç                       
               15  W-SSPC2-TXOFF-CD         PIC  X(03)  VALUE SPACES.   
      *                                     USER-ID                     
               15  W-SSPC2-USER-ID          PIC  X(08)  VALUE SPACES.   
      *                                     TERMINAL-ID                 
               15  W-SSPC2-TERMINAL-ID      PIC  X(08)  VALUE SPACES.   
      *                                     ACCESS TYPE(CRUD)           
               15  W-SSPC2-ACCESS-TYPE      PIC  X(01)  VALUE SPACES.   
      *                                     TABLE~?                   
               15  W-SSPC2-TABLE-ID         PIC  X(05)  VALUE SPACES.   
      *                                    ??[¦¼/ID                   
               15  W-SSPC2-TXPAYER-ID       PIC  X(13)  VALUE SPACES.   
      *                                    ??[¦¼/  ?awe               
               15  W-SSPC2-TXPAYER-TP       PIC  X(01)  VALUE SPACES.   
      *                                    ?/?/iE?~æÖKEY              
               15  W-SSPC2-MGMT-NO          PIC  X(35)  VALUE SPACES.   
      *                                     RETURN CODE                 
               15  W-SSPC2-STATUS           PIC  X(01)  VALUE SPACES.   
           05  FILLER                 PIC  X(3513) VALUE SPACE.         
                                                                        
      ***************************************************************** 
      *                                                               * 
      *                 M O D U L E         A R E A                   * 
      *                                                               * 
      ***************************************************************** 
      *                                                                 
      *                                ***********         ************ 
      *                                *         wi¸Ý?V}Ý¤?         * 
      *                                ***********         ************ 
           COPY SSYHE.                                                  
                                                                        
      *                                *************       ************ 
      *                                *     {7Úç?/?b?/iA?/ia  AREA   
      *                                *************       ************ 
       01 W-EFYAA-AREA.                                                 
                                                                        
           COPY                        EFYAA.                           
                                                                        
      *                                ***********         ************ 
      *                                *  HANDLE CONDITION CONSTANTS 1* 
      *                                ***********         ************ 
           COPY SSYBE.                                                  
                                                                        
      ***************************************************************** 
      *                                                                 
      *                 V S A M    I O    A R E A                       
      *                                                                 
      ***************************************************************** 
                                                                        
      *                                *------------------------------- 
      *                                *   u3?vma{/ma?~?/ VSAM        
      *                                *------------------------------- 
           COPY                        BJYAM.                           
                                                                        
      *                                *------------------------------- 
      *                                *        MSG VSAM LAYOUT         
      *                                *------------------------------- 
           COPY                        SUY01.                           
                                                                        
                                                                        
      *                                *------------------------------- 
      *                                *        HELP WORK AREA          
      *                                *------------------------------- 
      *    COPY                        SHY01.                           
                                                                        
      ******************************************************************
      *                                                                *
      *                    D B 2   W O R K   A R E A                   *
      *                                                                *
      ******************************************************************
                                                                        
      *                                ***********         ************ 
      *                                *    SQL COMMUNICATION AREA    * 
      *                                ***********         ************ 
                                                                        
           EXEC SQL  INCLUDE  SQLCA    END-EXEC.                        
                                                                        
      *                                ***********         ************ 
      *                                *    ?/?3?/        I¦»~x?    * 
      *                                ***********         ************ 
                                                                        
           EXEC SQL  INCLUDE  TAOAA    END-EXEC.                        
                                                                        
      *                                ***********         ************ 
      *                                *    ÚÖ[?          I¦»~x?    * 
      *                                ***********         ************ 
                                                                        
           EXEC SQL  INCLUDE  TJOAC    END-EXEC.                        
                                                                        
      *                                ***********         ************ 
      *                                *    ÚÖ[?          I¦»~x?    * 
      *                                ***********         ************ 
                                                                        
           EXEC SQL  INCLUDE  TJOAB    END-EXEC.                        
                                                                        
      ******************************************************************
      *                                                                *
      *           D E C L A R E      C U R S O R                        
      *                                                                *
      ******************************************************************
                                                                        
           EXEC SQL                                                     
                DECLARE  CURSOR_1  CURSOR FOR                           
                 SELECT  CD_ID2,                                        
                         DECODE                                         
                   FROM  DTJA.TTJAB                                     
                  WHERE  CD_ID1             = :TTJAB.CD-ID1             
                    AND  CD_ID2    LIKE     '01%'                       
               ORDER BY  CD_ID1, CD_ID2                                 
           END-EXEC.                                                    
                                                                        
                                                                        
      *                                ***********         ************ 
      *                                *  PROGRAM SELF COMM AREA      * 
      *                                ***********         ************ 
                                                                        
      *    COPY EFY4A.                                                  
                                                                        
       01  W-COMM-AREA.                                                 
                                                                        
       05  W-SYSTEM-COMMON.                                             
      *                                     CALLING PGM ID              
           10  W-COMM-CALLING-PROGRAM       PIC  X(05)  VALUE SPACES.   
      *                                     STEP                        
           10  W-COMM-STEP                  PIC  9(02)  VALUE ZEROS.    
      *                                     USERID                      
           10  W-COMM-USERID                PIC  X(08)  VALUE SPACES.   
      *                                    m?mÖ¼/E~p/                 
           10  W-COMM-TX-OFFCR-CD.                                      
      *                                    m?mÖ¼/E~p/(iA)           
               15  W-COMM-TX-OFFCR-CD-DEPT  PIC  X(01)  VALUE SPACE.    
      *                                    m?mÖ¼/E~p/(ia)           
               15  W-COMM-TX-OFFCR-CD-SECT  PIC  X(01)  VALUE SPACE.    
      *                                    m?mÖ¼/E~p/(Úç¹¬)         
               15  W-COMM-TX-OFFCR-CD-RANK  PIC  X(02)  VALUE SPACES.   
      *                                    [?saÚç                     
           10  W-COMM-TXOFF-CD              PIC  X(03)  VALUE SPACES.   
      *                                    ?~?/maÚÖ?/KEY              
           10  W-COMM-KEY-1.                                            
      *                                    [?~sE~p/                   
               15  W-TEAAA-TXTP-CD          PIC  X(02).                 
      *                                    ?V?7jÝæz                   
               15  W-TEAAA-SELECT-YYMM      PIC  X(06).                 
      *                                    ?~?/maÚÖ?/uVJ~             
               15  W-TEAAA-IVST-TARGET-NO   PIC  X(13).                 
      *                                    ?~?/??[¦¼/?awe             
               15  W-TEAAA-TXPAYER-TP       PIC  X(01).                 
      *                                    ?V?7jÝæz                   
               15  W-TEAAA-SELECT-SEQNO     PIC S9(04) COMP VALUE +0.   
      *                                    i¬¼7i¬»aKEY                
           10  W-COMM-KEY-2.                                            
      *                                    [?~sE~p/                   
               15  W-TEFFA-TXTP-CD          PIC  X(02) VALUE SPACES.    
      *                                    iA[¦¤~h?                   
               15  W-TEFFA-ASS-YYMM-FR      PIC  X(06) VALUE SPACES.    
      *                                    ??[¦¼/uVJ~                 
               15  W-TEFFA-RESID-BUSNID     PIC  X(13) VALUE SPACES.    
      *                                    ??[¦¼/?awe                 
               15  W-TEFFA-TXPAYER-TP       PIC  X(01) VALUE SPACES.    
      *                                    ?vi~?awe                   
               15  W-TEFFA-RTN-TP           PIC  X(01) VALUE SPACES.    
      *                                    i¬¼7?z??uVJ~               
               15  W-TEFFA-DETRM-SEQNO      PIC S9(04) COMP VALUE +0.   
      *                                    m?A~?/?/REC                
           10  W-COMM-INIT-REC.                                         
      *                                    m?A~?awe                   
               15  W-COMM-INIT-TP           PIC  X(01) VALUE SPACE.     
      *                                    i¬¼7?z??uVJ~?(m?A~?)       
               15  W-COMM-DETRM-SEQNO-INIT  PIC S9(04) COMP VALUE +0.   
      *                                    ?vi~?awe?(?vi~?)           
               15  W-TRIAA-RTN-TP           PIC  X(01) VALUE SPACE.     
      *                                    ?vi~{/?a?(?vi~?)           
               15  W-TRIAA-RTN-SERIAL-NO    PIC S9(04) COMP VALUE +0.   
      *                                    ?e{/uVJ~?(?vi~?)           
               15  W-TRIAA-SERIAL-NO        PIC S9(04) COMP VALUE +0.   
      *                                     RETURN CODE                 
           10  W-COMM-RC                    PIC  X(04).                 
      *                                     SQLCODE                     
           10  W-COMM-SQL          REDEFINES W-COMM-RC.                 
               15  FILLER                   PIC  -(04).                 
      *                                     MESSAGE                     
           10  W-COMM-MSG                   PIC  X(66)  VALUE SPACES.   
      *                                    i»Î?                       
           10  W-COMM-FILLER                PIC  X(51)  VALUE SPACES.   
      *                                     PROGRAM SELF COMMAREA     
       05  W-COMM-PGM-RR.                                               
                                                                        
      *      ?/?3?/uVJ~                                               
              10  W-HEAD-BUSNID                PIC X(10).               
      *      ?/?3j?n~?(m?}aj?n~?)                                     
              10  W-HEAD-BUSN-YEAR             PIC X(04).               
      *      ?/?3j?n~?(?Vj?n~?)                                       
              10  W-CM-BUSN-YEAR-BE            PIC X(04).               
      *      ?/?3j?n~?(?V?Vj?n~?)                                     
              10  W-CM-BUSN-YEAR-BBE           PIC X(04).               
      *      A?hV?a                                                   
              10  W-HEAD-OCC-CNT               PIC S9(03) COMP.         
      *      u3?v~?                                                   
              10  W-CM-TRADE-NM                PIC X(30).               
      *      ?3½»E~p/?(m?}a?)                                         
              10  W-CM-BUSNTP-CD               PIC X(07).               
      *      ?3½»~Öá(m?}a?)                                           
              10  W-CM-BUSNSECT-NM             PIC X(30).               
      *      ?3Ha~Öá(m?}a?)                                           
              10  W-CM-DETAIL-NM               PIC X(50).               
      *      ?3½»E~p/?(?V?)                                           
              10  W-CM-BUSNTP-CD-BE            PIC X(07).               
      *      ?3½»~Öá(?V?)                                             
              10  W-CM-BUSNSECT-NM-BE          PIC X(30).               
      *      ?3Ha~Öá(?V?)                                             
              10  W-CM-DETAIL-NM-BE            PIC X(50).               
      *      ?3½»E~p/?(?V?V?)                                         
              10  W-CM-BUSNTP-CD-BBE           PIC X(07).               
      *      ?3½»~Öá(?V?V?)                                           
              10  W-CM-BUSNSECT-NM-BBE         PIC X(30).               
      *      ?3Ha~Öá(?V?V?)                                           
              10  W-CM-DETAIL-NM-BBE           PIC X(50).               
              10  W-CM-DATA      OCCURS   70   TIMES.                   
      *          ia?7iA~s                                             
                  15  W-CM-NM                  PIC X(30).               
      *          m?}a?(??b?,m?}a??,?V?b??,Ba[?x~?)                 
                  15  W-CM-AMT                 PIC S9(10) COMP-3.       
                  15  W-CM-AMT-RATE            PIC S999V9 COMP-3.       
                  15  W-CM-CNT-RATE            PIC S999V9 COMP-3.       
                  15  W-CM-TRE-RATE            PIC S999V9 COMP-3.       
      *          ?VjÝá(??b?,m?}a??,?V?b??,Ba[?x~?)                 
                  15  W-CM-AMT-BE              PIC S9(10) COMP-3.       
                  15  W-CM-AMT-RATE-BE         PIC S999V9 COMP-3.       
                  15  W-CM-CNT-RATE-BE         PIC S999V9 COMP-3.       
                  15  W-CM-TRE-RATE-BE         PIC S999V9 COMP-3.       
      *          ?V?VjÝá(??b?,m?}a??,?V?b??,Ba[?x~?)               
                  15  W-CM-AMT-BBE             PIC S9(10) COMP-3.       
                  15  W-CM-AMT-RATE-BBE        PIC S999V9 COMP-3.       
                  15  W-CM-CNT-RATE-BBE        PIC S999V9 COMP-3.       
                  15  W-CM-TRE-RATE-BBE        PIC S999V9 COMP-3.       
              10  W-RESULT-RC                  PIC X(001).              
                                                                        
      ***************************************************************** 
      *                                                               * 
      *           E N D   O F  W O R K I N G  S T O R A G E           * 
      *                                                               * 
      ***************************************************************** 
                                                                        
       01  WS-END                      PIC X(40)                        
           VALUE 'MAPML - WORKING STORAGE ENDS HERE'.                   
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
                                                                        
           05  L-COMM-AREA             PIC  X(5766).                    
                                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *              P R O C E D U R E   D I V I S I O N               *
      *                                                                *
      ******************************************************************
                                                                        
       PROCEDURE                       DIVISION.                        
                                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *                  I N I T I A L I Z A T I O N                   *
      *                                                                *
      *    -?v?/?vJA~Ý¹¦Ú?p¬¸ç¹vDATA??  u?l?m/                 *
      *                                                                *
      ******************************************************************
                                                                        
       INITIALIZATION                  SECTION.                         
                                                                        
           MOVE  DFHCOMMAREA          TO W-COMM-AREA.                   
                                                                        
      ******************************************************************
      *                                                                *
      *                  M  A  I  N  L  I  N  E                        *
      *                                                                *
      ******************************************************************
                                                                        
       MAINLINE                        SECTION.                         
                                                                        
           IF  W-COMM-CALLING-PROGRAM  NOT =  'QSPC4'                   
                                                                        
               PERFORM  S0300-INITIALIZE                                
                                                                        
               PERFORM  S0100-MAIN-PROCESS                              
           END-IF.                                                      
                                                                        
       EJECT                                                            
                                                                        
      ******************************************************************
      *                                                                *
      *                    F I N A L I Z A T I O N                     *
      *                                                                *
      *        - CICS RETURN                                           *
      *                                                                *
      ******************************************************************
                                                                        
       FINALIZATION                    SECTION.                         
                                                                        
      *   ~?[¦Ù~?aæÖ  ?~K¦¼ß¸3                                        
           IF  W-COMM-MSG              =  SPACE                         
               PERFORM  S2500-READ-SUV010                               
           END-IF.                                                      
                                                                        
      * ERROR  CHECK                                                    
      *    B¦½?i?iAJB?v(HOST --> WEB )                                
                                                                        
           IF  NOT A-ERROR-COUNT-ZERO  AND                              
               W-COMM-RC               =  SPACES  OR  LOW-VALUE         
               MOVE  'RC01'            TO W-COMM-RC                     
           ELSE                                                         
               MOVE  SPACES            TO W-COMM-RC                     
           END-IF.                                                      
                                                                        
           MOVE  W-COMM-AREA           TO DFHCOMMAREA.                  
                                                                        
           PERFORM  S2600-RETURN.                                       
                                                                        
       EJECT                                                            
                                                                        
      ******************************************************************
      *                     S U B R O U T I N E S                      *
      ******************************************************************
      ******************************************************************
      *                                                                *
      *               S 0 1 0 0 - M A I N - P R O C E S S              *
      *                                                                *
      ******************************************************************
                                                                        
       S0100-MAIN-PROCESS              SECTION.                         
                                                                        
      *    HEAD wawe  »·??}?~s ==> START ?~K?                       
           PERFORM  S0200-ONE-PROCESS.                                  
                                                                        
       S0100-MAIN-PROCESS-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *               S 0 2 0 0 - O N E - P R O C E S S                *
      *                                                                *
      ******************************************************************
                                                                        
       S0200-ONE-PROCESS               SECTION.                         
                                                                        
           MOVE W-HEAD-BUSN-YEAR       TO W-YYYY                        
           MOVE W-HEAD-BUSNID          TO BJVAM0-BUSNID.                
           MOVE W-YYYY                 TO BJVAM0-BUSN-YEAR.             
           PERFORM  S0900-NXREAD-BJVAM0.                                
           PERFORM  S0500-TS-BUILD.                                     
           MOVE W-BUSN-YEAR(1)         TO BJVAM0-BUSN-YEAR.             
           MOVE W-BUSN-YEAR(1)         TO W-HEAD-BUSN-YEAR.             
           MOVE W-HEAD-BUSNID          TO BJVAM0-BUSNID.                
           PERFORM  S0400-BJVAM0-READ.                                  
           IF   W-RETURN-NORMAL                                         
                MOVE C-SEVENTY         TO W-HEAD-OCC-CNT                
                PERFORM  S1500-DATA-CM-MOVE                             
      *?~?siE?~                                                       
                PERFORM S2300-QSPC2-MOVE                                
                PERFORM S2400-LINK-QSPC2                                
                                                                        
                MOVE C-MSG-CS00001     TO W-MSG-ID                      
      *        ?~K?h/  o¦¸6ù°l~m/?.                                   
                                                                        
           ELSE                                                         
                ADD  1                 TO A-ERROR-COUNT                 
           END-IF.                                                      
                                                                        
       S0200-ONE-PROCESS-EXIT.                                          
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *               S 0 3 0 0 - I N I T I A L I Z E                  *
      *                                                                *
      ******************************************************************
                                                                        
       S0300-INITIALIZE                SECTION.                         
                                                                        
           PERFORM  VARYING  W-I   FROM  1      BY  1                   
                                         UNTIL  W-I >  C-SEVENTY        
                    MOVE SPACE           TO  W-CM-NM(W-I)               
                    MOVE ZERO            TO  W-CM-AMT(W-I)              
                                             W-CM-AMT-RATE(W-I)         
                                             W-CM-CNT-RATE(W-I)         
                                             W-CM-TRE-RATE(W-I)         
                                             W-CM-AMT-BE(W-I)           
                                             W-CM-AMT-RATE-BE(W-I)      
                                             W-CM-CNT-RATE-BE(W-I)      
                                             W-CM-TRE-RATE-BE(W-I)      
                                             W-CM-AMT-BBE(W-I)          
                                             W-CM-AMT-RATE-BBE(W-I)     
                                             W-CM-CNT-RATE-BBE(W-I)     
                                             W-CM-TRE-RATE-BBE(W-I)     
                                                                        
           END-PERFORM.                                                 
                                                                        
       S0300-INITIALIZE-EXIT.                                           
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 0 4 0 0 - B J V A M 0 - R E A D                  *
      *                                                                *
      ******************************************************************
                                                                        
       S0400-BJVAM0-READ              SECTION.                          
                                                                        
           EXEC CICS READ              FILE     ('BJVAM0')              
                                       INTO     (BJVAM0-R)              
                                       LENGTH   (W-LEN)                 
                                       RIDFLD   (BJVAM0-KEY)            
                                       RESP     (W-RETURN-CODE)         
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL         OR                               
               W-RETURN-NOTFND                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD   1                    TO  A-ERROR-COUNT             
               MOVE  W-RETURN-CODE        TO  W-SQL                     
               MOVE  W-SQL                TO  W-COMM-RC                 
               MOVE  'S0900-BJVAM0-READ'  TO  W-COMM-MSG                
           END-IF.                                                      
                                                                        
       S0900-READ-EXIT.                                                 
           EXIT.                                                        
           EJECT                                                        
      ***************************************************************** 
      *                                                               * 
      *             S 0 5 0 0 - T S - B U I L D                       * 
      *                                                               * 
      ***************************************************************** 
       S0500-TS-BUILD                  SECTION.                         
                                                                        
           MOVE     1                  TO  W-IQ.                        
                                                                        
           MOVE     W-HEAD-BUSNID      TO  BJVAM0-BUSNID.               
           MOVE     SPACE              TO  BJVAM0-BUSN-YEAR.            
           PERFORM  S0600-STARTBR.                                      
                                                                        
           IF  W-RETURN-NOTFND                                          
               CONTINUE                                                 
           ELSE                                                         
               MOVE  W-HEAD-BUSNID     TO BJVAM0-BUSNID                 
               MOVE  W-HEAD-BUSN-YEAR  TO BJVAM0-BUSN-YEAR              
               PERFORM  UNTIL S-READNEXT-ON OR W-IQ > 3                 
                  PERFORM  S0700-READNEXT-BJVAM0                        
                                                                        
                  EVALUATE   W-RETURN-CODE                              
                                                                        
                      WHEN   +00                                        
                                                                        
                             IF  W-HEAD-BUSNID   =   BJVAM0-BUSNID      
                             MOVE  BJVAM0-BUSN-YEAR TO W-BUSN-YEAR(W-IQ)
                             ADD   +1               TO W-IQ             
                             ELSE                                       
                             MOVE     HIGH-VALUES   TO S-READNEXT       
                             END-IF                                     
                                                                        
                      WHEN   +20                                        
                                                                        
                             MOVE     HIGH-VALUES   TO S-READNEXT       
                                                                        
                      WHEN  OTHER                                       
                                                                        
                             ADD   1                TO  A-ERROR-COUNT   
                             MOVE     HIGH-VALUES   TO S-READNEXT       
                                                                        
                  END-EVALUATE                                          
                                                                        
               END-PERFORM                                              
                                                                        
               PERFORM  S0800-ENDBR                                     
                                                                        
           END-IF.                                                      
                                                                        
       S0500-TS-BUILD-EXIT.                                             
           EXIT.                                                        
           EJECT                                                        
      ***************************************************************** 
      *                        S0600-STARTBR                            
      ***************************************************************** 
       S0600-STARTBR                   SECTION.                         
                                                                        
           EXEC CICS STARTBR           FILE        ('BJVAM0')           
                                       RIDFLD      (BJVAM0-R)           
      *                                GENERIC                          
      *                                KEYLENGTH   (10)                 
                                       GTEQ                             
                                       RESP        (W-RETURN-CODE)      
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL         OR                               
               W-RETURN-NOTFND                                          
               CONTINUE                                                 
           ELSE                                                         
               ADD   1                 TO  A-ERROR-COUNT                
           END-IF.                                                      
                                                                        
       S0600-STARTBR-EXIT.                                              
           EXIT.                                                        
           EJECT                                                        
      ***************************************************************** 
      *                                                                 
      *                   S0700-READNEXT-BJVAM0                         
      *                                                                 
      ***************************************************************** 
       S0700-READNEXT-BJVAM0           SECTION.                         
                                                                        
           EXEC CICS READPREV          FILE       ('BJVAM0')            
                                       INTO       (BJVAM0-R)            
                                       LENGTH     (W-LEN)               
                                       RIDFLD     (BJVAM0-KEY)          
      *                                KEYLENGTH  (14)                  
                                       RESP       (W-RETURN-CODE)       
           END-EXEC.                                                    
                                                                        
       S0700-READNEXT-BJVAM0-EXIT.                                      
           EXIT.                                                        
           EJECT                                                        
      ***************************************************************** 
      *                                                                 
      *                  5430-ENDBR                                   * 
      *                                                                 
      ***************************************************************** 
       S0800-ENDBR                     SECTION.                         
                                                                        
           EXEC    CICS ENDBR          FILE   ('BJVAM0')                
           END-EXEC.                                                    
                                                                        
       S0800-ENDBR-EXIT.                                                
           EXIT.                                                        
      ***************************************************************** 
      *                                                                *
      *             S 2 2 2 2 - N X R E A D - B J V A N 0              *
      *                                                                *
      ******************************************************************
                                                                        
       S0900-NXREAD-BJVAM0             SECTION.                         
                                                                        
                                                                        
           PERFORM  S0400-BJVAM0-READ.                                  
                                                                        
           IF       W-RETURN-NOTFND                                     
                                                                        
           PERFORM  VARYING  W-IT-CNT FROM 1 BY 1                       
                    UNTIL  W-IT-CNT > 9   OR    S-READNEXT-ON-A         
                                                                        
               MOVE  W-YYYY                TO  W-YYYY-A                 
               COMPUTE W-YYYY-B  = W-YYYY-A  -  W-IT-CNT                
               MOVE  W-YYYY-B              TO  BJVAM0-BUSN-YEAR         
               MOVE  W-HEAD-BUSNID         TO  BJVAM0-BUSNID            
                                                                        
               PERFORM S0400-BJVAM0-READ                                
                                                                        
               IF    W-RETURN-NORMAL                                    
                     MOVE  HIGH-VALUE      TO  S-READNEXT-A             
                     MOVE  0               TO  A-ERROR-COUNT            
               ELSE                                                     
                     ADD   1               TO  A-ERROR-COUNT            
               END-IF                                                   
                                                                        
           END-PERFORM                                                  
                                                                        
           IF        A-ERROR-COUNT-ZERO                                 
                     MOVE BJVAM0-BUSN-YEAR TO W-HEAD-BUSN-YEAR          
           ELSE                                                         
                     MOVE C-MSG-CA00020    TO W-MSG-ID                  
           END-IF                                                       
                                                                        
           END-IF.                                                      
                                                                        
       S0900-NXREAD-BJVAM0-EXIT.                                        
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *                 S 1 0 0 0 - O P E N - T T J A B                *
      *                                                                *
      ******************************************************************
                                                                        
       S1000-OPEN-TTJAB                  SECTION.                       
                                                                        
           EXEC SQL OPEN CURSOR_1                                       
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-CODE = C-SQL-NORMAL                             
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
                                                                        
               ADD   1                    TO  A-ERROR-COUNT             
               MOVE  W-RETURN-CODE        TO  W-SQL                     
               MOVE  W-SQL                TO  W-COMM-RC                 
               MOVE  'S1100-OPEN-TTJAB'   TO  W-COMM-MSG                
                                                                        
           END-IF.                                                      
                                                                        
       S1000-OPEN-TTJAB-EXIT.                                           
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                S 1 1 0 0 - F E T C H - T T J A B               *
      *                                                                *
      ******************************************************************
                                                                        
       S1100-FETCH-TTJAB                 SECTION.                       
                                                                        
           EXEC SQL  FETCH  CURSOR_1                                    
                     INTO  :TTJAB.CD-ID2,                               
                           :TTJAB.DECODE                                
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL OR                                
                         C-SQL-NOTFND                                   
               CONTINUE                                                 
           ELSE                                                         
                                                                        
               ADD   1                    TO  A-ERROR-COUNT             
               MOVE  SQLCODE              TO  W-SQL                     
               MOVE  W-SQL                TO  W-COMM-RC                 
               MOVE  'S1200-FETCH-TTJAB'  TO  W-COMM-MSG                
                                                                        
           END-IF.                                                      
                                                                        
       S1100-FETCH-TTJAB-EXIT.                                          
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                S 1 2 0 0 - C L O S E - T T J A B               *
      *                                                                *
      ******************************************************************
                                                                        
       S1200-CLOSE-TTJAB                 SECTION.                       
                                                                        
           EXEC SQL CLOSE CURSOR_1                                      
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL                                   
               CONTINUE                                                 
           ELSE                                                         
                                                                        
               ADD   1                    TO  A-ERROR-COUNT             
               MOVE  SQLCODE              TO  W-SQL                     
               MOVE  W-SQL                TO  W-COMM-RC                 
               MOVE  'S1300-CLOSE-TTJAB'  TO  W-COMM-MSG                
                                                                        
           END-IF.                                                      
                                                                        
       S1200-CLOSE-TTJAB-EXIT.                                          
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *             S 1 3 0 0 - T T A A A - S E L E C T                *
      *                                                                *
      ******************************************************************
                                                                        
       S1300-TTAAA-SELECT              SECTION.                         
                                                                        
           EXEC SQL SELECT  TRADE_NM                                    
                      INTO :TRADE-NM                                    
                      FROM  DTAA.TTAAA                                  
                      WHERE BUSNID        = :TTAAA.BUSNID               
                        AND LAST_FG       = 'Y'                         
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE   =  C-SQL-NORMAL  OR                            
               SQLCODE   =  C-SQL-NOTFND                                
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
                                                                        
               ADD   1                    TO  A-ERROR-COUNT             
               MOVE  SQLCODE              TO  W-SQL                     
               MOVE  W-SQL                TO  W-COMM-RC                 
               MOVE  'S1700-TTAAA-SELECT' TO  W-COMM-MSG                
                                                                        
           END-IF.                                                      
                                                                        
       S1300-TTAAA-SELECT-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *             S 1 4 0 0 - T T J A C - S E L E C T                *
      *                                                                *
      ******************************************************************
                                                                        
       S1400-TTJAC-SELECT              SECTION.                         
                                                                        
                                                                        
           MOVE  BJVAM0-BUSN-YEAR(1:4)    TO ATTRIBUTE-YEAR OF TTJAC.   
           MOVE  BJVAM0-YEAR-BUSNTP-CD    TO STD-INCM-RT-CD OF TTJAC.   
                                                                        
           PERFORM S2200-DB-TTJAC-READ.                                 
           IF  SQLCODE = -811  OR SQLCODE = C-SQL-NORMAL                
               CONTINUE                                                 
           ELSE                                                         
               MOVE  BJVAM0-BUSN-YEAR(1:4) TO W-CDB-YYMM                
               COMPUTE W-CDB-YEAR = W-CDB-YYMM - 1                      
               MOVE  W-CDB-YEAR           TO ATTRIBUTE-YEAR OF TTJAC    
           END-IF.                                                      
                                                                        
           PERFORM S2100-DB-TTJAC-READ.                                 
                                                                        
           IF  SQLCODE = C-SQL-NORMAL                                   
                                                                        
               MOVE BUSNSECT-NM  OF TTJAC  TO W-BUSNSECT-NM             
               MOVE DETAIL-NM    OF TTJAC  TO W-DETAIL-NM               
                                                                        
           ELSE                                                         
                                                                        
                   IF  SQLCODE = C-SQL-NOTFND  AND                      
                       BJVAM0-YEAR-BUSNTP-CD  = '999999'                
                                                                        
                       MOVE ' XXXXXXX '         TO W-BUSNSECT-NM       
                       MOVE ' XXXXXXX '         TO W-DETAIL-NM         
                                                                        
                   ELSE                                                 
                                                                        
                       MOVE '*************'        TO W-BUSNSECT-NM     
                       MOVE '*************'        TO W-DETAIL-NM       
                                                                        
                   END-IF                                               
                                                                        
           END-IF.                                                      
                                                                        
       S1400-TTJAC-SELECT-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *             S 2 0 0 0 - O N E - D A T A - C M - M O V E        *
      *                                                                *
      ******************************************************************
                                                                        
       S1500-DATA-CM-MOVE              SECTION.                         
                                                                        
           MOVE W-HEAD-BUSNID          TO BUSNID  OF TTAAA.             
           PERFORM  S1300-TTAAA-SELECT.                                 
                                                                        
           IF  SQLCODE   =  C-SQL-NORMAL                                
                                                                        
      *       u3?v~?                                                  
               INITIALIZE  W-SSSHE-AREA                                 
               MOVE  TRADE-NM OF TTAAA  TO  W-SSSHE-I-DATA              
               MOVE  +30                TO  W-SSSHE-I-LENGTH            
               CALL  C-PGM-SSSHE    USING   W-SSSHE-AREA                
                                                                        
               IF  W-SSSHE-STATUS  =  SPACES                            
                   MOVE  W-SSSHE-I-DATA TO  W-CM-TRADE-NM               
                                                                        
               ELSE                                                     
                   MOVE  SPACE          TO  W-CM-TRADE-NM               
                                                                        
               END-IF                                                   
                                                                        
           ELSE                                                         
               MOVE SPACE               TO  W-CM-TRADE-NM               
           END-IF.                                                      
                                                                        
      *   ?3½»E~p/?(m?}a?)                                            
           MOVE BJVAM0-YEAR-BUSNTP-CD   TO  W-CM-BUSNTP-CD.             
                                                                        
           PERFORM  S1400-TTJAC-SELECT.                                 
                                                                        
      *   m?}aj?n~{çþ~                                                
           PERFORM  S1600-DATA-MOVE.                                    
                                                                        
      *   ?Vj?n~{çþ~                                                  
           IF   W-BUSN-YEAR(2)     NOT =  SPACE                         
                MOVE W-BUSN-YEAR(2)    TO BJVAM0-BUSN-YEAR              
                MOVE W-HEAD-BUSNID     TO BJVAM0-BUSNID                 
                PERFORM  S0400-BJVAM0-READ                              
                IF   W-RETURN-NORMAL                                    
                     PERFORM  S1400-TTJAC-SELECT                        
                     PERFORM  S1700-BE-DATA-MOVE                        
                END-IF                                                  
           ELSE                                                         
                ADD  1                 TO A-ERROR-COUNT                 
           END-IF.                                                      
                                                                        
      *   ?V?(?V?)j?n~{çþ~                                            
           IF   W-BUSN-YEAR(3)     NOT =  SPACE                         
                MOVE W-BUSN-YEAR(3)    TO BJVAM0-BUSN-YEAR              
                MOVE W-HEAD-BUSNID     TO BJVAM0-BUSNID                 
                PERFORM  S0400-BJVAM0-READ                              
                IF   W-RETURN-NORMAL                                    
                     PERFORM  S1400-TTJAC-SELECT                        
                     PERFORM  S1900-BBE-DATA-MOVE                       
                END-IF                                                  
           ELSE                                                         
                ADD  1                 TO A-ERROR-COUNT                 
           END-IF.                                                      
                                                                        
       S1500-DATA-CM-MOVE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 1 6 0 0 - D A T A - M O V E                       *
      *                                                                *
      ******************************************************************
                                                                        
       S1600-DATA-MOVE                  SECTION.                        
                                                                        
      *   ia?7iA~s                                                    
           MOVE '231'                   TO  CD-ID1   OF TTJAB.          
           PERFORM  S1000-OPEN-TTJAB.                                   
           PERFORM  VARYING  W-I   FROM  1      BY  1                   
                                         UNTIL  W-I >  C-SEVENTY        
                                                                        
              PERFORM  S1100-FETCH-TTJAB                                
                                                                        
              IF  SQLCODE = C-SQL-NORMAL                                
                                                                        
                  INITIALIZE  W-SSSHE-AREA                              
                  MOVE  DECODE   OF TTJAB  TO  W-SSSHE-I-DATA           
                  MOVE  +30                TO  W-SSSHE-I-LENGTH         
                  CALL  C-PGM-SSSHE    USING   W-SSSHE-AREA             
                                                                        
                  IF    W-SSSHE-STATUS  =  SPACES                       
                                                                        
                        MOVE  W-SSSHE-I-DATA TO  W-CM-NM(W-I)           
                                                                        
                  ELSE                                                  
                                                                        
                        MOVE  SPACE          TO  W-CM-NM(W-I)           
                                                                        
                  END-IF                                                
                                                                        
              ELSE                                                      
                                                                        
                  MOVE  SPACE            TO  W-CM-NM(W-I)               
              END-IF                                                    
                                                                        
           END-PERFORM.                                                 
                                                                        
           PERFORM  S1200-CLOSE-TTJAB.                                  
                                                                        
           MOVE W-BUSNSECT-NM           TO W-CM-BUSNSECT-NM.            
           MOVE W-DETAIL-NM             TO W-CM-DETAIL-NM.              
                                                                        
      *   ??b                                                        
           IF   BJVAM0-YEAR-AMT(01)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(01)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(01)   =  BJVAM0-YEAR-AMT(01)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(02)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(02)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(02)   =  BJVAM0-YEAR-AMT(02)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(03)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(03)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(03)   =  BJVAM0-YEAR-AMT(03)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(04)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(04)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(04)   =  BJVAM0-YEAR-AMT(04)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(05)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(05)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(05)   =  BJVAM0-YEAR-AMT(05)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(06)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(06)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(06)   =  BJVAM0-YEAR-AMT(06)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(07)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(07)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(07)   =  BJVAM0-YEAR-AMT(07)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(08)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(08)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(08)   =  BJVAM0-YEAR-AMT(08)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(09)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(09)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(09)   =  BJVAM0-YEAR-AMT(09)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(10)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(10)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(10)   =  BJVAM0-YEAR-AMT(10)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(11)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(11)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(11)   =  BJVAM0-YEAR-AMT(11)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(12)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(12)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(12)   =  BJVAM0-YEAR-AMT(12)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(13)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(13)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(13)   =  BJVAM0-YEAR-AMT(13)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(14)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(14)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(14)   =  BJVAM0-YEAR-AMT(14)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(15)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(15)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(15)   =  BJVAM0-YEAR-AMT(15)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(16)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(16)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(16)   =  BJVAM0-YEAR-AMT(16)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(17)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(17)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(17)   =  BJVAM0-YEAR-AMT(17)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(18)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(18)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(18)   =  BJVAM0-YEAR-AMT(18)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(19)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(19)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(19)   =  BJVAM0-YEAR-AMT(19)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(20)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(20)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(20)   =  BJVAM0-YEAR-AMT(20)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(21)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(21)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(21)   =  BJVAM0-YEAR-AMT(21)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(22)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(22)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(22)   =  BJVAM0-YEAR-AMT(22)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(23)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(23)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(23)   =  BJVAM0-YEAR-AMT(23)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(24)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(24)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(24)   =  BJVAM0-YEAR-AMT(24)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(25)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(25)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(25)   =  BJVAM0-YEAR-AMT(25)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(26)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(26)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(26)   =  BJVAM0-YEAR-AMT(26)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(27)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(27)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(27)   =  BJVAM0-YEAR-AMT(27)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(28)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(28)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(28)   =  BJVAM0-YEAR-AMT(28)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(29)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(29)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(29)   =  BJVAM0-YEAR-AMT(29)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(30)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(30)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(30)   =  BJVAM0-YEAR-AMT(30)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(31)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(31)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(31)   =  BJVAM0-YEAR-AMT(31)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(32)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(32)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(32)   =  BJVAM0-YEAR-AMT(32)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(33)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(33)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(33)   =  BJVAM0-YEAR-AMT(33)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(34)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(34)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(34)   =  BJVAM0-YEAR-AMT(34)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(35)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(35)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(35)   =  BJVAM0-YEAR-AMT(35)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(35)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(35)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(35)   =  BJVAM0-YEAR-AMT(35)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(36)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(36)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(36)   =  BJVAM0-YEAR-AMT(36)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(37)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(37)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(37)   =  BJVAM0-YEAR-AMT(37)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(38)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(38)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(38)   =  BJVAM0-YEAR-AMT(38)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(39)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(39)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(39)   =  BJVAM0-YEAR-AMT(39)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(40)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(40)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(40)   =  BJVAM0-YEAR-AMT(40)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(41)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(41)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(41)   =  BJVAM0-YEAR-AMT(41)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(42)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(42)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(42)   =  BJVAM0-YEAR-AMT(42)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(43)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(43)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(43)   =  BJVAM0-YEAR-AMT(43)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(44)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(44)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(44)   =  BJVAM0-YEAR-AMT(44)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(45)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(45)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(45)   =  BJVAM0-YEAR-AMT(45)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(46)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(46)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(46)   =  BJVAM0-YEAR-AMT(46)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(47)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(47)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(47)   =  BJVAM0-YEAR-AMT(47)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(48)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(48)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(48)   =  BJVAM0-YEAR-AMT(48)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(49)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(49)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(49)   =  BJVAM0-YEAR-AMT(49)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(50)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(50)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(50)   =  BJVAM0-YEAR-AMT(50)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(51)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(51)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(51)   =  BJVAM0-YEAR-AMT(51)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(52)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(52)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(52)   =  BJVAM0-YEAR-AMT(52)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(53)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(53)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(53)   =  BJVAM0-YEAR-AMT(53)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(54)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(54)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(54)   =  BJVAM0-YEAR-AMT(54)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(55)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(55)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(55)   =  BJVAM0-YEAR-AMT(55)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(56)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(56)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(56)   =  BJVAM0-YEAR-AMT(56)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(57)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(57)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(57)   =  BJVAM0-YEAR-AMT(57)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(58)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(58)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(58)   =  BJVAM0-YEAR-AMT(58)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(59)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(59)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(59)   =  BJVAM0-YEAR-AMT(59)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(60)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(60)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(60)   =  BJVAM0-YEAR-AMT(60)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(61)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(61)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(61)   =  BJVAM0-YEAR-AMT(61)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(62)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(62)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(62)   =  BJVAM0-YEAR-AMT(62)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(63)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(63)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(63)   =  BJVAM0-YEAR-AMT(63)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(64)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(64)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(64)   =  BJVAM0-YEAR-AMT(64)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(65)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(65)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(65)   =  BJVAM0-YEAR-AMT(65)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(66)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(66)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(66)   =  BJVAM0-YEAR-AMT(66)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(67)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(67)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(67)   =  BJVAM0-YEAR-AMT(67)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(68)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(68)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(68)   =  BJVAM0-YEAR-AMT(68)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(69)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(69)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(69)   =  BJVAM0-YEAR-AMT(69)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(70)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT(70)                 
           ELSE                                                         
                COMPUTE  W-CM-AMT(70)   =  BJVAM0-YEAR-AMT(70)/ C-MIL   
           END-IF.                                                      
                                                                        
      *   m?}a??(m?}a?)                                              
           MOVE BJVAM0-YEAR-RATE(01)    TO W-CM-AMT-RATE(01) .          
           MOVE BJVAM0-YEAR-RATE(02)    TO W-CM-AMT-RATE(02) .          
           MOVE BJVAM0-YEAR-RATE(03)    TO W-CM-AMT-RATE(03) .          
           MOVE BJVAM0-YEAR-RATE(04)    TO W-CM-AMT-RATE(04) .          
           MOVE BJVAM0-YEAR-RATE(05)    TO W-CM-AMT-RATE(05) .          
           MOVE BJVAM0-YEAR-RATE(06)    TO W-CM-AMT-RATE(06) .          
           MOVE BJVAM0-YEAR-RATE(07)    TO W-CM-AMT-RATE(07) .          
           MOVE BJVAM0-YEAR-RATE(08)    TO W-CM-AMT-RATE(08) .          
           MOVE BJVAM0-YEAR-RATE(09)    TO W-CM-AMT-RATE(09) .          
           MOVE BJVAM0-YEAR-RATE(10)    TO W-CM-AMT-RATE(10) .          
           MOVE BJVAM0-YEAR-RATE(11)    TO W-CM-AMT-RATE(11) .          
           MOVE BJVAM0-YEAR-RATE(12)    TO W-CM-AMT-RATE(12) .          
           MOVE BJVAM0-YEAR-RATE(13)    TO W-CM-AMT-RATE(13) .          
           MOVE BJVAM0-YEAR-RATE(14)    TO W-CM-AMT-RATE(14) .          
           MOVE BJVAM0-YEAR-RATE(15)    TO W-CM-AMT-RATE(15) .          
           MOVE BJVAM0-YEAR-RATE(16)    TO W-CM-AMT-RATE(16) .          
           MOVE BJVAM0-YEAR-RATE(17)    TO W-CM-AMT-RATE(17) .          
           MOVE BJVAM0-YEAR-RATE(18)    TO W-CM-AMT-RATE(18) .          
           MOVE BJVAM0-YEAR-RATE(19)    TO W-CM-AMT-RATE(19) .          
           MOVE BJVAM0-YEAR-RATE(20)    TO W-CM-AMT-RATE(20) .          
           MOVE BJVAM0-YEAR-RATE(21)    TO W-CM-AMT-RATE(21) .          
           MOVE BJVAM0-YEAR-RATE(22)    TO W-CM-AMT-RATE(22) .          
           MOVE BJVAM0-YEAR-RATE(23)    TO W-CM-AMT-RATE(23) .          
           MOVE BJVAM0-YEAR-RATE(24)    TO W-CM-AMT-RATE(24) .          
           MOVE BJVAM0-YEAR-RATE(25)    TO W-CM-AMT-RATE(25) .          
           MOVE BJVAM0-YEAR-RATE(26)    TO W-CM-AMT-RATE(26) .          
           MOVE BJVAM0-YEAR-RATE(27)    TO W-CM-AMT-RATE(27) .          
           MOVE BJVAM0-YEAR-RATE(28)    TO W-CM-AMT-RATE(28) .          
           MOVE BJVAM0-YEAR-RATE(29)    TO W-CM-AMT-RATE(29) .          
           MOVE BJVAM0-YEAR-RATE(30)    TO W-CM-AMT-RATE(30) .          
           MOVE BJVAM0-YEAR-RATE(31)    TO W-CM-AMT-RATE(31) .          
           MOVE BJVAM0-YEAR-RATE(32)    TO W-CM-AMT-RATE(32) .          
           MOVE BJVAM0-YEAR-RATE(33)    TO W-CM-AMT-RATE(33) .          
           MOVE BJVAM0-YEAR-RATE(34)    TO W-CM-AMT-RATE(34) .          
           MOVE BJVAM0-YEAR-RATE(35)    TO W-CM-AMT-RATE(35) .          
           MOVE BJVAM0-YEAR-RATE(36)    TO W-CM-AMT-RATE(36) .          
           MOVE BJVAM0-YEAR-RATE(37)    TO W-CM-AMT-RATE(37) .          
           MOVE BJVAM0-YEAR-RATE(38)    TO W-CM-AMT-RATE(38) .          
           MOVE BJVAM0-YEAR-RATE(39)    TO W-CM-AMT-RATE(39) .          
           MOVE BJVAM0-YEAR-RATE(40)    TO W-CM-AMT-RATE(40) .          
           MOVE BJVAM0-YEAR-RATE(41)    TO W-CM-AMT-RATE(41) .          
           MOVE BJVAM0-YEAR-RATE(42)    TO W-CM-AMT-RATE(42) .          
           MOVE BJVAM0-YEAR-RATE(43)    TO W-CM-AMT-RATE(43) .          
           MOVE BJVAM0-YEAR-RATE(44)    TO W-CM-AMT-RATE(44) .          
           MOVE BJVAM0-YEAR-RATE(45)    TO W-CM-AMT-RATE(45) .          
           MOVE BJVAM0-YEAR-RATE(46)    TO W-CM-AMT-RATE(46) .          
           MOVE BJVAM0-YEAR-RATE(47)    TO W-CM-AMT-RATE(47) .          
           MOVE BJVAM0-YEAR-RATE(48)    TO W-CM-AMT-RATE(48) .          
           MOVE BJVAM0-YEAR-RATE(49)    TO W-CM-AMT-RATE(49) .          
           MOVE BJVAM0-YEAR-RATE(50)    TO W-CM-AMT-RATE(50) .          
           MOVE BJVAM0-YEAR-RATE(51)    TO W-CM-AMT-RATE(51) .          
           MOVE BJVAM0-YEAR-RATE(52)    TO W-CM-AMT-RATE(52) .          
           MOVE BJVAM0-YEAR-RATE(53)    TO W-CM-AMT-RATE(53) .          
           MOVE BJVAM0-YEAR-RATE(54)    TO W-CM-AMT-RATE(54) .          
           MOVE BJVAM0-YEAR-RATE(55)    TO W-CM-AMT-RATE(55) .          
           MOVE BJVAM0-YEAR-RATE(56)    TO W-CM-AMT-RATE(56) .          
           MOVE BJVAM0-YEAR-RATE(57)    TO W-CM-AMT-RATE(57) .          
           MOVE BJVAM0-YEAR-RATE(58)    TO W-CM-AMT-RATE(58) .          
           MOVE BJVAM0-YEAR-RATE(59)    TO W-CM-AMT-RATE(59) .          
           MOVE BJVAM0-YEAR-RATE(60)    TO W-CM-AMT-RATE(60) .          
           MOVE BJVAM0-YEAR-RATE(61)    TO W-CM-AMT-RATE(61) .          
           MOVE BJVAM0-YEAR-RATE(62)    TO W-CM-AMT-RATE(62) .          
           MOVE BJVAM0-YEAR-RATE(63)    TO W-CM-AMT-RATE(63) .          
           MOVE BJVAM0-YEAR-RATE(64)    TO W-CM-AMT-RATE(64) .          
           MOVE BJVAM0-YEAR-RATE(65)    TO W-CM-AMT-RATE(65) .          
           MOVE BJVAM0-YEAR-RATE(66)    TO W-CM-AMT-RATE(66) .          
           MOVE BJVAM0-YEAR-RATE(67)    TO W-CM-AMT-RATE(67) .          
           MOVE BJVAM0-YEAR-RATE(68)    TO W-CM-AMT-RATE(68) .          
           MOVE BJVAM0-YEAR-RATE(69)    TO W-CM-AMT-RATE(69) .          
           MOVE BJVAM0-YEAR-RATE(70)    TO W-CM-AMT-RATE(70) .          
                                                                        
      *   ?V?b??(m?}a?)                                              
           MOVE BJVAM0-YEAR-COUNT-RATE(01)  TO W-CM-CNT-RATE(01) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(02)  TO W-CM-CNT-RATE(02) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(03)  TO W-CM-CNT-RATE(03) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(04)  TO W-CM-CNT-RATE(04) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(05)  TO W-CM-CNT-RATE(05) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(06)  TO W-CM-CNT-RATE(06) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(07)  TO W-CM-CNT-RATE(07) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(08)  TO W-CM-CNT-RATE(08) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(09)  TO W-CM-CNT-RATE(09) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(10)  TO W-CM-CNT-RATE(10) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(11)  TO W-CM-CNT-RATE(11) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(12)  TO W-CM-CNT-RATE(12) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(13)  TO W-CM-CNT-RATE(13) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(14)  TO W-CM-CNT-RATE(14) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(15)  TO W-CM-CNT-RATE(15) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(16)  TO W-CM-CNT-RATE(16) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(17)  TO W-CM-CNT-RATE(17) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(18)  TO W-CM-CNT-RATE(18) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(19)  TO W-CM-CNT-RATE(19) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(20)  TO W-CM-CNT-RATE(20) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(21)  TO W-CM-CNT-RATE(21) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(22)  TO W-CM-CNT-RATE(22) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(23)  TO W-CM-CNT-RATE(23) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(24)  TO W-CM-CNT-RATE(24) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(25)  TO W-CM-CNT-RATE(25) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(26)  TO W-CM-CNT-RATE(26) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(27)  TO W-CM-CNT-RATE(27) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(28)  TO W-CM-CNT-RATE(28) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(29)  TO W-CM-CNT-RATE(29) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(30)  TO W-CM-CNT-RATE(30) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(31)  TO W-CM-CNT-RATE(31) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(32)  TO W-CM-CNT-RATE(32) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(33)  TO W-CM-CNT-RATE(33) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(34)  TO W-CM-CNT-RATE(34) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(35)  TO W-CM-CNT-RATE(35) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(36)  TO W-CM-CNT-RATE(36) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(37)  TO W-CM-CNT-RATE(37) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(38)  TO W-CM-CNT-RATE(38) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(39)  TO W-CM-CNT-RATE(39) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(40)  TO W-CM-CNT-RATE(40) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(41)  TO W-CM-CNT-RATE(41) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(42)  TO W-CM-CNT-RATE(42) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(43)  TO W-CM-CNT-RATE(43) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(44)  TO W-CM-CNT-RATE(44) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(45)  TO W-CM-CNT-RATE(45) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(46)  TO W-CM-CNT-RATE(46) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(47)  TO W-CM-CNT-RATE(47) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(48)  TO W-CM-CNT-RATE(48) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(49)  TO W-CM-CNT-RATE(49) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(50)  TO W-CM-CNT-RATE(50) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(51)  TO W-CM-CNT-RATE(51) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(52)  TO W-CM-CNT-RATE(52) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(53)  TO W-CM-CNT-RATE(53) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(54)  TO W-CM-CNT-RATE(54) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(55)  TO W-CM-CNT-RATE(55) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(56)  TO W-CM-CNT-RATE(56) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(57)  TO W-CM-CNT-RATE(57) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(58)  TO W-CM-CNT-RATE(58) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(59)  TO W-CM-CNT-RATE(59) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(60)  TO W-CM-CNT-RATE(60) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(61)  TO W-CM-CNT-RATE(61) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(62)  TO W-CM-CNT-RATE(62) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(63)  TO W-CM-CNT-RATE(63) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(64)  TO W-CM-CNT-RATE(64) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(65)  TO W-CM-CNT-RATE(65) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(66)  TO W-CM-CNT-RATE(66) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(67)  TO W-CM-CNT-RATE(67) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(68)  TO W-CM-CNT-RATE(68) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(69)  TO W-CM-CNT-RATE(69) .      
           MOVE BJVAM0-YEAR-COUNT-RATE(70)  TO W-CM-CNT-RATE(70) .      
                                                                        
      *   Ba[?x~?(m?}a?)                                              
           MOVE BJVAM0-YEAR-TREND-RATE(01)  TO W-CM-TRE-RATE(01) .      
           MOVE BJVAM0-YEAR-TREND-RATE(02)  TO W-CM-TRE-RATE(02) .      
           MOVE BJVAM0-YEAR-TREND-RATE(03)  TO W-CM-TRE-RATE(03) .      
           MOVE BJVAM0-YEAR-TREND-RATE(04)  TO W-CM-TRE-RATE(04) .      
           MOVE BJVAM0-YEAR-TREND-RATE(05)  TO W-CM-TRE-RATE(05) .      
           MOVE BJVAM0-YEAR-TREND-RATE(06)  TO W-CM-TRE-RATE(06) .      
           MOVE BJVAM0-YEAR-TREND-RATE(07)  TO W-CM-TRE-RATE(07) .      
           MOVE BJVAM0-YEAR-TREND-RATE(08)  TO W-CM-TRE-RATE(08) .      
           MOVE BJVAM0-YEAR-TREND-RATE(09)  TO W-CM-TRE-RATE(09) .      
           MOVE BJVAM0-YEAR-TREND-RATE(10)  TO W-CM-TRE-RATE(10) .      
           MOVE BJVAM0-YEAR-TREND-RATE(11)  TO W-CM-TRE-RATE(11) .      
           MOVE BJVAM0-YEAR-TREND-RATE(12)  TO W-CM-TRE-RATE(12) .      
           MOVE BJVAM0-YEAR-TREND-RATE(13)  TO W-CM-TRE-RATE(13) .      
           MOVE BJVAM0-YEAR-TREND-RATE(14)  TO W-CM-TRE-RATE(14) .      
           MOVE BJVAM0-YEAR-TREND-RATE(15)  TO W-CM-TRE-RATE(15) .      
           MOVE BJVAM0-YEAR-TREND-RATE(16)  TO W-CM-TRE-RATE(16) .      
           MOVE BJVAM0-YEAR-TREND-RATE(17)  TO W-CM-TRE-RATE(17) .      
           MOVE BJVAM0-YEAR-TREND-RATE(18)  TO W-CM-TRE-RATE(18) .      
           MOVE BJVAM0-YEAR-TREND-RATE(19)  TO W-CM-TRE-RATE(19) .      
           MOVE BJVAM0-YEAR-TREND-RATE(20)  TO W-CM-TRE-RATE(20) .      
           MOVE BJVAM0-YEAR-TREND-RATE(21)  TO W-CM-TRE-RATE(21) .      
           MOVE BJVAM0-YEAR-TREND-RATE(22)  TO W-CM-TRE-RATE(22) .      
           MOVE BJVAM0-YEAR-TREND-RATE(23)  TO W-CM-TRE-RATE(23) .      
           MOVE BJVAM0-YEAR-TREND-RATE(24)  TO W-CM-TRE-RATE(24) .      
           MOVE BJVAM0-YEAR-TREND-RATE(25)  TO W-CM-TRE-RATE(25) .      
           MOVE BJVAM0-YEAR-TREND-RATE(26)  TO W-CM-TRE-RATE(26) .      
           MOVE BJVAM0-YEAR-TREND-RATE(27)  TO W-CM-TRE-RATE(27) .      
           MOVE BJVAM0-YEAR-TREND-RATE(28)  TO W-CM-TRE-RATE(28) .      
           MOVE BJVAM0-YEAR-TREND-RATE(29)  TO W-CM-TRE-RATE(29) .      
           MOVE BJVAM0-YEAR-TREND-RATE(30)  TO W-CM-TRE-RATE(30) .      
           MOVE BJVAM0-YEAR-TREND-RATE(31)  TO W-CM-TRE-RATE(31) .      
           MOVE BJVAM0-YEAR-TREND-RATE(32)  TO W-CM-TRE-RATE(32) .      
           MOVE BJVAM0-YEAR-TREND-RATE(33)  TO W-CM-TRE-RATE(33) .      
           MOVE BJVAM0-YEAR-TREND-RATE(34)  TO W-CM-TRE-RATE(34) .      
           MOVE BJVAM0-YEAR-TREND-RATE(35)  TO W-CM-TRE-RATE(35) .      
           MOVE BJVAM0-YEAR-TREND-RATE(36)  TO W-CM-TRE-RATE(36) .      
           MOVE BJVAM0-YEAR-TREND-RATE(37)  TO W-CM-TRE-RATE(37) .      
           MOVE BJVAM0-YEAR-TREND-RATE(38)  TO W-CM-TRE-RATE(38) .      
           MOVE BJVAM0-YEAR-TREND-RATE(39)  TO W-CM-TRE-RATE(39) .      
           MOVE BJVAM0-YEAR-TREND-RATE(40)  TO W-CM-TRE-RATE(40) .      
           MOVE BJVAM0-YEAR-TREND-RATE(41)  TO W-CM-TRE-RATE(41) .      
           MOVE BJVAM0-YEAR-TREND-RATE(42)  TO W-CM-TRE-RATE(42) .      
           MOVE BJVAM0-YEAR-TREND-RATE(43)  TO W-CM-TRE-RATE(43) .      
           MOVE BJVAM0-YEAR-TREND-RATE(44)  TO W-CM-TRE-RATE(44) .      
           MOVE BJVAM0-YEAR-TREND-RATE(45)  TO W-CM-TRE-RATE(45) .      
           MOVE BJVAM0-YEAR-TREND-RATE(46)  TO W-CM-TRE-RATE(46) .      
           MOVE BJVAM0-YEAR-TREND-RATE(47)  TO W-CM-TRE-RATE(47) .      
           MOVE BJVAM0-YEAR-TREND-RATE(48)  TO W-CM-TRE-RATE(48) .      
           MOVE BJVAM0-YEAR-TREND-RATE(49)  TO W-CM-TRE-RATE(49) .      
           MOVE BJVAM0-YEAR-TREND-RATE(50)  TO W-CM-TRE-RATE(50) .      
           MOVE BJVAM0-YEAR-TREND-RATE(51)  TO W-CM-TRE-RATE(51) .      
           MOVE BJVAM0-YEAR-TREND-RATE(52)  TO W-CM-TRE-RATE(52) .      
           MOVE BJVAM0-YEAR-TREND-RATE(53)  TO W-CM-TRE-RATE(53) .      
           MOVE BJVAM0-YEAR-TREND-RATE(54)  TO W-CM-TRE-RATE(54) .      
           MOVE BJVAM0-YEAR-TREND-RATE(55)  TO W-CM-TRE-RATE(55) .      
           MOVE BJVAM0-YEAR-TREND-RATE(56)  TO W-CM-TRE-RATE(56) .      
           MOVE BJVAM0-YEAR-TREND-RATE(57)  TO W-CM-TRE-RATE(57) .      
           MOVE BJVAM0-YEAR-TREND-RATE(58)  TO W-CM-TRE-RATE(58) .      
           MOVE BJVAM0-YEAR-TREND-RATE(59)  TO W-CM-TRE-RATE(59) .      
           MOVE BJVAM0-YEAR-TREND-RATE(60)  TO W-CM-TRE-RATE(60) .      
           MOVE BJVAM0-YEAR-TREND-RATE(61)  TO W-CM-TRE-RATE(61) .      
           MOVE BJVAM0-YEAR-TREND-RATE(62)  TO W-CM-TRE-RATE(62) .      
           MOVE BJVAM0-YEAR-TREND-RATE(63)  TO W-CM-TRE-RATE(63) .      
           MOVE BJVAM0-YEAR-TREND-RATE(64)  TO W-CM-TRE-RATE(64) .      
           MOVE BJVAM0-YEAR-TREND-RATE(65)  TO W-CM-TRE-RATE(65) .      
           MOVE BJVAM0-YEAR-TREND-RATE(66)  TO W-CM-TRE-RATE(66) .      
           MOVE BJVAM0-YEAR-TREND-RATE(67)  TO W-CM-TRE-RATE(67) .      
           MOVE BJVAM0-YEAR-TREND-RATE(68)  TO W-CM-TRE-RATE(68) .      
           MOVE BJVAM0-YEAR-TREND-RATE(69)  TO W-CM-TRE-RATE(69) .      
           MOVE BJVAM0-YEAR-TREND-RATE(70)  TO W-CM-TRE-RATE(70) .      
                                                                        
       S1600-DATA-MOVE-EXIT.                                            
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 1 7 0 0 - B E - D A T A - M O V E                 *
      *                                                                *
      ******************************************************************
                                                                        
       S1700-BE-DATA-MOVE               SECTION.                        
                                                                        
      *   ?/?3j?n~?(?Vj?n~?)                                          
      *    MOVE W-YYYY2                TO W-CM-BUSN-YEAR-BE.            
           MOVE W-BUSN-YEAR(2)         TO W-CM-BUSN-YEAR-BE.            
                                                                        
      *   ?3½»E~p/?(?V?)                                              
           MOVE BJVAM0-YEAR-BUSNTP-CD   TO  W-CM-BUSNTP-CD-BE.          
           MOVE W-BUSNSECT-NM           TO  W-CM-BUSNSECT-NM-BE.        
           MOVE W-DETAIL-NM             TO  W-CM-DETAIL-NM-BE.          
      *   ??b                                                        
           IF   BJVAM0-YEAR-AMT(01)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(01)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(01) = BJVAM0-YEAR-AMT(01)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(02)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(02)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(02) = BJVAM0-YEAR-AMT(02)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(03)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(03)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(03) = BJVAM0-YEAR-AMT(03)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(04)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(04)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(04) = BJVAM0-YEAR-AMT(04)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(05)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(05)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(05) = BJVAM0-YEAR-AMT(05)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(06)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(06)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(06) = BJVAM0-YEAR-AMT(06)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(07)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(07)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(07) = BJVAM0-YEAR-AMT(07)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(08)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(08)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(08) = BJVAM0-YEAR-AMT(08)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(09)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(09)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(09) = BJVAM0-YEAR-AMT(09)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(10)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(10)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(10) = BJVAM0-YEAR-AMT(10)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(11)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(11)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(11) = BJVAM0-YEAR-AMT(11)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(12)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(12)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(12) = BJVAM0-YEAR-AMT(12)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(13)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(13)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(13) = BJVAM0-YEAR-AMT(13)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(14)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(14)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(14) = BJVAM0-YEAR-AMT(14)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(15)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(15)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(15) = BJVAM0-YEAR-AMT(15)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(16)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(16)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(16) = BJVAM0-YEAR-AMT(16)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(17)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(17)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(17) = BJVAM0-YEAR-AMT(17)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(18)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(18)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(18) = BJVAM0-YEAR-AMT(18)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(19)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(19)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(19) = BJVAM0-YEAR-AMT(19)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(20)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(20)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(20) = BJVAM0-YEAR-AMT(20)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(21)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(21)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(21) = BJVAM0-YEAR-AMT(21)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(22)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(22)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(22) = BJVAM0-YEAR-AMT(22)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(23)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(23)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(23) = BJVAM0-YEAR-AMT(23)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(24)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(24)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(24) = BJVAM0-YEAR-AMT(24)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(25)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(25)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(25) = BJVAM0-YEAR-AMT(25)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(26)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(26)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(26) = BJVAM0-YEAR-AMT(26)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(27)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(27)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(27) = BJVAM0-YEAR-AMT(27)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(28)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(28)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(28) = BJVAM0-YEAR-AMT(28)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(29)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(29)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(29) = BJVAM0-YEAR-AMT(29)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(30)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(30)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(30) = BJVAM0-YEAR-AMT(30)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(31)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(31)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(31) = BJVAM0-YEAR-AMT(31)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(32)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(32)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(32) = BJVAM0-YEAR-AMT(32)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(33)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(33)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(33) = BJVAM0-YEAR-AMT(33)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(34)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(34)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(34) = BJVAM0-YEAR-AMT(34)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(35)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(35)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(35) = BJVAM0-YEAR-AMT(35)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(35)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(35)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(35) = BJVAM0-YEAR-AMT(35)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(36)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(36)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(36) = BJVAM0-YEAR-AMT(36)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(37)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(37)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(37) = BJVAM0-YEAR-AMT(37)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(38)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(38)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(38) = BJVAM0-YEAR-AMT(38)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(39)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(39)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(39) = BJVAM0-YEAR-AMT(39)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(40)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(40)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(40) = BJVAM0-YEAR-AMT(40)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(41)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(41)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(41) = BJVAM0-YEAR-AMT(41)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(42)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(42)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(42) = BJVAM0-YEAR-AMT(42)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(43)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(43)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(43) = BJVAM0-YEAR-AMT(43)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(44)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(44)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(44) = BJVAM0-YEAR-AMT(44)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(45)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(45)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(45) = BJVAM0-YEAR-AMT(45)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(46)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(46)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(46) = BJVAM0-YEAR-AMT(46)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(47)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(47)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(47) = BJVAM0-YEAR-AMT(47)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(48)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(48)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(48) = BJVAM0-YEAR-AMT(48)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(49)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(49)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(49) = BJVAM0-YEAR-AMT(49)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(50)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(50)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(50) =  BJVAM0-YEAR-AMT(50)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(51)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(51)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(51) = BJVAM0-YEAR-AMT(51)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(52)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(52)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(52) = BJVAM0-YEAR-AMT(52)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(53)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(53)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(53) = BJVAM0-YEAR-AMT(53)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(54)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(54)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(54) = BJVAM0-YEAR-AMT(54)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(55)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(55)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(55) = BJVAM0-YEAR-AMT(55)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(56)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(56)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(56) = BJVAM0-YEAR-AMT(56)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(57)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(57)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(57) = BJVAM0-YEAR-AMT(57)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(58)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(58)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(58) = BJVAM0-YEAR-AMT(58)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(59)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(59)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(59) = BJVAM0-YEAR-AMT(59)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(60)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(60)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(60) = BJVAM0-YEAR-AMT(60)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(61)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(61)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(61) = BJVAM0-YEAR-AMT(61)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(62)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(62)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(62) = BJVAM0-YEAR-AMT(62)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(63)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(63)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(63) = BJVAM0-YEAR-AMT(63)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(64)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(64)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(64) = BJVAM0-YEAR-AMT(64)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(65)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(65)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(65) = BJVAM0-YEAR-AMT(65)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(66)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(66)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(66) = BJVAM0-YEAR-AMT(66)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(67)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(67)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(67) = BJVAM0-YEAR-AMT(67)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(68)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(68)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(68) = BJVAM0-YEAR-AMT(68)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(69)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(69)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(69) = BJVAM0-YEAR-AMT(69)/ C-MIL   
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(70)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BE(70)              
           ELSE                                                         
                COMPUTE  W-CM-AMT-BE(70) = BJVAM0-YEAR-AMT(70)/ C-MIL   
           END-IF.                                                      
                                                                        
      *   m?}a??(m?}a?)                                              
           MOVE BJVAM0-YEAR-RATE(01)    TO W-CM-AMT-RATE-BE(01) .       
           MOVE BJVAM0-YEAR-RATE(02)    TO W-CM-AMT-RATE-BE(02) .       
           MOVE BJVAM0-YEAR-RATE(03)    TO W-CM-AMT-RATE-BE(03) .       
           MOVE BJVAM0-YEAR-RATE(04)    TO W-CM-AMT-RATE-BE(04) .       
           MOVE BJVAM0-YEAR-RATE(05)    TO W-CM-AMT-RATE-BE(05) .       
           MOVE BJVAM0-YEAR-RATE(06)    TO W-CM-AMT-RATE-BE(06) .       
           MOVE BJVAM0-YEAR-RATE(07)    TO W-CM-AMT-RATE-BE(07) .       
           MOVE BJVAM0-YEAR-RATE(08)    TO W-CM-AMT-RATE-BE(08) .       
           MOVE BJVAM0-YEAR-RATE(09)    TO W-CM-AMT-RATE-BE(09) .       
           MOVE BJVAM0-YEAR-RATE(10)    TO W-CM-AMT-RATE-BE(10) .       
           MOVE BJVAM0-YEAR-RATE(11)    TO W-CM-AMT-RATE-BE(11) .       
           MOVE BJVAM0-YEAR-RATE(12)    TO W-CM-AMT-RATE-BE(12) .       
           MOVE BJVAM0-YEAR-RATE(13)    TO W-CM-AMT-RATE-BE(13) .       
           MOVE BJVAM0-YEAR-RATE(14)    TO W-CM-AMT-RATE-BE(14) .       
           MOVE BJVAM0-YEAR-RATE(15)    TO W-CM-AMT-RATE-BE(15) .       
           MOVE BJVAM0-YEAR-RATE(16)    TO W-CM-AMT-RATE-BE(16) .       
           MOVE BJVAM0-YEAR-RATE(17)    TO W-CM-AMT-RATE-BE(17) .       
           MOVE BJVAM0-YEAR-RATE(18)    TO W-CM-AMT-RATE-BE(18) .       
           MOVE BJVAM0-YEAR-RATE(19)    TO W-CM-AMT-RATE-BE(19) .       
           MOVE BJVAM0-YEAR-RATE(20)    TO W-CM-AMT-RATE-BE(20) .       
           MOVE BJVAM0-YEAR-RATE(21)    TO W-CM-AMT-RATE-BE(21) .       
           MOVE BJVAM0-YEAR-RATE(22)    TO W-CM-AMT-RATE-BE(22) .       
           MOVE BJVAM0-YEAR-RATE(23)    TO W-CM-AMT-RATE-BE(23) .       
           MOVE BJVAM0-YEAR-RATE(24)    TO W-CM-AMT-RATE-BE(24) .       
           MOVE BJVAM0-YEAR-RATE(25)    TO W-CM-AMT-RATE-BE(25) .       
           MOVE BJVAM0-YEAR-RATE(26)    TO W-CM-AMT-RATE-BE(26) .       
           MOVE BJVAM0-YEAR-RATE(27)    TO W-CM-AMT-RATE-BE(27) .       
           MOVE BJVAM0-YEAR-RATE(28)    TO W-CM-AMT-RATE-BE(28) .       
           MOVE BJVAM0-YEAR-RATE(29)    TO W-CM-AMT-RATE-BE(29) .       
           MOVE BJVAM0-YEAR-RATE(30)    TO W-CM-AMT-RATE-BE(30) .       
           MOVE BJVAM0-YEAR-RATE(31)    TO W-CM-AMT-RATE-BE(31) .       
           MOVE BJVAM0-YEAR-RATE(32)    TO W-CM-AMT-RATE-BE(32) .       
           MOVE BJVAM0-YEAR-RATE(33)    TO W-CM-AMT-RATE-BE(33) .       
           MOVE BJVAM0-YEAR-RATE(34)    TO W-CM-AMT-RATE-BE(34) .       
           MOVE BJVAM0-YEAR-RATE(35)    TO W-CM-AMT-RATE-BE(35) .       
           MOVE BJVAM0-YEAR-RATE(36)    TO W-CM-AMT-RATE-BE(36) .       
           MOVE BJVAM0-YEAR-RATE(37)    TO W-CM-AMT-RATE-BE(37) .       
           MOVE BJVAM0-YEAR-RATE(38)    TO W-CM-AMT-RATE-BE(38) .       
           MOVE BJVAM0-YEAR-RATE(39)    TO W-CM-AMT-RATE-BE(39) .       
           MOVE BJVAM0-YEAR-RATE(40)    TO W-CM-AMT-RATE-BE(40) .       
           MOVE BJVAM0-YEAR-RATE(41)    TO W-CM-AMT-RATE-BE(41) .       
           MOVE BJVAM0-YEAR-RATE(42)    TO W-CM-AMT-RATE-BE(42) .       
           MOVE BJVAM0-YEAR-RATE(43)    TO W-CM-AMT-RATE-BE(43) .       
           MOVE BJVAM0-YEAR-RATE(44)    TO W-CM-AMT-RATE-BE(44) .       
           MOVE BJVAM0-YEAR-RATE(45)    TO W-CM-AMT-RATE-BE(45) .       
           MOVE BJVAM0-YEAR-RATE(46)    TO W-CM-AMT-RATE-BE(46) .       
           MOVE BJVAM0-YEAR-RATE(47)    TO W-CM-AMT-RATE-BE(47) .       
           MOVE BJVAM0-YEAR-RATE(48)    TO W-CM-AMT-RATE-BE(48) .       
           MOVE BJVAM0-YEAR-RATE(49)    TO W-CM-AMT-RATE-BE(49) .       
           MOVE BJVAM0-YEAR-RATE(50)    TO W-CM-AMT-RATE-BE(50) .       
           MOVE BJVAM0-YEAR-RATE(51)    TO W-CM-AMT-RATE-BE(51) .       
           MOVE BJVAM0-YEAR-RATE(52)    TO W-CM-AMT-RATE-BE(52) .       
           MOVE BJVAM0-YEAR-RATE(53)    TO W-CM-AMT-RATE-BE(53) .       
           MOVE BJVAM0-YEAR-RATE(54)    TO W-CM-AMT-RATE-BE(54) .       
           MOVE BJVAM0-YEAR-RATE(55)    TO W-CM-AMT-RATE-BE(55) .       
           MOVE BJVAM0-YEAR-RATE(56)    TO W-CM-AMT-RATE-BE(56) .       
           MOVE BJVAM0-YEAR-RATE(57)    TO W-CM-AMT-RATE-BE(57) .       
           MOVE BJVAM0-YEAR-RATE(58)    TO W-CM-AMT-RATE-BE(58) .       
           MOVE BJVAM0-YEAR-RATE(59)    TO W-CM-AMT-RATE-BE(59) .       
           MOVE BJVAM0-YEAR-RATE(60)    TO W-CM-AMT-RATE-BE(60) .       
           MOVE BJVAM0-YEAR-RATE(61)    TO W-CM-AMT-RATE-BE(61) .       
           MOVE BJVAM0-YEAR-RATE(62)    TO W-CM-AMT-RATE-BE(62) .       
           MOVE BJVAM0-YEAR-RATE(63)    TO W-CM-AMT-RATE-BE(63) .       
           MOVE BJVAM0-YEAR-RATE(64)    TO W-CM-AMT-RATE-BE(64) .       
           MOVE BJVAM0-YEAR-RATE(65)    TO W-CM-AMT-RATE-BE(65) .       
           MOVE BJVAM0-YEAR-RATE(66)    TO W-CM-AMT-RATE-BE(66) .       
           MOVE BJVAM0-YEAR-RATE(67)    TO W-CM-AMT-RATE-BE(67) .       
           MOVE BJVAM0-YEAR-RATE(68)    TO W-CM-AMT-RATE-BE(68) .       
           MOVE BJVAM0-YEAR-RATE(69)    TO W-CM-AMT-RATE-BE(69) .       
           MOVE BJVAM0-YEAR-RATE(70)    TO W-CM-AMT-RATE-BE(70) .       
      *   ?V?b??(m?}a?)                                              
           MOVE BJVAM0-YEAR-COUNT-RATE(01)  TO W-CM-CNT-RATE-BE(01) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(02)  TO W-CM-CNT-RATE-BE(02) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(03)  TO W-CM-CNT-RATE-BE(03) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(04)  TO W-CM-CNT-RATE-BE(04) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(05)  TO W-CM-CNT-RATE-BE(05) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(06)  TO W-CM-CNT-RATE-BE(06) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(07)  TO W-CM-CNT-RATE-BE(07) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(08)  TO W-CM-CNT-RATE-BE(08) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(09)  TO W-CM-CNT-RATE-BE(09) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(10)  TO W-CM-CNT-RATE-BE(10) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(11)  TO W-CM-CNT-RATE-BE(11) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(12)  TO W-CM-CNT-RATE-BE(12) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(13)  TO W-CM-CNT-RATE-BE(13) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(14)  TO W-CM-CNT-RATE-BE(14) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(15)  TO W-CM-CNT-RATE-BE(15) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(16)  TO W-CM-CNT-RATE-BE(16) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(17)  TO W-CM-CNT-RATE-BE(17) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(18)  TO W-CM-CNT-RATE-BE(18) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(19)  TO W-CM-CNT-RATE-BE(19) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(20)  TO W-CM-CNT-RATE-BE(20) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(21)  TO W-CM-CNT-RATE-BE(21) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(22)  TO W-CM-CNT-RATE-BE(22) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(23)  TO W-CM-CNT-RATE-BE(23) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(24)  TO W-CM-CNT-RATE-BE(24) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(25)  TO W-CM-CNT-RATE-BE(25) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(26)  TO W-CM-CNT-RATE-BE(26) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(27)  TO W-CM-CNT-RATE-BE(27) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(28)  TO W-CM-CNT-RATE-BE(28) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(29)  TO W-CM-CNT-RATE-BE(29) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(30)  TO W-CM-CNT-RATE-BE(30) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(31)  TO W-CM-CNT-RATE-BE(31) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(32)  TO W-CM-CNT-RATE-BE(32) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(33)  TO W-CM-CNT-RATE-BE(33) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(34)  TO W-CM-CNT-RATE-BE(34) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(35)  TO W-CM-CNT-RATE-BE(35) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(36)  TO W-CM-CNT-RATE-BE(36) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(37)  TO W-CM-CNT-RATE-BE(37) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(38)  TO W-CM-CNT-RATE-BE(38) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(39)  TO W-CM-CNT-RATE-BE(39) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(40)  TO W-CM-CNT-RATE-BE(40) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(41)  TO W-CM-CNT-RATE-BE(41) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(42)  TO W-CM-CNT-RATE-BE(42) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(43)  TO W-CM-CNT-RATE-BE(43) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(44)  TO W-CM-CNT-RATE-BE(44) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(45)  TO W-CM-CNT-RATE-BE(45) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(46)  TO W-CM-CNT-RATE-BE(46) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(47)  TO W-CM-CNT-RATE-BE(47) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(48)  TO W-CM-CNT-RATE-BE(48) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(49)  TO W-CM-CNT-RATE-BE(49) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(50)  TO W-CM-CNT-RATE-BE(50) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(51)  TO W-CM-CNT-RATE-BE(51) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(52)  TO W-CM-CNT-RATE-BE(52) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(53)  TO W-CM-CNT-RATE-BE(53) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(54)  TO W-CM-CNT-RATE-BE(54) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(55)  TO W-CM-CNT-RATE-BE(55) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(56)  TO W-CM-CNT-RATE-BE(56) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(57)  TO W-CM-CNT-RATE-BE(57) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(58)  TO W-CM-CNT-RATE-BE(58) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(59)  TO W-CM-CNT-RATE-BE(59) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(60)  TO W-CM-CNT-RATE-BE(60) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(61)  TO W-CM-CNT-RATE-BE(61) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(62)  TO W-CM-CNT-RATE-BE(62) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(63)  TO W-CM-CNT-RATE-BE(63) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(64)  TO W-CM-CNT-RATE-BE(64) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(65)  TO W-CM-CNT-RATE-BE(65) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(66)  TO W-CM-CNT-RATE-BE(66) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(67)  TO W-CM-CNT-RATE-BE(67) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(68)  TO W-CM-CNT-RATE-BE(68) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(69)  TO W-CM-CNT-RATE-BE(69) .   
           MOVE BJVAM0-YEAR-COUNT-RATE(70)  TO W-CM-CNT-RATE-BE(70) .   
                                                                        
      *   Ba[?x~?(m?}a?)                                              
           MOVE BJVAM0-YEAR-TREND-RATE(01)  TO W-CM-TRE-RATE-BE(01) .   
           MOVE BJVAM0-YEAR-TREND-RATE(02)  TO W-CM-TRE-RATE-BE(02) .   
           MOVE BJVAM0-YEAR-TREND-RATE(03)  TO W-CM-TRE-RATE-BE(03) .   
           MOVE BJVAM0-YEAR-TREND-RATE(04)  TO W-CM-TRE-RATE-BE(04) .   
           MOVE BJVAM0-YEAR-TREND-RATE(05)  TO W-CM-TRE-RATE-BE(05) .   
           MOVE BJVAM0-YEAR-TREND-RATE(06)  TO W-CM-TRE-RATE-BE(06) .   
           MOVE BJVAM0-YEAR-TREND-RATE(07)  TO W-CM-TRE-RATE-BE(07) .   
           MOVE BJVAM0-YEAR-TREND-RATE(08)  TO W-CM-TRE-RATE-BE(08) .   
           MOVE BJVAM0-YEAR-TREND-RATE(09)  TO W-CM-TRE-RATE-BE(09) .   
           MOVE BJVAM0-YEAR-TREND-RATE(10)  TO W-CM-TRE-RATE-BE(10) .   
           MOVE BJVAM0-YEAR-TREND-RATE(11)  TO W-CM-TRE-RATE-BE(11) .   
           MOVE BJVAM0-YEAR-TREND-RATE(12)  TO W-CM-TRE-RATE-BE(12) .   
           MOVE BJVAM0-YEAR-TREND-RATE(13)  TO W-CM-TRE-RATE-BE(13) .   
           MOVE BJVAM0-YEAR-TREND-RATE(14)  TO W-CM-TRE-RATE-BE(14) .   
           MOVE BJVAM0-YEAR-TREND-RATE(15)  TO W-CM-TRE-RATE-BE(15) .   
           MOVE BJVAM0-YEAR-TREND-RATE(16)  TO W-CM-TRE-RATE-BE(16) .   
           MOVE BJVAM0-YEAR-TREND-RATE(17)  TO W-CM-TRE-RATE-BE(17) .   
           MOVE BJVAM0-YEAR-TREND-RATE(18)  TO W-CM-TRE-RATE-BE(18) .   
           MOVE BJVAM0-YEAR-TREND-RATE(19)  TO W-CM-TRE-RATE-BE(19) .   
           MOVE BJVAM0-YEAR-TREND-RATE(20)  TO W-CM-TRE-RATE-BE(20) .   
           MOVE BJVAM0-YEAR-TREND-RATE(21)  TO W-CM-TRE-RATE-BE(21) .   
           MOVE BJVAM0-YEAR-TREND-RATE(22)  TO W-CM-TRE-RATE-BE(22) .   
           MOVE BJVAM0-YEAR-TREND-RATE(23)  TO W-CM-TRE-RATE-BE(23) .   
           MOVE BJVAM0-YEAR-TREND-RATE(24)  TO W-CM-TRE-RATE-BE(24) .   
           MOVE BJVAM0-YEAR-TREND-RATE(25)  TO W-CM-TRE-RATE-BE(25) .   
           MOVE BJVAM0-YEAR-TREND-RATE(26)  TO W-CM-TRE-RATE-BE(26) .   
           MOVE BJVAM0-YEAR-TREND-RATE(27)  TO W-CM-TRE-RATE-BE(27) .   
           MOVE BJVAM0-YEAR-TREND-RATE(28)  TO W-CM-TRE-RATE-BE(28) .   
           MOVE BJVAM0-YEAR-TREND-RATE(29)  TO W-CM-TRE-RATE-BE(29) .   
           MOVE BJVAM0-YEAR-TREND-RATE(30)  TO W-CM-TRE-RATE-BE(30) .   
           MOVE BJVAM0-YEAR-TREND-RATE(31)  TO W-CM-TRE-RATE-BE(31) .   
           MOVE BJVAM0-YEAR-TREND-RATE(32)  TO W-CM-TRE-RATE-BE(32) .   
           MOVE BJVAM0-YEAR-TREND-RATE(33)  TO W-CM-TRE-RATE-BE(33) .   
           MOVE BJVAM0-YEAR-TREND-RATE(34)  TO W-CM-TRE-RATE-BE(34) .   
           MOVE BJVAM0-YEAR-TREND-RATE(35)  TO W-CM-TRE-RATE-BE(35) .   
           MOVE BJVAM0-YEAR-TREND-RATE(36)  TO W-CM-TRE-RATE-BE(36) .   
           MOVE BJVAM0-YEAR-TREND-RATE(37)  TO W-CM-TRE-RATE-BE(37) .   
           MOVE BJVAM0-YEAR-TREND-RATE(38)  TO W-CM-TRE-RATE-BE(38) .   
           MOVE BJVAM0-YEAR-TREND-RATE(39)  TO W-CM-TRE-RATE-BE(39) .   
           MOVE BJVAM0-YEAR-TREND-RATE(40)  TO W-CM-TRE-RATE-BE(40) .   
           MOVE BJVAM0-YEAR-TREND-RATE(41)  TO W-CM-TRE-RATE-BE(41) .   
           MOVE BJVAM0-YEAR-TREND-RATE(42)  TO W-CM-TRE-RATE-BE(42) .   
           MOVE BJVAM0-YEAR-TREND-RATE(43)  TO W-CM-TRE-RATE-BE(43) .   
           MOVE BJVAM0-YEAR-TREND-RATE(44)  TO W-CM-TRE-RATE-BE(44) .   
           MOVE BJVAM0-YEAR-TREND-RATE(45)  TO W-CM-TRE-RATE-BE(45) .   
           MOVE BJVAM0-YEAR-TREND-RATE(46)  TO W-CM-TRE-RATE-BE(46) .   
           MOVE BJVAM0-YEAR-TREND-RATE(47)  TO W-CM-TRE-RATE-BE(47) .   
           MOVE BJVAM0-YEAR-TREND-RATE(48)  TO W-CM-TRE-RATE-BE(48) .   
           MOVE BJVAM0-YEAR-TREND-RATE(49)  TO W-CM-TRE-RATE-BE(49) .   
           MOVE BJVAM0-YEAR-TREND-RATE(50)  TO W-CM-TRE-RATE-BE(50) .   
           MOVE BJVAM0-YEAR-TREND-RATE(51)  TO W-CM-TRE-RATE-BE(51) .   
           MOVE BJVAM0-YEAR-TREND-RATE(52)  TO W-CM-TRE-RATE-BE(52) .   
           MOVE BJVAM0-YEAR-TREND-RATE(53)  TO W-CM-TRE-RATE-BE(53) .   
           MOVE BJVAM0-YEAR-TREND-RATE(54)  TO W-CM-TRE-RATE-BE(54) .   
           MOVE BJVAM0-YEAR-TREND-RATE(55)  TO W-CM-TRE-RATE-BE(55) .   
           MOVE BJVAM0-YEAR-TREND-RATE(56)  TO W-CM-TRE-RATE-BE(56) .   
           MOVE BJVAM0-YEAR-TREND-RATE(57)  TO W-CM-TRE-RATE-BE(57) .   
           MOVE BJVAM0-YEAR-TREND-RATE(58)  TO W-CM-TRE-RATE-BE(58) .   
           MOVE BJVAM0-YEAR-TREND-RATE(59)  TO W-CM-TRE-RATE-BE(59) .   
           MOVE BJVAM0-YEAR-TREND-RATE(60)  TO W-CM-TRE-RATE-BE(60) .   
           MOVE BJVAM0-YEAR-TREND-RATE(61)  TO W-CM-TRE-RATE-BE(61) .   
           MOVE BJVAM0-YEAR-TREND-RATE(62)  TO W-CM-TRE-RATE-BE(62) .   
           MOVE BJVAM0-YEAR-TREND-RATE(63)  TO W-CM-TRE-RATE-BE(63) .   
           MOVE BJVAM0-YEAR-TREND-RATE(64)  TO W-CM-TRE-RATE-BE(64) .   
           MOVE BJVAM0-YEAR-TREND-RATE(65)  TO W-CM-TRE-RATE-BE(65) .   
           MOVE BJVAM0-YEAR-TREND-RATE(66)  TO W-CM-TRE-RATE-BE(66) .   
           MOVE BJVAM0-YEAR-TREND-RATE(67)  TO W-CM-TRE-RATE-BE(67) .   
           MOVE BJVAM0-YEAR-TREND-RATE(68)  TO W-CM-TRE-RATE-BE(68) .   
           MOVE BJVAM0-YEAR-TREND-RATE(69)  TO W-CM-TRE-RATE-BE(69) .   
           MOVE BJVAM0-YEAR-TREND-RATE(70)  TO W-CM-TRE-RATE-BE(70) .   
                                                                        
       S1700-BE-DATA-MOVE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 1 8 0 0 - B E - Z E R O - M O V E                 *
      *                                                                *
      ******************************************************************
                                                                        
       S1800-BE-ZERO-MOVE               SECTION.                        
                                                                        
      *   ?3½»E~p/?(?V?)                                              
           MOVE SPACE                   TO  W-CM-BUSNTP-CD-BE.          
           MOVE SPACE                   TO  W-CM-BUSNSECT-NM-BE.        
           MOVE SPACE                   TO  W-CM-DETAIL-NM-BE.          
      *   ??b                                                        
           PERFORM  VARYING  W-I   FROM  1      BY  1                   
                                         UNTIL  W-I >  C-SEVENTY        
                    MOVE ZERO            TO  W-CM-AMT-BE(W-I)           
                                             W-CM-AMT-RATE-BE(W-I)      
                                             W-CM-CNT-RATE-BE(W-I)      
                                             W-CM-TRE-RATE-BE(W-I)      
                                                                        
           END-PERFORM.                                                 
                                                                        
       S1800-BE-ZERO-MOVE-EXIT.                                         
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 1 9 0 0 - B B E - D A T A - M O V E               *
      *                                                                *
      ******************************************************************
                                                                        
       S1900-BBE-DATA-MOVE              SECTION.                        
                                                                        
      *   ?/?3j?n~?(?V?Vj?n~?)                                        
      *    MOVE W-YYYY2                TO W-CM-BUSN-YEAR-BBE.           
           MOVE W-BUSN-YEAR(3)         TO W-CM-BUSN-YEAR-BBE.           
                                                                        
      *   ?3½»E~p/?(?V?V?)                                            
           MOVE BJVAM0-YEAR-BUSNTP-CD   TO  W-CM-BUSNTP-CD-BBE.         
           MOVE W-BUSNSECT-NM           TO  W-CM-BUSNSECT-NM-BBE.       
           MOVE W-DETAIL-NM             TO  W-CM-DETAIL-NM-BBE.         
      *   ??b                                                        
           IF   BJVAM0-YEAR-AMT(01)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(01)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(01) = BJVAM0-YEAR-AMT(01)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(02)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(02)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(02) = BJVAM0-YEAR-AMT(02)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(03)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(03)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(03) = BJVAM0-YEAR-AMT(03)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(04)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(04)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(04) = BJVAM0-YEAR-AMT(04)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(05)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(05)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(05) = BJVAM0-YEAR-AMT(05)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(06)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(06)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(06) = BJVAM0-YEAR-AMT(06)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(07)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(07)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(07) = BJVAM0-YEAR-AMT(07)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(08)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(08)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(08) = BJVAM0-YEAR-AMT(08)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(09)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(09)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(09) = BJVAM0-YEAR-AMT(09)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(10)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(10)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(10) = BJVAM0-YEAR-AMT(10)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(11)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(11)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(11) = BJVAM0-YEAR-AMT(11)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(12)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(12)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(12) = BJVAM0-YEAR-AMT(12)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(13)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(13)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(13) = BJVAM0-YEAR-AMT(13)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(14)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(14)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(14) = BJVAM0-YEAR-AMT(14)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(15)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(15)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(15) = BJVAM0-YEAR-AMT(15)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(16)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(16)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(16) = BJVAM0-YEAR-AMT(16)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(17)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(17)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(17) = BJVAM0-YEAR-AMT(17)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(18)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(18)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(18) = BJVAM0-YEAR-AMT(18)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(19)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(19)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(19) = BJVAM0-YEAR-AMT(19)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(20)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(20)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(20) = BJVAM0-YEAR-AMT(20)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(21)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(21)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(21) = BJVAM0-YEAR-AMT(21)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(22)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(22)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(22) = BJVAM0-YEAR-AMT(22)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(23)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(23)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(23) = BJVAM0-YEAR-AMT(23)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(24)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(24)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(24) = BJVAM0-YEAR-AMT(24)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(25)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(25)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(25) = BJVAM0-YEAR-AMT(25)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(26)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(26)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(26) = BJVAM0-YEAR-AMT(26)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(27)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(27)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(27) = BJVAM0-YEAR-AMT(27)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(28)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(28)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(28) = BJVAM0-YEAR-AMT(28)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(29)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(29)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(29) = BJVAM0-YEAR-AMT(29)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(30)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(30)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(30) = BJVAM0-YEAR-AMT(30)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(31)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(31)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(31) = BJVAM0-YEAR-AMT(31)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(32)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(32)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(32) = BJVAM0-YEAR-AMT(32)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(33)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(33)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(33) = BJVAM0-YEAR-AMT(33)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(34)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(34)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(34) = BJVAM0-YEAR-AMT(34)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(35)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(35)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(35) = BJVAM0-YEAR-AMT(35)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(35)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(35)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(35) = BJVAM0-YEAR-AMT(35)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(36)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(36)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(36) = BJVAM0-YEAR-AMT(36)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(37)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(37)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(37) = BJVAM0-YEAR-AMT(37)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(38)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(38)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(38) = BJVAM0-YEAR-AMT(38)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(39)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(39)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(39) = BJVAM0-YEAR-AMT(39)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(40)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(40)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(40) = BJVAM0-YEAR-AMT(40)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(41)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(41)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(41) = BJVAM0-YEAR-AMT(41)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(42)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(42)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(42) = BJVAM0-YEAR-AMT(42)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(43)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(43)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(43) = BJVAM0-YEAR-AMT(43)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(44)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(44)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(44) = BJVAM0-YEAR-AMT(44)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(45)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(45)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(45) = BJVAM0-YEAR-AMT(45)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(46)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(46)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(46) = BJVAM0-YEAR-AMT(46)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(47)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(47)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(47) = BJVAM0-YEAR-AMT(47)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(48)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(48)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(48) = BJVAM0-YEAR-AMT(48)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(49)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(49)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(49) = BJVAM0-YEAR-AMT(49)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(50)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(50)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(50) = BJVAM0-YEAR-AMT(50)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(51)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(51)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(51) = BJVAM0-YEAR-AMT(51)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(52)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(52)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(52) = BJVAM0-YEAR-AMT(52)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(53)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(53)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(53) = BJVAM0-YEAR-AMT(53)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(54)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(54)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(54) = BJVAM0-YEAR-AMT(54)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(55)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(55)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(55) = BJVAM0-YEAR-AMT(55)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(56)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(56)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(56) = BJVAM0-YEAR-AMT(56)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(57)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(57)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(57) = BJVAM0-YEAR-AMT(57)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(58)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(58)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(58) = BJVAM0-YEAR-AMT(58)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(59)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(59)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(59) = BJVAM0-YEAR-AMT(59)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(60)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(60)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(60) = BJVAM0-YEAR-AMT(60)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(61)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(61)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(61) = BJVAM0-YEAR-AMT(61)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(62)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(62)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(62) = BJVAM0-YEAR-AMT(62)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(63)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(63)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(63) = BJVAM0-YEAR-AMT(63)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(64)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(64)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(64) = BJVAM0-YEAR-AMT(64)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(65)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(65)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(65) = BJVAM0-YEAR-AMT(65)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(66)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(66)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(66) = BJVAM0-YEAR-AMT(66)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(67)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(67)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(67) = BJVAM0-YEAR-AMT(67)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(68)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(68)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(68) = BJVAM0-YEAR-AMT(68)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(69)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(69)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(69) = BJVAM0-YEAR-AMT(69)/ C-MIL  
           END-IF.                                                      
           IF   BJVAM0-YEAR-AMT(70)     =  ZERO                         
                MOVE ZERO               TO W-CM-AMT-BBE(70)             
           ELSE                                                         
                COMPUTE  W-CM-AMT-BBE(70) = BJVAM0-YEAR-AMT(70)/ C-MIL  
           END-IF.                                                      
                                                                        
      *   m?}a??(m?}a?)                                              
           MOVE BJVAM0-YEAR-RATE(01)    TO W-CM-AMT-RATE-BBE(01) .      
           MOVE BJVAM0-YEAR-RATE(02)    TO W-CM-AMT-RATE-BBE(02) .      
           MOVE BJVAM0-YEAR-RATE(03)    TO W-CM-AMT-RATE-BBE(03) .      
           MOVE BJVAM0-YEAR-RATE(04)    TO W-CM-AMT-RATE-BBE(04) .      
           MOVE BJVAM0-YEAR-RATE(05)    TO W-CM-AMT-RATE-BBE(05) .      
           MOVE BJVAM0-YEAR-RATE(06)    TO W-CM-AMT-RATE-BBE(06) .      
           MOVE BJVAM0-YEAR-RATE(07)    TO W-CM-AMT-RATE-BBE(07) .      
           MOVE BJVAM0-YEAR-RATE(08)    TO W-CM-AMT-RATE-BBE(08) .      
           MOVE BJVAM0-YEAR-RATE(09)    TO W-CM-AMT-RATE-BBE(09) .      
           MOVE BJVAM0-YEAR-RATE(10)    TO W-CM-AMT-RATE-BBE(10) .      
           MOVE BJVAM0-YEAR-RATE(11)    TO W-CM-AMT-RATE-BBE(11) .      
           MOVE BJVAM0-YEAR-RATE(12)    TO W-CM-AMT-RATE-BBE(12) .      
           MOVE BJVAM0-YEAR-RATE(13)    TO W-CM-AMT-RATE-BBE(13) .      
           MOVE BJVAM0-YEAR-RATE(14)    TO W-CM-AMT-RATE-BBE(14) .      
           MOVE BJVAM0-YEAR-RATE(15)    TO W-CM-AMT-RATE-BBE(15) .      
           MOVE BJVAM0-YEAR-RATE(16)    TO W-CM-AMT-RATE-BBE(16) .      
           MOVE BJVAM0-YEAR-RATE(17)    TO W-CM-AMT-RATE-BBE(17) .      
           MOVE BJVAM0-YEAR-RATE(18)    TO W-CM-AMT-RATE-BBE(18) .      
           MOVE BJVAM0-YEAR-RATE(19)    TO W-CM-AMT-RATE-BBE(19) .      
           MOVE BJVAM0-YEAR-RATE(20)    TO W-CM-AMT-RATE-BBE(20) .      
           MOVE BJVAM0-YEAR-RATE(21)    TO W-CM-AMT-RATE-BBE(21) .      
           MOVE BJVAM0-YEAR-RATE(22)    TO W-CM-AMT-RATE-BBE(22) .      
           MOVE BJVAM0-YEAR-RATE(23)    TO W-CM-AMT-RATE-BBE(23) .      
           MOVE BJVAM0-YEAR-RATE(24)    TO W-CM-AMT-RATE-BBE(24) .      
           MOVE BJVAM0-YEAR-RATE(25)    TO W-CM-AMT-RATE-BBE(25) .      
           MOVE BJVAM0-YEAR-RATE(26)    TO W-CM-AMT-RATE-BBE(26) .      
           MOVE BJVAM0-YEAR-RATE(27)    TO W-CM-AMT-RATE-BBE(27) .      
           MOVE BJVAM0-YEAR-RATE(28)    TO W-CM-AMT-RATE-BBE(28) .      
           MOVE BJVAM0-YEAR-RATE(29)    TO W-CM-AMT-RATE-BBE(29) .      
           MOVE BJVAM0-YEAR-RATE(30)    TO W-CM-AMT-RATE-BBE(30) .      
           MOVE BJVAM0-YEAR-RATE(31)    TO W-CM-AMT-RATE-BBE(31) .      
           MOVE BJVAM0-YEAR-RATE(32)    TO W-CM-AMT-RATE-BBE(32) .      
           MOVE BJVAM0-YEAR-RATE(33)    TO W-CM-AMT-RATE-BBE(33) .      
           MOVE BJVAM0-YEAR-RATE(34)    TO W-CM-AMT-RATE-BBE(34) .      
           MOVE BJVAM0-YEAR-RATE(35)    TO W-CM-AMT-RATE-BBE(35) .      
           MOVE BJVAM0-YEAR-RATE(36)    TO W-CM-AMT-RATE-BBE(36) .      
           MOVE BJVAM0-YEAR-RATE(37)    TO W-CM-AMT-RATE-BBE(37) .      
           MOVE BJVAM0-YEAR-RATE(38)    TO W-CM-AMT-RATE-BBE(38) .      
           MOVE BJVAM0-YEAR-RATE(39)    TO W-CM-AMT-RATE-BBE(39) .      
           MOVE BJVAM0-YEAR-RATE(40)    TO W-CM-AMT-RATE-BBE(40) .      
           MOVE BJVAM0-YEAR-RATE(41)    TO W-CM-AMT-RATE-BBE(41) .      
           MOVE BJVAM0-YEAR-RATE(42)    TO W-CM-AMT-RATE-BBE(42) .      
           MOVE BJVAM0-YEAR-RATE(43)    TO W-CM-AMT-RATE-BBE(43) .      
           MOVE BJVAM0-YEAR-RATE(44)    TO W-CM-AMT-RATE-BBE(44) .      
           MOVE BJVAM0-YEAR-RATE(45)    TO W-CM-AMT-RATE-BBE(45) .      
           MOVE BJVAM0-YEAR-RATE(46)    TO W-CM-AMT-RATE-BBE(46) .      
           MOVE BJVAM0-YEAR-RATE(47)    TO W-CM-AMT-RATE-BBE(47) .      
           MOVE BJVAM0-YEAR-RATE(48)    TO W-CM-AMT-RATE-BBE(48) .      
           MOVE BJVAM0-YEAR-RATE(49)    TO W-CM-AMT-RATE-BBE(49) .      
           MOVE BJVAM0-YEAR-RATE(50)    TO W-CM-AMT-RATE-BBE(50) .      
           MOVE BJVAM0-YEAR-RATE(51)    TO W-CM-AMT-RATE-BBE(51) .      
           MOVE BJVAM0-YEAR-RATE(52)    TO W-CM-AMT-RATE-BBE(52) .      
           MOVE BJVAM0-YEAR-RATE(53)    TO W-CM-AMT-RATE-BBE(53) .      
           MOVE BJVAM0-YEAR-RATE(54)    TO W-CM-AMT-RATE-BBE(54) .      
           MOVE BJVAM0-YEAR-RATE(55)    TO W-CM-AMT-RATE-BBE(55) .      
           MOVE BJVAM0-YEAR-RATE(56)    TO W-CM-AMT-RATE-BBE(56) .      
           MOVE BJVAM0-YEAR-RATE(57)    TO W-CM-AMT-RATE-BBE(57) .      
           MOVE BJVAM0-YEAR-RATE(58)    TO W-CM-AMT-RATE-BBE(58) .      
           MOVE BJVAM0-YEAR-RATE(59)    TO W-CM-AMT-RATE-BBE(59) .      
           MOVE BJVAM0-YEAR-RATE(60)    TO W-CM-AMT-RATE-BBE(60) .      
           MOVE BJVAM0-YEAR-RATE(61)    TO W-CM-AMT-RATE-BBE(61) .      
           MOVE BJVAM0-YEAR-RATE(62)    TO W-CM-AMT-RATE-BBE(62) .      
           MOVE BJVAM0-YEAR-RATE(63)    TO W-CM-AMT-RATE-BBE(63) .      
           MOVE BJVAM0-YEAR-RATE(64)    TO W-CM-AMT-RATE-BBE(64) .      
           MOVE BJVAM0-YEAR-RATE(65)    TO W-CM-AMT-RATE-BBE(65) .      
           MOVE BJVAM0-YEAR-RATE(66)    TO W-CM-AMT-RATE-BBE(66) .      
           MOVE BJVAM0-YEAR-RATE(67)    TO W-CM-AMT-RATE-BBE(67) .      
           MOVE BJVAM0-YEAR-RATE(68)    TO W-CM-AMT-RATE-BBE(68) .      
           MOVE BJVAM0-YEAR-RATE(69)    TO W-CM-AMT-RATE-BBE(69) .      
           MOVE BJVAM0-YEAR-RATE(70)    TO W-CM-AMT-RATE-BBE(70) .      
      *   ?V?b??(m?}a?)                                              
           MOVE BJVAM0-YEAR-COUNT-RATE(01)  TO W-CM-CNT-RATE-BBE(01) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(02)  TO W-CM-CNT-RATE-BBE(02) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(03)  TO W-CM-CNT-RATE-BBE(03) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(04)  TO W-CM-CNT-RATE-BBE(04) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(05)  TO W-CM-CNT-RATE-BBE(05) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(06)  TO W-CM-CNT-RATE-BBE(06) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(07)  TO W-CM-CNT-RATE-BBE(07) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(08)  TO W-CM-CNT-RATE-BBE(08) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(09)  TO W-CM-CNT-RATE-BBE(09) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(10)  TO W-CM-CNT-RATE-BBE(10) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(11)  TO W-CM-CNT-RATE-BBE(11) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(12)  TO W-CM-CNT-RATE-BBE(12) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(13)  TO W-CM-CNT-RATE-BBE(13) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(14)  TO W-CM-CNT-RATE-BBE(14) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(15)  TO W-CM-CNT-RATE-BBE(15) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(16)  TO W-CM-CNT-RATE-BBE(16) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(17)  TO W-CM-CNT-RATE-BBE(17) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(18)  TO W-CM-CNT-RATE-BBE(18) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(19)  TO W-CM-CNT-RATE-BBE(19) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(20)  TO W-CM-CNT-RATE-BBE(20) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(21)  TO W-CM-CNT-RATE-BBE(21) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(22)  TO W-CM-CNT-RATE-BBE(22) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(23)  TO W-CM-CNT-RATE-BBE(23) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(24)  TO W-CM-CNT-RATE-BBE(24) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(25)  TO W-CM-CNT-RATE-BBE(25) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(26)  TO W-CM-CNT-RATE-BBE(26) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(27)  TO W-CM-CNT-RATE-BBE(27) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(28)  TO W-CM-CNT-RATE-BBE(28) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(29)  TO W-CM-CNT-RATE-BBE(29) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(30)  TO W-CM-CNT-RATE-BBE(30) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(31)  TO W-CM-CNT-RATE-BBE(31) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(32)  TO W-CM-CNT-RATE-BBE(32) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(33)  TO W-CM-CNT-RATE-BBE(33) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(34)  TO W-CM-CNT-RATE-BBE(34) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(35)  TO W-CM-CNT-RATE-BBE(35) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(36)  TO W-CM-CNT-RATE-BBE(36) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(37)  TO W-CM-CNT-RATE-BBE(37) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(38)  TO W-CM-CNT-RATE-BBE(38) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(39)  TO W-CM-CNT-RATE-BBE(39) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(40)  TO W-CM-CNT-RATE-BBE(40) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(41)  TO W-CM-CNT-RATE-BBE(41) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(42)  TO W-CM-CNT-RATE-BBE(42) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(43)  TO W-CM-CNT-RATE-BBE(43) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(44)  TO W-CM-CNT-RATE-BBE(44) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(45)  TO W-CM-CNT-RATE-BBE(45) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(46)  TO W-CM-CNT-RATE-BBE(46) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(47)  TO W-CM-CNT-RATE-BBE(47) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(48)  TO W-CM-CNT-RATE-BBE(48) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(49)  TO W-CM-CNT-RATE-BBE(49) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(50)  TO W-CM-CNT-RATE-BBE(50) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(51)  TO W-CM-CNT-RATE-BBE(51) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(52)  TO W-CM-CNT-RATE-BBE(52) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(53)  TO W-CM-CNT-RATE-BBE(53) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(54)  TO W-CM-CNT-RATE-BBE(54) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(55)  TO W-CM-CNT-RATE-BBE(55) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(56)  TO W-CM-CNT-RATE-BBE(56) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(57)  TO W-CM-CNT-RATE-BBE(57) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(58)  TO W-CM-CNT-RATE-BBE(58) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(59)  TO W-CM-CNT-RATE-BBE(59) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(60)  TO W-CM-CNT-RATE-BBE(60) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(61)  TO W-CM-CNT-RATE-BBE(61) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(62)  TO W-CM-CNT-RATE-BBE(62) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(63)  TO W-CM-CNT-RATE-BBE(63) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(64)  TO W-CM-CNT-RATE-BBE(64) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(65)  TO W-CM-CNT-RATE-BBE(65) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(66)  TO W-CM-CNT-RATE-BBE(66) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(67)  TO W-CM-CNT-RATE-BBE(67) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(68)  TO W-CM-CNT-RATE-BBE(68) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(69)  TO W-CM-CNT-RATE-BBE(69) .  
           MOVE BJVAM0-YEAR-COUNT-RATE(70)  TO W-CM-CNT-RATE-BBE(70) .  
                                                                        
      *   Ba[?x~?(m?}a?)                                              
           MOVE BJVAM0-YEAR-TREND-RATE(01)  TO W-CM-TRE-RATE-BBE(01) .  
           MOVE BJVAM0-YEAR-TREND-RATE(02)  TO W-CM-TRE-RATE-BBE(02) .  
           MOVE BJVAM0-YEAR-TREND-RATE(03)  TO W-CM-TRE-RATE-BBE(03) .  
           MOVE BJVAM0-YEAR-TREND-RATE(04)  TO W-CM-TRE-RATE-BBE(04) .  
           MOVE BJVAM0-YEAR-TREND-RATE(05)  TO W-CM-TRE-RATE-BBE(05) .  
           MOVE BJVAM0-YEAR-TREND-RATE(06)  TO W-CM-TRE-RATE-BBE(06) .  
           MOVE BJVAM0-YEAR-TREND-RATE(07)  TO W-CM-TRE-RATE-BBE(07) .  
           MOVE BJVAM0-YEAR-TREND-RATE(08)  TO W-CM-TRE-RATE-BBE(08) .  
           MOVE BJVAM0-YEAR-TREND-RATE(09)  TO W-CM-TRE-RATE-BBE(09) .  
           MOVE BJVAM0-YEAR-TREND-RATE(10)  TO W-CM-TRE-RATE-BBE(10) .  
           MOVE BJVAM0-YEAR-TREND-RATE(11)  TO W-CM-TRE-RATE-BBE(11) .  
           MOVE BJVAM0-YEAR-TREND-RATE(12)  TO W-CM-TRE-RATE-BBE(12) .  
           MOVE BJVAM0-YEAR-TREND-RATE(13)  TO W-CM-TRE-RATE-BBE(13) .  
           MOVE BJVAM0-YEAR-TREND-RATE(14)  TO W-CM-TRE-RATE-BBE(14) .  
           MOVE BJVAM0-YEAR-TREND-RATE(15)  TO W-CM-TRE-RATE-BBE(15) .  
           MOVE BJVAM0-YEAR-TREND-RATE(16)  TO W-CM-TRE-RATE-BBE(16) .  
           MOVE BJVAM0-YEAR-TREND-RATE(17)  TO W-CM-TRE-RATE-BBE(17) .  
           MOVE BJVAM0-YEAR-TREND-RATE(18)  TO W-CM-TRE-RATE-BBE(18) .  
           MOVE BJVAM0-YEAR-TREND-RATE(19)  TO W-CM-TRE-RATE-BBE(19) .  
           MOVE BJVAM0-YEAR-TREND-RATE(20)  TO W-CM-TRE-RATE-BBE(20) .  
           MOVE BJVAM0-YEAR-TREND-RATE(21)  TO W-CM-TRE-RATE-BBE(21) .  
           MOVE BJVAM0-YEAR-TREND-RATE(22)  TO W-CM-TRE-RATE-BBE(22) .  
           MOVE BJVAM0-YEAR-TREND-RATE(23)  TO W-CM-TRE-RATE-BBE(23) .  
           MOVE BJVAM0-YEAR-TREND-RATE(24)  TO W-CM-TRE-RATE-BBE(24) .  
           MOVE BJVAM0-YEAR-TREND-RATE(25)  TO W-CM-TRE-RATE-BBE(25) .  
           MOVE BJVAM0-YEAR-TREND-RATE(26)  TO W-CM-TRE-RATE-BBE(26) .  
           MOVE BJVAM0-YEAR-TREND-RATE(27)  TO W-CM-TRE-RATE-BBE(27) .  
           MOVE BJVAM0-YEAR-TREND-RATE(28)  TO W-CM-TRE-RATE-BBE(28) .  
           MOVE BJVAM0-YEAR-TREND-RATE(29)  TO W-CM-TRE-RATE-BBE(29) .  
           MOVE BJVAM0-YEAR-TREND-RATE(30)  TO W-CM-TRE-RATE-BBE(30) .  
           MOVE BJVAM0-YEAR-TREND-RATE(31)  TO W-CM-TRE-RATE-BBE(31) .  
           MOVE BJVAM0-YEAR-TREND-RATE(32)  TO W-CM-TRE-RATE-BBE(32) .  
           MOVE BJVAM0-YEAR-TREND-RATE(33)  TO W-CM-TRE-RATE-BBE(33) .  
           MOVE BJVAM0-YEAR-TREND-RATE(34)  TO W-CM-TRE-RATE-BBE(34) .  
           MOVE BJVAM0-YEAR-TREND-RATE(35)  TO W-CM-TRE-RATE-BBE(35) .  
           MOVE BJVAM0-YEAR-TREND-RATE(36)  TO W-CM-TRE-RATE-BBE(36) .  
           MOVE BJVAM0-YEAR-TREND-RATE(37)  TO W-CM-TRE-RATE-BBE(37) .  
           MOVE BJVAM0-YEAR-TREND-RATE(38)  TO W-CM-TRE-RATE-BBE(38) .  
           MOVE BJVAM0-YEAR-TREND-RATE(39)  TO W-CM-TRE-RATE-BBE(39) .  
           MOVE BJVAM0-YEAR-TREND-RATE(40)  TO W-CM-TRE-RATE-BBE(40) .  
           MOVE BJVAM0-YEAR-TREND-RATE(41)  TO W-CM-TRE-RATE-BBE(41) .  
           MOVE BJVAM0-YEAR-TREND-RATE(42)  TO W-CM-TRE-RATE-BBE(42) .  
           MOVE BJVAM0-YEAR-TREND-RATE(43)  TO W-CM-TRE-RATE-BBE(43) .  
           MOVE BJVAM0-YEAR-TREND-RATE(44)  TO W-CM-TRE-RATE-BBE(44) .  
           MOVE BJVAM0-YEAR-TREND-RATE(45)  TO W-CM-TRE-RATE-BBE(45) .  
           MOVE BJVAM0-YEAR-TREND-RATE(46)  TO W-CM-TRE-RATE-BBE(46) .  
           MOVE BJVAM0-YEAR-TREND-RATE(47)  TO W-CM-TRE-RATE-BBE(47) .  
           MOVE BJVAM0-YEAR-TREND-RATE(48)  TO W-CM-TRE-RATE-BBE(48) .  
           MOVE BJVAM0-YEAR-TREND-RATE(49)  TO W-CM-TRE-RATE-BBE(49) .  
           MOVE BJVAM0-YEAR-TREND-RATE(50)  TO W-CM-TRE-RATE-BBE(50) .  
           MOVE BJVAM0-YEAR-TREND-RATE(51)  TO W-CM-TRE-RATE-BBE(51) .  
           MOVE BJVAM0-YEAR-TREND-RATE(52)  TO W-CM-TRE-RATE-BBE(52) .  
           MOVE BJVAM0-YEAR-TREND-RATE(53)  TO W-CM-TRE-RATE-BBE(53) .  
           MOVE BJVAM0-YEAR-TREND-RATE(54)  TO W-CM-TRE-RATE-BBE(54) .  
           MOVE BJVAM0-YEAR-TREND-RATE(55)  TO W-CM-TRE-RATE-BBE(55) .  
           MOVE BJVAM0-YEAR-TREND-RATE(56)  TO W-CM-TRE-RATE-BBE(56) .  
           MOVE BJVAM0-YEAR-TREND-RATE(57)  TO W-CM-TRE-RATE-BBE(57) .  
           MOVE BJVAM0-YEAR-TREND-RATE(58)  TO W-CM-TRE-RATE-BBE(58) .  
           MOVE BJVAM0-YEAR-TREND-RATE(59)  TO W-CM-TRE-RATE-BBE(59) .  
           MOVE BJVAM0-YEAR-TREND-RATE(60)  TO W-CM-TRE-RATE-BBE(60) .  
           MOVE BJVAM0-YEAR-TREND-RATE(61)  TO W-CM-TRE-RATE-BBE(61) .  
           MOVE BJVAM0-YEAR-TREND-RATE(62)  TO W-CM-TRE-RATE-BBE(62) .  
           MOVE BJVAM0-YEAR-TREND-RATE(63)  TO W-CM-TRE-RATE-BBE(63) .  
           MOVE BJVAM0-YEAR-TREND-RATE(64)  TO W-CM-TRE-RATE-BBE(64) .  
           MOVE BJVAM0-YEAR-TREND-RATE(65)  TO W-CM-TRE-RATE-BBE(65) .  
           MOVE BJVAM0-YEAR-TREND-RATE(66)  TO W-CM-TRE-RATE-BBE(66) .  
           MOVE BJVAM0-YEAR-TREND-RATE(67)  TO W-CM-TRE-RATE-BBE(67) .  
           MOVE BJVAM0-YEAR-TREND-RATE(68)  TO W-CM-TRE-RATE-BBE(68) .  
           MOVE BJVAM0-YEAR-TREND-RATE(69)  TO W-CM-TRE-RATE-BBE(69) .  
           MOVE BJVAM0-YEAR-TREND-RATE(70)  TO W-CM-TRE-RATE-BBE(70) .  
                                                                        
       S1900-BBE-DATA-MOVE-EXIT.                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 2 0 0 0 - B B E - Z E R O - M O V E               *
      *                                                                *
      ******************************************************************
                                                                        
       S2000-BBE-ZERO-MOVE              SECTION.                        
                                                                        
      *   ?3½»E~p/?(?V?)                                              
           MOVE SPACE                   TO  W-CM-BUSNTP-CD-BBE.         
           MOVE SPACE                   TO  W-CM-BUSNSECT-NM-BBE.       
           MOVE SPACE                   TO  W-CM-DETAIL-NM-BBE.         
      *   ??b                                                        
           PERFORM  VARYING  W-I   FROM  1      BY  1                   
                                         UNTIL  W-I >  C-SEVENTY        
                    MOVE ZERO            TO  W-CM-AMT-BBE(W-I)          
                                             W-CM-AMT-RATE-BBE(W-I)     
                                             W-CM-CNT-RATE-BBE(W-I)     
                                             W-CM-TRE-RATE-BBE(W-I)     
                                                                        
           END-PERFORM.                                                 
                                                                        
       S2000-BBE-ZERO-MOVE-EXIT.                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *            S 1 5 0 0 - D B - T T J A C - R E A D               *
      *                                                                *
      ******************************************************************
       S2100-DB-TTJAC-READ          SECTION.                            
                                                                        
           EXEC SQL SELECT  BUSNSECT_NM , DETAIL_NM                     
                      INTO  :TTJAC.BUSNSECT-NM, :TTJAC.DETAIL-NM        
                      FROM DTJA.TTJAC                                   
                      WHERE ATTRIBUTE_YEAR  = :TTJAC.ATTRIBUTE-YEAR     
                        AND STD_INCM_RT_CD  = :TTJAC.STD-INCM-RT-CD     
           END-EXEC.                                                    
                                                                        
           EVALUATE SQLCODE                                             
                                                                        
               WHEN C-SQL-NORMAL                                        
               WHEN C-SQL-NOTFND                                        
                                                                        
                    CONTINUE                                            
                                                                        
               WHEN OTHER                                               
                                                                        
                    ADD  1                      TO A-ERROR-COUNT        
                                                                        
           END-EVALUATE.                                                
                                                                        
       S2100-DB-TTJAC-READ-EXIT.                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *              S 1 5 0 1 - D B - T T J A C - R E A D             *
      *              98j?11?z19?z  Bah/                          *
      ******************************************************************
           SKIP2                                                        
981119 S2200-DB-TTJAC-READ  SECTION.                                    
                                                                        
           EXEC SQL SELECT  BUSNSECT_NM , DETAIL_NM                     
                      INTO  :TTJAC.BUSNSECT-NM, :TTJAC.DETAIL-NM        
                      FROM DTJA.TTJAC                                   
                      WHERE ATTRIBUTE_YEAR  = :TTJAC.ATTRIBUTE-YEAR     
                                                                        
           END-EXEC.                                                    
                                                                        
981119 S2200-DB-TTJAC-READ-EXIT.                                        
           SKIP1                                                        
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                 S 2 3 0 0 - Q S P C 2 - M O V E                *
      *                                                                *
      ******************************************************************
                                                                        
       S2300-QSPC2-MOVE                SECTION.                         
                                                                        
           MOVE  'MAPML'               TO  W-SSPC2-PROGRAM-ID.          
           MOVE  W-COMM-TXOFF-CD       TO  W-SSPC2-TXOFF-CD.            
           MOVE  W-COMM-USERID         TO  W-SSPC2-USER-ID              
           MOVE  SPACE                 TO  W-SSPC2-TERMINAL-ID          
           MOVE  'R'                   TO  W-SSPC2-ACCESS-TYPE.         
           MOVE  'BJVAM'               TO  W-SSPC2-TABLE-ID.            
           MOVE  W-HEAD-BUSNID         TO  W-SSPC2-TXPAYER-ID.          
           MOVE  '8'                   TO  W-SSPC2-TXPAYER-TP.          
           MOVE  SPACE                 TO  W-SSPC2-STATUS.              
                                                                        
       S2300-QSPC2-MOVE-EXIT.                                           
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *                S 2 4 0 0 - L I N K - Q S P C 2                 *
      *                                                                *
      ******************************************************************
                                                                        
       S2400-LINK-QSPC2                SECTION.                         
                                                                        
           MOVE  C-PGM-QSPC2           TO  W-LINK-PGM.                  
                                                                        
           EXEC  CICS  LINK            PROGRAM (W-LINK-PGM)             
                                       COMMAREA(W-QSPC2-AREA)           
                                       LENGTH  (4000)                   
                                       RESP    (W-RETURN-CODE)          
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
                                                                        
               IF  W-SSPC2-STATUS  =  SPACE                             
                   CONTINUE                                             
                                                                        
               ELSE                                                     
                                                                        
                   ADD  +1                     TO A-ERROR-COUNT         
                   MOVE W-SSPC2-STATUS         TO W-COMM-RC             
                   MOVE 'QSPC2-LINK-STAT-ERR'  TO W-COMM-MSG            
                                                                        
               END-IF                                                   
                                                                        
           ELSE                                                         
                                                                        
               ADD  +1                         TO A-ERROR-COUNT         
               MOVE W-RETURN-CODE              TO W-SQL                 
               MOVE W-SQL                      TO W-COMM-SQL            
               MOVE 'QSPC2-LINK-RETURN-ERR'    TO W-COMM-MSG            
                                                                        
           END-IF.                                                      
                                                                        
                                                                        
       S2400-LINK-QSPC2-EXIT.                                           
           EXIT.                                                        
           EJECT                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *                   S 8 0 0 0 - R E A D - S U V 0 1              *
      *                                                                *
      ******************************************************************
       S2500-READ-SUV010               SECTION.                         
                                                                        
           EXEC CICS READ     FILE     ('SUV010')                       
                              INTO     (W-MESSAGE)                      
                              RIDFLD   (W-MSG-ID)                       
                              RESP     (W-RETURN-CODE)                  
           END-EXEC.                                                    
                                                                        
           IF  W-RETURN-NORMAL                                          
                                                                        
               MOVE W-MSG-CONTENTS       TO W-COMM-MSG                  
                                                                        
           ELSE                                                         
                                                                        
               MOVE 'MESSAGE NOT-FOUND'  TO W-COMM-MSG                  
                                                                        
           END-IF.                                                      
                                                                        
       S2500-READ-SUV010-EXIT.                                          
           EXIT.                                                        
      ******************************************************************
      *                                                                *
      *                   S 2 6 0 0 - R E T U R N                      *
      *                                                                *
      *                     - RETURN TO CICS                           *
      *                                                                *
      ******************************************************************
                                                                        
       S2600-RETURN                    SECTION.                         
                                                                        
           IF W-ABEND-FG   NOT =  SPACE                                 
              EXEC CICS    SYNCPOINT ROLLBACK                           
           END-EXEC.                                                    
                                                                        
           EXEC CICS RETURN                                             
           END-EXEC.                                                    
                                                                        
       S2600-RETURN-EXIT.                                               
           EXIT.                                                        
           EJECT                                                        
      ***************************************************************** 
      *                                                               * 
      *      ?/?~?/?j?a?/?~Èßwawe»·l~m/  ..END OF PROGRAM           * 
      *                                                               * 
      ***************************************************************** 
