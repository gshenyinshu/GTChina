      ****************************************************************  
      *                                                              *  
      *           I D E N T I F I C A T I O N  D I V I S I O N       *  
      *                                                              *  
      ****************************************************************  
       IDENTIFICATION                    DIVISION.                      
                                                                        
       PROGRAM-ID.                       LCBBG110.                      
       AUTHOR.                           FNS.
       DATE-WRITTEN.                     2004-04-19.                    
       DATE-COMPILED.                                                   

      ****************************************************************  
      *  HANDLER     :  Ka}pZ  JOB SYSIN p7 (TG110)     *  
      *  DESCRIPTION :  12z~  iiA}  Ka}pZ   JOB      -*  
      *  LCBB8G11 RUN  }  SYSIN p7                        *  
      *  TRANSACTION ID : NONE                                       *  
      *  JSP       FILE : NONE                                       *  
      *  JS        FILE : NONE                                       *  
      *  SERVLET   FILE : NONE                                       *  
      *  MAIN   PROGRAM : LCBBG110                                   *  
      *  SUB    PROGRAM : LCBXU170                                   *  
      *  INTERFACE DESC : NONE                                       *
      *                                                              *  
      *  TABLE                                                 CRUD  *  
      *  ==========================================================  *  
      *                                                              *  
      * vi HISTORY                                               *  
      * viz   CSRuVJ~  3/3a                     *
      *  ====== ============== ======  ============================  *
      *  040910                FNS  BA~7                     *
      ****************************************************************  

      ****************************************************************  
      *                                                              *  
      *         E N V I R O N M E N T   D I V I S I O N              *  
      *                                                              *  
      ****************************************************************  
       ENVIRONMENT                       DIVISION.                      
       INPUT-OUTPUT                      SECTION.
      *
       FILE-CONTROL.
           SELECT   O1-UNLOAD-SYSIN      ASSIGN  TO  UTG110
                                  FILE STATUS  IS W-O1-STATUS.

           SELECT   O2-DELETE-SYSIN      ASSIGN  TO  DTG110
                                  FILE STATUS  IS W-O2-STATUS.
      ****************************************************************
      *                                                              *
      *         D A T A                 D I V I S I O N              *
      *                                                              *
      ****************************************************************
       DATA                              DIVISION.
      *----------------------------------------------------------------*
       FILE     SECTION.
      *
      ****************************************************************
      *                                                              *
      *     O1-UNLOAD-SYSIN                       DDNAME=UTG110      *
      * - //v~v  }  UNLOAD  SYSIN                        *
      *                                                              *
      ****************************************************************
       FD  O1-UNLOAD-SYSIN.
       01  O1-UNLOAD-SYSINREC            PIC  X(80).
      ****************************************************************
      *                                                              *
      *     O2-DELETE-SYSIN                       DDNAME=DTG110      *
      * - //v~v  }  DELETE  SYSIN                        *
      *                                                              *
      ****************************************************************
       FD  O2-DELETE-SYSIN.
       01  O2-DELETE-SYSINREC            PIC  X(80).
      ****************************************************************
      *                                                              *
      *        W O R K I N G - S T O A G E  S E C T I O N            *
      *                                                              *
      ****************************************************************
       WORKING-STORAGE                   SECTION.
      ******************************************************************
       77  I                             PIC 9(02).
       01  PROGRAM-NAME                  PIC X(08)
                                         VALUE 'LCBBG110'.
      ****************************************************************
      *                                                              *
      *    U S E R - A B E N D S                                     *
      *                                                              *
      ****************************************************************
       01  USER-ABENDS.
           05  U-ABEND.
               10  U-ABEND-CODE          PIC  S9(04)  VALUE +2001.

      *----------------------------------------------------------------*
      * WORK AREA  7a
      *----------------------------------------------------------------*
       01  WORK-AREA.
           05  W-O1-STATUS               PIC  X(02)  VALUE SPACE.
           05  W-O2-STATUS               PIC  X(02)  VALUE SPACE.

       01  WK-UNLOAD-SYSIN.
           05  WK-U-1                    PIC  X(80) VALUE
               ' UNLOAD'.
           05  WK-U-2                    PIC  X(80) VALUE
               '   DIRECT   YES'.
           05  WK-U-3                    PIC  X(80) VALUE
               '   SHRLEVEL REFERENCE'.
           05  WK-U-4                    PIC  X(80) VALUE
               '   FORMAT   DSNTIAUL '.
           05  WK-U-5                    PIC  X(80) VALUE
               '   UNLOADDN SYSREC   '.
           05  WK-U-6                    PIC  X(80) VALUE
               '   CNTLDDN  CNTL     '.
           05  WK-U-7                    PIC  X(80) VALUE  SPACE.
           05  WK-U-8                    PIC  X(80) VALUE
               'CCCCCCCCCCCCCCCCCCCCCCCCCCC'.
           05  WK-U-9                    PIC  X(80) VALUE  SPACE.
           05  WK-U-10                   PIC  X(80) VALUE
               '       SELECT  *     '.
           05  WK-U-11                   PIC  X(80) VALUE
               '         FROM  LCBD2G11.TG110  '.
           05  WK-U-12.
               10  WK-U-12-1             PIC  X(30) VALUE
                   '        WHERE  JR_N    <      '.
               10  WK-U-12-2             PIC  X(01) VALUE  X'7D'.
               10  WK-U-12-3-DATE        PIC  X(08) VALUE  SPACE.
               10  WK-U-12-3-ZERO        PIC  X(14) VALUE
                   '00000000000000'.
               10  WK-U-12-4             PIC  X(01) VALUE  X'7D'.
               10  WK-U-12-5             PIC  X(02) VALUE  ' ;'.
               10  WK-U-12-6             PIC  X(24) VALUE  SPACE.
       01  WK-UNLOAD-SYSIN-TABLE   REDEFINES  WK-UNLOAD-SYSIN.
           05  WK-UNLOAD-COMMAND   OCCURS  12 TIMES  PIC  X(80).

       01  WK-DELETE-SYSIN.
           05  WK-D-1                    PIC  X(80) VALUE
               ' REORG TABLESPACE LCBD2G11.TG110'.
           05  WK-D-2                    PIC  X(80) VALUE
               ' SHRLEVEL REFERENCE COPY YES    '.
           05  WK-D-3                    PIC  X(80) VALUE
               ' SORTNUM  32         '.
           05  WK-D-4                    PIC  X(80) VALUE
               ' DDTYPE LOCPFCPY     '.
           05  WK-D-5.
               10  WK-D-5-1              PIC  X(15) VALUE
               '        DSNPAT '.
               10  WK-D-5-2              PIC  X(01) VALUE  X'7D'.
               10  WK-D-5-3              PIC  X(38) VALUE
               'PLCB.ZD2BR.LCBD2G11.TG110.P&PART.(+1)'.
               10  WK-D-5-4              PIC  X(01) VALUE  X'7D'.
               10  WK-D-5-5              PIC  X(25) VALUE  SPACE.
           05  WK-D-6                    PIC  X(80) VALUE  SPACE.
           05  WK-D-7                    PIC  X(80) VALUE
               '   DELETE  FROM  LCBD2G11.TG110'.
           05  WK-D-8.
               10  WK-D-8-1              PIC  X(30) VALUE
                   '        WHERE  JR_N      <    '.
               10  WK-D-8-2              PIC  X(01) VALUE  X'7D'.
               10  WK-D-8-3-DATE         PIC  X(08) VALUE  SPACE.
               10  WK-D-8-3-ZERO         PIC  X(14) VALUE
                   '00000000000000'.
               10  WK-D-8-4              PIC  X(01) VALUE  X'7D'.
               10  WK-D-8-5              PIC  X(26) VALUE  SPACE.
           05  WK-D-9.
               10  WK-D-9-1              PIC  X(35) VALUE
                   '        AND  SU_PRCS_RSLT_CD  IN  ('.
               10  WK-D-9-2              PIC  X(01) VALUE  X'7D'.
               10  WK-D-9-3              PIC  X(02) VALUE  '00'.
               10  WK-D-9-4              PIC  X(01) VALUE  X'7D'.
               10  WK-D-9-5              PIC  X(02) VALUE  ', '.
               10  WK-D-9-6              PIC  X(01) VALUE  X'7D'.
               10  WK-D-9-7              PIC  X(02) VALUE  '10'.
               10  WK-D-9-8              PIC  X(01) VALUE  X'7D'.
               10  WK-D-9-9              PIC  X(01) VALUE  ')'.
               10  WK-D-9-10             PIC  X(34) VALUE  SPACE.
       01  WK-DELETE-SYSIN-TABLE   REDEFINES  WK-DELETE-SYSIN.
           05  WK-DELETE-COMMAND   OCCURS   9 TIMES  PIC  X(80).

       01  WS-CALL-PGM                   PIC  X(08).
      *-----------------------------------------------------------------
      *   z/  _  7v~   AREA
      *-----------------------------------------------------------------
       01  LCBXU170-PARM.
         02  LCBXU170-STRTAREA.
             REPLACE         == (BNCS) ==    BY   == U170 ==.
             COPY LCBYSTRT.
             REPLACE OFF.

         02  LCBXU170-USERAREA.
             COPY  LCBYU170.

      ******************************************************************
       PROCEDURE                              DIVISION.
      ******************************************************************
       MAIN-RTN.

      * OPEN  SYSIN  DATA  SET  FOR  OUTPUT
           OPEN  OUTPUT  O1-UNLOAD-SYSIN.

            IF  W-O1-STATUS  =  00
                NEXT  SENTENCE
            ELSE
                DISPLAY  'UNLOAD SYSIN OPEN ERROR '
                         W-O1-STATUS
                MOVE     U-ABEND-CODE    TO  RETURN-CODE
                GOBACK
            END-IF.


      * Kv3saa ~ez Bi
      * 12 z  ~Vz/   GET
           INITIALIZE                         LCBXU170-PARM.
           MOVE  FUNCTION  CURRENT-DATE(1:8)  TO  U170-FROM-DATE.
           MOVE    '030'                  TO  U170-FUN-C.
           MOVE    '2'                    TO  U170-PUT-GUBUN.
           MOVE     12                    TO  U170-ILSU.

           PERFORM                            U0000-CALL-U170
                                        THRU  U0000-EXIT.

           MOVE   U170-DATE              TO  WK-U-12-3-DATE
                                             WK-D-8-3-DATE.

           PERFORM  VARYING  I  FROM  1  BY  1  UNTIL   I  >  12
               MOVE  WK-UNLOAD-COMMAND(I)    TO  O1-UNLOAD-SYSINREC
               WRITE O1-UNLOAD-SYSINREC
               IF  W-O1-STATUS  =  00
                   CONTINUE
               ELSE
                   DISPLAY  'UNLOAD SYSIN WRITE ERROR '
                            W-O1-STATUS
                   MOVE     U-ABEND-CODE    TO  RETURN-CODE
                   GOBACK
               END-IF
               MOVE  SPACE                  TO  O1-UNLOAD-SYSINREC
           END-PERFORM.

           CLOSE  O1-UNLOAD-SYSIN.

           OPEN  OUTPUT  O2-DELETE-SYSIN.
           IF  W-O2-STATUS  =  00
               NEXT  SENTENCE
           ELSE
               DISPLAY  'DELETE SYSIN OPEN ERROR '
                        W-O2-STATUS
               MOVE     U-ABEND-CODE    TO  RETURN-CODE
               GOBACK
           END-IF.

           PERFORM  VARYING  I  FROM  1  BY  1  UNTIL   I  >  9
               MOVE  WK-DELETE-COMMAND(I)    TO  O2-DELETE-SYSINREC
               WRITE O2-DELETE-SYSINREC
               IF  W-O2-STATUS  =  00
                   CONTINUE
               ELSE
                   DISPLAY  'DELETE SYSIN WRITE ERROR '
                            W-O2-STATUS
                   MOVE     U-ABEND-CODE    TO  RETURN-CODE
                   GOBACK
               END-IF
               MOVE  SPACE                  TO  O2-DELETE-SYSINREC
           END-PERFORM.

           CLOSE  O2-DELETE-SYSIN.

           GOBACK.

       MAIN-EXIT.
           EXIT.
      *-----------------------------------------------------------------
      *  z/7v~  ~K
      *-----------------------------------------------------------------
       U0000-CALL-U170.

           MOVE  'LCBXU170'               TO  WS-CALL-PGM.
           CALL   WS-CALL-PGM          USING  LCBXU170-PARM.

      *    -------------------------------------------------------------

           IF  U170-BOCOM-ERR-TYPE    NOT =  'N'
               DISPLAY  'U170 CALL ERROR : '  U170-ERR-REC
               MOVE      U-ABEND-CODE     TO  RETURN-CODE
               DISPLAY  '+++++++++++++++++++++++++++++++++++++++++++++'
               DISPLAY  '+++ LCBXU170 ERROR!!!!'
               DISPLAY  '+++ FROM LCBBG110     '
               DISPLAY  '+++++++++++++++++++++++++++++++++++++++++++++'
               GOBACK
           END-IF.

       U0000-EXIT.
           EXIT.
      ******************************************************************
      *               T H E   E N D   (LCBBG110)
      ******************************************************************

