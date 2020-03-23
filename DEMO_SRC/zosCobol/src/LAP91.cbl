      ******************************************************************
      *                                                                *
      *         I D E N T I F I C A T I O N   D I V I S I O N          *
      *                                                                *
      ******************************************************************

       IDENTIFICATION DIVISION.

       PROGRAM-ID.    LAP91.
       AUTHOR.        ITPlus.
       INSTALLATION.  ITPlus.
       DATE-WRITTEN.  2003.10.21.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *                    L   A   P   9   1                           *
      *                                                                *
      *  PROGRAM TYPE   -  ONLINE COBOL                                *
      *                                                                *
      *  FUNCTION       - ??[?uVJ~ÙÖ  Bi??{çþ~(PRINT TXN)            *
      *                 -  LA30(OR LA32),RWA1,RWA2¹¦Úç  J~Bi?.       *
      *                                                                *
      *  TRANSACTION    -  LA91                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; LAP91                       *
      *                                                                *
      *  INPUT PARMS    -  COMMUNICATION AREA      -  4000 BYTE        *
      *                                                                *
      *                 -  FAST PATH?/æÖ?~INPUT PARMS                *
      *                    -?/?3?/p?suVJ~(10 BYTE)                  *
      *                    -u¬¤?maÚÖ      ( 1 BYTE)                  *
      *                    -~?ÖÚ?u?}p    ( 1 BYTE)                  *
      *                    -¼ß?3?z?/      ( 8 BYTE)                  *
      *                    -?/wa?/»¦      (50 BYTE)                  *
      *                    - PRINTER ID     ( 4 BYTE)                  *
      *                                                                *
      *  OUTPUT PARMS   -  NONE                                        *
      *                                                                *
      *  TABLES         -  DTAA.TTAAA -?/?3?/                        *
      *                    DTAA.TTAAB -?3½»                          *
      *                    DTCA.TTCAA -u3?v?~vv?/}?                  *
      *                    DTIA.TTIAA -??[¦¼/                        *
      *                    DTIA.TTIAB -h/?a?7v~                      *
      *                    DTIA.TTIAD -tv?v?a¹ß                      *
      *                    DTJA.TTJAD -u3?7n?                        *
      *                    DTJA.TTJBA -{7Úç                          *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  I/O FILES      -  NONE                                        *
      *                                                                *
      *  SWITCHES       -  S-CICS-RETURN                               *
      *                    LOW-VALUES    PSEUDO RETURN                 *
      *                    HIGH-VALUES   CICS RETURN                   *
      *                                                                *
      *                 -  S-TTAAA-SW                                  *
      *                    LOW-VALUES  WHEN MORE RECORDS TO FETCH      *
      *                    HIGH-VALUES WHEN NO MORE RECORDS TO FETCH   *
      *                                                                *
      *  EXITS          -  NORMAL   - RETURN TO CICS                   *
      *                                                                *
      *                 -  ABNORMAL - NONE                             *
      *                                                                *
      *  SPECIAL LOGIC  -  NONE                                        *
      *                                                                *
      *  MODIFICATIONS  -                                              *
      *                                                                *
      *  DATE      S.E.            DESCRIPTION                         *
      *  --------  --------------  ---------------------------------   *
      *2003/10/21  ITPlus             INITIAL WRITTEN                   *
      *                                                                *
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
           VALUE 'LAP91 - WORKING STORAGE BEGINS HERE'.

      ******************************************************************
      *                                                                *
      *                    A C C U M U L A T O R S                     *
      *                                                                *
      ******************************************************************

       01  ACCUMULATORS.

           05  A-RECORD-COUNT          PIC S9(04) COMP SYNC VALUE +0.
               88  A-NO-RECORD-FOUND                        VALUE +0.

           05  A-RECORD-TTAAB          PIC S9(04) COMP SYNC VALUE +0.
               88  A-NO-RECORD-TTAAB                        VALUE +0.

           05  A-RECORD-TTAAK          PIC S9(04) COMP SYNC VALUE +0.
               88  A-NO-RECORD-TTAAK                        VALUE +0.

           05  A-LINE-COUNT            PIC S9(04) COMP SYNC VALUE +0.
               88  A-LINE-COUNT-IS-MAX                      VALUE +30.

           05  A-ACCUM-COUNT           PIC S9(04) COMP SYNC VALUE +0.
               88  A-ACCUM-COUNT-IS-MAX                     VALUE +13.

           05  A-PAGE-COUNT            PIC S9(03) COMP-3    VALUE +0.

      ******************************************************************
      *                                                                *
      *                       C O N S T A N T S                        *
      *                                                                *
      ******************************************************************

       01  CONSTANTS.

           05  C-PRINT-LENGTH          PIC S9(04) COMP SYNC VALUE +125.
           05  C-ONPRT-END-MARK        PIC  X(01) VALUE X'3F'.

           05  C-PGM-LAP91             PIC  X(08) VALUE 'LAP91'.
           05  C-PGM-RWA1              PIC  X(08) VALUE 'RWA1'.
           05  C-COMM-LNTH             PIC S9(04) COMP SYNC VALUE +4000.

           05  C-MAP                   PIC  X(08) VALUE 'LAU91'.
           05  C-MAPSET                PIC  X(08) VALUE 'LAU91'.
           05  C-PGM-SSSAK             PIC  X(05) VALUE 'SSSAK'.
           05  C-PGM-SSSAX             PIC  X(05) VALUE 'SSSAX'.
           05  C-PGM-SSSAV             PIC  X(05) VALUE 'SSSAV'.
           05  C-PGM-SSSAA             PIC  X(05) VALUE 'SSSAA'.
           05  C-PGM-SSSHE             PIC  X(05) VALUE 'SSSHE'.
           05  C-COLL-CHNG-ON          PIC  X(01) VALUE 'Y'.

      *                                ********************************
      *                                *       USER MESSAGE CODES     *
      *                                ********************************

           05  C-MSG-NO-DATA           PIC  X(07) VALUE 'ES00005'.
           05  C-MSG-END-DATA          PIC  X(07) VALUE 'ES00006'.

      *                                ********************************
      *                                *      C O N S T A N T S       *
      *                                ********************************

           COPY SSYBC.


      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************

       01  SWITCHES.

           05  S-CICS-RETURN           PIC  X(01) VALUE LOW-VALUES.
               88 S-CICS-RETURN-ON                VALUE HIGH-VALUES.

           05  S-TTAAA-SW              PIC  X(01) VALUE LOW-VALUES.
               88  S-TTAAA-END                    VALUE HIGH-VALUES.

           05  S-TTAAK-SW              PIC  X(01) VALUE LOW-VALUES.
               88  S-TTAAK-END                    VALUE HIGH-VALUES.

           05  S-TTAAB-SW              PIC  X(01) VALUE LOW-VALUES.
               88  S-TTAAB-END                    VALUE HIGH-VALUES.

      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************

      *                                *********************************
      *                                *       WORK COMMON AREA        *
      *                                *********************************

           COPY SSYBG.

      *                                *********************************
      *                                *       DB2 STATUS SQL CODE     *
      *                                *********************************

           COPY SSYBI.


      *                                *********************************
      *                                *       EIBRESP        VALUE    *
      *                                *********************************

           COPY SSYBE.

      *                                *********************************
      *                                *    PROGRAM SELF COMM AREA     *
      *                                *********************************

450    COPY QMY00.

       01  W-COMM-AREA-R  REDEFINES W-COMM-AREA.

      *i?I?
           05  FIL                     PIC  X(450).

      *?~l?
           05  FIL                     PIC  X(50).
           05  W-COMM-NAP-KIND         PIC  X(01).
           05  W-COMM-BUSN             PIC  X(13).
           05  W-COMM-SAMOK            PIC  X(02).
           05  W-COMM-CHNG-DATE        PIC  X(12).
           05  W-COMM-R-SAYU           PIC  X(50).
           05  W-COMM-COLL-CHNG        PIC  X(01).
           05  W-COMM-CODE             PIC  X(01).
           05  W-COMM-PRT              PIC  X(04).
           05  W-COMM-AREA-YEAR        PIC  X(04).
           05  W-COMM-AREA-TXOFF-CD    PIC  X(03).
           05  W-COMM-AREA-NO          PIC  X(07).
           05  W-COMM-AREA-JAE         PIC  X(01).
           05  FIL                     PIC  X(01).

      * SELF
           05  W-SELF-REC.

               10  W-COMM-IDTEAMN      PIC  X(24).

               10  W-COMM-STATUS       PIC  X(01).
                   88  W-COMM-STATUS-SPACE      VALUE SPACES.
                   88  W-COMM-STATUS-LOW-VALUE  VALUE LOW-VALUES.

               10  W-COMM-PRINT        PIC  X(04).
                   88  W-COMM-PRINT-SPACE       VALUE SPACES.
                   88  W-COMM-PRINT-LOW-VALUE   VALUE LOW-VALUES.

               10  W-COMM-ADDR         PIC  X(60).
               10  W-RETURN-ADDR       PIC  X(40).
               10  W-LINE-SKIP         PIC  9(02).
               10  W-CHK-SW            PIC  X(01).
               10  W-CHK-SW1           PIC  X(01).
               10  W-CHK-FORM          PIC  X(03).
               10  W-SAVE-BUSNID       PIC  X(10).
               10  W-SAVE-OPEN-DT      PIC  X(08).
               10  W-SAVE-RESID        PIC  X(13).
               10  W-SAVE-TXPAYER-TP   PIC  X(01).
               10  MOVE-CNT            PIC  9(02).
               10  CHK-CNT             PIC  9(02).
               10  CHK-SW              PIC  X(01).
               10  W-COMM-RETURN-ST    PIC  X(02).
               10  W-JUPSU-NO          PIC  9(07).

       01  W-RCVE-DT.

           05 W-RCVE-YY                PIC X(04) VALUE SPACE.
           05 W-RCVE-MM                PIC X(02) VALUE SPACE.
           05 W-RCVE-DD                PIC X(02) VALUE SPACE.

       01  WORK-AREA.

           05 I                        PIC 9(02) VALUE 0.
           05 J                        PIC 9(02) VALUE 0.
           05 LEFT-LENGTH              PIC 9(03) VALUE 0.
           05 SEPERATE-POSITION        PIC 9(02) VALUE 0.
           05 SO-POSITION              PIC 9(02) VALUE 0.
           05 SI-POSITION              PIC 9(02) VALUE 0.
           05 SO-COUNT                 PIC 9(02) VALUE 0.
           05 SI-COUNT                 PIC 9(02) VALUE 0.
           05 WORK-EDIT-SAMU           PIC X(30) VALUE SPACE.
           05 WS-TXOFF-NM-A            PIC X(30) VALUE SPACE.
           05 WS-TXOFF-NM-B            PIC X(30) VALUE SPACE.

       01  W-SSSAX-ADDRESS1            PIC X(122).
       01  W-SSSAX-ADDRESS2            PIC X(122).

       01  W-ADDRESS-RECORD.

           05 W-SI-DO                  PIC X(12).
           05 W-GU-SI-GUN              PIC X(14).
           05 W-DONG-UEP-MYUN          PIC X(14).
           05 W-GA-RHEE                PIC X(14).
           05 W-SAN-BUNJI              PIC X(04).
           05 W-BUNJI                  PIC ZZZZ.
           05 W-HO                     PIC ZZZZ.
           05 W-APT-BLOCK              PIC X(30).
           05 W-APT-DONG               PIC X(12).
           05 W-APT-HO                 PIC X(06).
           05 W-TONG                   PIC ZZZZ.
           05 W-BAN                    PIC ZZZZ.


      *****************************************************************
      *                                                               *
      *                 M O D U L E         A R E A                   *
      *                                                               *
      *****************************************************************

      *                                *********************************
      *                                *    ADDRESS EDIT               *
      *                                *********************************
           COPY SSYAK.


      *                                *********************************
      *                                *    ADDRESS EDIT 2             *
      *                                *********************************
           COPY SSYAX.

      *                                *********************************
      *                                *    ?a[~èÝÙ·2                *
      *                                *********************************

           COPY SSYAV.

      *                                *********************************
      *                                *    NUM EDIT                   *
      *                                *********************************

           COPY SSYAA.

      *                                *********************************
      *                                *    SOSI CHECK                 *
      *                                *********************************

           COPY SSYHE.


      *****************************************************************
      *                                                               *
      *                 V S A M    I O    A R E A                     *
      *                                                               *
      *****************************************************************

           COPY SUY01.

      *****************************************************************
      *                                                               *
      *                  D B 2   W O R K   A R E A                    *
      *                                                               *
      *****************************************************************
      *                                ********************************
      *                                *    SQL COMMUNICATION AREA    *
      *                                ********************************

           EXEC SQL  INCLUDE  SQLCA
           END-EXEC.

      *                                ********************************
      *                                *     ?/?3?/                   
      *                                ********************************

           EXEC SQL INCLUDE            TAOAA
           END-EXEC.


      *                                ********************************
      *                                *     u3?v?~vv?/}?             
      *                                ********************************

           EXEC SQL INCLUDE            TCOAA
           END-EXEC.

      *                                ********************************
      *                                *     ??[¦¼/                   
      *                                ********************************

           EXEC SQL INCLUDE            TIOAA
           END-EXEC.


      *                                ********************************
      *                                *     u3?7n?                   
      *                                ********************************

           EXEC SQL INCLUDE            TJOAD
           END-EXEC.


      *                                ********************************
      *                                *     h/?a?7v~                 
      *                                ********************************

           EXEC SQL INCLUDE            TIOAB
           END-EXEC.


      *                                ********************************
      *                                *     ?3½»  ?3Ha           *
      *                                ********************************

           EXEC SQL INCLUDE            TAOAB
           END-EXEC.


      *                                ********************************
      *                                *     tv?v?a¹ß               *
      *                                ********************************

           EXEC SQL INCLUDE            RWOAD
           END-EXEC.


      *                                ********************************
      *                                *     {7Úç                   *
      *                                ********************************

           EXEC SQL INCLUDE            TJOBA
           END-EXEC.


      ******************************************************************
      *                                                                *
      *                      M A P   L A Y O U T                       *
      *                                                                *
      ******************************************************************

           COPY LAU91.

      ******************************************************************
      *                                                                *
      *             ??  [?  uV  J~  ÙÖ                               *
      *              ------------------                                *
      *              : ONFORM.T75                                      *
      ******************************************************************

       01  HEAD-0.
           05  HD0-ID                  PIC X(05) VALUE '@T75F'.
      *    05  HDO-MODE                PIC X(02) VALUE ' M'.

      * M -> OPTIONu?LINE DOWN ( 'M' ->  HD0-MODE )

       01  HEAD-2.

           05  FIL                     PIC X(01) VALUE '5'.
           05  FIL                     PIC X(29) VALUE SPACE.
           05  HD2-CODE                PIC X(03) VALUE SPACE.
           05  FIL                     PIC X(01) VALUE '-'.
           05  HD2-KIND                PIC X(02) VALUE SPACE.
           05  FIL                     PIC X(01) VALUE '-'.
           05  HD2-SERI                PIC X(05) VALUE SPACE.

       01  LIST-1.

           05  FIL                     PIC X(01) VALUE '3'.
           05  FIL                     PIC X(23) VALUE SPACE.
           05  L1-NAME                 PIC X(56) VALUE SPACE.

       01  LIST-2.

           05  FIL                     PIC X(01) VALUE '3'.
           05  FIL                     PIC X(23) VALUE SPACE.
           05  L2-ADDR                 PIC X(60) VALUE SPACE.

       01  LIST-2-1.

           05  FIL                     PIC X(01) VALUE '3'.
           05  FIL                     PIC X(22) VALUE SPACE.
           05  L2-ADDR-2               PIC X(60) VALUE SPACE.

       01  LIST-3.

           05  FIL                     PIC X(01) VALUE '3'.
           05  FIL                     PIC X(23) VALUE SPACE.
           05  L3-NAME                 PIC X(18) VALUE SPACE.
           05  FIL                     PIC X(22) VALUE SPACE.
           05  L3-PESN-NO              PIC X(14) VALUE SPACE.

       01  LIST-4.

           05  FIL                     PIC X(01) VALUE '3'.
           05  FIL                     PIC X(23) VALUE SPACE.
           05  L4-ADDR                 PIC X(60) VALUE SPACE.

       01  LIST-4-2.

           05  FIL                     PIC X(01) VALUE '3'.
           05  FIL                     PIC X(22) VALUE SPACE.
           05  L4-ADDR-2               PIC X(60) VALUE SPACE.

       01  LIST-5.

           05 FIL                      PIC X(01) VALUE '3'.
           05 FIL                      PIC X(23) VALUE SPACE.
           05 L5-REMK                  PIC X(50) VALUE SPACE.

       01  LIST-6.

           05  FIL                     PIC X(01) VALUE '0'.
           05  FIL                     PIC X(28) VALUE SPACE.
           05  L6-ON-BOARD-YEAR        PIC Z(04) VALUE SPACE.
           05  FIL                     PIC X(04) VALUE SPACE.
           05  L6-ON-BOARD-MM          PIC Z(02) VALUE SPACE.
           05  FIL                     PIC X(03) VALUE SPACE.
           05  L6-ON-BOARD-DD          PIC Z(02) VALUE SPACE.

       01  LIST-7.

           05  FIL                     PIC X(01) VALUE '6'.
           05  FIL                     PIC X(02) VALUE SPACE.
           05  L7-ON-BOARD-NAME        PIC X(30) VALUE SPACE.


      ******************************************************************
      *                                                              *
      *          tv  ?v  Úç  ??  u?  ¤°  wi  h/                    *
      *                                                              *
      ******************************************************************

       01  PR-HEAD-0.
           05  PR-HD0-ID               PIC X(05) VALUE '@T78F'.
      *    05  PR-HDO-MODE             PIC X(01) VALUE 'M'.

      * M -> OPTIONu?LINE DOWN ( 'M' ->  HD0-MODE )

       01  PRT-1.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P1-TRADE                PIC X(60) VALUE SPACE.

       01  PRT-2.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P2-BUSNID               PIC X(13) VALUE SPACE.
           05  FIL                     PIC X(33) VALUE SPACE.
           05  P2-CORPID               PIC X(15) VALUE SPACE.

       01  PRT-3.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P3-NAME                 PIC X(20) VALUE SPACE.

       01  PRT-4.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P4-UPTA                 PIC X(20) VALUE SPACE.
           05  FIL                     PIC X(24) VALUE SPACE.
           05  P4-JONG                 PIC X(20) VALUE SPACE.

       01  PRT-5.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P5-ADDR                 PIC X(60) VALUE SPACE.

       01  PRT-6.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P6-BON-ADDR             PIC X(60) VALUE SPACE.

       01  PRT-7.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P7-NO                   PIC X(16) VALUE SPACE.

       01  PRT-8.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P8-YEAR                 PIC Z(04).
           05  P8-FIL1                 PIC X(01) VALUE SPACE.
           05  P8-MM                   PIC Z(02).
           05  P8-FIL2                 PIC X(01) VALUE SPACE.
           05  P8-DD                   PIC Z(02).

       01  PRT-9.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  FIL                     PIC X(70) VALUE
                                               'XXXXXXXXX'.

       01  PRT-10.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P10-NAME                PIC X(20) VALUE SPACE.

       01  PRT-11.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P11-REMK                PIC X(70) VALUE SPACE.

       01  PRT-12.

           05  FIL                     PIC X(01) VALUE SPACE.
           05  FIL                     PIC X(46) VALUE SPACE.
           05  P12-ON-BOARD-YEAR       PIC Z(04) VALUE SPACE.
           05  FIL                     PIC X(06) VALUE SPACE.
           05  P12-ON-BOARD-MM         PIC Z(02) VALUE SPACE.
           05  FIL                     PIC X(06) VALUE SPACE.
           05  P12-ON-BOARD-DD         PIC Z(02) VALUE SPACE.

       01  PRT-13.

           05  FIL                     PIC X(01) VALUE '4'.
           05  FIL                     PIC X(25) VALUE SPACE.
           05  P13-ON-BOARD-NAME       PIC X(30) VALUE SPACE.

      *****************************************************************
      *                                                               *
      *           E N D   O F  W O R K I N G  S T O R A G E           *
      *                                                               *
      *****************************************************************

       01  WS-END                      PIC X(40)
           VALUE 'LAP91 - WORKING STORAGE ENDS HERE'.
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
      *    - RETRIEVE?? I?}a ?v?/?v JA~Ý¹¦Ú? p¬¸ç¹vDATA??  *
      *     u?l?m/?.                                                 *
      *      = TAP30( TAP90 )r~l?RWPA1/2¹¦ÚçDATA??  u???.       *
      *                                                                *
      *    - PRINT LINE?a A~?~h±»? ?~?7}?m/?.                    *
      *                                                                *
      ******************************************************************

       INITIALIZATION                  SECTION.

           PERFORM  S1000-RETRIEVE.

           PERFORM  S1100-ASK-TIME.

      ******************************************************************
      *                                                                *
      *                    M A I N L I N E                             *
      *                                                                *
      *                - Bi?? PROCESS ?z}p                         *
      *                                                                *
      ******************************************************************

       MAINLINE                        SECTION.


           MOVE W-YEAR                 TO W-DB2DATE-YEAR.
           PERFORM  S0100-MAIN-PROCESS.


       EJECT

      ******************************************************************
      *                                                                *
      *                    F I N A L I Z A T I O N                     *
      *                                                                *
      *        - ACCUM?~E/j]»ÝPAGE?? PRINTER?~SEND}?           *
      *        - CICS RETURN                                           *
      *                                                                *
      ******************************************************************

       FINALIZATION                    SECTION.

           PERFORM  S2700-SEND-PAGE.

           PERFORM  S2900-RETURN.

           GOBACK.

       EJECT

      ******************************************************************
      *                     S U B R O U T I N E S                      *
      ******************************************************************

      ******************************************************************
      *                                                                *
      *            S 0 1 0 0 - M A I N - P R O C E S S                 *
      *                                                                *
      ******************************************************************


       S0100-MAIN-PROCESS              SECTION.

           INITIALIZE  W-SELF-REC.

      *&& XPEDITOR TEST
      *    MOVE '1098900035'           TO W-COMM-BUSN.
      *    MOVE '109'                  TO W-COMM-AREA-TXOFF-CD.

           MOVE W-COMM-BUSN(1:10)      TO BUSNID OF TTAAA.

           PERFORM  S1200-SELECT-TTAAA.

           IF  SQLCODE = C-SQL-NORMAL

               IF  BUSNID OF TTAAA(4:2) = '89'

                   PERFORM  S0200-FORM-T75-MOVE
                   PERFORM  S0300-FORM-T75-PRINT

                   MOVE '12'           TO TREAT-STAUS OF TRWAD

                   STRING  W-DB2DATE-YEAR W-DATE(4:2) W-DATE(7:2)
                           DELIMITED BY SIZE INTO
                                 ISSUE-DT OF TRWAD
                   END-STRING

                   STRING W-TIME(1:2) W-TIME(4:2) W-TIME(7:2)
                          DELIMITED BY SIZE INTO ISSUE-TIME OF TRWAD
                   END-STRING

                   PERFORM  S0700-RETURN-TREAT-ST

               ELSE

                   MOVE '11'           TO W-COMM-RETURN-ST
                   PERFORM  S0400-PRINT-BULGA

               END-IF

0511  *        IF  TXOFF-CD OF TTAAA = W-COMM-AREA-TXOFF-CD
      *
      *            IF  BUSNID OF TTAAA(4:2) = '89'
      *
      *                PERFORM  S0200-FORM-T75-MOVE
      *                PERFORM  S0300-FORM-T75-PRINT
      *
      *                MOVE '12'      TO TREAT-STAUS OF TRWAD
      *
      *                STRING  W-DB2DATE-YEAR W-DATE(4:2) W-DATE(7:2)
      *                        DELIMITED BY SIZE INTO
      *                              ISSUE-DT OF TRWAD
      *                END-STRING
      *
      *                PERFORM  S0700-RETURN-TREAT-ST
      *
      *            ELSE
      *
      *                MOVE '11'      TO W-COMM-RETURN-ST
      *                PERFORM  S0400-PRINT-BULGA
      *
      *            END-IF
      *
      *        ELSE
      *
      *            MOVE '12'          TO W-COMM-RETURN-ST
      *            PERFORM  S0400-PRINT-BULGA
      *
      *        END-IF

           ELSE

               MOVE '13'              TO W-COMM-RETURN-ST
               PERFORM  S0400-PRINT-BULGA

           END-IF.


       S0100-MAIN-PROCESS-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 0 2 0 0 - F O R M - T 7 5 - M O V E               *
      *                                                                *
      *         - n¦»~H/??  OUT FIELD ¹¦  MOVE }?m/              *
      *                                                                *
      ******************************************************************

       S0200-FORM-T75-MOVE             SECTION.

           MOVE BUSNID OF TTAAA (1:3)  TO HD2-CODE.
           MOVE BUSNID OF TTAAA (4:2)  TO HD2-KIND.
           MOVE BUSNID OF TTAAA (6:5)  TO HD2-SERI.

           MOVE TRADE-NM1    OF TTAAA  TO L1-NAME.

           MOVE LGDONG-CD    OF TTAAA  TO LGDONG-CD OF TTJAD.

990318*?/?3¼Ö[~?a?~¹¦?'?~?,?e?,?a?,»°?,~Ýá,n»á'?~?/i~  ?/?~o¦¤~  æç}a
      *ma»ÖE~p/?v  }p?7n?  E~p/??  »ï¸çÚç  ?/?3?/p?sÙÖ¹¦  Bi??
      *??[?uVJ~ÙÖ
           PERFORM  S1410-SELECT-TTJAD2.

           IF  SQLCODE = C-SQL-NORMAL

               MOVE  COUNTERPART-CD OF TTJAD
                                       TO LGDONG-CD OF TTJAD

               PERFORM  S1400-SELECT-TTJAD

               IF  SQLCODE = C-SQL-NORMAL

                   MOVE SI-DO     OF TTJAD
                                       TO W-SSSAV-SI-DO
                   MOVE GU-SI-GUN OF TTJAD
                                       TO W-SSSAV-GU-SI-GUN
                   MOVE DONG-UEP-MYUN OF TTJAD
                                       TO W-SSSAV-DONG-EUP-MYUN
                   MOVE GA-RHEE   OF TTJAD
                                       TO W-SSSAV-GA-RI
                   MOVE SAN-BUNJI OF TTAAA
                                       TO W-SSSAV-SAN-BUNJI
                   MOVE BUNJI     OF TTAAA
                                       TO W-SSSAV-BUNJI
                   MOVE HO        OF TTAAA
                                       TO W-SSSAV-HO
      *        MOVE APT-BLOCK1 OF TTAAA
      *                                TO W-APT-BLOCK
      * i~»¦uVJ~ÙÖ»Ý APT-BLOCK2?/æÖ
                   MOVE APT-BLOCK2 OF TTAAA
                                       TO W-SSSAV-APT-BLOCK
                   MOVE APT-DONG1 OF TTAAA
                                       TO W-SSSAV-APT-DONG
                   MOVE APT-HO1   OF TTAAA
                                       TO W-SSSAV-APT-HO
                   MOVE TONG      OF TTAAA
                                       TO W-SSSAV-TONG
                   MOVE BAN       OF TTAAA
                                       TO W-SSSAV-BAN

                   CALL C-PGM-SSSAV USING W-SSSAV-AREA

                   IF  W-SSSAV-OUTPUT(60:62) = SPACE

                       MOVE W-SSSAV-OUTPUT TO L2-ADDR
                       MOVE SPACE          TO L2-ADDR-2

                   ELSE

                       PERFORM  S5555-ADDRESS-PRINT

                       MOVE W-SSSAX-OUTPUT TO L2-ADDR
                       MOVE W-SSSAV-OUTPUT TO L2-ADDR-2

                   END-IF

      *                PERFORM    S2300-FORMAT-ADDRESS
      *                MOVE W-SSSAX-OUTPUT(1:SEPERATE-POSITION)
      *                                    TO L2-ADDR
      *                COMPUTE W-INDEX = SEPERATE-POSITION + 1
      *                MOVE W-SSSAX-OUTPUT(W-INDEX:LEFT-LENGTH)
      *                                    TO L2-ADDR-2
      *
      *            END-IF

               ELSE

                   MOVE SPACE          TO L2-ADDR
                                          L2-ADDR-2

               END-IF

           ELSE

               MOVE SPACE          TO L2-ADDR
                                      L2-ADDR-2

           END-IF.

           MOVE RESID-CHIEF  OF TTAAA  TO RESID OF TTIAA.
           MOVE TXPAYER-TP-CHIEF OF TTAAA
                                       TO TXPAYER-TP OF TTIAA.

           PERFORM  S1300-SELECT-TTIAA.

           IF  SQLCODE =  C-SQL-NORMAL

               MOVE +18                TO W-SSSHE-I-LENGTH
               MOVE NM OF TTIAA        TO W-SSSHE-I-DATA

               CALL C-PGM-SSSHE USING     W-SSSHE-I-LENGTH              
                                          W-SSSHE-I-DATA                
                                          W-SSSHE-STATUS                

               MOVE W-SSSHE-I-DATA     TO L3-NAME                       

           ELSE

               MOVE SPACE              TO L3-NAME

           END-IF.

           IF  RESID-CHIEF OF TTAAA (13:1) = (SPACE OR LOW-VALUE)

               MOVE RESID-CHIEF OF TTAAA   TO L3-PESN-NO

           ELSE
               STRING RESID-CHIEF OF TTAAA (1:6) '-'
                      RESID-CHIEF OF TTAAA (7:7) '-'
                      DELIMITED BY SIZE  INTO L3-PESN-NO
               END-STRING

           END-IF.

           MOVE RESID-HOUSE-HD   OF TTIAA TO RESID-HOUSE-HD   OF TTIAB.
           MOVE TXPAYER-TP-HOUSE OF TTIAA TO TXPAYER-TP-HOUSE OF TTIAB.

           PERFORM  S1500-SELECT-TTIAB.

           IF  SQLCODE =  C-SQL-NORMAL

               MOVE LGDONG-CD OF TTIAB TO LGDONG-CD OF TTJAD

990318*?/?3¼Ö[~?a?~¹¦?'?~?,?e?,?a?,»°?,~Ýá,n»á'?~?/i~  ?/?~o¦¤~  æç}a
      *ma»ÖE~p/?v  }p?7n?  E~p/??  »ï¸çÚç  ?/?3?/p?sÙÖ¹¦  Bi??
      *i~»¦uVJ~ÙÖ
               PERFORM  S1410-SELECT-TTJAD2

               IF  SQLCODE = C-SQL-NORMAL

                   MOVE  COUNTERPART-CD OF TTJAD
                                           TO LGDONG-CD OF TTJAD

                   PERFORM  S1400-SELECT-TTJAD

                   IF  SQLCODE = C-SQL-NORMAL

                       MOVE SI-DO     OF TTJAD TO W-SI-DO
                       MOVE GU-SI-GUN OF TTJAD TO W-GU-SI-GUN
                       MOVE DONG-UEP-MYUN OF TTJAD
                                               TO W-DONG-UEP-MYUN
                       MOVE GA-RHEE   OF TTJAD TO W-GA-RHEE
                       MOVE SAN-BUNJI OF TTIAB TO W-SAN-BUNJI
                       MOVE BUNJI OF TTIAB TO W-BUNJI
                       MOVE HO    OF TTIAB TO W-HO
                       MOVE APT-BLOCK1 OF TTIAB
                                           TO W-APT-BLOCK
                       MOVE APT-DONG1 OF TTIAB
                                           TO W-APT-DONG
                       MOVE APT-HO1 OF TTIAB
                                           TO W-APT-HO
                       MOVE TONG  OF TTIAB TO W-TONG
                       MOVE BAN   OF TTIAB TO W-BAN

                       PERFORM  S2200-VALID-SSSAX

                       IF  W-SSSAX-OUTPUT(55:47) = SPACE

                           MOVE W-SSSAX-OUTPUT
                                       TO L4-ADDR
                           MOVE SPACE  TO L4-ADDR-2

                       ELSE

                           PERFORM  S5556-ADDRESS-TTIAB

                           MOVE W-SSSAX-ADDRESS1
                                       TO L4-ADDR
                           MOVE W-SSSAX-ADDRESS2
                                       TO L4-ADDR-2

                       END-IF

      *
      *                    PERFORM    S2300-FORMAT-ADDRESS
      *                    MOVE W-SSSAX-OUTPUT(1:SEPERATE-POSITION)
      *                                        TO L4-ADDR
      *                    COMPUTE W-INDEX = SEPERATE-POSITION + 1
      *                    MOVE W-SSSAX-OUTPUT(W-INDEX:LEFT-LENGTH)
      *                                TO L4-ADDR-2
      *                END-IF

                   ELSE

                       MOVE SPACE      TO L4-ADDR
                                          L4-ADDR-2

                   END-IF

               ELSE

                   MOVE SPACE          TO L4-ADDR
                                          L4-ADDR-2

               END-IF

           ELSE

               MOVE SPACE              TO L4-ADDR
                                          L4-ADDR-2

           END-IF.


           MOVE W-DB2DATE-YEAR         TO L6-ON-BOARD-YEAR.
           MOVE W-DATE(4:2)            TO L6-ON-BOARD-MM.
           MOVE W-DATE(7:2)            TO L6-ON-BOARD-DD.

010914*    IF  NOT (W-COMM-CHNG-DATE(1:8)  =  SPACE  OR  LOW-VALUE)
      *        MOVE W-COMM-CHNG-DATE(1:4)  TO L6-ON-BOARD-YEAR
      *        MOVE W-COMM-CHNG-DATE(5:2)  TO L6-ON-BOARD-MM
      *        MOVE W-COMM-CHNG-DATE(7:2)  TO L6-ON-BOARD-DD
      *    END-IF.


           MOVE TXOFF-CD OF TTAAA      TO TXOFF-CD OF TTJBA.

           PERFORM  S1600-SELECT-TTJBA.


       S0200-FORM-T75-MOVE-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *          S 0 3 0 0 - F O R M - T 7 5 - P R I N T               *
      *                                                                *
      *        - OUT FIELD¹¦MOVEo? DATA??  Bi??}?m/?.            *
      *                                                                *
      ******************************************************************


       S0300-FORM-T75-PRINT            SECTION.

           MOVE ZERO                   TO A-ACCUM-COUNT.

           MOVE HEAD-0                 TO OUTPUTO.
           PERFORM  S2600-SEND-TO-PRINT-EJECT.

           MOVE SPACE                  TO OUTPUTO.
           MOVE 11                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE HEAD-2                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE  6                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE LIST-1                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE  2                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE LIST-2                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.
           MOVE LIST-2-1               TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE  1                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE LIST-3                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE  2                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE LIST-4                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.
           MOVE LIST-4-2               TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE SPACE                  TO OUTPUTO.
           MOVE  1                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

      *-  ?/wa?/»¦  {5?/?~h/1BYTEse?/?~~?1BYTE?~¸ç?/?~?.
           IF  W-COMM-R-SAYU(1:1)  =  X'0E'
               MOVE W-COMM-R-SAYU       TO L5-REMK
           ELSE
               MOVE W-COMM-R-SAYU(1:49) TO L5-REMK(2:49)
           END-IF.

           MOVE LIST-5                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.
      *-
           MOVE 24                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE LIST-6                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE  3                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE LIST-7                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE C-ONPRT-END-MARK       TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE SPACE                  TO OUTPUTO.
           PERFORM  S2500-SEND-TO-PRINT-ERASE.

           MOVE ZERO                   TO A-LINE-COUNT W-INDEX
                                          A-ACCUM-COUNT.

       S0300-FORM-T75-PRINT-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 0 4 0 0 - P R I N T - B U L G A                   *
      *                                                                *
      *            -tv?vÚç??  u¬¤?wih/  I»Ù~Úç  u?}p                 *
      *                                                                *
      ******************************************************************


       S0400-PRINT-BULGA              SECTION.


           IF  W-COMM-RETURN-ST = '12'

               PERFORM  S0500-FORM-02-MOVE
               MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE' TO P11-REMK

               PERFORM  S0600-FORM-02-PRINT

           ELSE

               IF  W-COMM-RETURN-ST = '13'

                   PERFORM  S0500-FORM-02-MOVE
                   MOVE
                  'EEEEEEEEEEEEEEEEEEEEE' TO P11-REMK

                   PERFORM  S0600-FORM-02-PRINT

               ELSE

                   IF  CORP-CHAR-CD OF TTAAA = '8' AND
                       BUSNTP-CD-MAIN OF TTAAA = SPACE OR LOW-VALUE

                       PERFORM  S0500-FORM-02-MOVE
                       MOVE
                 'UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'
                   TO P11-REMK

                       PERFORM  S0600-FORM-02-PRINT

                   ELSE

                       PERFORM  S0500-FORM-02-MOVE
                       MOVE
                     'UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'
                       TO P11-REMK

                       PERFORM  S0600-FORM-02-PRINT

                   END-IF

               END-IF

           END-IF.

           MOVE '13'               TO TREAT-STAUS OF TRWAD.

           PERFORM  S0700-RETURN-TREAT-ST.


       S0400-PRINT-BULGA-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *            S 0 5 0 0 - F O R M - 0 2 - M O V E                 *
      *                                                                *
      *   - n¦»~H/??  OUT FIELD ¹¦  MOVE }?m/(u¬¤?wih/)        *
      *                                                                *
      ******************************************************************


       S0500-FORM-02-MOVE              SECTION.


           STRING W-COMM-AREA-YEAR      '-'
                  W-COMM-AREA-TXOFF-CD  '-'
                  W-COMM-AREA-NO
                  DELIMITED BY SIZE INTO P7-NO
           END-STRING.

      *ÚÖJ~
           MOVE TRADE-NM1    OF TTAAA  TO P1-TRADE

      *?/?3?/p?suVJ~
           STRING BUSNID OF TTAAA (1:3) '-'
                  BUSNID OF TTAAA (4:2) '-'
                  BUSNID OF TTAAA (6:5)
                  DELIMITED BY SIZE  INTO P2-BUSNID
           END-STRING.

      *ma?/?/?7~Öá&?atv?(u3?v?)p?suVJ~
           MOVE RESID-CHIEF  OF TTAAA  TO RESID OF TTIAA.
           MOVE TXPAYER-TP-CHIEF OF TTAAA
                                       TO TXPAYER-TP OF TTIAA.

           PERFORM  S1300-SELECT-TTIAA.

           MOVE NM OF TTIAA            TO P3-NAME
                                          P10-NAME.

           IF  BUSN-OWNER-TP OF TTAAA = '5'

               MOVE BUSNID-HQ       OF TTAAA TO BUSNID-HQ  OF TTCAA
               MOVE RGST-OPEN-DT-HQ OF TTAAA TO RGST-OPEN-DT OF TTCAA

               PERFORM  S2100-SELECT-TTCAA

               STRING CORPID OF TTCAA(1:6) '-'
                      CORPID OF TTCAA(7:7)
                      DELIMITED BY SIZE INTO P2-CORPID
               END-STRING

           ELSE

               STRING RESID-CHIEF OF TTAAA (1:6) '-'
                      RESID-CHIEF OF TTAAA (7:7)
                      DELIMITED BY SIZE  INTO P2-CORPID
               END-STRING

           END-IF.

      *?/?3¼Ö[~?a?~
           MOVE LGDONG-CD    OF TTAAA  TO LGDONG-CD OF TTJAD.

990318*u¬¤?wih/  I»Ù~Úçl?  ?'?~?e?a»°~?n»á'  ?/?~¸Ý}?
           PERFORM  S1400-SELECT-TTJAD.

           IF  SQLCODE = C-SQL-NORMAL

               MOVE SI-DO     OF TTJAD TO W-SI-DO
               MOVE GU-SI-GUN OF TTJAD TO W-GU-SI-GUN
               MOVE DONG-UEP-MYUN OF TTJAD
                                       TO W-DONG-UEP-MYUN
               MOVE GA-RHEE   OF TTJAD TO W-GA-RHEE
               MOVE SAN-BUNJI OF TTAAA TO W-SAN-BUNJI
               MOVE BUNJI     OF TTAAA TO W-BUNJI
               MOVE HO        OF TTAAA TO W-HO
               MOVE APT-BLOCK1 OF TTAAA
                                       TO W-APT-BLOCK
               MOVE APT-DONG1 OF TTAAA
                                       TO W-APT-DONG
               MOVE APT-HO1   OF TTAAA TO W-APT-HO
               MOVE TONG      OF TTAAA TO W-TONG
               MOVE BAN       OF TTAAA TO W-BAN

               PERFORM  S2200-VALID-SSSAX

               MOVE W-SSSAX-OUTPUT     TO P5-ADDR

           ELSE

               CONTINUE

           END-IF.

      *?/?3¼Ö?a?a[~?(u3?v»Ývv?1[~?a?~?)
      *ha?v?/?3?/?viÖæa( BUSN-OWNER-TP OF TTAAA = '1' '2' '3' '4')
      *u3?v?/?3?/?viÖæa( BUSN-OWNER-TP OF TTAAA = '5'         )

           IF  BUSN-OWNER-TP OF TTAAA = ( '1' OR '2' OR '3' OR '4')

               MOVE RESID-HOUSE-HD     OF TTIAA
                                       TO RESID-HOUSE-HD   OF TTIAB
               MOVE TXPAYER-TP-HOUSE   OF TTIAA
                                       TO TXPAYER-TP-HOUSE OF TTIAB

               PERFORM  S1500-SELECT-TTIAB

               IF  SQLCODE = C-SQL-NORMAL

                   MOVE LGDONG-CD OF TTAAA TO LGDONG-CD OF TTJAD

                    PERFORM  S1400-SELECT-TTJAD

                   IF  SQLCODE = C-SQL-NORMAL

                       MOVE SI-DO     OF TTJAD TO W-SI-DO
                       MOVE GU-SI-GUN OF TTJAD TO W-GU-SI-GUN
                       MOVE DONG-UEP-MYUN OF TTJAD
                                               TO W-DONG-UEP-MYUN
                       MOVE GA-RHEE   OF TTJAD TO W-GA-RHEE

                       MOVE SAN-BUNJI     OF TTIAB
                                       TO W-SAN-BUNJI
                       MOVE BUNJI         OF TTIAB
                                       TO W-BUNJI
                       MOVE HO            OF TTIAB
                                       TO W-HO
                       MOVE APT-BLOCK1    OF TTIAB
                                       TO W-APT-BLOCK
                       MOVE APT-DONG1     OF TTIAB
                                       TO W-APT-DONG
                       MOVE APT-HO1       OF TTIAB
                                       TO W-APT-HO
                       MOVE TONG          OF TTIAB
                                       TO W-TONG
                       MOVE BAN           OF TTIAB
                                       TO W-BAN

                       PERFORM  S2200-VALID-SSSAX

                       MOVE W-SSSAX-OUTPUT
                                       TO P6-BON-ADDR

                   ELSE

                       CONTINUE

                   END-IF

               ELSE

                   CONTINUE

               END-IF

           ELSE

               PERFORM  S1200-SELECT-TTAAA

               IF  SQLCODE = C-SQL-NORMAL

                   MOVE LGDONG-CD OF TTAAA TO LGDONG-CD OF TTJAD

                    PERFORM  S1400-SELECT-TTJAD

                   IF  SQLCODE = C-SQL-NORMAL

                       MOVE SI-DO     OF TTJAD TO W-SI-DO
                       MOVE GU-SI-GUN OF TTJAD TO W-GU-SI-GUN
                       MOVE DONG-UEP-MYUN OF TTJAD
                                       TO W-DONG-UEP-MYUN
                       MOVE GA-RHEE   OF TTJAD TO W-GA-RHEE

                       MOVE SAN-BUNJI     OF TTAAA
                                       TO W-SAN-BUNJI
                       MOVE BUNJI         OF TTAAA
                                       TO W-BUNJI
                       MOVE HO            OF TTAAA
                                       TO W-HO
                       MOVE APT-BLOCK1    OF TTAAA
                                       TO W-APT-BLOCK
                       MOVE APT-DONG1     OF TTAAA
                                       TO W-APT-DONG
                       MOVE APT-HO1       OF TTAAA
                                       TO W-APT-HO
                       MOVE TONG          OF TTAAA
                                       TO W-TONG
                       MOVE BAN           OF TTAAA
                                       TO W-BAN

                       PERFORM  S2200-VALID-SSSAX

                       MOVE W-SSSAX-OUTPUT
                                       TO P6-BON-ADDR

                   ELSE

                       CONTINUE

                   END-IF

               ELSE

                   CONTINUE

               END-IF

           END-IF.


      *?3Ha?&½»~s~?

           MOVE BUSNID       OF TTAAA  TO BUSNID       OF TTAAB.
           MOVE RGST-OPEN-DT OF TTAAA  TO RGST-OPEN-DT OF TTAAB.
           MOVE SPACE                  TO P4-UPTA P4-JONG.

           PERFORM  S1800-SELECT-TTAAB.

           IF  SQLCODE = C-SQL-NORMAL

               MOVE BUSNSECT-NM OF TTAAB TO P4-UPTA
               MOVE ITEM-NM     OF TTAAB TO P4-JONG

           ELSE

               CONTINUE

           END-IF.

      *?3?a?z?/
           PERFORM  S0800-TRWAD-PROCESS.

           IF  SQLCODE = C-SQL-NORMAL

               MOVE RCVE-DT OF TRWAD   TO W-RCVE-DT
               MOVE W-RCVE-YY          TO P8-YEAR
               MOVE '/'                TO P8-FIL1
               MOVE W-RCVE-MM          TO P8-MM
               MOVE '/'                TO P8-FIL2
               MOVE W-RCVE-DD          TO P8-DD

           ELSE
               MOVE SPACE              TO P8-FIL1 P8-FIL2
               MOVE 0                  TO P8-YEAR P8-MM   P8-DD

           END-IF.

      *JÝ¼a?z?/?(u?}p?z?)
      *    MOVE W-DB2DATE-YEAR         TO P8-YEAR.
      *    MOVE '/'                    TO P8-FIL1.
      *    MOVE W-DATE(4:2)            TO P8-MM.
      *    MOVE '/'                    TO P8-FIL2.
      *    MOVE W-DATE(7:2)            TO P8-DD.

           MOVE W-DB2DATE-YEAR         TO P12-ON-BOARD-YEAR.
           MOVE W-DATE(4:2)            TO P12-ON-BOARD-MM.
           MOVE W-DATE(7:2)            TO P12-ON-BOARD-DD.

010914*
      *    IF  NOT (W-COMM-CHNG-DATE(1:8)  =  SPACE  OR  LOW-VALUE)
      *        MOVE W-COMM-CHNG-DATE(1:4)  TO P12-ON-BOARD-YEAR
      *        MOVE W-COMM-CHNG-DATE(5:2)  TO P12-ON-BOARD-MM
      *        MOVE W-COMM-CHNG-DATE(7:2)  TO P12-ON-BOARD-DD
      *    END-IF.


      * [?saÚç
           MOVE TXOFF-CD OF TTAAA      TO TXOFF-CD OF TTJBA.

           PERFORM  S1600-SELECT-TTJBA.
           MOVE TXOFF-NM OF TTJBA(1:8) TO P13-ON-BOARD-NAME.


       S0500-FORM-02-MOVE-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 0 6 0 0 - F O R M - 0 2 - P R I N T               *
      *                                                                *
      *   - OUT FIELD ¹¦  MOVE o? DATA ??  Bi??}?m/?.?(u¬¤?wih/)
      *                                                                *
      ******************************************************************


       S0600-FORM-02-PRINT             SECTION.

           MOVE ZERO                   TO A-ACCUM-COUNT.

           MOVE PR-HEAD-0              TO OUTPUTO.
           PERFORM  S2600-SEND-TO-PRINT-EJECT.

           MOVE SPACE                  TO OUTPUTO.
           MOVE 16                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE SPACE                  TO OUTPUTO.
           MOVE PRT-1                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-2                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-3                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-4                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-5                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-6                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 05                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-7                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-8                  TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-9                  TO OUTPUTO
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 01                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-10                 TO OUTPUTO
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 05                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-11                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 10                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-12                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE 03                     TO W-LINE-SKIP.
           PERFORM  S0900-LINE-SKIP.

           MOVE PRT-13                 TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE C-ONPRT-END-MARK       TO OUTPUTO.
           PERFORM  S2400-SEND-TO-PRINT.

           MOVE SPACES                 TO OUTPUTO.
           PERFORM  S2500-SEND-TO-PRINT-ERASE.

           MOVE ZERO                   TO A-LINE-COUNT W-INDEX
                                          A-ACCUM-COUNT.

       S0600-FORM-02-PRINT-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 0 7 0 0 - R E T U R N - T R E A T - S T           *
      *                                                                *
      ******************************************************************


       S0700-RETURN-TREAT-ST           SECTION.


           MOVE W-COMM-AREA-TXOFF-CD   TO RCVE-NO-TXOFF OF TRWAD.
           MOVE W-COMM-AREA-YEAR       TO RCVE-NO-YY    OF TRWAD.
           MOVE W-COMM-AREA-NO         TO W-SSSAA-IN-DATA.

           CALL C-PGM-SSSAA USING         W-SSSAA-IN-DATA
                                          W-SSSAA-OUT-DATA
                                          W-SSSAA-OUT-LOWCNT
                                          W-SSSAA-STATUS.

           MOVE W-SSSAA-OUT-DATA       TO W-JUPSU-NO.
           MOVE W-JUPSU-NO             TO RCVE-NO-SEQNO OF TRWAD.

           PERFORM  S1900-UPDATE-TRWAD.


       S0700-RETURN-TREAT-ST-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 0 8 0 0 - S E L E C T - T R W A D                 *
      *                                                                *
      ******************************************************************


       S0800-TRWAD-PROCESS             SECTION.


           MOVE W-COMM-AREA-TXOFF-CD   TO RCVE-NO-TXOFF OF TRWAD.
           MOVE W-COMM-AREA-YEAR       TO RCVE-NO-YY    OF TRWAD.
           MOVE W-COMM-AREA-NO         TO W-SSSAA-IN-DATA.

           CALL C-PGM-SSSAA USING         W-SSSAA-IN-DATA
                                          W-SSSAA-OUT-DATA
                                          W-SSSAA-OUT-LOWCNT
                                          W-SSSAA-STATUS.

           MOVE W-SSSAA-OUT-DATA       TO W-JUPSU-NO.
           MOVE W-JUPSU-NO             TO RCVE-NO-SEQNO OF TRWAD.

           PERFORM  S2000-SELECT-TRWAD.


       S0800-TRWAD-PROCESS-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *                 S 0 9 0 0 - L I N E - S K I P                  *
      *                                                                *
      *               - FORM LAYOUT PRINT FROM LINE SKIP               *
      *                                                                *
      ******************************************************************


       S0900-LINE-SKIP                 SECTION.

           MOVE SPACE                  TO OUTPUTO.

           PERFORM  VARYING W-INDEX FROM    1      BY  1

                                      UNTIL W-INDEX >  W-LINE-SKIP

               PERFORM  S2400-SEND-TO-PRINT

           END-PERFORM.

       S0900-LINE-SKIP-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *                 S 1 0 0 0 - R E T R I E V E                    *
      *                                                                *
      *                - COMMAREA??RETRIEVE}?m/?.                  *
      *                                                                *
      ******************************************************************


       S1000-RETRIEVE                  SECTION.

           EXEC CICS RETRIEVE INTO   (W-COMM-AREA(1:4000))
                              LENGTH (C-COMM-LNTH)
                              RESP   (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-CICS    TO W-ABEND-FG
               MOVE ' S1000-RETRIEVE ' TO W-ABEND-SECTION
      **       PERFORM S3000-ABEND

           END-IF.

       S1000-RETRIEVE-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 1 0 0 - A S K - T I M E                         *
      *                                                                *
      *                - JÝ¼a?a ?¬¿/?A ?~hÝ»? u??              
      *                                                                *
      ******************************************************************


       S1100-ASK-TIME                  SECTION.

           EXEC CICS ASKTIME    ABSTIME (W-ABSTIME)
           END-EXEC.

           EXEC CICS FORMATTIME ABSTIME (W-ABSTIME)
                                YEAR    (W-YEAR)
                                YYMMDD  (W-DATE)
                                TIME    (W-TIME)
                                DATESEP
                                TIMESEP
           END-EXEC.

       S1100-ASK-TIME-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 2 0 0 - S E L E C T - T T A A A                 *
      *                                                                *
      ******************************************************************


       S1200-SELECT-TTAAA              SECTION.

           EXEC SQL SELECT BUSNID,
                           RGST_OPEN_DT,
                           RESID_CHIEF,
                           TXPAYER_TP_CHIEF,
                           BUSN_OWNER_TP,
                           BUSNID_HQ,
                           RGST_OPEN_DT_HQ,
                           BUSNTP_CD_MAIN,
                           LGDONG_CD,
                           SAN_BUNJI,
                           BUNJI,
                           HO,
                           APT_BLOCK,
                           APT_DONG,
                           APT_HO,
                           TONG,
                           BAN,
                           TXOFF_CD,
                           COBUSN_FG,
                           TRADE_NM,
                           TRADE_NM1,
                           APT_BLOCK1,
                           APT_DONG1,
                           APT_HO1,
                           APT_BLOCK2
                    INTO  :TTAAA.BUSNID,
                          :TTAAA.RGST-OPEN-DT,
                          :TTAAA.RESID-CHIEF,
                          :TTAAA.TXPAYER-TP-CHIEF,
                          :TTAAA.BUSN-OWNER-TP,
                          :TTAAA.BUSNID-HQ,
                          :TTAAA.RGST-OPEN-DT-HQ,
                          :TTAAA.BUSNTP-CD-MAIN,
                          :TTAAA.LGDONG-CD,
                          :TTAAA.SAN-BUNJI,
                          :TTAAA.BUNJI,
                          :TTAAA.HO,
                          :TTAAA.APT-BLOCK,
                          :TTAAA.APT-DONG,
                          :TTAAA.APT-HO,
                          :TTAAA.TONG,
                          :TTAAA.BAN,
                          :TTAAA.TXOFF-CD,
                          :TTAAA.COBUSN-FG,
                          :TTAAA.TRADE-NM,
                          :TTAAA.TRADE-NM1,
                          :TTAAA.APT-BLOCK1,
                          :TTAAA.APT-DONG1,
                          :TTAAA.APT-HO1,
                          :TTAAA.APT-BLOCK2
                    FROM  DTAA.TTAAA
                    WHERE BUSNID   = :TTAAA.BUSNID
                    AND   LAST_FG  = 'Y'
                    AND   STAT_CD_BUSN_OWNER = '0'
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL

               CONTINUE

           ELSE

               MOVE ALL SPACE TO TRADE-NM      OF TTAAA
                                 TRADE-NM1     OF TTAAA
                                 BUSNID        OF TTAAA
                                 RGST-OPEN-DT  OF TTAAA
                                 RESID-CHIEF   OF TTAAA
                                 BUSN-OWNER-TP OF TTAAA
                                 LGDONG-CD     OF TTAAA
                                 SAN-BUNJI     OF TTAAA
               MOVE ALL ZERO  TO BUNJI         OF TTAAA
                                 HO            OF TTAAA
               MOVE ALL SPACE TO APT-BLOCK     OF TTAAA
                                 APT-DONG      OF TTAAA
                                 APT-HO        OF TTAAA
                                 APT-BLOCK1    OF TTAAA
                                 APT-DONG1     OF TTAAA
                                 APT-HO1       OF TTAAA
               MOVE ALL ZERO  TO TONG          OF TTAAA
                                 BAN           OF TTAAA
           END-IF.

       S1200-SELECT-TTAAA-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 3 0 0 - S E L E C T - T T I A A                 *
      *                                                                *
      ******************************************************************


       S1300-SELECT-TTIAA              SECTION.


           EXEC SQL SELECT NM,
                           RESID_HOUSE_HD,
                           TXPAYER_TP_HOUSE
                    INTO  :TTIAA.NM,
                          :TTIAA.RESID-HOUSE-HD,
                          :TTIAA.TXPAYER-TP-HOUSE
                    FROM   DTIA.TTIAA
                    WHERE  RESID      = :TTIAA.RESID
                    AND    TXPAYER_TP = :TTIAA.TXPAYER-TP
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL OR
               SQLCODE = C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE ' S1300-SELECT-TTIAA '
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1300-SELECT-TTIAA-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 4 0 0 - S E L E C T - T T J A D                 *
      *                                                                *
      ******************************************************************


       S1400-SELECT-TTJAD              SECTION.

           EXEC SQL SELECT SI_DO,
                           GU_SI_GUN,
                           DONG_UEP_MYUN,
                           GA_RHEE
                    INTO  :TTJAD.SI-DO,
                          :TTJAD.GU-SI-GUN,
                          :TTJAD.DONG-UEP-MYUN,
                          :TTJAD.GA-RHEE
                    FROM   DTJA.TTJAD
                    WHERE  LGDONG_CD = :TTJAD.LGDONG-CD
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL OR
               SQLCODE = C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE ' S1400-SELECT-TTJAD '
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1400-SELECT-TTJAD-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 4 1 0 - S E L E C T - T T J A D 2               *
      *                                                                *
      ******************************************************************


       S1410-SELECT-TTJAD2             SECTION.

           EXEC SQL SELECT COUNTERPART_CD
                    INTO  :TTJAD.COUNTERPART-CD
                    FROM   DTJA.TTJAD
                    WHERE  LGDONG_CD = :TTJAD.LGDONG-CD
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL OR
               SQLCODE = C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE ' S1410-SELECT-TTJAD2'
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1410-SELECT-TTJAD-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 5 0 0 - S E L E C T - T T I A B                 *
      *                                                                *
      ******************************************************************


       S1500-SELECT-TTIAB              SECTION.

           EXEC SQL SELECT LGDONG_CD,
                           SAN_BUNJI,
                           BUNJI,
                           HO,
                           APT_BLOCK,
                           APT_DONG,
                           APT_HO,
                           TONG,
                           BAN,
                           APT_BLOCK1,
                           APT_DONG1,
                           APT_HO1
                    INTO  :TTIAB.LGDONG-CD,
                          :TTIAB.SAN-BUNJI,
                          :TTIAB.BUNJI,
                          :TTIAB.HO,
                          :TTIAB.APT-BLOCK,
                          :TTIAB.APT-DONG,
                          :TTIAB.APT-HO,
                          :TTIAB.TONG,
                          :TTIAB.BAN,
                          :TTIAB.APT-BLOCK1,
                          :TTIAB.APT-DONG1,
                          :TTIAB.APT-HO1
                    FROM   DTIA.TTIAB
                    WHERE  RESID_HOUSE_HD   = :TTIAB.RESID-HOUSE-HD
                    AND    TXPAYER_TP_HOUSE = :TTIAB.TXPAYER-TP-HOUSE
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL OR
               SQLCODE = C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE ' S1500-SELECT-TTIAB '
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1500-SELECT-TTIAB-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 1 6 0 0 - S E L E C T - T T J B A                 *
      *                                                                *
      ******************************************************************


       S1600-SELECT-TTJBA              SECTION.

           EXEC SQL SELECT TXOFF_NM
                    INTO  :TTJBA.TXOFF-NM
                    FROM   DTJB.TTJBA
                    WHERE  TXOFF_CD  = :TTJBA.TXOFF-CD
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL

               MOVE SPACE              TO W-SSSAX-INPUT
                                          WS-TXOFF-NM-A
                                          WS-TXOFF-NM-B

               STRING TXOFF-NM OF TTJBA (1:10)
                      'DDDDDDDD'
                      DELIMITED BY SIZE  INTO WS-TXOFF-NM-A
               END-STRING

      *--     [?saÚç~?iA  ?'[?saÚç¼Ö?'?/?~?a '0E0F'Úß½¦
      *--     ?1?)[?saÚç~Ö»~  ?2?/?v  iÖæa
               IF  WS-TXOFF-NM-A(6:1)  = X'0F'

                   MOVE WS-TXOFF-NM-A( 1: 5) TO WS-TXOFF-NM-B( 1: 5)
                   MOVE WS-TXOFF-NM-A(12:10) TO WS-TXOFF-NM-B( 6:10)

               ELSE

      *--       ?2?)[?saÚç~Ö»~  ?3?/?v  iÖæa
                 IF  WS-TXOFF-NM-A(8:1)  = X'0F'

                     MOVE WS-TXOFF-NM-A( 1: 7) TO WS-TXOFF-NM-B( 1: 7)
                     MOVE WS-TXOFF-NM-A(12:10) TO WS-TXOFF-NM-B( 8:10)

                 ELSE

      *--         ?3?)[?saÚç~Ö»~  ?4?/?v  iÖæa
                   IF  WS-TXOFF-NM-A(10:1) = X'0F'

                       MOVE WS-TXOFF-NM-A( 1: 9) TO WS-TXOFF-NM-B( 1: 9)
                       MOVE WS-TXOFF-NM-A(12:10) TO WS-TXOFF-NM-B(10:10)

                   ELSE
                       MOVE WS-TXOFF-NM-A        TO WS-TXOFF-NM-B

                   END-IF
                 END-IF
               END-IF

               MOVE WS-TXOFF-NM-B      TO W-SSSAX-INPUT

               CALL C-PGM-SSSAX USING     W-SSSAX-AREA

               MOVE W-SSSAX-OUTPUT     TO WORK-EDIT-SAMU

               MOVE ZERO               TO I J
               MOVE SPACE              TO L7-ON-BOARD-NAME

               PERFORM VARYING W-INDEX FROM 1   BY  1
                                       UNTIL  W-INDEX > 30

                       IF  WORK-EDIT-SAMU (W-INDEX:1) = '*'

                           COMPUTE J = W-INDEX - 1

                           COMPUTE I = 30 - J

                           MOVE SPACE  TO L7-ON-BOARD-NAME  (1:I)

                           ADD 1       TO I
                           MOVE WORK-EDIT-SAMU              (1:J)
                                       TO L7-ON-BOARD-NAME  (I:J)
                           MOVE 31     TO W-INDEX

                       ELSE

                           CONTINUE

                       END-IF

               END-PERFORM

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S1600-SELECT-TTJBA '
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1600-SELECT-TTJBA-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *            S 1 7 0 0 - S E L E C T - T T J B A                 *
      *                                                                *
      ******************************************************************


       S1700-SELECT-TTJBA              SECTION.

           EXEC SQL SELECT TXOFF_NM
                    INTO  :TTJBA.TXOFF-NM
                    FROM   DTJB.TTJBA
                    WHERE  TXOFF_CD  = :TTJBA.TXOFF-CD
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL

               STRING TXOFF-NM OF TTJBA(1:8)
                     'DDDDDDDD'
                      DELIMITED BY SIZE INTO L7-ON-BOARD-NAME
               END-STRING

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S1700-SELECT-TTJBA'
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1700-SELECT-TTJBA-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *            S 1 8 0 0 - S E L E C T - T T A A B                 *
      *                                                                *
      ******************************************************************


       S1800-SELECT-TTAAB              SECTION.

           EXEC SQL SELECT BUSNSECT_NM,
                           ITEM_NM
                    INTO  :TTAAB.BUSNSECT-NM,
                          :TTAAB.ITEM-NM
                    FROM   DTAA.TTAAB
                    WHERE  BUSNID       = :TTAAB.BUSNID
                    AND    RGST_OPEN_DT = :TTAAB.RGST-OPEN-DT
                    AND    MAIN_BUSNTP_FG = 'Y'
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL OR C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S1800-SELECT-TTAAB'
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S1800-SELECT-TTAAB-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *        S 1 9 0 0 - U P D A T E - T R W A D                     *
      *                                                                *
      ******************************************************************


       S1900-UPDATE-TRWAD              SECTION.


           EXEC SQL UPDATE DRWA.TRWAD
                    SET    TREAT_STAUS   = :TRWAD.TREAT-STAUS,
                           ISSUE_DT      = :TRWAD.ISSUE-DT,
                           ISSUE_TIME    = :TRWAD.ISSUE-TIME
                    WHERE  RCVE_NO_TXOFF = :TRWAD.RCVE-NO-TXOFF
                    AND    RCVE_NO_YY    = :TRWAD.RCVE-NO-YY
                    AND    RCVE_NO_SEQNO = :TRWAD.RCVE-NO-SEQNO
           END-EXEC.


           IF  SQLCODE =   C-SQL-NORMAL

               CONTINUE

           ELSE

               IF  SQLCODE = C-SQL-NOTFND

                   STRING 'UP-'
                          RCVE-NO-TXOFF OF TRWAD '-'
                          RCVE-NO-YY    OF TRWAD '-'
                          W-COMM-AREA-NO

                          DELIMITED BY SIZE INTO W-ABEND-SECTION

                   END-STRING

                   PERFORM  S3000-ABEND

               ELSE

                   MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
                   MOVE 'S1900-UPDATE-TRWAD'
                                           TO W-ABEND-SECTION

                   PERFORM  S3000-ABEND

               END-IF

           END-IF.


       S1900-UPDATE-TRWAD-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *        S 2 0 0 0 - S E L E C T - T R W A D                     *
      *                                                                *
      ******************************************************************


       S2000-SELECT-TRWAD              SECTION.


           EXEC SQL SELECT RCVE_DT
                    INTO  :TRWAD.RCVE-DT
                    FROM   DRWA.TRWAD
                    WHERE  RCVE_NO_TXOFF = :TRWAD.RCVE-NO-TXOFF
                    AND    RCVE_NO_YY    = :TRWAD.RCVE-NO-YY
                    AND    RCVE_NO_SEQNO = :TRWAD.RCVE-NO-SEQNO
           END-EXEC.


       S2000-SELECT-TRWAD-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 2 1 0 0 - S E L E C T - T T C A A                 *
      *                                                                *
      ******************************************************************


       S2100-SELECT-TTCAA              SECTION.

           EXEC SQL SELECT CORPID
                    INTO  :TTCAA.CORPID
                    FROM   DTCA.TTCAA
                    WHERE  BUSNID_HQ    = :TTCAA.BUSNID-HQ
                    AND    RGST_OPEN_DT = :TTCAA.RGST-OPEN-DT
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL OR C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S2100-SELECT-TTCAA '
                                       TO W-ABEND-SECTION
               PERFORM  S3000-ABEND

           END-IF.

       S2100-SELECT-TTCAA-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 2 2 0 0 - V A L I D - S S S A K                   *
      *                                                                *
      ******************************************************************


       S2200-VALID-SSSAX               SECTION.

           MOVE W-ADDRESS-RECORD       TO W-SSSAX-INPUT.
           CALL C-PGM-SSSAX USING W-SSSAX-AREA.

       S2200-VALID-SSSAX-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 2 3 0 0 - F O R M A T - A D D R E S S             *
      *                                                                *
      *  -?a[~}Ö»~55BYTE?~ÚÖ?ziÖæa  m/??a[~}Ö¹?PRINT}?  æçC~?V?7*
      ******************************************************************


       S2300-FORMAT-ADDRESS            SECTION.

           PERFORM    VARYING W-INDEX FROM 55 BY 1
                              UNTIL W-INDEX > 102
               IF  W-SSSAX-OUTPUT(W-INDEX:1) = X'0E'
                   ADD 1               TO SO-COUNT
               END-IF
               IF  W-SSSAX-OUTPUT(W-INDEX:1) = X'0F'
                   ADD 1               TO SI-COUNT
               END-IF
               IF  SO-COUNT = 1
                   MOVE W-INDEX        TO SO-POSITION
                   MOVE 2              TO SO-COUNT
               END-IF
               IF  SI-COUNT = 1
                   MOVE W-INDEX        TO SI-POSITION
                   MOVE 2              TO SI-COUNT
               END-IF
           END-PERFORM.

           IF  SI-COUNT > SO-COUNT
      *-       (1:54)¹¦'0E0F'h/  x~?7ÚÖ?S?v  iÖæa»¶?.
      *-      ?/?/?/?.ÚÖh/?.x??S}Ö»~Ka??  oauV?a  ?a[~ÎÝ¹¦  ¹À¤¶?.

               PERFORM   VARYING W-INDEX FROM SI-POSITION BY -1
                                 UNTIL W-INDEX < 1

                   IF  W-SSSAX-OUTPUT(W-INDEX:1) = X'0E'
                       COMPUTE SEPERATE-POSITION =
                               W-INDEX - 1
                       COMPUTE LEFT-LENGTH =
                                    102 - SEPERATE-POSITION
                       MOVE 0          TO W-INDEX

                   END-IF
               END-PERFORM
           ELSE

      *-       (1:54)¹¦'0E0F'h/  ?7ÚÖ?S?v  iÖæa»¶?.
      *-      n»á,J~?,I»á,uÝ»?  oauV?a  ?a[~ÎÝ¹¦  ¹À¤¶?.
               PERFORM   VARYING W-INDEX FROM 102 BY -1
                                 UNTIL W-INDEX < 1
                   IF  W-SSSAX-OUTPUT(W-INDEX:1) = X'0F'

                       MOVE W-INDEX    TO SEPERATE-POSITION
                       COMPUTE LEFT-LENGTH =
                                    102 - SEPERATE-POSITION
                       MOVE 0          TO W-INDEX

                   END-IF
               END-PERFORM
           END-IF.

       S2300-FORMAT-ADDRESS-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 5 5 5 5 - A D D R E S S - P R I N T               *
      *                                                                *
      ******************************************************************

       S5555-ADDRESS-PRINT             SECTION.

           INITIALIZE   W-SSSAX-AREA
                        W-SSSAV-AREA.

           MOVE SI-DO     OF TTJAD     TO W-SSSAX-SI-DO
           MOVE GU-SI-GUN OF TTJAD     TO W-SSSAX-GU-SI-GUN
           MOVE DONG-UEP-MYUN OF TTJAD TO W-SSSAX-DONG-EUP-MYUN
           MOVE GA-RHEE   OF TTJAD     TO W-SSSAX-GA-RI
           MOVE SAN-BUNJI OF TTAAA     TO W-SSSAX-SAN-BUNJI
           MOVE BUNJI     OF TTAAA     TO W-SSSAX-BUNJI
           MOVE HO        OF TTAAA     TO W-SSSAX-HO
           MOVE APT-BLOCK2 OF TTAAA    TO W-SSSAV-APT-BLOCK
           MOVE APT-DONG1 OF TTAAA     TO W-SSSAV-APT-DONG
           MOVE APT-HO1   OF TTAAA     TO W-SSSAV-APT-HO
           MOVE TONG      OF TTAAA     TO W-SSSAV-TONG
           MOVE BAN       OF TTAAA     TO W-SSSAV-BAN

           CALL C-PGM-SSSAX USING W-SSSAX-AREA.

           CALL C-PGM-SSSAV USING W-SSSAV-AREA.

       S5555-ADDRESS-PRINT-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *            S 5 5 5 6 - A D D R E S S - T T I A B               *
      *                                                                *
      ******************************************************************

       S5556-ADDRESS-TTIAB             SECTION.

           INITIALIZE   W-SSSAX-AREA
                        W-SSSAX-ADDRESS1
                        W-SSSAX-ADDRESS2.

           MOVE SI-DO     OF TTJAD     TO W-SSSAX-SI-DO
           MOVE GU-SI-GUN OF TTJAD     TO W-SSSAX-GU-SI-GUN
           MOVE DONG-UEP-MYUN OF TTJAD TO W-SSSAX-DONG-EUP-MYUN
           MOVE GA-RHEE   OF TTJAD     TO W-SSSAX-GA-RI
           MOVE SAN-BUNJI OF TTIAB     TO W-SSSAX-SAN-BUNJI
           MOVE BUNJI     OF TTIAB     TO W-SSSAX-BUNJI
           MOVE HO        OF TTIAB     TO W-SSSAX-HO

           CALL C-PGM-SSSAX USING W-SSSAX-AREA.
           MOVE  W-SSSAX-OUTPUT        TO W-SSSAX-ADDRESS1.

           INITIALIZE   W-SSSAX-AREA

           MOVE APT-BLOCK1 OF TTIAB    TO W-SSSAX-APT-BLOCK
           MOVE APT-DONG1 OF TTIAB     TO W-SSSAX-APT-DONG
           MOVE APT-HO1   OF TTIAB     TO W-SSSAX-APT-HO
           MOVE TONG      OF TTIAB     TO W-SSSAX-TONG
           MOVE BAN       OF TTIAB     TO W-SSSAX-BAN

           CALL C-PGM-SSSAX USING W-SSSAX-AREA.
           MOVE  W-SSSAX-OUTPUT        TO W-SSSAX-ADDRESS2.

       S5556-ADDRESS-PRINT-EXIT.
           EXIT.
       EJECT



      ******************************************************************
      *                                                                *
      *              S 2 4 0 0 - S E N D - T O - P R I N T             *
      *                                                                *
      *    - u?}p}?  ?/?/??PRINT?~  v~?em/?.(WITHOUT ERASE OPTION) *
      *                                                                *
      ******************************************************************


       S2400-SEND-TO-PRINT             SECTION.

           EXEC CICS SEND MAP    ('LAU91')
                          MAPSET ('LAU91')
                          ACCUM
                          PAGING
                          RESP   (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-CICS    TO W-ABEND-FG
      *        ADD 1                   TO A-ACCUM-COUNT
               MOVE 'S1500-SEND-TO-PRINT'
                                       TO W-ABEND-SECTION
      *        PERFORM S3000-ABEND

           END-IF.

       S2400-SEND-TO-PRINT-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *        S 2 5 0 0 - S E N D - T O - P R I N T - E R A S E       *
      *                                                                *
      *     - u?}p}¬¼/?/??PRINT?~v~?em/?. (WITH ERASE OPTION)      *
      *                                                                *
      ******************************************************************


       S2500-SEND-TO-PRINT-ERASE       SECTION.

           EXEC CICS SEND MAP    ('LAU91')
                          MAPSET ('LAU91')
                          ACCUM
                          PAGING
                          ERASE
                          RESP   (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-CICS    TO W-ABEND-FG
               MOVE 'S2500-SEND-TO-PRINT-ERASE '
                                       TO W-ABEND-SECTION
      *        PERFORM S3000-ABEND

           END-IF.

       S2500-SEND-TO-PRINT-ERASE-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *        S 2 6 0 0 - S E N D - T O - P R I N T - E J E C T       *
      *                                                                *
      *      - u?}p}¬¼/?/??PRINT?~v~?em/?. (WITH FORMFEED OPTION)  *
      *                                                                *
      ******************************************************************


       S2600-SEND-TO-PRINT-EJECT       SECTION.

           EXEC CICS SEND MAP    ('LAU91')
                          MAPSET ('LAU91')
                          ACCUM
                          PAGING
                          FORMFEED
                          ERASE
                          RESP   (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               CONTINUE
      *        MOVE +1                 TO A-ACCUM-COUNT

           ELSE

      *        ADD 1                   TO A-ACCUM-COUNT
               MOVE C-ABEND-FG-CICS    TO W-ABEND-FG
               MOVE 'S1700-SEND-TO-PRINT-EJECT'
                                       TO W-ABEND-SECTION

      *        PERFORM  S3000-ABEND

           END-IF.

       S2600-SEND-TO-PRINT-EJECT-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *                  S 2 7 0 0 - S E N D - P A G E                 *
      *                                                                *
      *        - ACCUM?~E/j]»ÝPAGE??PRINTER?~SEND}?            *
      *                                                                *
      ******************************************************************


       S2700-SEND-PAGE                 SECTION.

           EXEC CICS SEND PAGE
           END-EXEC.

       S2700-SEND-PAGE-EXIT.
           EXIT.
       EJECT



      ******************************************************************
      *                                                                *
      *               S 2 8 0 0 - R E A D - S A M E S S G E            *
      *                                                                *
      *      - ERROR MESSAGE VSAM»¬MESSAGE CODE??KEY?~}/?/»ï?   *
      *      - MESSAGE?aæÖ»¬Bi??                                     *
      *                                                                *
      ******************************************************************

       S2800-READ-MESSAGE              SECTION.

      *    EXEC CICS READ  FILE   ('SUV0101')
           EXEC CICS READ  FILE   (C-MSG-FILE-NAME)
                           INTO   (W-MESSAGE)
                           LENGTH (C-MSG-FILE-LNTH)
                           RIDFLD (W-MSG-ID)
                           RESP   (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL
               CONTINUE
      *        MOVE W-MSG-CONTENTS     TO LIST-MSG

           ELSE

               MOVE C-ABEND-FG-CICS    TO W-ABEND-FG
               MOVE 'S1900-READ-MESSAGE'
                                       TO W-ABEND-SECTION

               PERFORM S3000-ABEND

           END-IF.

       S2800-READ-MESSAGE-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *                   S 2 9 0 0 - R E T U R N                      *
      *                                                                *
      *                     - RETURN TO CICS                           *
      *                                                                *
      ******************************************************************

       S2900-RETURN                    SECTION.

           EXEC CICS RETURN
           END-EXEC.

       S2900-RETURN-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *                      S 3 0 0 0 - A B E N D                     *
      *                                                                *
      *       - ABEND½»?¦¹?q/?/ABENDMESSAGE??a?7}?KaTXN½»?/     *
      *                                                                *
      ******************************************************************


       S3000-ABEND                     SECTION.

           IF  W-ABEND-FG-DB2

               MOVE C-ABEND-DB2        TO W-ABEND
               MOVE SQLCODE            TO W-ABEND-CODE

           ELSE

               MOVE C-ABEND-CICS       TO W-ABEND
               MOVE W-RETURN-CODE      TO W-ABEND-CODE

           END-IF.

           MOVE C-PGM-LAP91            TO W-ABEND-PGMID.
           MOVE W-SYSTEM-MESSAGE       TO OUTPUTO.

           EXEC CICS SEND FROM    (LAU91O)
                          LENGTH  (C-PRINT-LENGTH)
                          ERASE
                          CTLCHAR (C-CTRL-CHAR)
           END-EXEC.

           PERFORM S2900-RETURN.

       S3000-ABEND-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *      ?/?~?/?j?a?/?~Èßwawe»·l~m/  ..END OF PROGRAM           *
      *                                                               *
      *****************************************************************
