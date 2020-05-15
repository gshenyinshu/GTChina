      ****************************************************************
      *                                                              *
      *           I D E N T I F I C A T I O N  D I V I S I O N       *
      *                                                              *
      ****************************************************************
       IDENTIFICATION                    DIVISION.                      
                                                                        
       PROGRAM-ID.                       LCHBVJ20.                      
       AUTHOR.                           CHOI JAE HYUK.
       DATE-WRITTEN.                     2003-12-18.
       DATE-COMPILED.                                                   
                                                                        
      ****************************************************************
      *  HANDLER     : ~//n{/  ~v/  av7v~  wep7      *
      *  DESCRIPTION : avo  ~//n{/  ~v/  7v~  v{7, -*
      *JEv~~  we}// SAM FILE p7AS_IS : LNCBPN50        *
      *  4000 BYTE VSAM --> 300 BYTE SAM DOWN-LOAD                   *
      *                                                              *
      *  TRANSACTION ID : NONE                                       *
      *  JSP       FILE : NONE                                       *
      *  JS        FILE : NONE                                       *
      *  SERVLET   FILE : NONE                                       *
      *  MAIN   PROGRAM : LCHBVJ20                                   *
      *  SUB    PROGRAM :                                            *
      *                                                              *
      *  TABLE                                                CRUD   *
      *  ==========================================================  *
      *                                                              *
      * viHISTORY                                                *
      * viz/     CSRuVJ~ 3/ 3a                 *
      *  ==========   =========   ======   ========================  *
      *  2003/12/18              BaJ BA~7                 *
      ****************************************************************
                                                                        
      ****************************************************************
      *                                                              *
      *         E N V I R O N M E N T   D I V I S I O N              *
      *                                                              *
      ****************************************************************
       ENVIRONMENT                       DIVISION.                      
                                                                        
       INPUT-OUTPUT                      SECTION.                       
                                                                        
       FILE-CONTROL.                                                    
                                                                        
           SELECT  I-SRCE-FILE    ASSIGN        TO  LCHVSRCE            
                                  ORGANIZATION  IS  INDEXED
                                  ACCESS  MODE  IS  SEQUENTIAL
                                  RECORD  KEY   IS  SRCE-KEY
                                  FILE  STATUS  IS  W-SRCE-STATUS.
                                                                        
           SELECT  O-TRGT-FILE    ASSIGN        TO  LCHVTRGT.           
                                                                        
           SELECT  IO-PPKZ-FILE   ASSIGN        TO  LCHVPPKZ            
                                  ORGANIZATION  IS  INDEXED
                                  ACCESS  MODE  IS  RANDOM
                                  RECORD  KEY   IS  PPKZ-KEY
                                  FILE  STATUS  IS  W-PPKZ-STATUS.
                                                                        
      ****************************************************************
      *                                                              *
      *                    D A T A   D I V I S I O N                 *
      *                                                              *
      ****************************************************************
       DATA                              DIVISION.                      
                                                                        
       FILE                              SECTION.                       
      ***************************************************************   
      *                                                             *   
      *    I-SRCE-FILE                           DDNAME - LCHVSRCE  *   
      *                                                             *   
      *    4000 BYTE VSAM                                           *   
      *                                                             *   
      ***************************************************************   
       FD  I-SRCE-FILE                                                  
           BLOCK  CONTAINS            0  RECORDS                        
           LABEL  RECORDS           ARE  STANDARD                       
           DATA   RECORD             IS  LCHYKIA3.                      

      ***  COPY  LCHYKIA3.
       01  LCHYKIA3.                                                    
                                                                        
           05  GENERIC-RECORD              PIC  X(4000).                
                                                                        
           05  TARGET-RECORD  REDEFINES  GENERIC-RECORD.                
               10  TRGT-KEY.                                            
                   15  TRGT-SEQ-NO           PIC  9(06).                
               10  TRGT-DATA                 PIC  X(3992).              
                                                                        
               10  TRGT-DATA-A  REDEFINES  TRGT-DATA.                   
                   15  TRGT-DATA-TABLE-A  OCCURS  14  TIMES.            
                       20  TRGT-DATA-ITEM-A  PIC  X(267).               
                   15  FILLER                PIC  X(254).               
                                                                        
               10  TRGT-DATA-B  REDEFINES  TRGT-DATA.                   
                   15  TRGT-DATA-TABLE-B  OCCURS  36  TIMES.            
                       20  TRGT-DATA-ITEM-B  PIC  X(105).               
                   15  FILLER                PIC  X(212).               
                                                                        
               10  TRGT-DATA-C  REDEFINES  TRGT-DATA.                   
                   15  TRGT-DATA-TABLE-C  OCCURS  36  TIMES.            
                       20  TRGT-DATA-ITEM-C  PIC  X(105).               
                   15  FILLER                PIC  X(212).               
               10  TRGT-NUM-OF-RECS          PIC  9(02).                
                                                                        
           05  SOURCE-RECORD  REDEFINES  GENERIC-RECORD.                
               10  SRCE-KEY.                                            
                   15  SRCE-SEQ-NO           PIC  9(06).                
               10  SRCE-DATA                 PIC  X(3992).              
                                                                        
               10  SRCE-DATA-I  REDEFINES  SRCE-DATA.                   
                   15  SRCE-DATA-TABLE-I  OCCURS  14  TIMES.            
                       20  SRCE-DATA-ITEM-I  PIC  X(267).               
                   15  FILLER                PIC  X(254).               
                                                                        
               10  SRCE-DATA-J  REDEFINES  SRCE-DATA.                   
                   15  SRCE-DATA-TABLE-J  OCCURS  36  TIMES.            
                       20  SRCE-DATA-ITEM-J  PIC  X(105).               
                   15  FILLER                PIC  X(212).               
                                                                        
               10  SRCE-DATA-K  REDEFINES  SRCE-DATA.                   
                   15  SRCE-DATA-TABLE-K  OCCURS  36  TIMES.            
                       20  SRCE-DATA-ITEM-K  PIC  X(105).               
                   15  FILLER                PIC  X(212).               
                                                                        
               10  SRCE-NUM-OF-RECS          PIC  9(02).                

      ***************************************************************   
      *                                                             *   
      *    O-TRGT-FILE                           DDNAME - LCHVTRGT  *   
      *                                                             *   
      *    300 BYTE                                                 *   
      ***************************************************************   
       FD  O-TRGT-FILE                                                  
           RECORDING  MODE           IS  F                              
           RECORD  CONTAINS         300  CHARACTERS                     
           BLOCK  CONTAINS            0  RECORDS                        
           LABEL  RECORDS           ARE  STANDARD                       
           DATA  RECORD              IS  O-TRGT-RECORD.                 

       01  O-TRGT-RECORD.

           05  O-TRGT-GENERIC-REC      PIC  X(300).

           05  O-TRGT-REC-I  REDEFINES  O-TRGT-GENERIC-REC.
               10  O-TRGT-REC-I-267    PIC  X(267).
               10  FILLER              PIC  X(033).

           05  O-TRGT-REC-J  REDEFINES  O-TRGT-GENERIC-REC.
               10  O-TRGT-REC-J-105    PIC  X(105).
               10  FILLER              PIC  X(195).

           05  O-TRGT-REC-K  REDEFINES  O-TRGT-GENERIC-REC.
               10  O-TRGT-REC-K-105    PIC  X(105).
               10  FILLER              PIC  X(195).

      ***************************************************************   
      *                                                             *   
      *    IO-PPKZ-FILE                          DDNAME - LCHVPPKZ  *   
      *                                                             *   
      *    1000 BYTE                                                *   
      ***************************************************************   
           SKIP2                                                        
       FD  IO-PPKZ-FILE                                                 
           BLOCK  CONTAINS     0  RECORDS                               
           LABEL  RECORDS    ARE  STANDARD                              
           DATA   RECORD      IS  LCHYPPKZ.

      ***  COPY  LCHYPPKZ.
       01  LCHYPPKZ.                                                    
                                                                        
           05  PPKZ-KEY.                                                
      * 7v~J ( u/vi,zS/JEv,v{77v~ ..)             
               10  PPKZ-FILE-NAME         PIC X(01).                    
           05  PPKZ-DATA                  PIC X(999).                   
                                                                        
           05  PPKZ-MGMT-INFO  REDEFINES  PPKZ-DATA.                    
      * 7v~J CHECK                                                
               10  PPKZ-FILE-IN-SVC       PIC X(01).                    
      * Vpsa CHECK                                              
               10  PPKZ-SERVICE-FLAG      PIC X(01).                    
                   88  PPKZ-SERVICE-IN-PROGRESS  VALUE 'Y'.             
                   88  PPKZ-SERVICE-AVAILABLE    VALUE 'N' ' '.         
      * TIME OUT CHECK                                                  
               10  PPKZ-TIMER-INDICATOR   PIC X(01).                    
                   88  TIMER-EVENT-IS-EXPIRED    VALUE 'Y'.             
                   88  TIMER-EVENT-IS-REQUESTED  VALUE 'N' ' '.         
      * /}.                                                    
               10  PPKZ-SCHEDULER-EXIT    PIC X(01).                    
                   88  SCHEDULER-IS-NOT-NEEDED  VALUE 'Y'.              
      * KIA -> LG TERMINAL NO                                           
               10  PPKZ-INCOMING-LU             PIC X(04).              
      * LG -> KIA TERMINAL NO                                           
               10  PPKZ-OUTGOING-LU             PIC X(04).              
               10  PPKZ-LU-1                    PIC X(04).              
               10  PPKZ-LU-2                    PIC X(04).              
               10  PPKZ-LU-3                    PIC X(04).              
               10  PPKZ-LU-4                    PIC X(04).              
               10  FILLER                       PIC X(971).             
                                                                        
           05  PPKZ-FILE-INFO  REDEFINES  PPKZ-DATA.                    
      * JaVh/l/wa                                              
               10  PPKZ-SVC-AVAILABILITY        PIC X(03).              
                   88  PPKZ-SVC-IS-DISABLED     VALUE 'DIS'.            
                   88  PPKZ-SVC-IS-ENABLED      VALUE 'ENA'.            
      * FILE SIZE                                                       
               10  PPKZ-FILE-SIZE               PIC 9(12).              
      * RECORD COUNT ( euV )                                         
               10  PPKZ-SEQ-SIZE                PIC 9(06).              
      * }E~p/a  n~H/a                                          
               10  PPKZ-REC-SIZE                PIC 9(03).              
      * /avKa  Ha FLAG                                         
               10  PPKZ-TRANSFER-STATUS         PIC X(02).              
                   88  TRANSFER-IS-NOT-STARTED   VALUE SPACES.          
                   88  TRANSFER-IS-NOT-COMPLETED VALUE 'ER'.            
                   88  TRANSFER-IS-COMPLETED     VALUE 'OK'.            
      * /av}  VeuV                                          
               10  PPKZ-SEQ-TRANSFERED          PIC 9(06).              
      * /av}  E~p/hVa (105BYTE, 267BYTE ahna )           
               10  PPKZ-REC-TRANSFERED          PIC 9(09).              
      * /av} BYTE                                               
               10  PPKZ-BYTE-TRANSFERED         PIC 9(12).              
               10  FILLER                       PIC X(946).             
                                                                        
      *****************************************************************
      *                                                               *
      *                 W O R K I N G   S T O R A G E                 *
      *                                                               *
      *****************************************************************
       WORKING-STORAGE                   SECTION.                       
                                                                        
       01  WS-BEGIN                    PIC  X(40) VALUE                 
           'LCHBVJ20 *** WORKING STORAGE BEGINS HERE'.                  
                                                                        
      *****************************************************************
      *                                                               *
      *                     U S E R - A B E N D S                     *
      *                                                               *
      *****************************************************************
       01  USER-ABENDS.
           05  U-ABEND.
               10  U-ABEND-CODE        PIC S9(04) VALUE +2001.
               10  FILLER              PIC  X(01) VALUE '-'.
               10  U-ABEND-MSG         PIC  X(50) VALUE SPACES.

      *****************************************************************
      *                                                               *
      *                    A C C U M U L A T O R S                    *
      *                                                               *
      *****************************************************************
                                                                        
       01  ACCUMULATORS.                                                
                                                                        
           05  A-SRCE-READ-CNT         PIC S9(09) COMP SYNC VALUE +0.   
                                                                        
           05  A-TRGT-WRITE-CNT        PIC S9(09) COMP SYNC VALUE +0.   
                                                                        
           05  A-PPKZ-READ-CNT         PIC S9(09) COMP SYNC VALUE +0.   
           05  A-PPKZ-READ-ERR-CNT     PIC S9(09) COMP SYNC VALUE +0.   
                                                                        
           05  A-PPKZ-REWRITE-CNT      PIC S9(09) COMP SYNC VALUE +0.   
           05  A-PPKZ-REWRITE-ERR-CNT  PIC S9(09) COMP SYNC VALUE +0.   
                                                                        
      ******************************************************************
      *                                                                *
      *                        C O N S T A N T S                       *
      *                                                                *
      ******************************************************************
       01  CONSTANTS.                                                   
                                                                        
           05  C-PROG-ID               PIC  X(08) VALUE 'LCHBVJ20'.

           05  C-SRCE-OPEN-ERR-CD    PIC S9(04) COMP SYNC VALUE +2001.
           05  C-PPKZ-OPEN-ERR-CD    PIC S9(04) COMP SYNC VALUE +2002.
           05  C-PPKZ-OVFL-ERR-CD    PIC S9(04) COMP SYNC VALUE +2003.
           05  C-SYSIN-ERR-CD        PIC S9(04) COMP SYNC VALUE +2004.
           05  C-NOTNUM-ERR-CD       PIC S9(04) COMP SYNC VALUE +2005.
                                                                        
           05  C-SRCE-OPEN-ERR-MSG   PIC  X(50) VALUE
               'USER ABEND: SOURCE VSAM OPEN ERROR!'.
           05  C-PPKZ-OPEN-ERR-MSG   PIC  X(50) VALUE
               'USER ABEND: PPKZ VSAM OPEN ERROR!'.
           05  C-PPKZ-OVFL-ERR-MSG   PIC  X(50) VALUE
               'USER ABEND: PPKZ VSAM OVERFLOWED!'.
           05  C-SYSIN-ERR-MSG       PIC  X(50) VALUE
               'USER ABEND: INVALID SYSIN INFO!  '.
           05  C-NOTNUM-ERR-MSG      PIC  X(50) VALUE
               'USER ABEND: FIELD NOT NUMERIC!   '.
                                                                        
           05  C-STATUS-NORMAL         PIC  X(04) VALUE '00'.
                                                                        
           05  C-MAX-REC-I-CNT         PIC  9(02) VALUE 14.
           05  C-MAX-REC-J-CNT         PIC  9(02) VALUE 36.
           05  C-MAX-REC-K-CNT         PIC  9(02) VALUE 36.
                                                                        
           05  C-REC-SIZE-I            PIC  9(03) VALUE 267.
           05  C-REC-SIZE-J            PIC  9(03) VALUE 105.
           05  C-REC-SIZE-K            PIC  9(03) VALUE 105.
                                                                        
      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************
       01  SWITCHES.                                                    
                                                                        
           05  S-EOF-SRCE-SWITCH       PIC  X(01) VALUE LOW-VALUES.     
               88  S-EOF-SRCE-REACHED             VALUE HIGH-VALUES.    
                                                                        
           05  S-ERROR-SWITCH          PIC  X(01) VALUE LOW-VALUES.     
               88  S-ERROR-FOUND                  VALUE HIGH-VALUES.    
                                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************
       01  WORK-AREAS.                                                  
                                                                        
           05  W-ERR-TYPE                PIC  X(01).
           05  W-SUB-PGM                 PIC  X(08).
           05  W-ABEND-CODE              PIC S9(09) COMP SYNC VALUE +0.
           05  W-SYSTEM-DATE             PIC  X(08).
           05  W-SYSTEM-TIME             PIC  X(06).
           05  W-SRCE-STATUS           PIC  X(02) VALUE '00'.           
               88  W-SRCE-STATUS-NORMAL           VALUE '00' '97'.      
                                                                        
           05  W-PPKZ-STATUS           PIC  X(02) VALUE '00'.           
               88  W-PPKZ-STATUS-NORMAL           VALUE '00' '97'.      
               88  W-PPKZ-STATUS-OVERFLOW         VALUE '24'.
                                                                        
           05  W-SYSIN-INFO.
               10  W-SYSIN-FILENAME      PIC  X(01) VALUE SPACES.
                   88  W-SYSIN-FILENAME-IS-VALID    VALUE 'I' 'J' 'K'.
                   88  W-SYSIN-FILENAME-IS-I        VALUE 'I'.
                   88  W-SYSIN-FILENAME-IS-J        VALUE 'J'.
                   88  W-SYSIN-FILENAME-IS-K        VALUE 'K'.
                                                                        
           05  W-IDX                     PIC  9(02) VALUE ZERO.         
           05  W-REC-CNT                 PIC  9(02) VALUE ZERO.         
           05  W-MAX-REC-CNT             PIC  9(02) VALUE ZERO.
                                                                        
      ****************************************************************
      *                                                              *
      *          C O P Y                                             *
      *                                                              *
      ****************************************************************
      ****************************************************************
      *    BATCH STARTAREA                                           *
      ****************************************************************
       01  STRTAREA.
         REPLACE        == (BNCS) ==  BY == STRT ==.
           COPY  LCBYSTRT.
         REPLACE OFF.

      ****************************************************************
      *                                                              *
      *          SQLCA DEFINITION                                    *
      *                                                              *
      ****************************************************************

      ****************************************************************
      *                                                              *
      *    P A R A M E T E R S                                       *
      *                                                              *
      ****************************************************************
      ****************************************************************
      * LCBXU910 PROGRAM ( GET COMMIT COUNT & RESTART INFORMATION )  *
      ****************************************************************
       01  LCBXU910-PARAM.
         02  LCBXU910-STRTAREA.
         REPLACE        == (BNCS) ==  BY == U910 ==.
           COPY  LCBYSTRT.
         REPLACE OFF.
         02  LCBXU910-USERAREA.
           COPY  LCBYU910.

      ****************************************************************
      * LCBXU930 PROGRAM ( BATCH FINALIZATION )                      *
      ****************************************************************
       01  LCBXU930-PARAM.
         02  LCBXU930-STRTAREA.
         REPLACE        == (BNCS) ==  BY == U930 ==.
           COPY  LCBYSTRT.
         REPLACE OFF.
         02  LCBXU930-USERAREA.
           COPY  LCBYU930.

      ****************************************************************
      *                                                              *
      *    T A B L E S                                               *
      *                                                              *
      ****************************************************************
      *01  TABLES.

      ******************************************************************
      *                                                                *
      *           E N D   O F   W O R K I N G   S T O R A G E          *
      *                                                                *
      ******************************************************************
       01  WS-END                       PIC  X(40) VALUE                
           'LCHBVJ20 ***** WORKING STORAGE ENDS HERE'.                  
                                                                        
      ******************************************************************
      *                                                                *
      *               P R O C E D U R E   D I V I S I O N              *
      *                                                                *
      ******************************************************************
       PROCEDURE                         DIVISION.                      
                                                                        
      *==============================================================*
      *                                                              *
      *            S T A R T    B I Z   H A N D L E R                *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *          I N I T I A L Z A T I O N                           *
      *                                                              *
      ****************************************************************
       INITIALIZATION                    SECTION.
                                                                        
           MOVE     'Y'                  TO  STRT-BOCOM-ERR-TYPE.
           MOVE      C-PROG-ID           TO  STRT-BOCOM-ERR-PROG.

           PERFORM  S1000-OPEN-FILE.
                                                                        
      *    I :Vzuvi  ~we-t~/(Kv//  ~iE)
      *    J :VzzSJEv  ~we
      *    K :~v/  /v{7  7v~

           PERFORM  S1100-CHECK-OPEN-STATUS.
                                                                        
      *    PROGRAM START ENTRY ...

           PERFORM  S1500-CALL-LCBXU910.

           ACCEPT   W-SYSIN-INFO        FROM  SYSIN.
           PERFORM  S1700-VALIDATE-SYSIN.
                                                                        
      *   av/zq/ARRAY INDEX COUNT BaBi                      
      *     A,I  : 265 * 14 TIMES        -->  14                        
      *     B,J  : 105 * 36 TIMES        -->  36                        
      *     C,K  : 105 * 36 TIMES        -->  36                        
           PERFORM  S1600-SET-FILE-INFO.

           ACCEPT  W-SYSTEM-DATE         FROM  DATE  YYYYMMDD.
           ACCEPT  W-SYSTEM-TIME         FROM  TIME.
                                                                        
      * KIA~waH  Vo  7v~VSAM READ

           PERFORM  S1300-READ-SRCE-FILE.
                                                                        
      ****************************************************************
      *                                                              *
      *                       M A I N L I N E                        *
      *                                                              *
      ****************************************************************
       MAINLINE  SECTION.
                                                                        
           PERFORM  S1400-MAIN-PROCESS                                  
                                        UNTIL  S-EOF-SRCE-REACHED.      

           MOVE 'N'                      TO  STRT-BOCOM-ERR-TYPE.

      ****************************************************************  
      *                                                              *  
      *                  F I N A L I Z A T I O N                     *  
      *                                                              *  
      ****************************************************************  
       FINALIZATION                      SECTION.                       

      *    MASTER CONTROL VSAM UPDATE

           IF  A-SRCE-READ-CNT  >  +0
               PERFORM  S2100-UPDATE-MGMT-FILE
           END-IF.

           PERFORM  S2000-END-RTN.

           PERFORM  S2200-CLOSE-FILE.

           IF  STRT-BOCOM-ERR-TYPE  NOT = 'N'
               PERFORM  S2300-DISPLAY-ERRMSG
               MOVE     U-ABEND-CODE     TO  RETURN-CODE
           ELSE
               MOVE     +0000            TO  RETURN-CODE
           END-IF.

           PERFORM  S2400-DISPLAY-RESULT.
                                                                        
           GOBACK.                                                      
                                                                        
      *==============================================================*
      *                                                              *
      *                E N D    B I Z   H A N D L E R                *
      *                                                              *
      *==============================================================*
      *==============================================================*
      *                                                              *
      *         S T A R T    A C C E P T   I N F O R M A T I O N     *
      *                                                              *
      *==============================================================*
      *NONE
      *==============================================================*
      *                                                              *
      *             E N D    A C C E P T   I N F O R M A T I O N     *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *               S T A R T    F I L E   O P E N                 *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *            S 1 0 0 0 - O P E N -  F I L E                    *
      *                                                              *
      * 1/}/l  ~~pSAM FILEOPEN}m/                      *  
      ****************************************************************
       S1000-OPEN-FILE                   SECTION.
                                                                        
           OPEN  INPUT  I-SRCE-FILE                                     
                OUTPUT  O-TRGT-FILE
                   I-O  IO-PPKZ-FILE.

       S1000-OPEN-FILET-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *       S 1 1 0 0 - C H E C K - O P E N - S T A T U S          *
      *                                                              *
      ****************************************************************
       S1100-CHECK-OPEN-STATUS           SECTION.

           IF  W-SRCE-STATUS-NORMAL
               CONTINUE
           ELSE
               MOVE  'E'                 TO  STRT-BOCOM-ERR-TYPE        
               MOVE  'S1100'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               MOVE  C-SRCE-OPEN-ERR-CD  TO  STRT-BOCOM-ERR-STATUS
               MOVE  C-SRCE-OPEN-ERR-MSG TO  STRT-BOCOM-ERR-DATA        
               DISPLAY '>>  S1100-CHECK-OPEN-STATUS   <<'               
               GO   TO  FINALIZATION
           END-IF.
                                                                        
           IF  W-PPKZ-STATUS-NORMAL
               CONTINUE
           ELSE
               MOVE  'E'                 TO  STRT-BOCOM-ERR-TYPE        
               MOVE  'S1100'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               MOVE  C-PPKZ-OPEN-ERR-CD  TO  STRT-BOCOM-ERR-STATUS
               MOVE  C-PPKZ-OPEN-ERR-MSG TO  STRT-BOCOM-ERR-DATA        
               DISPLAY '>>  S1100-CHECK-OPEN-STATUS   <<'               
               GO   TO  FINALIZATION
           END-IF.

       S1100-CHECK-OPEN-STATUS-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *                   E N D    F I L E   O P E N                 *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *               S T A R T    I N P U T   R E A D               *
      *                                                              *
      *==============================================================*
      ***************************************************************
      *                                                             *
      *            S 1 2 0 0 - R E A D - P P K Z - F I L E          *
      *                                                             *
      ***************************************************************
       S1200-READ-PPKZ-FILE              SECTION.

           MOVE  LOW-VALUES            TO  S-ERROR-SWITCH.
                                                                        
           READ  IO-PPKZ-FILE
               INVALID  KEY
                   MOVE  HIGH-VALUE    TO  S-ERROR-SWITCH
                   ADD  +1             TO  A-PPKZ-READ-ERR-CNT
                   DISPLAY  'INVALID PPKZ KEY => '  PPKZ-KEY
                            '(' W-PPKZ-STATUS ')'
                   GO   TO  S1200-READ-PPKZ-FILE-EXIT.
                                                                        
           ADD  +1                     TO  A-PPKZ-READ-CNT.

       S1200-READ-PPKZ-FILE-EXIT.
           EXIT.

      ***************************************************************
      *                                                             *
      *            S 1 3 0 0 - R E A D - S R C E - F I L E          *
      *                                                             *
      ***************************************************************
       S1300-READ-SRCE-FILE              SECTION.
                                                                        
           READ  I-SRCE-FILE   AT END
                 MOVE  HIGH-VALUE        TO  S-EOF-SRCE-SWITCH
                 GO                      TO  S1300-READ-SRCE-FILE-EXIT.

           IF  SRCE-SEQ-NO    =    ZERO
               GO                        TO  S1300-READ-SRCE-FILE
           ELSE
               CONTINUE
           END-IF.

           ADD  +1                       TO  A-SRCE-READ-CNT.
                                                                        
       S1300-READ-SRCE-FILE-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *                   E N D    I N P U T   R E A D               *
      *                                                              *
      *==============================================================*
                                                                        
      *==============================================================*
      *                                                              *
      *             S T A R T   H/  ~/I  D B ~K             *
      *                                                              *
      *==============================================================*
      *==============================================================*
      *                                                              *
      *                 E N D   H/  ~/I  D B ~K             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *           S T A R T   }am  ~/I  D B ~K             *
      *                                                              *
      *==============================================================*
      *==============================================================*
      *                                                              *
      *               E N D   }am  ~/I  D B ~K             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *          S T A R T    B U S I N E S S   L O G I C            *
      *                                                              *
      *==============================================================*
      ******************************************************************
      *                                                                *
      *               S 1 4 0 0 - M A I N - P R O C E S S              *
      *                                                                *
      ******************************************************************
       S1400-MAIN-PROCESS                SECTION.

           MOVE  SRCE-NUM-OF-RECS        TO  W-REC-CNT.
                                                                        
           PERFORM  S1800-CHECK-NUMERIC.
                                                                        
           PERFORM  S1900-DIVIDE-AND-WRITE  VARYING  W-IDX
               FROM  1  BY  1  UNTIL  W-IDX  >  W-REC-CNT
                                  OR  W-IDX  >  W-MAX-REC-CNT.
                                                                        
           PERFORM  S1300-READ-SRCE-FILE.
                                                                        
       S1400-MAIN-PROCESS-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *               S 1 5 0 0 - C A L L - L C B X U 9 1 0          *
      *                                                              *
      ****************************************************************
       S1500-CALL-LCBXU910               SECTION.

           INITIALIZE  LCBXU910-PARAM.

           MOVE  C-PROG-ID               TO  U910-PGM-ID.

           MOVE  'LCBXU910'              TO  W-SUB-PGM.
           CALL  W-SUB-PGM            USING  LCBXU910-PARAM.
           MOVE  LCBXU910-STRTAREA       TO  STRTAREA.

           IF  U910-BOCOM-ERR-TYPE    NOT =  'N'
               GO      TO  FINALIZATION
           END-IF.

       S1500-CALL-LCBXU910-EXIT.
           EXIT.

      ******************************************************************
      *                                                                *
      *              S 1 6 0 0 - S E T - F I L E - I N F O             *
      *                                                                *
      ******************************************************************
       S1600-SET-FILE-INFO               SECTION.

           EVALUATE  TRUE
               WHEN  W-SYSIN-FILENAME-IS-I
                     MOVE  C-MAX-REC-I-CNT
                                         TO  W-MAX-REC-CNT

               WHEN  W-SYSIN-FILENAME-IS-J
                     MOVE  C-MAX-REC-J-CNT
                                         TO  W-MAX-REC-CNT

               WHEN  W-SYSIN-FILENAME-IS-K
                     MOVE  C-MAX-REC-K-CNT
                                         TO  W-MAX-REC-CNT

           END-EVALUATE.

       S1600-SET-FILE-INFO-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *              S 1 7 0 0 - V A L I D A T E - S Y S I N         *
      *                                                              *
      ****************************************************************
       S1700-VALIDATE-SYSIN              SECTION.

           MOVE  W-SYSIN-FILENAME      TO  PPKZ-KEY.
           PERFORM  S1200-READ-PPKZ-FILE.

           IF  S-ERROR-FOUND
               MOVE  'E'                 TO  STRT-BOCOM-ERR-TYPE        
               MOVE  'S1700'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               MOVE  C-SYSIN-ERR-CD      TO  STRT-BOCOM-ERR-STATUS
               MOVE  C-SYSIN-ERR-MSG     TO  STRT-BOCOM-ERR-DATA        
               DISPLAY '>>  S1700-VALIDATE-SYSIN  <<'                   
               GO   TO  FINALIZATION
           ELSE
           IF  W-SYSIN-FILENAME-IS-VALID
               CONTINUE
           ELSE
               MOVE  'E'                 TO  STRT-BOCOM-ERR-TYPE        
               MOVE  'S1700'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               MOVE  C-SYSIN-ERR-CD      TO  STRT-BOCOM-ERR-STATUS
               MOVE  C-SYSIN-ERR-MSG     TO  STRT-BOCOM-ERR-DATA        
               DISPLAY '>>  S1700-VALIDATE-SYSIN  <<'                   
               GO   TO  FINALIZATION

           END-IF
           END-IF.

       S1700-VALIDATE-SYSIN-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *              S 1 8 0 0 - C H E C K - N U M E R I C           *
      *                                                              *
      ****************************************************************
       S1800-CHECK-NUMERIC               SECTION.
                                                                        
           IF  SRCE-NUM-OF-RECS  IS  NUMERIC
               CONTINUE
           ELSE
               MOVE 'Y'                  TO  STRT-BOCOM-ERR-TYPE
               MOVE  'S1800'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               DISPLAY  '>>  S1800-CHECK-NUMERIC  ERROR  <<'
               DISPLAY  'SRCE-SEQ-NO          = ' SRCE-SEQ-NO
               DISPLAY  'SRCE-NUM-OF-RECORDS  = ' SRCE-NUM-OF-RECS
               DISPLAY  '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
               GO    TO        FINALIZATION
           END-IF.
                                                                        
       S1800-CHECK-NUMERIC-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *         S 1 9 0 0 - D I V I D E - A N D - W R I T E          *
      *                                                              *
      *  avu  ~/  7v~105 BYTE~  we~  p7            *
      *                                                              *
      ****************************************************************
       S1900-DIVIDE-AND-WRITE            SECTION.

           MOVE  SPACES                  TO  O-TRGT-RECORD.

           EVALUATE  TRUE

               WHEN  W-SYSIN-FILENAME-IS-I
                     MOVE  SRCE-DATA-ITEM-I(W-IDX)
                                         TO  O-TRGT-REC-I-267

               WHEN  W-SYSIN-FILENAME-IS-J
                     MOVE  SRCE-DATA-ITEM-J(W-IDX)
                                         TO  O-TRGT-REC-J-105

               WHEN  W-SYSIN-FILENAME-IS-K
                     MOVE  SRCE-DATA-ITEM-K(W-IDX)
                                         TO  O-TRGT-REC-K-105

           END-EVALUATE.

           WRITE  O-TRGT-RECORD.

           ADD  +1                       TO  A-TRGT-WRITE-CNT.

       S1900-DIVIDE-AND-WRITE-EXIT.
           EXIT.

      ******************************************************************
      *                                                                *
      *              S 2 0 0 0 - E N D - R T N                         *
      *                                                                *
      ******************************************************************
       S2000-END-RTN                     SECTION.

           MOVE  STRT-BOCOM-ERR-TYPE     TO  W-ERR-TYPE.

      *--  INIT VAR
           INITIALIZE  LCBXU930-USERAREA.

      *--  MOVE KEY VAR
           MOVE  W-SYSTEM-DATE           TO  U930-CUR-DATE.
           MOVE  W-SYSTEM-TIME           TO  U930-CUR-TIME.
           MOVE  U910-PGM-ID             TO  U930-PGM-ID.
           MOVE  U910-PROC-ID            TO  U930-PROC-ID.

      *--  SUB PROGRAM
           MOVE  'LCBXU930'              TO  W-SUB-PGM.
           CALL  W-SUB-PGM            USING  LCBXU930-PARAM.

           IF    U930-BOCOM-ERR-TYPE      =  'N'
                 CONTINUE
           ELSE
                 DISPLAY  '  ***   END-RTN   ***  '
                 DISPLAY  '  CALL LCBXU930 ERROR  '
                 MOVE  LCBXU930-STRTAREA TO  STRTAREA
           END-IF.

           MOVE  W-ERR-TYPE              TO  STRT-BOCOM-ERR-TYPE.

       S2000-END-RTN-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *              E N D    B U S I N E S S   L O G I C            *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *           S T A R T   }am  ~/I  D B u             *
      *                                                              *
      *==============================================================*
      *==============================================================*
      *                                                              *
      *               E N D   }am  ~/I  D B u             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T   H/  ~/I  D B u             *
      *                                                              *
      *==============================================================*
      *NONE
      *==============================================================*
      *                                                              *
      *                 E N D   H/  ~/I  D B u             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T    O U T P U T   W R I T E             *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *         S 2 1 0 0 - U P D A T E - M G M T - F I L E          *
      *                                                              *
      ****************************************************************
       S2100-UPDATE-MGMT-FILE            SECTION.

           MOVE  W-SYSIN-FILENAME        TO  PPKZ-KEY.

           PERFORM  S1200-READ-PPKZ-FILE.

           MOVE  ZERO                    TO  PPKZ-FILE-SIZE.
           MOVE  ZERO                    TO  PPKZ-SEQ-SIZE.
           MOVE  ZERO                    TO  PPKZ-REC-SIZE.

           MOVE  SPACES                  TO  PPKZ-TRANSFER-STATUS.

           MOVE  ZERO                    TO  PPKZ-SEQ-TRANSFERED.
           MOVE  ZERO                    TO  PPKZ-REC-TRANSFERED.
           MOVE  ZERO                    TO  PPKZ-BYTE-TRANSFERED.

           MOVE  LOW-VALUES              TO  S-ERROR-SWITCH.
                                                                        
           MOVE  C-STATUS-NORMAL         TO  W-PPKZ-STATUS.

           REWRITE  LCHYPPKZ.

           IF  W-PPKZ-STATUS-NORMAL
               ADD  +1                   TO  A-PPKZ-REWRITE-CNT
           ELSE
           IF  W-PPKZ-STATUS-OVERFLOW
               MOVE  'E'                 TO  STRT-BOCOM-ERR-TYPE        
               MOVE  'S2100'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               MOVE  C-PPKZ-OVFL-ERR-CD  TO  STRT-BOCOM-ERR-STATUS
               MOVE  C-PPKZ-OVFL-ERR-MSG TO  STRT-BOCOM-ERR-DATA        
               DISPLAY '>>  S2100-UPDATE-MGMT-FILE  <<'                 
               GO   TO  FINALIZATION
           ELSE
               ADD  +1                   TO  A-PPKZ-REWRITE-ERR-CNT
               MOVE  'E'                 TO  STRT-BOCOM-ERR-TYPE        
               MOVE  'S2100'             TO  STRT-BOCOM-ERR-PARAGRAPH   
               DISPLAY  'PPKZ REWRITE FAILURE => '  PPKZ-KEY
                        '(' W-PPKZ-STATUS ')'
           END-IF
           END-IF.

       S2100-UPDATE-MGMT-FILE-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *                 E N D    O U T P U T   W R I T E             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T    F I L E   C L O S E                 *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *           S 2 2 0 0 - C L O S E - F I L E                    *
      *                                                              *
      ****************************************************************
       S2200-CLOSE-FILE                   SECTION.

           CLOSE  I-SRCE-FILE                                           
                  O-TRGT-FILE
                  IO-PPKZ-FILE.

       S2200-CLOSE-FILE-EXIT.
           EXIT.                                                        

      *==============================================================*
      *                                                              *
      *                 E N D    F I L E   C L O S E                 *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T    R E S U L T   D I S P L A Y         *
      *                                                              *
      *==============================================================*

      ****************************************************************
      *                                                              *
      *            S 2 3 0 0 - D I S P L A Y - E R R M S G           *
      *                                                              *
      ****************************************************************
       S2300-DISPLAY-ERRMSG              SECTION.

           DISPLAY  '>> ERROR MESSAGE'.
           DISPLAY  'ERR-TYPE=('  STRT-BOCOM-ERR-TYPE  ')'.

           IF  STRT-BOCOM-ERR-TYPE       =  'Y'
               DISPLAY  STRT-BOCOM-ERR-PROG
                        ' '
                        STRT-BOCOM-ERR-PARAGRAPH
                        ' '
                        STRT-BOCOM-ERR-TBLNAME
                        ' '
                        STRT-BOCOM-ERR-FUNC
                        ' '
                        STRT-BOCOM-ERR-STATUS
           ELSE
               DISPLAY  STRT-BOCOM-ERR-SUBMSG
           END-IF.

           DISPLAY  'ERR-DATA=('  STRT-BOCOM-ERR-DATA   ')'.

       S2300-DISPLAY-ERRMSG-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *           S 2 4 0 0 - D I S P L A Y - R E S U L T            *
      *                                                              *
      ****************************************************************
       S2400-DISPLAY-RESULT              SECTION.

           DISPLAY  '======= LCHJVJ20 WORK RESULT ======='.
           DISPLAY  'SOURCE FILENAME      => '  W-SYSIN-FILENAME.
           DISPLAY  '================================'.
           DISPLAY  'SRCE READ CNT        => '  A-SRCE-READ-CNT.        
           DISPLAY  'TRGT WRITE CNT       => '  A-TRGT-WRITE-CNT.       
           DISPLAY  '--------------------------------'.
           DISPLAY  'PPKZ READ CNT        => '  A-PPKZ-READ-CNT.        
           DISPLAY  'PPKZ READ ERR CNT    => '  A-PPKZ-READ-ERR-CNT.
           DISPLAY  'PPKZ REWRITE CNT     => '  A-PPKZ-REWRITE-CNT.     
           DISPLAY  'PPKZ REWRITE ERR CNT => '  A-PPKZ-REWRITE-ERR-CNT. 
           DISPLAY  '================================'.

       S2400-DISPLAY-RESULT-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *                 E N D    R E S U L T   D I S P L A Y         *
      *                                                              *
      *==============================================================*
                                                                        
