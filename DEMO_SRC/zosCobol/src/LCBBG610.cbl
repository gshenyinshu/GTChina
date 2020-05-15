      ****************************************************************
      *                                                              *
      *           I D E N T I F I C A T I O N  D I V I S I O N       *
      *                                                              *
      ****************************************************************
       IDENTIFICATION                    DIVISION.

       PROGRAM-ID.                       LCBBG610.
       AUTHOR.                           ITPlus.
       DATE-WRITTEN.                     2004-10-13.
       DATE-COMPILED.

      ****************************************************************
      *  HANDLER     : aa/7v~DWv DATAp7             *
      *  DESCRIPTION : aa/7v~  DWv}  DATA p7   *
      *                                                              *
      *  TRANSACTION ID : NONE                                       *
      *  JSP       FILE : NONE                                       *
      *  JS        FILE : NONE                                       *
      *  SERVLET   FILE : NONE                                       *
      *  MAIN   PROGRAM : LCBBG610                                   *
      *  SUB    PROGRAM :                                            *
      *                                                              *
      *  TABLE                                         CRUD          *
      *  ==========================================================  *
      *  NONE                                                        *
      *                                                              *
      * viHISTORY                                                *
      * viz   CSRuVJ~  3/  3a                     *
      *  ====== ============== ======  ============================  *
      *  041013               vv  BA~7                     *
      ****************************************************************

      ****************************************************************
      *                                                              *
      *         E N V I R O N M E N T   D I V I S I O N              *
      *                                                              *
      ****************************************************************
       ENVIRONMENT                       DIVISION.

       INPUT-OUTPUT                      SECTION.

       FILE-CONTROL.

           SELECT  I-SAM-FILE     ASSIGN  TO  LCBNC010.

           SELECT  O-SAM-FILE     ASSIGN  TO  LCBNC020.

      ****************************************************************
      *                                                              *
      *         D A T A                 D I V I S I O N              *
      *                                                              *
      ****************************************************************
       DATA                              DIVISION.

       FILE                              SECTION.

      ****************************************************************
      *                                                              *
      *     I-SAM-FILE                            DDNAME - LCBNC010  *
      * - INPUT SAM FILE                                             *
      *                                                              *
      ****************************************************************
       FD  I-SAM-FILE

           RECORDING  MODE           IS  F
           RECORD     CONTAINS       35  CHARACTERS
           BLOCK      CONTAINS        0  RECORDS
           LABEL      RECORDS       ARE  STANDARD
           DATA       RECORD         IS  I-SAM-REC.

       01  I-SAM-REC                     PIC  X(35).

      ****************************************************************
      *                                                              *
      *     O-SAM-FILE                            DDNAME - LCBNC020  *
      * - FINAL OUTPUT SAM FILE                                      *
      *                                                              *
      ****************************************************************
       FD  O-SAM-FILE

           RECORDING  MODE           IS  F
           RECORD     CONTAINS       35  CHARACTERS
           BLOCK      CONTAINS        0  RECORDS
           LABEL      RECORDS       ARE  STANDARD
           DATA       RECORD         IS  O-SAM-REC.

       01  O-SAM-REC                     PIC  X(35).

      ****************************************************************
      *                                                              *
      *         W O R K I N G - S T O R A G E  S E C T I O N         *
      *                                                              *
      ****************************************************************
       WORKING-STORAGE                   SECTION.

       01  WS-BEGIN                      PIC  X(40)  VALUE
           'LCBBG610 - WORKING STORAGE BEGINS HERE'.

      ****************************************************************
      *                                                              *
      *    U S E R - A B E N D S                                     *
      *                                                              *
      ****************************************************************
       01  USER-ABENDS.

           05  U-ABEND-CODE              PIC  S9(4)   VALUE +2001.

      ****************************************************************
      *                                                              *
      *                  A C C U M U L A T O R S                     *
      *                                                              *
      ****************************************************************
       01  ACCUMULATORS.
           05  A-READ-ISAM-CNT           PIC  9(15)  VALUE  ZERO.
           05  A-WRITE-OSAM-CNT          PIC  9(15)  VALUE  ZERO.
           05  A-WRITE-OSAM-TCNT         PIC  9(15)  VALUE  ZERO.

      ****************************************************************
      *                                                              *
      *                  C O N S T A N T S                           *
      *                                                              *
      ****************************************************************
       01  CONSTANTS.
           05  C-RETURN-CODE             PIC  S9(04) COMP  SYNC
                                                     VALUE +2001.
           05  C-PROG-ID                 PIC  X(08)  VALUE 'LCBBG610'.

      ****************************************************************
      *                                                              *
      *                    S W I T C H E S                           *
      *                                                              *
      ****************************************************************
      *01  SWITCHES.

      ****************************************************************
      *                                                              *
      *            W O R K   A R E A S                               *
      *                                                              *
      ****************************************************************
       01  WORK-AREAS.

           05  W-EOF-FLG                 PIC  X(01)  VALUE  SPACE.
           05  W-SYSTEM-DATE             PIC  X(08)  VALUE  SPACE.

           05  O-HD-REC.
               10 O-HD-GB                PIC  X(02).
      *-- //BaBi~e~z/
               10 O-HD-CRT-ST-D          PIC  X(08).
      *-- //BaBi~e/z/
               10 O-HD-CRT-END-D         PIC  X(08).
      *-- Vz      
               10 O-HD-TRNS-D            PIC  X(08).
               10 O-HD-FILLER            PIC  X(09).

           05  O-TR-REC.
               10 O-TR-GB                PIC  X(02).
      *-- ADATAhVa  HD + TR + DATA
               10 O-TR-TOT-DATA-CNT      PIC  9(09).
      *-- zDATAhVa
               10 O-TR-RL-DATA-CNT       PIC  9(09).
               10 O-TR-FILLER            PIC  X(15).

      ****************************************************************
      *                                                              *
      *    C O P Y B O O K S                                         *
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
      *    SQLCA DEFINITION                                          *
      ****************************************************************
      *    EXEC  SQL  INCLUDE  SQLCA  END-EXEC.

      ****************************************************************
      *                                                              *
      *                   C U R S O R S                              *
      *                                                              *
      ****************************************************************
      *NONE                                                          *

      ****************************************************************
      *                                                              *
      *    P A R A M E T E R S                                       *
      *                                                              *
      ****************************************************************

      ****************************************************************
      *                                                              *
      *    T A B L E S                                               *
      *                                                              *
      ****************************************************************
      *NONE
      ****************************************************************
      *                                                              *
      *    E N D    O F   W O R K I N G - S T O R A G E              *
      *                                                              *
      ****************************************************************
       01  WS-END                        PIC  X(40) VALUE
           'LCBBG610 - WORKING STORAGE ENDS HERE'.

      ****************************************************************
      *                                                              *
      *        P R O C E D U R E  D I V I S I O N                    *
      *                                                              *
      ****************************************************************
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

      *--  INITIALIZE FLG
           INITIALIZE  WORK-AREAS.
           INITIALIZE  ACCUMULATORS.

           MOVE      'Y'                 TO  STRT-BOCOM-ERR-TYPE.
           MOVE      C-PROG-ID           TO  STRT-BOCOM-ERR-PROG.

           ACCEPT  W-SYSTEM-DATE  FROM  DATE  YYYYMMDD.

      *--  OPEN ALL SAM FILE
           PERFORM  S0200-OPEN-INPUT-FILE.

      ****************************************************************
      *                                                              *
      *             M A I N L I N E                                  *
      *                                                              *
      ****************************************************************
       MAINLINE                          SECTION.

      *--  READ DATA FILE
           INITIALIZE  W-EOF-FLG.

      *--  READ INPUT SAM FILE
           PERFORM  S0300-READ-ISAM-RTN.

      *--  WRITE  HEADER
           PERFORM  S0500-WRITE-HEAD.

           PERFORM  S0400-WRITE-DT    UNTIL  W-EOF-FLG  =  'Y'.


      *--  WRITE  TRAILER
           PERFORM  S0700-WRITE-TRAILER.

           MOVE      'N'                 TO  STRT-BOCOM-ERR-TYPE.

      ****************************************************************
      *                                                              *
      *             F I N A L I Z A T I O N                          *
      *                                                              *
      ****************************************************************
       FINALIZATION                      SECTION.

      *--  CLOSE ALL SAM FILE
           PERFORM  S0900-CLOSE-FILE.

      *--  DISPLAY RESULT
           IF  STRT-BOCOM-ERR-TYPE  NOT = 'N'
               PERFORM  S1000-DISPLAY-ERRMSG
               MOVE     U-ABEND-CODE     TO  RETURN-CODE
           ELSE
               MOVE     +0000            TO  RETURN-CODE
           END-IF.

      *--  DISPLAY RESULT
           PERFORM  S1100-DISPLAY-RES.

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
      *            S0200-OPEN-INPUT-FILE                             *
      *                                                              *
      * 1/}/l  ~~pSAM FILEOPEN}m/                      *
      * 2 OPENKaFILE STATUSCHECK}m/                         *
      *                                                              *
      ****************************************************************
       S0200-OPEN-INPUT-FILE             SECTION.


           OPEN  INPUT     I-SAM-FILE.
           OPEN  OUTPUT    O-SAM-FILE.

       S0200-OPEN-INPUT-FILE-EXIT.
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
      ****************************************************************
      *                                                              *
      *               S0300-READ-ISAM-RTN                            *
      *                                                              *
      * 1 READ INPUT SAM FILE                                        *
      *                                                              *
      ****************************************************************
       S0300-READ-ISAM-RTN               SECTION.

           READ  I-SAM-FILE              AT  END

                 MOVE  'Y'               TO  W-EOF-FLG
                 GO                      TO  S0300-READ-ISAM-RTN-EXIT   
           END-READ.

           ADD   +1                      TO  A-READ-ISAM-CNT.

       S0300-READ-ISAM-RTN-EXIT.
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
      *NONE
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
      *
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
      ****************************************************************
      *                                                              *
      *               S0500-WRITE-HEAD                               *
      *                                                              *
      ****************************************************************
       S0500-WRITE-HEAD                  SECTION.

           INITIALIZE  O-SAM-REC.

      *-- //BaBi~e~z,/z,Vz
           MOVE  'HD'                    TO  O-HD-GB.
           MOVE   W-SYSTEM-DATE          TO  O-HD-CRT-ST-D
                                             O-HD-CRT-END-D
                                             O-HD-TRNS-D.
           MOVE   SPACE                  TO  O-HD-FILLER.

           MOVE   O-HD-REC               TO  O-SAM-REC.

           WRITE  O-SAM-REC.
           ADD   +1                      TO  A-WRITE-OSAM-TCNT.

       S0500-WRITE-HEAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *               S0400-WRITE-DT                                 *
      *                                                              *
      ****************************************************************
       S0400-WRITE-DT                    SECTION.

           INITIALIZE  O-SAM-REC.

           MOVE  I-SAM-REC               TO  O-SAM-REC.

           WRITE  O-SAM-REC.

           ADD   +1                      TO  A-WRITE-OSAM-CNT.
           ADD   +1                      TO  A-WRITE-OSAM-TCNT.

           PERFORM  S0300-READ-ISAM-RTN.

       S0400-WRITE-DT-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *               S0700-WRITE-TRAILER                            *
      *                                                              *
      ****************************************************************
       S0700-WRITE-TRAILER               SECTION.

           INITIALIZE  O-SAM-REC.

           ADD   +1                      TO  A-WRITE-OSAM-TCNT.
           MOVE  'TR'                    TO  O-TR-GB.
      *-- ADATAhVa
           MOVE   A-WRITE-OSAM-TCNT      TO  O-TR-TOT-DATA-CNT.
      *-- zDATAhVa
           MOVE   A-WRITE-OSAM-CNT       TO  O-TR-RL-DATA-CNT.
           MOVE   SPACE                  TO  O-TR-FILLER.

           MOVE   O-TR-REC               TO  O-SAM-REC.

           WRITE  O-SAM-REC.

       S0700-WRITE-TRAILER-EXIT.
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
      *NONE
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
      *==============================================================*
      *                                                              *
      *                 E N D    O U T P U T   W R I T E             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T    F I L E   C L O S E                 *
      *                                                              *
      * 1/}SAM FILECLOSE}m/.                            *
      *                                                              *
      *==============================================================*
       S0900-CLOSE-FILE                   SECTION.

           CLOSE  I-SAM-FILE.
           CLOSE  O-SAM-FILE.

       S0900-CLOSE-FILE-EXIT.
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
      *            S1000-DISPLAY-ERRMSG                              *
      *                                                              *
      * 1 DISPLAY ERROR MESSAGE.                                     *
      *                                                              *
      ****************************************************************
       S1000-DISPLAY-ERRMSG              SECTION.

           DISPLAY  '>> ERROR MESSAGE'.
           DISPLAY  'ERR-TYPE=('  STRT-BOCOM-ERR-TYPE  ')'.

           IF  STRT-BOCOM-ERR-TYPE  =  'Y'
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

       S1000-DISPLAY-ERRMSG-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *               S1100-DISPLAY-RES                              *
      *                                                              *
      * 1iiA  Bi}m/.                                         *
      *                                                              *
      ****************************************************************
       S1100-DISPLAY-RES               SECTION.

           DISPLAY  '*****  LCBBG610  WORK  RESULT  *********'.
           DISPLAY  ' INPUT READ    COUNT  = '  A-READ-ISAM-CNT.
           DISPLAY  ' SAM WRITE     COUNT  = '  A-WRITE-OSAM-CNT.
           DISPLAY  ' SAM WRITE TOT COUNT  = '  A-WRITE-OSAM-TCNT.
           DISPLAY  '**************************************** '.

       S1100-DISPLAY-RES-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *                 E N D    R E S U L T   D I S P L A Y         *
      *                                                              *
      *==============================================================*

