      *****************************************************************
      *                                                               *
      *         I D E N T I F I C A T I O N   D I V I S I O N         *
      *                                                               *
      *****************************************************************

       IDENTIFICATION                  DIVISION.

       PROGRAM-ID.                     LEP32.
       AUTHOR.                         ITPlus.
       INSTALLATION.                   ITPlus.
       DATE-WRITTEN.                   2004.12.17.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *  PROGRAM TYPE   -  ONLINE COBOL                                *
      *                                                                *
      *  FUNCTION       - ?/?3?/v??væÖD/p/h/?pK¦Ú/?/i¬½¦¤??b?~K?     *
      *                                                                *
      *                                                                *
      *  DESCRIPTION    - ?/?3?/v??væÖD/p/h/?pK¦Ú/?/i¬½¦¤??b?~K?}?m/ *
      *                                                                *
      *  TRANSACTION ID -  LE32                                        *
      *  JSP       FILE -  LEP3200.JSP                                 *
      *  SERVLET   FILE -  NONE                                        *
      *                                                                *
      *  MAIN  PROGRAM  -  LEP32                                       *
      *  SUB   PROGRAM  -  SSSHE (}Ý¤¬èÝÙ?)                          *
      *                    SSSAK (?a[~èÝÙ·)                          *
      *  INPUT PARMS    -  COMMUNICATION  AREA    -   4000 BYTE        *
      *                                                                *
      *  OUTPUT PARMS   -  NONE                                        *
      *                                                                *
      *  TABLES                                                  CRUD  *
      *  ============================================================  *
      *  DTAA.TTAAA (  ?/?3?/       TABLE )                     R    *
      *  DTIA.TTIAA (  ??[¦¼/       TABLE )                     R    *
      *  DTJB.TTJBA (  {7  Úç       TABLE )                     R    *
      *  DTJB.TTJBC (  m?mÖ¤~h?     TABLE )                     R    *
      *  DTJB.TTJBD (  [?sai?sa?v   TABLE )                     R    *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  I/O FILES      -  NONE                                        *
      *                                                                *
      *  SWITCHES       -  NONE                                        *
      *                                                                *
      *  EXITS          -  NORMAL   - RETURN TO CICS                   *
      *                                                                *
      *                 -  ABNORMAL - NONE                             *
      *                                                                *
      *  SPECIAL LOGIC  -  NONE                                        *
      *                                                                *
      * v?i?HISTORY                                                  *
      *                                                                *
      * v?iÖ»z    ¼ß?3?/      ¼ß?3?aæÖ                           *
      *  ==========  ============  ==================================  *
      *  2004/12/17 ?~LÖ¤?       INITIAL CODING                      *
      *  2005/05/16 ?~LÖ¤?      ?pvs?/?3?/h/  »·??o?  iÖæa??  max~ *
      *                           ha?3?z?/n~  ?L¹¦Úç  »·??  u?? *
      ******************************************************************

      *****************************************************************
      *                                                                *
      *            E N V I R O N M E N T   D I V I S I O N             *
      *                                                                *
      *****************************************************************

       ENVIRONMENT                       DIVISION.

      ******************************************************************
      *                                                                *
      *                   D A T A   D I V I S I O N                    *
      *                                                                *
      ******************************************************************

       DATA                              DIVISION.

      ******************************************************************
      *                                                                *
      *                 W O R K I N G   S T O R A G E                  *
      *                                                                *
      ******************************************************************

       WORKING-STORAGE                   SECTION.

       01  WS-START                    PIC X(40)
           VALUE 'LEP32 - WORKING STORAGE BEGINS HERE'.

      ******************************************************************
      *                                                                *
      *                    A C C U M U L A T O R S                     *
      *                                                                *
      ******************************************************************
       01  ACCUMULATORS.
           05  A-READ-COUNT            PIC  9(07)  VALUE ZERO.
           05  A-TTLAK-MOVE-CNT        PIC  9(07)  VALUE ZERO.
           05  A-AMT-SUM               PIC  9(15)  VALUE  0.

      ******************************************************************
      *                                                                *
      *                       C O N S T A N T S                        *
      *                                                                *
      ******************************************************************
       01  CONSTANTS.
           05  C-PGM-LEP32             PIC  X(05)  VALUE  'LEP32'.
           05  C-PGM-SSSHE             PIC  X(05)  VALUE  'SSSHE'.
      *    ?a[~  ?~K?
           05  C-PGM-SSSAV             PIC  X(05)  VALUE  'SSSAV'.
           05  C-PGM-SSSAK             PIC  X(05)  VALUE  'SSSAK'.
      *                                ********************************
      *                                *  RETURN CODE
      *                                ********************************
       01  C-COUNT.
           05  C-MAX-COUNT-10          PIC  9(02)  VALUE  10.

      *                                ********************************
      *                                *  RETURN CODE
      *                                ********************************
       01  C-RETURN-CODE.
           05  C-RC01                  PIC  X(04)  VALUE  'RC01'.
           05  C-RC02                  PIC  X(04)  VALUE  'RC02'.
           05  C-RC15                  PIC  X(04)  VALUE  'RC15'.
           05  C-RC10                  PIC  X(04)  VALUE  'RC10'.

      *                                ********************************
      *                                *  USER MESSAGE CODES
      *                                ********************************
       01  C-USER-MESSAGE.
           05  C-MSG-CT00001           PIC  X(07)  VALUE  'CT00001'.
           05  C-MSG-AT00104           PIC  X(07)  VALUE  'AT00104'.
           05  C-MSG-AT02350           PIC  X(07)  VALUE  'AT02350'.
           05  C-MSG-AT17500           PIC  X(07)  VALUE  'AT17500'.
           05  C-MSG-AT70210           PIC  X(07)  VALUE  'AT70210'.
           05  C-MSG-AT80100           PIC  X(07)  VALUE  'AT80100'.
           05  C-MSG-AT00124           PIC  X(07)  VALUE  'AT00124'.
           05  C-MSG-AT38312           PIC  X(07)  VALUE  'AT38312'.

      *                                ********************************
      *                                *  COMMON  CONSTANTS           *
      *                                ********************************
           COPY                        SSYBC.

      *                                ********************************
      *                                *  DB2 STATUS SQL CODES        *
      *                                ********************************
           COPY                        SSYBI.

      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************
       01  SWITCHES.
           05  S-ROLLBACK              PIC  X(01)  VALUE 'Y'.
               88  S-ROLLBACK-YES                  VALUE 'Y'.
           05  S-RECORD-MORE           PIC  X(01)  VALUE 'Y'.
               88  S-RECORD-MORE-NO                VALUE 'N'.


      *****************************************************************
      *                                                               *
      *                     W O R K   A R E A S                       *
      *                                                               *
      *****************************************************************
       01  WORKAREAS.
           05  W-SYSTEM-DATE.
               10  W-SYSTEM-YY         PIC  X(04) VALUE SPACE.
               10  W-SYSTEM-MM         PIC  X(02) VALUE SPACE.
               10  W-SYSTEM-DD         PIC  X(02) VALUE SPACE.

           05  W-INDEX.
               10 W-I                   PIC  9(03)  VALUE ZERO.
               10 K                     PIC  9(03)  VALUE ZERO.
           05  W-SQL                    PIC  ---9.

           05  W-WORK.
               10 W-TTLAK-TOTAL-CNT     PIC S9(13)V USAGE COMP-3.
               10  W-LENGTH             PIC S9(04)  COMP   VALUE +89.
               10  W-LENGTH-KEY         PIC S9(04)  COMP   VALUE +23.
               10  W-ALT-LENGTH         PIC S9(04)  COMP   VALUE +10.
               10  W-Z09                PIC  Z,ZZZ,ZZ9.
               10  W-Z15                PIC  Z,ZZZ,ZZZ,ZZ9.
               10  W-Z19                PIC  ZZZ,ZZZ,ZZZ,ZZZ,ZZ9.
               10  W-906                PIC  9(06)         VALUE ZERO.
               10  W-915                PIC  9(10)         VALUE ZERO.
               10  W-YER                PIC  X(04)         VALUE SPACE.
               10  W-BAN                PIC  X(01)         VALUE SPACE.
               10  W-APPV-CNT           PIC  9(06)         VALUE ZERO.
               10  W-APPV-AMT           PIC  9(15)         VALUE ZERO.
               10  W-AMT-SUM            PIC  9(15)         VALUE ZERO.
               10  W-CSR-INITIAL        PIC  9(01)         VALUE ZERO.

           05  W-EDIT-ADDR.
               10  W-EDIT-SAN-BUNJI      PIC  X(04)  VALUE  SPACE.
               10  W-EDIT-APT-BLOCK2     PIC  X(80)  VALUE  SPACE.
               10  W-EDIT-APT-DONG1      PIC  X(12)  VALUE  SPACE.
               10  W-EDIT-APT-HO1        PIC  X(06)  VALUE  SPACE.
               10  W-EDIT-BUNJI          PIC  ZZZZ.
               10  W-EDIT-HO             PIC  ZZZZ.
               10  W-EDIT-TONG           PIC  ZZZZ.
               10  W-EDIT-BAN            PIC  ZZZZ.
      *                                ********************************
      *                                *   ?væÖD/p/?~æÖma?     VSAM
      *                                ********************************

       01  I-BIVJ30-REC.

           05  I-BIVJ30-KEY-REC.
               10  I-BIVJ30-YEAR            PIC  X(04).
               10  I-BIVJ30-BAN             PIC  X(01).
               10  I-BIVJ30-CRDTCD-BUSNID   PIC  X(10).
               10  I-BIVJ30-GUBUN-CD        PIC  X(01).
               10  I-BIVJ30-SEQ             PIC  X(07).
           05  I-BIVJ30-BUSNID              PIC  X(10).
           05  I-BIVJ30-TXOFF-CD            PIC  X(03).
           05  I-BIVJ30-APPV-PR-FR          PIC  X(08).
           05  I-BIVJ30-APPV-PR-TO          PIC  X(08).
           05  I-BIVJ30-APPV-YYMM           PIC  X(06).
           05  I-BIVJ30-APPV-FG             PIC  X(01).
           05  I-BIVJ30-APPV-CNT            PIC  9(06).
           05  I-BIVJ30-SRVC-FEE            PIC S9(15) COMP-3.
           05  I-BIVJ30-SRVC-FEE-EX-APPVAMT PIC S9(15) COMP-3.
           05  I-BIVJ30-APPV-AMT            PIC S9(15) COMP-3.
      *****************************************************************
      *                    WORK  COMMON  AREA                         *
      *****************************************************************
           COPY                        SSYBG.

      *                                ********************************
      *                                *     EIBRESP       VALUE      *
      *                                ********************************
           COPY                        SSYBE.

      *****************************************************************
      *                                                               *
      *                  M O D U L E   A R E A                        *
      *                                                               *
      *****************************************************************
       01 W-MODULE-AREA.
      *                                ********************************
      *                                *       }Ý¤?  èÝÙ·           *
      *                                ********************************
           COPY                        SSYHE.

      *                                ********************************
      *                                *     ADDRESS    EDIT          *
      *                                ********************************

           COPY                        SSYAV.
      *                                *************       ************
      *                                *  LGDONG  EDIT     CHECK AREA *
      *                                *************       ************


           COPY                        SSYAK.
      *****************************************************************
      *                                                               *
      *                 V S A M    I O     A R E A                    *
      *                                                               *
      *****************************************************************
      *                                ********************************
      *                                *       MESSAGE VSAM WORK      *
      *                                ********************************
           COPY                        SUY01.

      *****************************************************************
      *                                                               *
      *           P R O G R A M    S E L F   C O M M   A R E A        *
      *                                                               *
      *****************************************************************
450        COPY                        QMY00.

      ***********************************
      *    USER  AREA -?~hV¹Ö¹ß
      ***********************************
           05  W-USER-AREA             REDEFINES  W-PRIVATE.
               10  W-CM-CONDITION.
      *            ?aBi?/?/?3?/p?suVJ~
                   15  W-CM-BUSNID           PIC  X(010).
      *            ha?3?z?/
                   15  W-CM-RGST-OPEN-DT     PIC  X(008).
      *            m?m?{7ÚçE~p/
                   15  W-CM-TXOFF-CD         PIC  X(003).
      *            j?n~
                   15  W-CM-DATEYY           PIC  X(004).
      *            ?~
                   15  W-CM-DATEGI           PIC  X(001).
      ***********************************
      *    USER AREA - SINGLE¹Ö¹ß
      ***********************************
               10  W-CM-SINGLE.
      *            ÚÖJ~?(u3?v~Öá)
                   15 W-CM-TRADE-NM1         PIC X(060).
      *            ?/?3¼Ö  [~?a?~
                   15 W-CM-ADDRESS           PIC X(080).
      *            ?7~Öá(ma?/?/?)
                   15 W-CM-NM                PIC X(020).
      *            ?VJAuVJ~
                   15 W-CM-TELNO-1           PIC X(004).
                   15 W-CM-TELNO-2           PIC X(004).
                   15 W-CM-TELNO-3           PIC X(004).
      *            ?væÖD/p/i¬¼a??b}?ia
                   15 W-CM-TOTAL             PIC X(020).
      ***********************************
      *    USER  AREA - PREV/NEXT ¹Ö¹ß
      ***********************************
               10  W-CM-NEXT.
      *            A?hV?a
                   15  W-CM-TOTAL-CNT        PIC  S9(04)  COMP.
      *            ua¹¬  hV?a
                   15  W-CM-ARRAY-CNT        PIC  S9(04)  COMP.
      *            SKIP hV?a
                   15  W-CM-SKIP-CNT         PIC  S9(04)  COMP.
      ***********************************
      *    USER  AREA - ARRAY ¹Ö¹ß
      ***********************************
               10  W-C1-MULTI.
                   15  W-C1-MULTI-ARRAY  OCCURS  10 TIMES.
      *               ?væÖD/p/K¦Ú/p?suVJ~
                       20 W-C1-BUSNID            PIC X(10).
      *               ?væÖD/p/K¦Ú/~?
                       20 W-C1-TRADE-NM          PIC X(30).
      *                i¬¼ajÝæz
                       20 W-C1-APPV-DT           PIC X(06).
      *                i¬¼ahV?a
                       20 W-C1-CNT               PIC X(09).
      *                i¬¼a??b
                       20 W-C1-AMT               PIC X(15).
      *****************************************************************
      *                                                               *
      *                  D B 2   W O R K   A R E A                    *
      *                                                               *
      *****************************************************************
      *               *************************************************
      *               *  SQL COMMUNICATION AREA                       *
      *               *************************************************
           EXEC  SQL  INCLUDE  SQLCA   END-EXEC.
      *                                ********************************
      *                                *    DCL FOR DTAA.TTAAA        *
      *                                ********************************

           EXEC SQL  INCLUDE TAOAA
           END-EXEC.


      *                                ********************************
      *                                *    DCL FOR DTIA.TTIAA        *
      *                                ********************************

           EXEC SQL  INCLUDE TIOAA
           END-EXEC.


      *                                ********************************
      *                                *    DCL FOR DTJB.TTJAD        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOAD
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTJB.TTJBA        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOBA
           END-EXEC.


      *                                ********************************
      *                                *    DCL FOR DTJB.TTJBC        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOBC
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTJB.TTJBD        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOBD
           END-EXEC.


      *                                ********************************
      *                                *      DECLARE  CURSOR         *
      *                                ********************************
      ******************************************************************
      *                                                                *
      *         D E C L A R E    C U R S O R                           *
      *                                                                *
      ******************************************************************
      *****************************************************************
      *                                                               *
      *           E N D   O F  W O R K I N G  S T O R A G E           *
      *                                                               *
      *****************************************************************

       01  WS-END                      PIC X(40)
           VALUE 'LEP32 - WORKING STORAGE ENDS HERE'.

      *****************************************************************
      *                                                               *
      *                 L I N K A G E   S E C T I O N                 *
      *                                                               *
      *****************************************************************

       LINKAGE                         SECTION.
       01  DFHCOMMAREA.
           05  L-COMM-AREA             PIC  X(4000).

      ******************************************************************
      *                                                                *
      *              P R O C E D U R E   D I V I S I O N               *
      *                                                                *
      ******************************************************************
       PROCEDURE                         DIVISION.

      ******************************************************************
      *                                                                *
      *                  I N I T I A L I Z A T I O N                   *
      *                                                                *
      ******************************************************************
       INITIALIZATION                    SECTION.
      * WEBiA HOSThÝ»a  n¦»~H?  ?vHçè¦»~?/
           MOVE  DFHCOMMAREA             TO  W-COMM-AREA.

           MOVE  SPACE                   TO  W-COMM-RC
                                             W-MSG-ID.

           MOVE  'Y'                     TO  S-ROLLBACK
                                             W-COMM-END-FG.
           PERFORM  S9100-GET-SYSTEM-DATE.
       EJECT

      *****************************************************************
      *                                                               *
      *                     M  A  I  N  L  I  N  E                    *
      *                                                               *
      *****************************************************************
       MAINLINE                          SECTION.

           EVALUATE  W-COMM-STEP
      * INQUIRY

               WHEN  10
                     PERFORM  S0300-INQUIRY-PROC

               WHEN  OTHER
                     MOVE  'RC01'            TO  W-COMM-RC
                     MOVE  'STEP-ERROR '     TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-EVALUATE.

           MOVE  'N'                     TO  S-ROLLBACK.

       EJECT

      *****************************************************************
      *                                                               *
      *                    F I N A L I Z A T I O N                    *
      *                                                               *
      *****************************************************************
       FINALIZATION                      SECTION.

      *>  ~?[¦Ù~GET{çþ~
           IF    W-MSG-ID            NOT =   SPACE
                 PERFORM  S9800-READ-SUV010
           END-IF.

      *    ROLLBACK{çþ~
           IF    S-ROLLBACK-YES
                 PERFORM  S9700-ROLLBACK-PROC
           END-IF.

           MOVE  W-COMM-AREA             TO  DFHCOMMAREA.
           PERFORM  S9900-RETURN.

       EJECT
      *****************************************************************
      *                                                               *
      *           V E R I F I C A T I O N   C H E C K                 *
      *                                                               *
      *****************************************************************
      *****************************************************************
      *                                                               *
      *                  B U S I N E S S   L O G I C                  *
      *                                                               *
      *****************************************************************
      *****************************************************************
      *                                                               *
      *                S0100-INQUIRY-MULTI                            *
      *   ?væÖD/p/h/?pK¦Ú/  ?/  i¬¼a??b  ?~K?  LOGIC           *
      *                                                               *
      *****************************************************************
 LHK   S0100-INQUIRY-MULTI                   SECTION.

           MOVE W-CM-BUSNID    TO I-BIVJ30-BUSNID.

           MOVE  ZERO                    TO  W-I
                                             A-READ-COUNT.
           MOVE  'Y'                     TO  S-RECORD-MORE.

           PERFORM  S0800-STARTBR-BIVJ31.

           IF  W-RETURN-NORMAL

               PERFORM  S0700-READNEXT-BIVJ31

               PERFORM  UNTIL W-RETURN-ENDFILE OR
                             (I-BIVJ30-BUSNID NOT = W-CM-BUSNID)

                 IF  (I-BIVJ30-YEAR   NOT = W-CM-DATEYY)  OR
                     (I-BIVJ30-BAN    NOT = W-CM-DATEGI)

                     CONTINUE

                 ELSE

                     ADD   1                    TO  A-READ-COUNT

                     IF  (A-READ-COUNT         >   W-CM-SKIP-CNT )  AND
                         (W-I                  <   C-MAX-COUNT-10)

                         PERFORM  S0400-MOVE-TO-COMM

                         MOVE I-BIVJ30-APPV-AMT     TO W-AMT-SUM
                         COMPUTE A-AMT-SUM = A-AMT-SUM + W-AMT-SUM

                     ELSE

                          MOVE I-BIVJ30-APPV-AMT     TO W-AMT-SUM
                          COMPUTE A-AMT-SUM = A-AMT-SUM + W-AMT-SUM

                     END-IF

                 END-IF

                 PERFORM  S0700-READNEXT-BIVJ31

               END-PERFORM

               MOVE A-AMT-SUM          TO W-Z19
               MOVE W-Z19              TO W-CM-TOTAL

               PERFORM  S0600-ENDBR-BIVJ31

           ELSE

               CONTINUE

           END-IF.

           IF    A-READ-COUNT           <=    ZERO
                 MOVE  ZERO                   TO  W-CM-TOTAL-CNT
                 MOVE  ZERO                   TO  W-CM-ARRAY-CNT

      *          }amÖ¼/?/h/  ?4ù°l~m/?.              
                 MOVE  C-RC15                 TO  W-COMM-RC
                 MOVE  C-MSG-AT38312          TO  W-MSG-ID

                 PERFORM                      FINALIZATION
           ELSE
                 MOVE  A-READ-COUNT           TO  W-CM-TOTAL-CNT
                 MOVE  W-I                    TO  W-CM-ARRAY-CNT

      *          ?7ÚÖ?S?/?~  ?~K?o¦¸6ù°l~m/?.
                 MOVE  C-RC10                 TO  W-COMM-RC
                 MOVE  C-MSG-CT00001          TO  W-MSG-ID
           END-IF.

       S0100-INQUIRY-MULTI-EXIT.
           EXIT.
           EJECT

      *****************************************************************
      *                                                               *
      *                S0200-INQUIRY-SINGLE                           *
      *   ?/?3?/??  ?~K?}/l?  LOGIC                             *
      *                                                               *
      *****************************************************************
       S0200-INQUIRY-SINGLE                  SECTION.

           IF (W-CM-DATEYY < 1800) OR (W-CM-DATEYY > 2100)

              MOVE  C-RC01            TO  W-COMM-RC
              MOVE  C-MSG-AT02350     TO  W-MSG-ID
      *           ?~K?}?  iA[?j?n~?A  iA[¦¤~hÝ»?  »·??}/ù·?~?~?.
              PERFORM                 FINALIZATION

           ELSE

               IF (W-CM-DATEGI = 1 OR 2)

                   CONTINUE

               ELSE
                   MOVE  C-RC01            TO  W-COMM-RC
                   MOVE  C-MSG-AT02350     TO  W-MSG-ID
      *           ?~K?}?  iA[?j?n~?A  iA[¦¤~hÝ»?  »·??}/ù·?~?~?.
                   PERFORM                 FINALIZATION
               END-IF
           END-IF.

           MOVE W-CM-TXOFF-CD           TO TXOFF-CD     OF TTAAA.
           MOVE W-CM-BUSNID             TO BUSNID       OF TTAAA.
050516     MOVE W-CM-RGST-OPEN-DT       TO RGST-OPEN-DT OF TTAAA.

           PERFORM  S0900-SELECT-TTAAA.

           EVALUATE SQLCODE

               WHEN C-SQL-NORMAL

                    PERFORM    S0500-HEADER-MOVE-SCR

                    IF  TXOFF-CD OF TTAAA = W-CM-TXOFF-CD

                        CONTINUE
LHK                 ELSE
                        MOVE  C-RC01            TO  W-COMM-RC
                        MOVE  C-MSG-AT17500     TO  W-MSG-ID
      *                }amÖÚ?saÚç¹¦Úç  iE?~}/l?  ?/?3?/h/  ?/l?l~m/.
                        PERFORM                 FINALIZATION
                    END-IF

               WHEN C-SQL-SELECT-DUP

                    MOVE  C-RC01            TO  W-COMM-RC
                    MOVE  C-MSG-AT70210     TO  W-MSG-ID
      *                ?pvso?  ?/?3?/  »·l~m/?.  
                    PERFORM                 FINALIZATION

               WHEN OTHER

                    MOVE  C-RC01            TO  W-COMM-RC
                    MOVE  C-MSG-AT80100     TO  W-MSG-ID
      *                t~p?so?  ?/?3?/  »·l~m/?.
                    PERFORM                 FINALIZATION

           END-EVALUATE.

       S0200-INQUIRY-SINGLE-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *                S0300-INQUIRY-PROC                             *
      *   ?væÖD/p/h/?pK¦Ú/?/i¬¼a??b  ?~K?}/l?  LOGIC             *
      *                                                               *
      *****************************************************************
       S0300-INQUIRY-PROC                   SECTION.

           INITIALIZE                W-CM-SINGLE.
           INITIALIZE                W-CM-ARRAY-CNT.
           INITIALIZE                W-CM-TOTAL-CNT.
           INITIALIZE                W-C1-MULTI.

           PERFORM    S0200-INQUIRY-SINGLE.

           PERFORM    S0100-INQUIRY-MULTI.

       S0300-INQUIRY-PROC-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *               S0400-MOVE-TO-COMM                              *
      *   ?væÖD/p/??b  ?7v~??WEB AREA ?~ MOVE                  *
      *                                                               *
      *****************************************************************
       S0400-MOVE-TO-COMM                    SECTION.

           ADD   1                       TO  W-I.

      *?væÖD/p/K¦Ú/uVJ~

           MOVE I-BIVJ30-CRDTCD-BUSNID TO W-C1-BUSNID (W-I).

      *?væÖD/p/K¦Ú/~?

           MOVE I-BIVJ30-CRDTCD-BUSNID TO BUSNID       OF TTAAA.
050516     MOVE SPACE                  TO RGST-OPEN-DT OF TTAAA.

           PERFORM  S0900-SELECT-TTAAA.

           IF  TRADE-NM1 OF TTAAA = LOW-VALUE

               MOVE SPACE              TO W-C1-TRADE-NM (W-I)

           ELSE

               MOVE TRADE-NM1 OF TTAAA  TO W-C1-TRADE-NM (W-I)

           END-IF.

      * i¬¼ajÝæz?,i¬¼ahV?a?,i¬¼a??b

           MOVE I-BIVJ30-APPV-YYMM     TO W-C1-APPV-DT (W-I).

           MOVE I-BIVJ30-APPV-CNT      TO W-Z09.
           MOVE W-Z09                  TO W-C1-CNT (W-I).

           MOVE I-BIVJ30-APPV-AMT      TO W-APPV-AMT.
           MOVE W-APPV-AMT             TO W-Z15.
           MOVE W-Z15                  TO W-C1-AMT(W-I).

       S0400-MOVE-TO-COMM-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *               S0500-HEADER-MOVE-SCR                           *
      *                                                               *
      *****************************************************************
       S0500-HEADER-MOVE-SCR             SECTION.

      * ÚÖJ~?/?7~?

           MOVE +30                    TO W-SSSHE-I-LENGTH.
           MOVE TRADE-NM1 OF TTAAA     TO W-SSSHE-I-DATA.

           CALL C-PGM-SSSHE USING         W-SSSHE-I-LENGTH
                                          W-SSSHE-I-DATA
                                          W-SSSHE-STATUS.

           MOVE W-SSSHE-I-DATA         TO W-CM-TRADE-NM1.

           MOVE RESID-CHIEF OF TTAAA   TO RESID OF TTIAA.
           MOVE TXPAYER-TP-CHIEF OF TTAAA
                                       TO TXPAYER-TP OF TTIAA.
           PERFORM    S1000-SQL-SELECT-TTIAA.

           MOVE NM OF TTIAA            TO W-CM-NM.

      *?/?3¼Ö[~?a?~

           INITIALIZE TTJAD.

           MOVE LGDONG-CD     OF TTAAA  TO LGDONG-CD OF TTJAD.

           PERFORM    S1100-SQL-SELECT-TTJAD.

           IF  SQLCODE = C-SQL-NORMAL

           INITIALIZE                    W-SSSAV-AREA
           MOVE  BUNJI          OF TTAAA TO  W-EDIT-BUNJI
           MOVE  HO             OF TTAAA TO  W-EDIT-HO
           MOVE  TONG           OF TTAAA TO  W-EDIT-TONG
           MOVE  BAN            OF TTAAA TO  W-EDIT-BAN
           MOVE  SI-DO          OF TTJAD TO  W-SSSAV-SI-DO

           MOVE  GU-SI-GUN      OF TTJAD TO  W-SSSAV-GU-SI-GUN
           MOVE  DONG-UEP-MYUN  OF TTJAD TO  W-SSSAV-DONG-EUP-MYUN
           MOVE  GA-RHEE        OF TTJAD TO  W-SSSAV-GA-RI
           MOVE  SAN-BUNJI      OF TTAAA TO  W-SSSAV-SAN-BUNJI
           MOVE  W-EDIT-BUNJI            TO  W-SSSAV-BUNJI
           MOVE  W-EDIT-HO               TO  W-SSSAV-HO
           MOVE  APT-BLOCK2     OF TTAAA TO  W-SSSAV-APT-BLOCK
           MOVE  APT-DONG1      OF TTAAA TO  W-SSSAV-APT-DONG
           MOVE  APT-HO1        OF TTAAA TO  W-SSSAV-APT-HO
           MOVE  W-EDIT-TONG             TO  W-SSSAV-TONG
           MOVE  W-EDIT-BAN              TO  W-SSSAV-BAN
           CALL  C-PGM-SSSAV          USING  W-SSSAV-AREA

           INITIALIZE                    W-SSSHE-AREA
           MOVE  W-SSSAV-OUTPUT          TO  W-SSSHE-I-DATA
           MOVE  +80                     TO  W-SSSHE-I-LENGTH
           CALL  C-PGM-SSSHE          USING  W-SSSHE-AREA
           MOVE  W-SSSHE-I-DATA          TO  W-CM-ADDRESS

           ELSE

               MOVE ' XXXXXXXXXX'           TO W-CM-ADDRESS

           END-IF.
      * ?VJAuVJ~

           IF  TELNO OF TTAAA > SPACE

               MOVE TELNO OF TTAAA (1:4)    TO W-CM-TELNO-1
               MOVE TELNO OF TTAAA (5:4)    TO W-CM-TELNO-2
               MOVE TELNO OF TTAAA (9:4)    TO W-CM-TELNO-3

            ELSE

               MOVE SPACE          TO W-CM-TELNO-1
                                      W-CM-TELNO-2
                                      W-CM-TELNO-3
           END-IF.


       S0500-HEADER-MOVE-SCR-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *                  S0600-ENDBR-BIVJ31                           *
      *                                                               *
      *****************************************************************
       S0600-ENDBR-BIVJ31                    SECTION.

           EXEC CICS ENDBR    FILE     ('BIVJ31')
                              RESP     (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               CONTINUE

           ELSE
                     MOVE  C-RC01            TO  W-COMM-RC
                     MOVE  'S0600-ENDBR-BIVJ31 ERROR...'
                                              TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-IF.
       S0600-ENDBR-BIVJ31-EXIT.
           EXIT.
           EJECT

      *****************************************************************
      *                                                               *
      *                  S0700-READNEXT-BIVJ31                      *
      *                                                               *
      *****************************************************************
       S0700-READNEXT-BIVJ31                 SECTION.

           EXEC CICS READNEXT FILE    ('BIVJ31')
                              INTO    (I-BIVJ30-REC)
                              LENGTH  (W-LENGTH)
                              RIDFLD  (I-BIVJ30-BUSNID)
                              RESP    (W-RETURN-CODE)
           END-EXEC.

           IF (W-RETURN-NORMAL) OR
              (W-RETURN-DUPKEY) OR
              (W-RETURN-ENDFILE)

               CONTINUE

      *        MOVE      1       TO   K
      *       (W-RETURN-ENDFILE)
      *        CONTINUE
      *
      *    ELSE
      *        IF W-RETURN-ENDFILE
      *
      *           MOVE   1          TO K

           ELSE
                     MOVE  C-RC01            TO  W-COMM-RC
                     MOVE  'S0700-READNEXT-BIVJ31 ERROR...'
                                              TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-IF.
       S0700-READNEXT-BIVJ31-EXIT.
           EXIT.
           EJECT

      *****************************************************************
      *                                                               *
      *            S0800-STARTBR-BIVJ31                               *
      *                                                             *
      *                                                               *
      *****************************************************************
       S0800-STARTBR-BIVJ31                  SECTION.

           EXEC CICS STARTBR  FILE     ('BIVJ31')
                              RIDFLD   (I-BIVJ30-BUSNID)
                              KEYLENGTH(W-ALT-LENGTH)
                              EQUAL
                              RESP     (W-RETURN-CODE)
           END-EXEC.

           IF (W-RETURN-NORMAL) OR
              (W-RETURN-NOTFND)

               CONTINUE

           ELSE
                     MOVE  C-RC01             TO  W-COMM-RC
                     MOVE  'S0800-STARTBR-BIVJ31 ERROR...'
                                              TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-IF.
       S0800-STARTBR-BIVJ31-EXIT.
           EXIT.
           EJECT
DB    *****************************************************************
      *                                                               *
      *            D B ?~K?                                         *
      *                                                               *
      *****************************************************************
      *****************************************************************
      *                                                               *
      *            S0900-SELECT-TTAAA                                 *
      * ?/?3?/  I¦»~x¬»?  SELCELCT }?m/?.                         *
      *                                                               *
      *****************************************************************
       S0900-SELECT-TTAAA                  SECTION.

           EXEC SQL SELECT
                          RGST_OPEN_DT,
                          TRADE_NM1,
                          TELNO,
                          RESID_CHIEF,
                          TXPAYER_TP_CHIEF,
                          BUSNTP_CD_MAIN,
                          BUSN_OWNER_TP,
                          STAT_CD_BUSN_OWNER,
                          TXOFF_CD,
                          LGDONG_CD,
                          SAN_BUNJI,
                          BUNJI,
                          HO,
                          APT_BLOCK2,
                          APT_DONG1,
                          APT_HO1,
                          TONG,
                          BAN
                     INTO
                          :TTAAA.RGST-OPEN-DT,
                          :TTAAA.TRADE-NM1,
                          :TTAAA.TELNO,
                          :TTAAA.RESID-CHIEF,
                          :TTAAA.TXPAYER-TP-CHIEF,
                          :TTAAA.BUSNTP-CD-MAIN,
                          :TTAAA.BUSN-OWNER-TP,
                          :TTAAA.STAT-CD-BUSN-OWNER,
                          :TTAAA.TXOFF-CD,
                          :TTAAA.LGDONG-CD,
                          :TTAAA.SAN-BUNJI,
                          :TTAAA.BUNJI,
                          :TTAAA.HO,
                          :TTAAA.APT-BLOCK2,
                          :TTAAA.APT-DONG1,
                          :TTAAA.APT-HO1,
                          :TTAAA.TONG,
                          :TTAAA.BAN
                    FROM DTAA.TTAAA
                   WHERE BUSNID       = :TTAAA.BUSNID
050516               AND (    RGST_OPEN_DT = :TTAAA.RGST-OPEN-DT
050516                     OR RGST_OPEN_DT = ' ')
                     AND LAST_FG  = 'Y'
                    WITH UR
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND OR
                SQLCODE = C-SQL-SELECT-DUP

                CONTINUE
           ELSE
                     MOVE   SQLCODE      TO  W-SQL
                     MOVE   W-SQL        TO  W-COMM-SQL
                     MOVE  'S0900-SELECT-TTAAA ERROR...'
                                              TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-IF.
       S0900-SELECT-TTAAA-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *             S1000-SQL-SELECT-TTIAA                            *
      * ??[¦¼/  I¦»~x¬»?  SELCELCT }?m/?.                         *
      *                                                               *
      *****************************************************************
       S1000-SQL-SELECT-TTIAA                SECTION.

           EXEC         SQL
                        SELECT   NM
                        INTO    :TTIAA.NM
                        FROM     DTIA.TTIAA
                        WHERE    RESID =:TTIAA.RESID
                        AND      TXPAYER_TP = :TTIAA.TXPAYER-TP
                        WITH    UR
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL   OR
               SQLCODE = C-SQL-SELECT-DUP   OR
               SQLCODE = C-SQL-NOTFND

               CONTINUE
           ELSE
                     MOVE   SQLCODE      TO  W-SQL
                     MOVE   W-SQL        TO  W-COMM-SQL
                     MOVE  'S1000-SQL-SELECT-TTIAA ERROR...'
                                              TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-IF.
       S1000-SQL-SELECT-TTIAA-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *             S1100-SQL-SELECT-TTJAD                            *
      * u3?7E~p/  I¦»~x¬»?  SELCELCT }?m/?.                       *
      *                                                               *
      *****************************************************************
       S1100-SQL-SELECT-TTJAD                SECTION.

           EXEC SQL SELECT
                          SI_DO,
                          GU_SI_GUN,
                          DONG_UEP_MYUN,
                          GA_RHEE,
                          TXOFF_CD
                    INTO :TTJAD.SI-DO,
                         :TTJAD.GU-SI-GUN,
                         :TTJAD.DONG-UEP-MYUN,
                         :TTJAD.GA-RHEE,
                         :TTJAD.TXOFF-CD
                   FROM   DTJA.TTJAD

                   WHERE  LGDONG_CD= :TTJAD.LGDONG-CD
                    WITH  UR
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL  OR
               SQLCODE = C-SQL-NOTFND

               CONTINUE
           ELSE
                     MOVE   SQLCODE      TO  W-SQL
                     MOVE   W-SQL        TO  W-COMM-SQL
                     MOVE  'S1100-SQL-SELECT-TTJAD ERROR...'
                                              TO  W-COMM-MSG
                     PERFORM                  FINALIZATION
           END-IF.
       S1100-SQL-SELECT-TTJAD-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *            S9100-GET-SYSTEM-DATE                              *
      *                                                               *
      *****************************************************************
       S9100-GET-SYSTEM-DATE             SECTION.

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

           MOVE  W-DB2DATE-YEAR          TO  W-SYSTEM-YY.
           MOVE  W-DB2DATE-MM            TO  W-SYSTEM-MM.
           MOVE  W-DB2DATE-DD            TO  W-SYSTEM-DD.

       S9100-GET-SYSTEM-DATE-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *            S9700-ROLLBACK-PROC                                *
      *                                                               *
      *****************************************************************
       S9700-ROLLBACK-PROC               SECTION.

           EXEC  CICS  SYNCPOINT  ROLLBACK  END-EXEC.

       S9700-ROLLBACK-PROC-EXIT.
           EXIT.
           EJECT

      *****************************************************************
      *                                                               *
      *                 S 9 8 0 0 - R E A D - S U V 0 1 0             *
      *                                                               *
      *****************************************************************
       S9800-READ-SUV010                 SECTION.
           EXEC  CICS READ     FILE     ('SUV010')
                               INTO     (W-MESSAGE)
                               RIDFLD   (W-MSG-ID)
                               RESP     (W-RETURN-CODE)
           END-EXEC.

           IF   W-RETURN-NORMAL
                MOVE  W-MSG-CONTENTS     TO  W-COMM-MSG
           ELSE
                MOVE 'MESSAGE NOT-FOUND' TO  W-COMM-MSG
           END-IF.

       S9800-READ-SUV010-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *                   S 9 9 0 0 - R E T U R N                     *
      *                                                               *
      *                     - RETURN TO CICS                          *
      *                                                               *
      *****************************************************************
       S9900-RETURN                      SECTION.

           EXEC  CICS  RETURN            END-EXEC.

       S9900-RETURN-EXIT.
           EXIT.
           EJECT
      *****************************************************************
      *                                                               *
      *             ?E  ?N  ?D  ?O?F  L ?E  ?P  ?6  ?0            *
      *                                                               *
      *****************************************************************
