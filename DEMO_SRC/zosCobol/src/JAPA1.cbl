      *****************************************************************
      *                                                               *
      *         I D E N T I F I C A T I O N   D I V I S I O N         *
      *                                                               *
      *****************************************************************

       IDENTIFICATION        DIVISION.

       PROGRAM-ID.           JAPA1.
       AUTHOR.               K.D.HONG.
       INSTALLATION.         GTONE.
       DATE-WRITTEN.         2008.02.26.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *                    J  A  P  A  1                               *
      *                                                                *
      *  FUNCTION       -                                              *
      *                                                                *
      *  TRANSACTION    -  JAA1                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; JAPA1                       *
      *                                                                *
      *  INPUT PARMS    -  MQ(MESSAGEQUEUE)                            *
      *                                                                *
      *  OUTPUT PARMS   -  SEE DETAIL                                  *
      *                                                                *
      *  INPUT FILES    -  NONE                                         
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  DATA SET       -  DTKA.TKAAD  (       LOG)                  *
      *                    DRWA.TRWAD  (         )                  *
      *                                                                *
      *  SWITCHES       -  S-CICS-RETURN                               *
      *                    LOW-VALUES    PSEUDO RETURN                 *
      *                    HIGH-VALUES   CICS RETURN                   *
      *                                                                *
      *  EXITS          -  NORMAL   - RETURN TO USER TERMINAL FOR      *
      *                               TERMINAL INPUT.                  *
      *                                                                *
      *                               PASSWORDS CANCELS THE TASK.      *
      *                                                                *
      *                 -  ABNORMAL - NONE                             *
      *                                                                *
      *   DATE        S.E.             DESCRIPTION                     *
      *   ========    =============    =============================   *
      *   02/02/26    Y.M.PARK         PROGRAM INITIALIZE              *
      *   03/04/03    Y.M.PARK         TRAN                     *
      *                                                             *
      *   03/12/16    D.S.KIM                                   *
      *   04/05/18    D.S.KIM                                     *
      *   05/05/17    E.Y.KANG                                      *
      ******************************************************************
           EJECT
      *****************************************************************
      *                                                                *
      *            E N V I R O N M E N T   D I V I S I O N             *
      *                                                                *
      *****************************************************************
       ENVIRONMENT                     DIVISION.

      ******************************************************************
      *                                                                *
      *                   D A T A   D I V I S I O N                    *
      *                                                                *
      ******************************************************************
       DATA                            DIVISION.

      ******************************************************************
      *                                                                *
      *                 W O R K I N G   S T O R A G E                  *
      *                                                                *
      ******************************************************************
       WORKING-STORAGE                 SECTION.
       01  WS-START                    PIC X(50)
           VALUE 'JAPA1 - WORKING STORAGE BEGINS HERE'.


      ******************************************************************
      *                    A C C U M U L A T O R S                     *
      ******************************************************************
       01  ACCUMULATORS.
           05  A-ERROR-COUNT           PIC S9(04) COMP SYNC VALUE +0.
           05  A-INSERT-CNT            PIC S9(04) COMP SYNC VALUE +0.
           05  A-UPDATE-CNT            PIC S9(04) COMP SYNC VALUE +0.
           05  C-COMM-LNTH             PIC S9(04) COMP SYNC VALUE +4000.

      ******************************************************************
      *                       C O N S T A N T S                        *
      ******************************************************************
       01  CONSTANTS.
           05  C-PGM-JAPA3             PIC  X(05)  VALUE 'JAPA3'.
           05  C-PGM-JAPA1             PIC  X(05)  VALUE 'JAPA1'.
           05  C-PGM-AFP09             PIC  X(05)  VALUE 'AFP09'.
           05  C-PGM-RWPP5             PIC  X(05)  VALUE 'RWPP5'.
           05  C-PGM-LWPP5             PIC  X(05)  VALUE 'LWPP5'.
           05  C-PGM-LWSP5             PIC  X(05)  VALUE 'LWSP5'.
           05  C-PGM-RWPPJ             PIC  X(05)  VALUE 'RWPPJ'.
           05  C-PGM-LWPPI             PIC  X(05)  VALUE 'LWPPI'.
           05  C-PGM-LWPPJ             PIC  X(05)  VALUE 'LWPPJ'.
           05  C-PGM-KEPA1             PIC  X(05)  VALUE 'KEPA1'.
           05  C-TRAN-JAA1             PIC  X(04)  VALUE 'JAA1'.
           05  C-TRAN-KEA1             PIC  X(04)  VALUE 'KEA1'.
           05  C-TRAN-AF09             PIC  X(04)  VALUE 'AF09'.
           05  C-TRAN-RWP5             PIC  X(04)  VALUE 'RWP5'.
           05  C-TRAN-LWP5             PIC  X(04)  VALUE 'LWP5'.
           05  C-TRAN-RWPJ             PIC  X(04)  VALUE 'RWPJ'.
           05  C-TRAN-LWPJ             PIC  X(04)  VALUE 'LWPJ'.
           05  C-TRAN-RWP1             PIC  X(04)  VALUE 'RWP1'.
           05  C-TRAN-BCFA             PIC  X(04)  VALUE 'BCFA'.
           05  C-PGM-PFP01             PIC  X(05) VALUE 'PFP01'.
           05  C-PGM-PF01              PIC  X(04) VALUE 'PF01'.
           05  C-PGM-PFP09             PIC  X(05) VALUE 'PFP09'.
           05  C-SUBPGM-SSSHE          PIC  X(08)  VALUE 'SSSHE'.
           05  C-TRAN-START            PIC  X(04)  VALUE SPACE.
           05  C-PGM-XCTL              PIC  X(05)  VALUE SPACE.
      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************
       01  SWITCHES.
           05  S-CICS-RETURN           PIC  X(01) VALUE LOW-VALUES.
               88 S-CICS-RETURN-ON                VALUE HIGH-VALUES.

           05  S-PROCESS               PIC  X(01)  VALUE  LOW-VALUES.
               88  S-DO-NOT-PROCESS                VALUE  HIGH-VALUES.

      *    03 S-MQ-OPEN                PIC  X(01)  VALUE  LOW-VALUE.
      *        88  S-MQ-NOT-OPEN                   VALUE  HIGH-VALUES.
      *****************************************************************
      *                                                               *
      *                     W O R K   A R E A S                       *
      *                                                               *
      *****************************************************************
       01  WORKAREAS.
           05  W-TXOFF                 PIC  X(03)      VALUE SPACE.
           05  W-SYS-DT                PIC  X(08)      VALUE SPACE.
           05  W-SYS-TIME              PIC  X(06)      VALUE SPACE.
           05  W-SQLCODE               PIC  -(04).
030403     05  W-START-CODE            PIC  X(02)      VALUE SPACE.
PYJ        05  W-NO                    PIC  ZZZZZZ9.
050324     05  W-SUB-PGM               PIC  X(05) VALUE SPACE.
      *
050324*    05 W-SUB-SYSTEM-COMMON.
      *       10  W-SUB-AMT1           PIC S9(15) COMP-3.
      *       10  W-SUB-AMT2           PIC S9(15) COMP-3.
      *       10  W-FILLER             PIC X(034).
      *       10  W-SUB-TXPAYER-TP     PIC X(001).
      *       10  W-SUB-RESID-BUSNID   PIC X(013).
      *       10  W-SUB-TXTP-CD        PIC X(002).
      *       10  W-SUB-ASS-YYMM-FR    PIC X(006).
      *       10  W-SUB-ASS-YYMM-TO    PIC X(006).
      *       10  W-SUB-BIGO           PIC X(050).
      *       10  W-SUB-ALL            PIC X(001).
      *       10  W-SUB-RETURN-CODE    PIC X(001).
      *       10  W-SUB-PRTID          PIC X(004).
      *       10  W-SUB-NO1            PIC X(004).
      *       10  W-SUB-NO2            PIC X(003).
      *       10  W-SUB-NO3            PIC X(007).
      *       10  W-SUB-CODE           PIC X(001).
      *       10  W-SUB-XCTL-CONFM     PIC X(001).
      *       10  W-SUB-CALLING-PGM    PIC X(005).
      *       10  W-SUB-STATUS.
      *           15 L-COMM-ENG-FG-C   PIC  X(01).
      *           15 L-COMM-SQL-C      PIC  X(04).
      *           15 L-COMM-MSG-C      PIC  X(50).

           05  W-ABEND.
               10  W-ABEND-TYPE        PIC S9(09) COMP SYNC VALUE +2.
               10  W-ABEND-CODE        PIC S9(09) COMP SYNC VALUE +0.
               10  W-ABEND-MSG         PIC  X(42) VALUE SPACES.

040518     05  W-TX-SRVC-TP            PIC  X(05) VALUE SPACE.
               88 W-TX-SRVC-TP-OK                 VALUE
                  'D0020' 'C4026' 'C4043' 'E0026' 'F4001' 'D4049'
                  'D0019' 'E4002' 'C4040' 'E0027' 'D4014' 'D4050'
                  'D0021' 'D4019' 'B4007' 'E0018' 'D4016' 'C4001'
                  'B0013' 'C4009' 'C4035' 'E0008' 'C4057' 'C4060'
                  'D2004' 'C4012' 'C4034' 'E0019' 'D4046' 'C4059'
                  'C2002' 'C4020' 'D4035' 'E0025' 'D4041' 'C4047'
                  'C2003' 'D4012' 'C4051' 'E0020' 'D4048' 'C4049'
                  'D2002' 'B4012' 'C4031' 'E0024' 'C1006' 'C4054'
                  'D2005' 'C4066' 'C4032' 'D0013' 'D1009' 'C4052'
                  'D2007' 'C4019' 'B4004' 'E0021' 'C1002' 'C4053'
                  'D2011' 'D4010' 'C4030' 'E0022' 'D1001' 'C4058'
                  'D2015' 'D4051' 'C4022' 'D0014' 'D1002' 'C4055'
                  'C4004' 'C4050' 'C4013' 'E0023' 'C1016' 'C5001'
                  'D4002' 'C4048' 'C4005' 'C3003' 'C1003' 'C5002'
                  'D4022' 'B4013' 'C4028' 'D0016' 'D4033' 'D0017'
                  'D4024' 'D4042' 'D4017' 'C0001' 'C4042' 'E0009'
                  'D4005' 'C4061' 'C4027' 'C0004' 'B4005' 'E0002'
                  'D4011' 'C4056' 'C4024' 'C0021' 'D0004'.

           05 W-SUB-SYSTEM-COMMON.
040915*       PFP09
              10  W-SUB-CALLING-PGM    PIC X(005).
              10  W-FILLER             PIC X(045).

              10  W-SUB-TXPAYER-TP     PIC X(001).
              10  W-SUB-RESID-BUSNID   PIC X(013).
              10  W-SUB-TXTP-CD        PIC X(002).
              10  W-SUB-ASS-YYMM-FR    PIC X(006).
              10  W-SUB-ASS-YYMM-TO    PIC X(006).
              10  W-SUB-BIGO           PIC X(050).
              10  W-SUB-ALL            PIC X(001).
              10  W-SUB-RETURN-CODE    PIC X(001).
              10  W-SUB-PRTID          PIC X(004).
              10  W-SUB-NO1            PIC X(004).
              10  W-SUB-NO2            PIC X(003).
              10  W-SUB-NO3            PIC X(007).
              10  W-SUB-CODE           PIC X(001).
              10  W-SUB-XCTL-CONFM     PIC X(001).
              10  FILLER               PIC X(005).
              10  W-SUB-STATUS.
                  15 L-COMM-ENG-FG-C   PIC  X(01).
                  15 L-COMM-SQL-C      PIC  X(04).
                  15 L-COMM-MSG-C      PIC  X(50).

       01  JAPA1-REC.
           05  I-REC.                                                   
               10  I-TRWAD-KEY.
3                  15  I-RCVE-NO-TXOFF     PIC X(03).
7                  15  I-RCVE-NO-YY        PIC X(04).
14                 15  I-RCVE-NO-SEQNO     PIC 9(07).
15             10  I-TXPAYER-TP            PIC X(01).
28             10  I-TXPAYER-ID            PIC X(13).
41             10  I-RESID-BUSNID          PIC X(13).
43             10  I-TXTP-CD               PIC X(02).
49             10  I-ASS-YYMM-FR           PIC X(06).
50             10  I-RTN-TP                PIC X(01).
54             10  I-RTN-SERIAL-NO         PIC 9(04).
60             10  I-ASS-YYMM-TO           PIC X(06).
65             10  I-TX-SRVC-TP            PIC X(05).
66             10  I-RCVE-METHOD           PIC X(01).
74             10  I-RCVE-DT               PIC X(08).
78             10  I-TX-OFFCR-RCVE         PIC X(04).
79             10  I-TREAT-METHOD          PIC X(01).
87             10  I-TREAT-DUEDT           PIC X(08).
91             10  I-TX-OFFCR-APPV         PIC X(04).
99             10  I-APPV-DT               PIC X(08).
104            10  I-TRNS-DEPT             PIC X(05).
124            10  I-TRNS-AGENCY           PIC X(20).
125            10  I-USE-PURPOSE           PIC X(01).
126            10  I-SUBMIT-AGENCY         PIC X(01).
129            10  I-ISSUE-QTY             PIC 9(03).
130            10  I-DISTR-METHOD          PIC X(01).
131            10  I-TXPAYER-TP-RQSTR      PIC X(01).
144            10  I-RESID-RQSTR           PIC X(13).
145            10  I-TXPAYER-TP-RCVER      PIC X(01).
158            10  I-RESID-RCVER           PIC X(13).
160            10  I-TREAT-STAUS           PIC X(02).
161            10  I-RELATE-TXPAYER        PIC X(01).
169            10  I-ISSUE-DT              PIC X(08).
177            10  I-DUSDT-EXT             PIC X(08).
180            10  I-ACTL-ISSUE-QTY        PIC 9(03).
188            10  I-EXPIRE-DT             PIC X(08).
208            10  I-WHY-EXPIRE-DT         PIC X(20).
218            10  I-ADMIT-NO              PIC X(10).
226            10  I-ADMIT-DT              PIC X(08).
234            10  I-BUSNID-DISTR-DT       PIC X(08).
254            10  I-BUSNID-DISTR-CS       PIC X(20).
264            10  I-CREAT-DT              PIC X(10).
284            10  I-AGENCY-NM             PIC X(20).
290            10  I-ASS-YYMM-FR1          PIC X(06).
292            10  I-INCM-TP               PIC X(02).
293            10  I-OPEN-FG               PIC X(01).

       01  TSQ-REC.
           05  TS-SYS-TIME             PIC  X(08).
           05  FILLER                  PIC  X(01).
           05  TS-DATA                 PIC  X(300).

       01  HTS-AREA.
           05  RCVE-TX-SRVC-TP        PIC X(005).
           05  H-TRWAD-KEY.
               10 H-RCVE-NO-YY        PIC X(004).
               10 H-RCVE-NO-TXOFF     PIC X(003).
               10 H-RCVE-NO-SEQNO     PIC 9(007).
           05  H-TREAT-STAUS          PIC X(002).
           05  H-ISSUE-DT             PIC X(008).
           05  H-EXPIRE-DT            PIC X(008).
           05  H-BUSNID-DISTR-CS      PIC X(020).
           05  H-ERR-DOCU             PIC X(078).
           05  FILLER                 PIC X(001).
           05  H-ERR-TP               PIC X(001).
           05  H-FILLER               PIC X(849).

031216 01  HTS-B1003.                                                   
           05  HEAD-R.                                                  
               10  H1-RCVE-TX-SRVC-TP     PIC X(005).                   
               10  H1-TRWAD-KEY.                                        
                   15 H1-RCVE-NO-YY       PIC X(004).                   
                   15 H1-RCVE-NO-TXOFF    PIC X(003).                   
                   15 H1-RCVE-NO-SEQNO    PIC 9(007).                   
               10  H1-RESID-BUSNID-TRWAD  PIC X(013).
               10  H1-GUBUN               PIC X(005).
           05  B1003-R.                                                 
               10  H1-TREAT-STAUS         PIC  X(02).                   
               10  H1-ISSUE-DT            PIC  X(08).                   
               10  H1-EXPIRE-DT           PIC  X(08).                   
               10  H1-BUSNID-DISTR-CS     PIC  X(20).                   
               10  H1-ERR-DOCU            PIC  X(78).                   
               10  FILLER                 PIC  X(01).                   
               10  H1-ERR-TP              PIC  X(01).                   
      *----------------------------------------------------------*
      * MESSAGE QUEUE ERROR     *
      *----------------------------------------------------------*
       01  QE-ERR-AREA.
           05 QE-RESP-CODE       PIC -(05)9.
           05 QE-REASON-CODE     PIC -(05)9.

      *****************************************************************
      *                                                               *
      *    M E S S A G E  A R E A                                     *
      *                                                               *
      *****************************************************************
       01  MQ-CONSTANTS.
      * WAIT INTERVAL
      * 60       GET WAIT
           03 C-INTERVAL       PIC S9(09) BINARY VALUE +60000.

           03 W-MQ-COUNT       PIC S9(05) COMP   VALUE ZEROS.
      *----------------------------------------------------------*
      * LENGTH CONSTANTS *
      *----------------------------------------------------------*
           03 LEN-GET-MQ       PIC S9(04) VALUE +293.
      *----------------------------------------------------------*
      * MESSAGE QUEUE CONSTANTS *
      *----------------------------------------------------------*
           03 C-MQ-Q-MGER      PIC X(48) VALUE "MQT1".
           03 C-GET-MQ-NAME    PIC X(15) VALUE "MQHOST.JAPA1.LQ".
        COPY CMCP1.
      *----------------------------------------------------------*
      * MESSAGE QUEUE CONSTANTS *
      *----------------------------------------------------------*
       01  MQ-WORK-AREA.
           05 MQ-Q-MGER          PIC  X(48)        VALUE SPACE.
           05 MQ-HCONN           PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-HANDLE          PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-OPTION          PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-OBJECT          PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-RESP-CODE       PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-REASON-CODE     PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-INQUIRY         PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-GET-LENGTH      PIC S9(09) BINARY VALUE ZEROS.
           05 MQ-GET-DATALENGTH  PIC  9(04)        VALUE ZEROS.

      * *----------------------------------------------------------*
      * * MESSAGE QUEUE BUFFER                                     *
      * *----------------------------------------------------------*
       01  MQ-BUFFER           PIC X(293).
      *****************************************************************
      * MQ AREA                                                       *
      * M E S S A G E  Q U E U E                                      *
      *                                                               *
      *****************************************************************
      * Copy CMCP1 to somewhere. 
             COPY CMCP1.
      * 01  MQ-OBJECT-DESCRIPTOR.
      **     COPY CMQODV.
      *
      * 01  MQ-MESSAGE-DESCRIPTOR.
      *     Some operations for CMQODV 
      *     COPY CMQMDV.
      *     COPY CMQODV.
      *
      * 01  MQ-GET-MESSAGE-OPTIONS.
      *     COPY CMQGMOV.
      *
      **01  MQ-PUT-MESSAGE-OPTIONS.
      **    COPY CMQPMOV.
      *
      * 01  MQ-CONSTANTS.
      *     COPY CMQV.

030403*****************************************************************
      *                                                               *
      *                 V S A M    I O    A R E A                     *
      *                                                               *
      *****************************************************************


      *                                ***********         ************
      *                                *        MESSAGE VSAM          *
      *                                ***********         ************

           COPY                        SUY01.


           EJECT.
      *****************************************************************
      *                                                               *
      *                  M O D U L E   A R E A                        *
      *                                                               *
      *****************************************************************
      *                                ********************************
      *                                *       C O N S T A N S        *
      *                                ********************************
           COPY                        SSYAB.

      *                                ********************************
      *                                *     C O N S T A N T          *
      *                                ********************************
           COPY                        SSYBC.

      * Some operations for COPY. 
           COPY CMCP2.      
      **                                ********************************
      **                                *     EIBRESP       VALUE      *
      **                                ********************************
      *     COPY                        SSYBE.
      *
      **                                ********************************
      **                                *     WORK  COMMON  AREA       *
      **                                ********************************
      *     COPY                        SSYBG.
      *
      **                                ********************************
      **                                *     DB2 STATUS SQL CODE      *
      **                                ********************************
      *     COPY                        SSYBI.

      *                                ********************************
      *                                *     HANDLE AID IDENTIFER     *
      *                                ********************************
           COPY                        DFHAID.

      *                                ********************************
      *                                *     DATE CHECK WORK AREA     *
      *                                ********************************
      *    COPY                        SSYDC.

      *                                ********************************
      *                                *    SELF  COMM AREA           *
      *                                ********************************
PYJ   *    COPY                        SSYBF.
      *                                ***********         ************
      *                                *  PROGRAM SELF COMM AREA      *
      *                                ***********         ************
      *
       COPY QMY00.
       
       

       01  W-COMM-AREA-HTS REDEFINES      W-COMM-AREA.
           05 FILLER                      PIC  X(400).
           05 FILLER                      PIC  X(300).
           05 W-COMM-SUB-HTS.
              10 FILLER                   PIC  X(078).
              10 W-COMM-SUB-DATA.
                 15 W-COMM-HTS-INCM-TP       PIC  X(002).
                 15 W-COMM-HTS-PRTID         PIC  X(004).
                 15 W-COMM-HTS-RCVEYY        PIC  X(004).
                 15 W-COMM-HTS-RCVETXOFF     PIC  X(003).
                 15 W-COMM-HTS-RCVESEQ       PIC  X(007).
                 15 W-COMM-HTS-RCVESEQR      REDEFINES
                    W-COMM-HTS-RCVESEQ       PIC  9(007).
                 15 FILLER                   PIC  X(001).
                 15 W-COMM-HTS-FG            PIC  X(001).
           05 W-COMM-SELF-HTS.
              10 FILLER                   PIC  X(400).
      * Some operations for CMCP2. 
       COPY CMCP2.
       01  W-COMM-AREA-REDFR REDEFINES    W-COMM-AREA.
      *
           05 FIL                         PIC  X(450).
      * SUB SYSTEM AREA
           05 W-COMM-SUB-PGM.
              10 W-COMM-XCTL-CALLING-PGM  PIC  X(005).
              10 FILLER                   PIC  X(070).
              10  W-SUB-STATUS.
                  15 L-COMM-ENG-FG        PIC  X(001).
                  15 L-COMM-SQL           PIC  X(004).
                  15 L-COMM-MSG           PIC  X(050).
              10 W-COMM-XCTL-PRTID        PIC  X(004).
              10 W-COMM-XCTL-RCVEYY       PIC  X(004).
              10 W-COMM-XCTL-RCVETXOFF    PIC  X(003).
              10 W-COMM-XCTL-RCVESEQ      PIC  X(007).
              10 W-COMM-XCTL-RCVESEQR     REDEFINES
                 W-COMM-XCTL-RCVESEQ      PIC  9(007).
              10 FILLER                   PIC  X(001).
              10 W-COMM-XCTL-CONFM        PIC  X(001).

      * SELF AREA
           05 W-COMM-SELF-PGM.
      *      
              10 W-COMM-XCTL-PDUEDT       PIC  X(008).
011218        10 W-COMM-UNION-TP          PIC  X(001).
              10 FIL                      PIC  X(3391).


      *****************************************************************
      *                                                               *
      *           E N D   O F  W O R K I N G  S T O R A G E           *
      *                                                               *
      *****************************************************************
       01  WS-END                      PIC X(40)
           VALUE 'JAPA1 - WORKING STORAGE ENDS HERE'.

       EJECT
      *****************************************************************
      *                                                               *
      *       DB2   WORK  AREA                                        *
      *                                                               *
      *****************************************************************
      *                                ********************************
      *                                *    SQL COMMUNICATION AREA    *
      *                                ********************************
           EXEC  SQL   INCLUDE  SQLCA   END-EXEC.

      *                                ********************************
      *                                *    DB2        TRWAD          *
      *                                ********************************
           EXEC  SQL   INCLUDE  RWOAD   END-EXEC.

      *                                ********************************
      *                                *    DB2        TKAAD          *
      *                                ********************************
           EXEC  SQL   INCLUDE  KAOAD   END-EXEC.

      ******************************************************************
      *                                                                *
      *              P R O C E D U R E   D I V I S I O N               *
      *                                                                *
      ******************************************************************
                                                                        
       PROCEDURE               DIVISION.                                
                                                                        
       S0000-BEGIN              SECTION.

           PERFORM   S1000-INIT.

020321     PERFORM   S2000-MAIN     UNTIL   S-DO-NOT-PROCESS.

           PERFORM   S3000-FINAL.

           PERFORM   S9100-RETURN.

           EJECT

       S0000-BEGIN-EXIT.
           EXIT.
      ******************************************************************
      *
      *S1000-INIT
      *
      ******************************************************************
       S1000-INIT               SECTION.

           INITIALIZE     WORKAREAS.

           PERFORM S8200-GET-SYSTEM-DATE.
           ACCEPT W-MSG-CONTENTS FROM DATE.	
030403     IF  W-START-CODE = 'TD'
                MOVE 'RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'
                                         TO W-MSG-CONTENTS
                EXEC CICS SEND   FROM   (W-MSG-CONTENTS)
                                 LENGTH (C-CLEAR-MSG-LNTH)
                                 ERASE
                                 RESP   (W-RETURN-CODE)
                END-EXEC
                PERFORM S9100-RETURN
           ELSE

               PERFORM S1200-MQ-OPEN-PROC

               MOVE  LOW-VALUES               TO  JAPA1-REC

020321         PERFORM S1300-MQ-GET-PROC

           END-IF.

       S1000-INIT-EXIT.
           EXIT.
      *************************************************************
      *                                                           *
      *S 1 1 0 0 - M Q - O P E N - P R O C                        *
      *P  MQ OPEN                                                 *
      *                                                           *
      *************************************************************
       S1200-MQ-OPEN-PROC              SECTION.

      *---- OPEN LOG TSQ WRITE
           MOVE SPACE                  TO TSQ-REC.
      *    MOVE 'MQ OPEN       .. '    TO TS-DATA(1:17).
      *    MOVE C-GET-MQ-NAME          TO TS-DATA(18:17).
      *    PERFORM S8100-LOG-TSQ-WRITE.

           MOVE MQOT-Q               TO MQOD-OBJECTTYPE.
           MOVE C-GET-MQ-NAME        TO MQOD-OBJECTNAME.
           MOVE MQOO-INPUT-SHARED    TO MQ-OPTION.

           CALL "MQOPEN"  USING  MQ-HCONN
                                 MQOD
                                 MQ-OPTION
                                 MQ-HANDLE
                                 MQ-RESP-CODE
                                 MQ-REASON-CODE.

           IF  MQ-RESP-CODE  =  MQCC-OK
               CONTINUE
021002*         MOVE 'MQ OPEN RESOLVDEQ.'   TO TS-DATA(01:18)
"     *         MOVE MQOD-RESOLVEDQNAME     TO TS-DATA(19:48)
"     *         PERFORM S8100-LOG-TSQ-WRITE

           ELSE
               MOVE 'MQ OPEN  ERROR.. '    TO TS-DATA(1:17)
               MOVE C-GET-MQ-NAME          TO TS-DATA(18:17)
               MOVE 'COMPCODE :'           TO TS-DATA(35:10)
               MOVE MQ-RESP-CODE           TO TS-DATA(45:10)
               MOVE 'REASON   :'           TO TS-DATA(55:10)
               MOVE MQ-REASON-CODE         TO TS-DATA(65:10)
               PERFORM S8100-LOG-TSQ-WRITE
               PERFORM S9100-RETURN
           END-IF.

       S1200-MQ-OPEN-PROC-EXIT.
           EXIT.
      *************************************************************
      *                                                           *
      *S 1 2 0 0 - M Q - G E T - P R O C                          *
      *P  MQ  GET                                                 *
      *                                                           *
      *************************************************************
       S1300-MQ-GET-PROC               SECTION.

      *---- GET  LOG TSQ WRITE
           MOVE SPACE                  TO TSQ-REC.
      *    MOVE 'MQ GET        .. '    TO TS-DATA(1:17).
      *    MOVE C-GET-MQ-NAME          TO TS-DATA(18:17).
      *    PERFORM S8100-LOG-TSQ-WRITE.

           MOVE C-GET-MQ-NAME             TO MQOD-OBJECTNAME.
           MOVE C-INTERVAL                TO MQGMO-WAITINTERVAL.
           MOVE LEN-GET-MQ                TO MQ-GET-LENGTH.
           MOVE MQOO-INPUT-SHARED         TO MQ-OPTION.
           MOVE MQMI-NONE                 TO MQMD-MSGID.
           MOVE MQCI-NONE                 TO MQMD-CORRELID.
           COMPUTE MQGMO-OPTIONS = MQGMO-NO-SYNCPOINT
                                 + MQGMO-NO-WAIT
                                 + MQGMO-ACCEPT-TRUNCATED-MSG.

           INITIALIZE           MQ-BUFFER
                                JAPA1-REC.

           CALL "MQGET" USING MQ-HCONN
                              MQ-HANDLE
                              MQMD
                              MQGMO
                              MQ-GET-LENGTH
                              MQ-BUFFER
                              MQ-GET-DATALENGTH
                              MQ-RESP-CODE
                              MQ-REASON-CODE.

           IF  MQ-RESP-CODE  = MQCC-OK
      *  GET data form QUEUE
021002*        MOVE 'MQ GET  REPLY Q..'    TO TS-DATA(01:17)
"     *        MOVE MQMD-REPLYTOQ          TO TS-DATA(18:48)
"     *        MOVE '   REPLY QMGR    '    TO TS-DATA(66:17)
"     *        MOVE MQMD-REPLYTOQMGR       TO TS-DATA(84:10)
"     *        PERFORM S8100-LOG-TSQ-WRITE

               PERFORM S8200-GET-SYSTEM-DATE
               MOVE MQ-BUFFER         TO JAPA1-REC
      *        MOVE I-TRWAD-KEY       TO TS-DATA
               MOVE JAPA1-REC         TO TS-DATA
               PERFORM S8100-LOG-TSQ-WRITE
           ELSE
               INITIALIZE MQ-BUFFER
               MOVE HIGH-VALUE                TO S-PROCESS

               IF  MQ-REASON-CODE  =  MQRC-NO-MSG-AVAILABLE
                   CONTINUE
               ELSE
                   MOVE 'MQ GET   ERROR.. '    TO TS-DATA(1:17)
                   MOVE C-GET-MQ-NAME          TO TS-DATA(18:17)
                   MOVE 'COMPCODE :'           TO TS-DATA(35:10)
                   MOVE MQ-RESP-CODE           TO TS-DATA(45:10)
                   MOVE 'REASON   :'           TO TS-DATA(55:10)
                   MOVE MQ-REASON-CODE         TO TS-DATA(65:10)
                   PERFORM S8100-LOG-TSQ-WRITE
                   PERFORM S3000-FINAL
                   PERFORM S9100-RETURN
               END-IF
           END-IF.

       S1300-MQ-GET-PROC-EXIT.
           EXIT.
      *****************************************************************
      *                                                               *
      *S2000-MAIN                                                     *
      *                                                               *
      *****************************************************************
       S2000-MAIN      SECTION.

           PERFORM  S2100-MOVE-MSG2TABLE.

           PERFORM  S2200-TRWAD-INSERT.

           IF  SQLCODE  =  C-SQL-NORMAL OR
040518                     C-SQL-DUP
               MOVE     ' '         TO  RCVE-ERR-GBN   OF TKAAD
040518         MOVE I-TX-SRVC-TP    TO  W-TX-SRVC-TP
040518         IF   W-TX-SRVC-TP-OK
                    CONTINUE
               ELSE
                    PERFORM  S2300-MOVE-TABLE2COMM
                    PERFORM  S2400-START-HTS
               END-IF
           ELSE
               MOVE     'Y'         TO  RCVE-ERR-GBN   OF TKAAD
           END-IF.

           PERFORM  S2500-TKAAD-INSERT.

020321     PERFORM  S1300-MQ-GET-PROC.

       S2000-MAIN-EXIT.
           EXIT.
           EJECT
      ****************************************************************
      *
      *S2100-MOVE-MSG2TABLE
      *      MOVE  MQ-BUFFER    TO  TRWAD-REC.
      ****************************************************************
       S2100-MOVE-MSG2TABLE            SECTION.

           MOVE  I-RCVE-NO-TXOFF    TO  RCVE-NO-TXOFF    OF TRWAD.
           MOVE  I-RCVE-NO-YY       TO  RCVE-NO-YY       OF TRWAD.
           MOVE  I-RCVE-NO-SEQNO    TO  RCVE-NO-SEQNO    OF TRWAD.
           MOVE  I-TXPAYER-TP       TO  TXPAYER-TP       OF TRWAD.
           MOVE  I-TXPAYER-ID       TO  TXPAYER-ID       OF TRWAD.
           MOVE  I-RESID-BUSNID     TO  RESID-BUSNID     OF TRWAD.
           MOVE  I-TXTP-CD          TO  TXTP-CD          OF TRWAD.
           MOVE  I-ASS-YYMM-FR      TO  ASS-YYMM-FR      OF TRWAD.
           MOVE  I-RTN-TP           TO  RTN-TP           OF TRWAD.
           MOVE  I-RTN-SERIAL-NO    TO  RTN-SERIAL-NO    OF TRWAD.
           MOVE  I-ASS-YYMM-TO      TO  ASS-YYMM-TO      OF TRWAD.
           MOVE  I-TX-SRVC-TP       TO  TX-SRVC-TP       OF TRWAD.
           MOVE  I-RCVE-METHOD      TO  RCVE-METHOD      OF TRWAD.      
           MOVE  I-RCVE-DT          TO  RCVE-DT          OF TRWAD.      
           MOVE  I-TX-OFFCR-RCVE    TO  TX-OFFCR-RCVE    OF TRWAD       
           MOVE  I-TREAT-METHOD     TO  TREAT-METHOD     OF TRWAD.      
           MOVE  I-TREAT-DUEDT      TO  TREAT-DUEDT      OF TRWAD.      
           MOVE  I-TX-OFFCR-APPV    TO  TX-OFFCR-APPV    OF TRWAD.      
           MOVE  I-APPV-DT          TO  APPV-DT          OF TRWAD.      
           MOVE  I-TRNS-DEPT        TO  TRNS-DEPT        OF TRWAD.      
           MOVE  I-TRNS-AGENCY      TO  TRNS-AGENCY      OF TRWAD.      
           MOVE  I-USE-PURPOSE      TO  USE-PURPOSE      OF TRWAD.      
           MOVE  I-SUBMIT-AGENCY    TO  SUBMIT-AGENCY    OF TRWAD.      
           MOVE  I-ISSUE-QTY        TO  ISSUE-QTY        OF TRWAD.      
           MOVE  I-DISTR-METHOD     TO  DISTR-METHOD     OF TRWAD.      
           MOVE  I-TXPAYER-TP-RQSTR TO  TXPAYER-TP-RQSTR OF TRWAD.      
           MOVE  I-RESID-RQSTR      TO  RESID-RQSTR      OF TRWAD.      
           MOVE  I-TXPAYER-TP-RCVER TO  TXPAYER-TP-RCVER OF TRWAD.      
           MOVE  I-RESID-RCVER      TO  RESID-RCVER      OF TRWAD.      
           MOVE  I-TREAT-STAUS      TO  TREAT-STAUS      OF TRWAD.      
           MOVE  I-RELATE-TXPAYER   TO  RELATE-TXPAYER   OF TRWAD.      
           MOVE  I-ISSUE-DT         TO  ISSUE-DT         OF TRWAD.      
           MOVE  I-DUSDT-EXT        TO  DUSDT-EXT        OF TRWAD.      
           MOVE  I-ACTL-ISSUE-QTY   TO  ACTL-ISSUE-QTY   OF TRWAD.      
           MOVE  I-EXPIRE-DT        TO  EXPIRE-DT        OF TRWAD.      
           MOVE  I-WHY-EXPIRE-DT    TO  WHY-EXPIRE-DT    OF TRWAD.      
           MOVE  I-ADMIT-NO         TO  ADMIT-NO         OF TRWAD.      
           MOVE  I-ADMIT-DT         TO  ADMIT-DT         OF TRWAD.      
           MOVE  I-BUSNID-DISTR-DT  TO  BUSNID-DISTR-DT  OF TRWAD.      
           MOVE  I-BUSNID-DISTR-CS  TO  BUSNID-DISTR-CS  OF TRWAD.      
      *    MOVE  I-CREAT-DT         TO  CREAT-DT         OF TRWAD.      
           MOVE  I-AGENCY-NM        TO  AGENCY-NM        OF TRWAD.      
           MOVE  I-ASS-YYMM-FR1     TO  ASS-YYMM-FR1     OF TRWAD.      
050517     MOVE  I-OPEN-FG          TO  OPEN-FG          OF TRWAD.      

       S2100-MOVE-MSG2TABLE-EXIT.
           EXIT.
           EJECT.
      ****************************************************************
      *
      *S2200-TRWAD-INSERT
      * INSERT  INTO TRWAD
      ****************************************************************
       S2200-TRWAD-INSERT              SECTION.

           EXEC  SQL   INSERT  INTO  DRWA.TRWAD
                              (RCVE_NO_TXOFF,
                               RCVE_NO_YY   ,
                               RCVE_NO_SEQNO,
                               TXPAYER_TP   ,
                               TXPAYER_ID   ,
                               RESID_BUSNID ,
                               TXTP_CD      ,
                               ASS_YYMM_FR  ,
                               RTN_TP       ,
                               RTN_SERIAL_NO,
                               ASS_YYMM_TO  ,
                               TX_SRVC_TP   ,
                               RCVE_METHOD  ,
                               RCVE_DT      ,
                               TX_OFFCR_RCVE,
                               TREAT_METHOD ,                           
                               TREAT_DUEDT  ,                           
                               TX_OFFCR_APPV,                           
                               APPV_DT      ,                           
                               TRNS_DEPT    ,                           
                               TRNS_AGENCY     ,                        
                               USE_PURPOSE     ,                        
                               SUBMIT_AGENCY   ,                        
                               ISSUE_QTY       ,                        
                               DISTR_METHOD    ,                        
                               TXPAYER_TP_RQSTR,                        
                               RESID_RQSTR     ,                        
                               TXPAYER_TP_RCVER,                        
                               RESID_RCVER     ,                        
                               TREAT_STAUS     ,                        
                               RELATE_TXPAYER  ,                        
                               ISSUE_DT        ,                        
                               DUSDT_EXT       ,                        
                               ACTL_ISSUE_QTY  ,                        
                               EXPIRE_DT       ,                        
                               WHY_EXPIRE_DT   ,                        
                               ADMIT_NO        ,                        
                               ADMIT_DT        ,                        
                               BUSNID_DISTR_DT ,                        
                               BUSNID_DISTR_CS ,                        
                               CREAT_DT        ,                        
                               AGENCY_NM       ,                        
                               ASS_YYMM_FR1    ,                        
050517                         OPEN_FG           )                      
                        VALUES                                          
                              (:TRWAD.RCVE-NO-TXOFF,
                               :TRWAD.RCVE-NO-YY ,
                               :TRWAD.RCVE-NO-SEQNO,
                               :TRWAD.TXPAYER-TP ,
                               :TRWAD.TXPAYER-ID ,
                               :TRWAD.RESID-BUSNID ,
                               :TRWAD.TXTP-CD ,
                               :TRWAD.ASS-YYMM-FR ,
                               :TRWAD.RTN-TP ,
                               :TRWAD.RTN-SERIAL-NO,
                               :TRWAD.ASS-YYMM-TO ,
                               :TRWAD.TX-SRVC-TP ,
                               :TRWAD.RCVE-METHOD ,
                               :TRWAD.RCVE-DT ,
                               :TRWAD.TX-OFFCR-RCVE,
                               :TRWAD.TREAT-METHOD ,                    
                               :TRWAD.TREAT-DUEDT ,                     
                               :TRWAD.TX-OFFCR-APPV,                    
                               :TRWAD.APPV-DT ,                         
                               :TRWAD.TRNS-DEPT ,                       
                               :TRWAD.TRNS-AGENCY ,                     
                               :TRWAD.USE-PURPOSE ,                     
                               :TRWAD.SUBMIT-AGENCY ,                   
                               :TRWAD.ISSUE-QTY ,                       
                               :TRWAD.DISTR-METHOD ,                    
                               :TRWAD.TXPAYER-TP-RQSTR,                 
                               :TRWAD.RESID-RQSTR ,                     
                               :TRWAD.TXPAYER-TP-RCVER,                 
                               :TRWAD.RESID-RCVER ,                     
                               :TRWAD.TREAT-STAUS ,                     
                               :TRWAD.RELATE-TXPAYER ,                  
                               :TRWAD.ISSUE-DT  ,                       
                               :TRWAD.DUSDT-EXT ,                       
                               :TRWAD.ACTL-ISSUE-QTY ,                  
                               :TRWAD.EXPIRE-DT ,                       
                               :TRWAD.WHY-EXPIRE-DT ,                   
                               :TRWAD.ADMIT-NO  ,                       
                               :TRWAD.ADMIT-DT  ,                       
                               :TRWAD.BUSNID-DISTR-DT ,                 
                               :TRWAD.BUSNID-DISTR-CS ,                 
                                CURRENT DATE    ,                       
                               :TRWAD.AGENCY-NM ,                       
                               :TRWAD.ASS-YYMM-FR1 ,                    
050517                         :TRWAD.OPEN-FG      )                    
           END-EXEC.                                                    
           IF  SQLCODE  =  C-SQL-NORMAL OR                              
040518                     C-SQL-DUP
               ADD  1              TO A-INSERT-CNT                      
           ELSE                                                         
               MOVE SPACE                  TO TSQ-REC
               MOVE SQLCODE                TO W-SQLCODE
               MOVE 'TRWAD INSERT ERROR..' TO TS-DATA(01:23)
               MOVE 'SQLCODE  :'           TO TS-DATA(24:10)
               MOVE W-SQLCODE              TO TS-DATA(35:05)
               MOVE I-TRWAD-KEY            TO TS-DATA(40:15)
               PERFORM S8100-LOG-TSQ-WRITE
               IF I-TX-SRVC-TP = 'B1003'
                  PERFORM   S9300-START-JAPA3
               ELSE
                  PERFORM   S9200-START-JAPA3
               END-IF                                                   
           END-IF.                                                      

       S2200-TRWAD-INSERT-EXIT.
           EXIT.
           EJECT.
      ******************************************************************
      *S2300-MOVE-TABLE2COMM                                            
      *      MOVE  TRWAD-REC  TO  COMM-AREA                             
      ******************************************************************
       S2300-MOVE-TABLE2COMM               SECTION.                     
                                                                        
      *    MOVE  SPACE                    TO  L-COMM-AREA.
           MOVE  SPACE                    TO  W-COMM-HTS-PRTID.
           MOVE  RCVE-NO-YY    OF TRWAD   TO  W-COMM-HTS-RCVEYY.
           MOVE  RCVE-NO-TXOFF OF TRWAD   TO  W-COMM-HTS-RCVETXOFF.
           MOVE  RCVE-NO-SEQNO OF TRWAD   TO  W-COMM-HTS-RCVESEQ.
           MOVE  'H'                      TO  W-COMM-HTS-FG.
           IF    TX-SRVC-TP    OF TRWAD = 'B1003'
                 MOVE  I-INCM-TP          TO  W-COMM-HTS-INCM-TP
           END-IF.

           IF  I-TX-SRVC-TP    =  'B0005'  OR 'B0006'  OR 'B0007'
                               OR 'B0008'
               INITIALIZE  W-COMM-SUB-PGM
               MOVE  SPACE                TO  W-COMM-XCTL-PRTID
               MOVE  RCVE-NO-YY    OF TRWAD   TO W-COMM-XCTL-RCVEYY
               MOVE  RCVE-NO-TXOFF OF TRWAD
                                          TO W-COMM-XCTL-RCVETXOFF
               MOVE  RCVE-NO-SEQNO OF TRWAD
                                          TO W-COMM-XCTL-RCVESEQ
               MOVE  'H'                  TO W-COMM-XCTL-CONFM

               MOVE  RCVE-NO-YY OF TRWAD TO  W-SUB-NO1 W-COMM-NO1
               MOVE  RCVE-NO-TXOFF OF TRWAD
                                         TO  W-SUB-NO2 W-COMM-NO2
               MOVE  RCVE-NO-SEQNO OF TRWAD  TO W-NO
               MOVE  W-NO                TO  W-SUB-NO3 W-COMM-NO3
               MOVE  C-PGM-JAPA1         TO  W-SUB-CALLING-PGM
                                             W-COMM-CALLING-PROGRAM
                                             W-COMM-XCTL-CALLING-PGM
PYJ            MOVE  C-PGM-PFP09         TO  W-LINK-PGM
               MOVE  'PF09'              TO  C-TRAN-START

           ELSE
              IF  I-TX-SRVC-TP    =  'B1001'
                  MOVE  C-TRAN-RWP5     TO  C-TRAN-START
      * ------------------------------------------------------ *
               MOVE RCVE-NO-YY    OF TRWAD TO W-SUB-NO1
               MOVE RCVE-NO-TXOFF OF TRWAD TO W-SUB-NO2
               MOVE RCVE-NO-SEQNO OF TRWAD TO W-SUB-NO3

               MOVE TXPAYER-TP    OF TRWAD TO W-SUB-TXPAYER-TP
               MOVE RESID-BUSNID  OF TRWAD TO W-SUB-RESID-BUSNID
               MOVE TXTP-CD       OF TRWAD TO W-SUB-TXTP-CD
               MOVE ASS-YYMM-FR   OF TRWAD TO W-SUB-ASS-YYMM-FR
               MOVE ASS-YYMM-TO   OF TRWAD TO W-SUB-ASS-YYMM-TO
               MOVE BUSNID-DISTR-CS OF TRWAD TO W-SUB-BIGO
               MOVE SPACE                  TO W-SUB-PRTID
               MOVE SPACE                  TO W-SUB-ALL
               MOVE 'H'                    TO W-SUB-XCTL-CONFM

               MOVE 'LWP5'                 TO C-TRAN-START
               MOVE C-PGM-LWSP5            TO W-SUB-PGM
               MOVE SPACE                  TO W-SUB-PRTID
      * ------------------------------------------------------ *

              ELSE
                IF  I-TX-SRVC-TP    =   'B1010'
                    MOVE  C-TRAN-RWPJ     TO  C-TRAN-START
               MOVE RCVE-NO-YY    OF TRWAD TO W-SUB-NO1
               MOVE RCVE-NO-TXOFF OF TRWAD TO W-SUB-NO2
               MOVE RCVE-NO-SEQNO OF TRWAD TO W-SUB-NO3

               MOVE TXPAYER-TP    OF TRWAD TO W-SUB-TXPAYER-TP
               MOVE RESID-BUSNID  OF TRWAD TO W-SUB-RESID-BUSNID
               MOVE TXTP-CD       OF TRWAD TO W-SUB-TXTP-CD
               MOVE ASS-YYMM-FR   OF TRWAD TO W-SUB-ASS-YYMM-FR
               MOVE ASS-YYMM-TO   OF TRWAD TO W-SUB-ASS-YYMM-TO
               MOVE BUSNID-DISTR-CS OF TRWAD TO W-SUB-BIGO
               MOVE SPACE                  TO W-SUB-PRTID
               MOVE SPACE                  TO W-SUB-ALL
               MOVE 'H'                    TO W-SUB-XCTL-CONFM

               MOVE 'LWPJ'                 TO C-TRAN-START
               MOVE C-PGM-LWPPI            TO W-LINK-PGM
               MOVE C-PGM-JAPA1         TO  W-SUB-CALLING-PGM
                                             W-COMM-CALLING-PROGRAM
                                             W-COMM-XCTL-CALLING-PGM
               MOVE SPACE                  TO W-SUB-PRTID

                ELSE
                    IF  I-TX-SRVC-TP    =   'B1003'
                        MOVE  C-TRAN-KEA1     TO  C-TRAN-START
                    ELSE
                        IF  I-TX-SRVC-TP    =   'B1002'
                            MOVE  C-TRAN-BCFA     TO  C-TRAN-START
                        ELSE
                            IF  I-TX-SRVC-TP    =   'B4009'
                                MOVE  C-TRAN-RWP1     TO  C-TRAN-START
                            END-IF
                        END-IF
                    END-IF
                END-IF
              END-IF
           END-IF.

       S2300-MOVE-TABLE2COMM-EXIT.                                      
           EXIT.                                                        
      ******************************************************************
      *S2400-START-HTS
      ******************************************************************
       S2400-START-HTS         SECTION.

      *    EXEC  SQL  COMMIT      END-EXEC.
      *    MOVE   SPACE                 TO  TSQ-REC.
      *    MOVE   'START TRAN  DATA : ' TO  TS-DATA(01:20).
      *    MOVE   W-COMM-SUB-PGM        TO  TS-DATA(21:200).
      *    PERFORM S8100-LOG-TSQ-WRITE.

           IF  C-TRAN-START  =  'PF09' OR  'LWPJ'
      *        MOVE W-SUB-SYSTEM-COMMON(1:150)
      *                                TO  W-SUBSYSTEM-COMMON

               EXEC  CICS  SYNCPOINT   END-EXEC

               MOVE  SPACE                TO  W-COMM-XCTL-PRTID
               MOVE  RCVE-NO-YY    OF TRWAD   TO W-COMM-XCTL-RCVEYY
               MOVE  RCVE-NO-TXOFF OF TRWAD
                                          TO W-COMM-XCTL-RCVETXOFF
               MOVE  RCVE-NO-SEQNO OF TRWAD
                                          TO W-COMM-XCTL-RCVESEQ
               MOVE  'H'                  TO W-COMM-XCTL-CONFM

               MOVE  RCVE-NO-YY OF TRWAD TO  W-SUB-NO1 W-COMM-NO1
               MOVE  RCVE-NO-TXOFF OF TRWAD
                                         TO  W-SUB-NO2 W-COMM-NO2
               MOVE  RCVE-NO-SEQNO OF TRWAD  TO W-NO
               MOVE  W-NO                TO  W-SUB-NO3 W-COMM-NO3
               MOVE  C-PGM-JAPA1         TO  W-SUB-CALLING-PGM
                                             W-COMM-CALLING-PROGRAM
                                             W-COMM-XCTL-CALLING-PGM

               EXEC  CICS  LINK     PROGRAM (W-LINK-PGM)
                                    COMMAREA(W-COMM-AREA(1:4000))
                                    LENGTH  (C-COMM-LNTH)
                                    RESP    (W-RETURN-CODE)
               END-EXEC
               MOVE   SPACE             TO  TSQ-REC
               EXEC  SQL  COMMIT      END-EXEC
               EXEC CICS SYNCPOINT ROLLBACK  END-EXEC
      *        IF  I-TX-SRVC-TP  = 'B1010'
      *
      *            PERFORM  S6100-PGM-START
      *
      *        END-IF
           ELSE
               IF  I-TX-SRVC-TP = 'B1001'

                   PERFORM  S6000-SUB-PGM-CALL

               ELSE
                   EXEC    CICS     START
                                    TRANSID(C-TRAN-START)
                                    FROM   (W-COMM-AREA(1:800))
                                    LENGTH (C-COMMAREA-LNTH)
                                    RESP   (W-RETURN-CODE)
                   END-EXEC
                   MOVE   SPACE         TO  TSQ-REC
               END-IF
           END-IF.

           EVALUATE TRUE
               WHEN W-RETURN-NORMAL
                    MOVE W-RETURN-CODE          TO  W-SQLCODE
      *             MOVE 'START TRAN   SUCC...' TO TS-DATA(01:22)
      *             MOVE I-TRWAD-KEY            TO TS-DATA(23:15)
      *             PERFORM S8100-LOG-TSQ-WRITE

               WHEN W-RETURN-NOTAUTH
                    MOVE W-RETURN-CODE          TO  W-SQLCODE
                    MOVE 'START '               TO TS-DATA(01:06)
                    MOVE C-TRAN-START           TO TS-DATA(07:04)
                    MOVE '  ERROR..'            TO TS-DATA(12:09)
                    MOVE I-TRWAD-KEY            TO TS-DATA(23:15)
                    MOVE '(RETURN-NOAUTH)'      TO TS-DATA(40:15)
                    PERFORM S8100-LOG-TSQ-WRITE
                    MOVE     'Y'         TO  PROC-ERR-GBN   OF TKAAD

                    IF I-TX-SRVC-TP = 'B1003'
                       PERFORM   S9300-START-JAPA3
                    ELSE
                       PERFORM   S9200-START-JAPA3
                    END-IF                                              

               WHEN OTHER
                    MOVE W-RETURN-CODE          TO  W-SQLCODE
                    MOVE 'START '               TO TS-DATA(01:06)
                    MOVE C-TRAN-START           TO TS-DATA(07:04)
                    MOVE '  ERROR..'            TO TS-DATA(12:09)
                    MOVE I-TRWAD-KEY            TO TS-DATA(23:15)
                    MOVE '(RETURN-CODE??)'      TO TS-DATA(40:15)
                    MOVE W-SQLCODE              TO TS-DATA(56:05)
                    PERFORM S8100-LOG-TSQ-WRITE
                    MOVE     'Y'         TO  PROC-ERR-GBN   OF TKAAD
                    IF I-TX-SRVC-TP = 'B1003'
                       PERFORM   S9300-START-JAPA3
                    ELSE
                       PERFORM   S9200-START-JAPA3
                    END-IF                                              
           END-EVALUATE.
                                                                        
       S2400-START-HTS-EXT.                                             
           EXIT.                                                        
      ****************************************************************
      *
      *S2500-TKAAD-INSERT
      *      MOVE  MQ-BUFFER    TO  TRWAD-REC.
      *      INSERT   INTO  TKAAD
      ****************************************************************
       S2500-TKAAD-INSERT              SECTION.

           MOVE  W-SYS-DT           TO  SYS-DT           OF TKAAD.
           PERFORM   S2510-TKAAD-MAX-INQ.

      *    MOVE  I-LOG-SEQNO        TO  LOG-SEQNO        OF TKAAD.
           MOVE  I-RCVE-NO-TXOFF    TO  RCVE-NO-TXOFF    OF TKAAD.
           MOVE  I-RCVE-NO-YY       TO  RCVE-NO-YY       OF TKAAD.
           MOVE  I-RCVE-NO-SEQNO    TO  RCVE-NO-SEQNO    OF TKAAD.
           MOVE  W-SYS-DT           TO  RCVE-DT          OF TKAAD.
           MOVE  W-SYS-TIME         TO  RCVE-TIME        OF TKAAD.
           MOVE  SPACE              TO  PROC-ERR-GBN     OF TKAAD.
           MOVE  SPACE              TO  TRANS-DT         OF TKAAD.
           MOVE  SPACE              TO  TRANS-TIME       OF TKAAD.
           MOVE  SPACE              TO  TRANS-ERR-GBN    OF TKAAD.
           IF  RCVE-ERR-GBN  OF TKAAD   =  'Y'
               MOVE  TS-DATA        TO  ERR-DOCU         OF TKAAD       
           ELSE
               MOVE  SPACE          TO  ERR-DOCU         OF TKAAD       
           END-IF.

           EXEC  SQL   INSERT  INTO  DKAA.TKAAD
                              (SYS_DT
                              ,LOG_SEQNO
                              ,RCVE_NO_TXOFF
                              ,RCVE_NO_YY
                              ,RCVE_NO_SEQNO
                              ,RCVE_DT
                              ,RCVE_TIME
                              ,RCVE_ERR_GBN
                              ,PROC_ERR_GBN
                              ,TRANS_DT
                              ,TRANS_TIME
                              ,TRANS_ERR_GBN
                              ,ERR_DOCU      )
                        VALUES                                          
                              (:TKAAD.SYS-DT
                              ,:TKAAD.LOG-SEQNO
                              ,:TKAAD.RCVE-NO-TXOFF
                              ,:TKAAD.RCVE-NO-YY
                              ,:TKAAD.RCVE-NO-SEQNO
                              ,:TKAAD.RCVE-DT
                              ,:TKAAD.RCVE-TIME
                              ,:TKAAD.RCVE-ERR-GBN
                              ,:TKAAD.PROC-ERR-GBN
                              ,:TKAAD.TRANS-DT
                              ,:TKAAD.TRANS-TIME
                              ,:TKAAD.TRANS-ERR-GBN
                              ,:TKAAD.ERR-DOCU     )
           END-EXEC.                                                    
           IF  SQLCODE  =  0                                            
               CONTINUE                                                 
           ELSE                                                         
               MOVE SPACE                  TO TSQ-REC
               MOVE SQLCODE                TO W-SQLCODE
               MOVE 'TKAAD INSERT ERROR..' TO TS-DATA(01:22)
               MOVE 'SQLCODE  :'           TO TS-DATA(21:10)
               MOVE W-SQLCODE              TO TS-DATA(33:05)
               MOVE I-TRWAD-KEY            TO TS-DATA(40:15)
               PERFORM S8100-LOG-TSQ-WRITE

           END-IF.                                                      

       S2500-TKAAD-INSERT-EXIT.
           EXIT.
           EJECT.
      ******************************************************************
      *S2510-TKAAD-MAX-INQ
      ******************************************************************
       S2510-TKAAD-MAX-INQ     SECTION.

           EXEC  SQL  SELECT  MAX(LOG_SEQNO)
                        INTO  :TKAAD.LOG-SEQNO
                        FROM  DKAA.TKAAD
                       WHERE  SYS_DT   = :TKAAD.SYS-DT
           END-EXEC.
           IF  SQLCODE  =  +0
               ADD    1                TO  LOG-SEQNO OF TKAAD
           ELSE
               MOVE   1                TO  LOG-SEQNO OF TKAAD
           END-IF.

       S2510-TKAAD-MAX-INQ-EXIT.
           EXIT.
           EJECT.
      ******************************************************************
      *
      *S3000-FINAL
      *
      ******************************************************************
       S3000-FINAL     SECTION.

           PERFORM S3100-MQ-CLOSE-PROC.

       S3000-FINAL-EXIT.
           EXIT.
      ******************************************************************
      *
      *S3100-MQ-CLOSE-PROC
      *
      ******************************************************************
       S3100-MQ-CLOSE-PROC  SECTION.

      *    MOVE SPACE                  TO TSQ-REC.
      *    MOVE 'MQ CLOSE      .. '    TO TS-DATA(1:17).
      *    MOVE C-GET-MQ-NAME          TO TS-DATA(18:17).
      *    PERFORM S8100-LOG-TSQ-WRITE.

           MOVE C-GET-MQ-NAME   TO MQOD-OBJECTNAME.
           MOVE MQCO-NONE       TO MQ-OPTION.
           CALL "MQCLOSE" USING MQ-HCONN
                                MQ-HANDLE
                                MQ-OPTION
                                MQ-RESP-CODE
                                MQ-REASON-CODE.

           IF  MQ-RESP-CODE  = MQCC-OK
               CONTINUE
           ELSE
               MOVE 'MQ CLOSE ERROR.. '    TO TS-DATA(1:17)
               MOVE C-GET-MQ-NAME          TO TS-DATA(18:17)
               MOVE 'COMPCODE :'           TO TS-DATA(35:10)
               MOVE MQ-RESP-CODE           TO TS-DATA(45:10)
               MOVE 'REASON   :'           TO TS-DATA(55:10)
               MOVE MQ-REASON-CODE         TO TS-DATA(65:10)
               PERFORM S8100-LOG-TSQ-WRITE
           END-IF.

       S3100-MQ-CLOSE-PROC-EXIT.
           EXIT.
      ******************************************************************
      *                                                                *
      *               S 6 0 0 0 - S U B - P G M - C A L L              *
      *                                                                *
      ******************************************************************

       S6000-SUB-PGM-CALL              SECTION.

           EXEC SQL  SET CURRENT PACKAGESET='NTA'
           END-EXEC.

           CALL W-SUB-PGM       USING  W-SUB-SYSTEM-COMMON.

           EXEC SQL SET CURRENT PACKAGESET='   '
           END-EXEC.

           IF  L-COMM-SQL-C  <=  SPACE
      *        CONTINUE
               PERFORM  S6100-PGM-START
           ELSE
               MOVE  L-COMM-MSG-C     TO  I-BUSNID-DISTR-CS
               MOVE   '13'            TO  TREAT-STAUS OF TRWAD          
               PERFORM S9200-START-JAPA3                                
               IF L-COMM-SQL-C = '13'
                  CONTINUE
               ELSE
                  EXEC CICS  SYNCPOINT  ROLLBACK  END-EXEC
               END-IF

           END-IF.

       S6000-SUB-PGM-CALL-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                  S 6 1 0 0 - P G M - S T A R T                 *
      *                                                                *
      ******************************************************************

       S6100-PGM-START                 SECTION.

           MOVE W-SUB-SYSTEM-COMMON(1:150)
                                       TO  W-SUBSYSTEM-COMMON.
           EXEC    CICS      START
                             TRANSID(C-TRAN-START)
                             FROM   (W-COMM-AREA(1:4000))
                             LENGTH (C-COMM-LNTH)
      *                      TERMID (W-SUB-PRTID)
                             RESP   (W-RETURN-CODE)

           END-EXEC.


       S6100-PGM-START-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *S8100-LOG-TSQ-WRITE
      *P
      *****************************************************************
       S8100-LOG-TSQ-WRITE   SECTION.

      *    CONTINUE.

           EXEC  CICS WRITEQ    TS       QUEUE('JAPA1Q')
                                         FROM(TSQ-REC)
                                         END-EXEC.

       S8100-LOG-TSQ-WRITE-EXIT.
           EXIT.
      *****************************************************************
      *S8200-GET-SYSTEM-DATE
      *P
      *****************************************************************
       S8200-GET-SYSTEM-DATE           SECTION.

           EXEC  CICS  ASKTIME  ABSTIME (W-ABSTIME)
           END-EXEC.

           EXEC  CICS  FORMATTIME
                       ABSTIME (W-ABSTIME)
                       YEAR    (W-YEAR)
                       YYMMDD  (W-DATE)
                       TIME    (W-TIME)
                       DATESEP
                       TIMESEP
           END-EXEC.

           MOVE   W-YEAR           TO  W-DB2DATE-YEAR.
           MOVE   W-DB2DATE-YEAR(1:2) TO  W-SYS-DT  (1:2).
           MOVE   W-DATE(1:2)      TO  W-SYS-DT  (3:2).
           MOVE   W-DATE(4:2)      TO  W-SYS-DT  (5:2).
           MOVE   W-DATE(7:2)      TO  W-SYS-DT  (7:2).

           MOVE   W-TIME           TO  TS-SYS-TIME.
           MOVE   W-TIME(1:2)      TO  W-SYS-TIME (1:2).
           MOVE   W-TIME(4:2)      TO  W-SYS-TIME (3:2).
           MOVE   W-TIME(7:2)      TO  W-SYS-TIME (5:2).

030403     EXEC  CICS  ASSIGN   STARTCODE(W-START-CODE)
           END-EXEC.


       S8200-GET-SYSTEM-DATE-EXIT.
           EXIT.
      ******************************************************************
      *        ??????  ?????  {çþ~  ???????        *
      ******************************************************************
      ******************************************************************
      *S9100-RETURN
      *     - RETURN TO CICS
      ******************************************************************
       S9100-RETURN SECTION.

           EXEC CICS RETURN END-EXEC.

       S9100-RETURN-EXIT.
           EXIT.
           EJECT
PYM   ******************************************************************
020219*                                                                *
"     *    S 9 2 1 0 - S T A R T - J A P A 3                           *
"     *                                                                *
"     ******************************************************************
        COPY CMCPSEC.
"     * S9200-START-JAPA3        SECTION.                                
"     *                                                                  
"     *     MOVE    I-TX-SRVC-TP               TO RCVE-TX-SRVC-TP.       
"     *     MOVE    I-RCVE-NO-TXOFF            TO H-RCVE-NO-TXOFF.       
"     *     MOVE    I-RCVE-NO-YY               TO H-RCVE-NO-YY.          
"     *     MOVE    I-RCVE-NO-SEQNO            TO H-RCVE-NO-SEQNO.       
"     *                                                                  
"     **Moving some data                                                       
"     *     MOVE    I-ISSUE-DT                 TO H-ISSUE-DT.            
"     *                                                                  
"     **Moving some data                                                       
"     *     MOVE    I-EXPIRE-DT                TO H-EXPIRE-DT.           
"     *                                                                  
"     **Moving some data                                                   
"     *     MOVE    I-BUSNID-DISTR-CS          TO H-BUSNID-DISTR-CS.     
"     *                                                                  
"     **Moving some data                                                       
      *     MOVE   'ZZ'                        TO  H-TREAT-STAUS.
      *     IF  I-TX-SRVC-TP = 'B1001'
      *         MOVE   '13'                    TO  H-TREAT-STAUS
      *     END-IF.
      *     MOVE   TS-DATA                     TO  H-ERR-DOCU.
      *     MOVE   SPACE                       TO  H-ERR-TP.
"     *                                                                  
020711*     MOVE 'JAA3'            TO   W-START-TRN.                     
PYM   *     EXEC CICS START    TRANSID (W-START-TRN)                     
"     *                        INTERVAL(0)                               
"     *                        FROM    (HTS-AREA)                        
"     *                        LENGTH  (LENGTH OF HTS-AREA)              
"     *                        RESP    (W-RETURN-CODE)                   
020711*     END-EXEC.                                                    
"                                                                       
"      S9200-START-JAPA3-EXIT.                                          
"          EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
"     *    S 9 3 0 0 - S T A R T - K A P A 3                           *
"     *                                                                *
"     ******************************************************************
"      S9300-START-JAPA3        SECTION.                                
"                                                                       
"          MOVE    I-TX-SRVC-TP               TO H1-RCVE-TX-SRVC-TP     
                                                 H1-GUBUN.              
"          MOVE    I-RCVE-NO-TXOFF            TO H1-RCVE-NO-TXOFF.      
"          MOVE    I-RCVE-NO-YY               TO H1-RCVE-NO-YY.         
"          MOVE    I-RCVE-NO-SEQNO            TO H1-RCVE-NO-SEQNO.      
"          MOVE    I-RESID-BUSNID             TO H1-RESID-BUSNID-TRWAD. 
"                                                                       
"      
"          MOVE    I-ISSUE-DT                 TO H1-ISSUE-DT.           
"                                                                       
"     
"          MOVE    I-EXPIRE-DT                TO H1-EXPIRE-DT.          
"                                                                       
"    
"          MOVE    I-BUSNID-DISTR-CS          TO H1-BUSNID-DISTR-CS.    
"                                                                       
"   
           MOVE   'ZZ'                        TO  H1-TREAT-STAUS.
           MOVE   TS-DATA                     TO  H1-ERR-DOCU.
           MOVE   SPACE                       TO  H1-ERR-TP.
"                                                                       
           MOVE 'JAA3'            TO   W-START-TRN.                     
           COPY CMCPLINK.
      
       
 
 
 
 
       
"                                                                       
"      S9300-START-JAPA3-EXIT.                                          
"          EXIT.                                                        
           EJECT 
"      S9300-START-JAPA4-EXIT.                                          
"          EXIT.                                                        
           EJECT                                                                    
      ******************************************************************
      *                                                                *
      *              F I N A L   P R O G R A M   C O D I N G           *
      *                                                                *
      *              PROGRAM  ID  :  JAPA1                             *
      *                                                                *
      ******************************************************************
