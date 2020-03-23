      *****************************************************************
      *
      *         I D E N T I F I C A T I O N   D I V I S I O N         *
      *                                                               *
      *****************************************************************

       IDENTIFICATION                  DIVISION.

       PROGRAM-ID.                     JEPA2.
       AUTHOR.                         KIM.D.S
       INSTALLATION.                   ITPlus.
       DATE-WRITTEN.                   2003.12.26.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *                    J     E    P    A    2                      *
      *                                                                *
      *  FUNCTION       - π÷seŸ÷~?tv?vu¨§∞ª?  ÊÁ}?  π÷se?v?S?/}?   *
      *                      ª∑?ﬂ·(?/?3º÷[~?a?~t?wa?3Ωªp?)           *
      *                                                                *
      *  TRANSACTION    -  JEA2                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; JEPA2                       *
      *                                                                *
      *  INPUT PARMS    -  NONE                                        *
      *                                                                *
      *  OUTPUT PARMS   -  SEE DETAIL                                  *
      *                                                                *
      *  INPUT FILES    -  SUV010 ( MESSAGE iE?~)                    *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  TABLES         -  DTIA.TTIAA     (   ??[¶º/       TABLE )   *
      *                    DTAA.TTAAA     (   ?/?3?/       TABLE )   *
      *                    DTAA.TTAAB     (   ?3Ωª         TABLE )   *
      *                    DTAA.TTAAC     (   ?/?3?/?~??   TABLE )   *
      *                    DTJB.TTJAD     (   u3?7n?       TABLE )   *
      *                    DTIA.TTIAB     (   h/?a?7v~     TABLE )   *
      *                    DTJA.TTJAB     (   ⁄÷[?E~p/     TABLE )   *
      *                    DRWA.RWOAD     (   tv?v?aπﬂ     TABLE )   *
      *                    DRWA.RWOAQ     (   tv?vª¶J?E~p/ TABLE )   *
      *                    DRWA.TRWAJ     (   π÷se?/?3?/   TABLE )   *
      *                    DRWA.TRWAK     (   π÷se?3Ωª     TABLE )   *
      *                    DRWA.TRWAM     (   π÷se??[¶º/   TABLE )   *
      *                    DRWA.TRWAN     (   π÷seh/?a?7v~ TABLE )   *
      *                    DRWA.TRWAL     (   π÷sei?n?ma?/ TABLE )   *
      *                    DRWA.TRWAM     (   π÷se??[¶º/   TABLE )   *
      *                                                                *
      *  SWITCHES       -  S-CICS-RETURN                               *
      *                    LOW-VALUES    PSEUDO RETURN                 *
      *                    HIGH-VALUES   CICS RETURN                   *
      *                                                                *
      *                 -  S-FAST-PATH                                 *
      *                    LOW-VALUES    NOT FROM FAST PATH            *
      *                    HIGH-VALUES   FROM FAST PATH                *
      *                                                                *
      *                 -  S-HELP-RETURN                               *
      *                    LOW-VALUES    NOT FROM HELP                 *
      *                    HIGH-VALUES   FROM HELP                     *
      *                                                                *
      *  EXITS          -  NORMAL   - RETURN TO USER TERMINAL FOR      *
      *                               TERMINAL INPUT.                  *
      *                                                                *
      *                               PASSWORDS CANCELS THE TASK.      *
      *                                                                *
      *                 -  ABNORMAL - NONE                             *
      *                                                                *
      *  SPECIAL LOGIC  -  NONE                                        *
      *                                                                *
      *  MODIFICATIONS  -                                              *
      *                                                                *
      *   DATE        S.E.             DESCRIPTION                     *
      *   ==========  =============    =============================   *
      *   2003/12/26  KIM.D.S          INITAIL WRITTEN                 *
      ******************************************************************
       EJECT
      ******************************************************************
      *                                                                *
      *            E N V I R O N M E N T   D I V I S I O N             *
      *                                                                *
      ******************************************************************

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

       01  WS-START                    PIC  X(40)
           VALUE 'JEPA2 - WORKING STORAGE BEGINS HERE'.

      ******************************************************************
      *                                                                *
      *                    A C C U M U L A T O R S                     *
      *                                                                *
      ******************************************************************

       01  ACCUMULATORS.

           05  A-ERROR-COUNT           PIC S9(04) COMP SYNC VALUE +0.
               88  A-ERROR-COUNT-ZERO             VALUE +0.
               88  A-ERROR-COUNT-ONE              VALUE +1.

      ******************************************************************
      *                                                                *
      *                       C O N S T A N T S                        *
      *                                                                *
      ******************************************************************

       01  CONSTANTS.

           05  C-PGM-JEPA2             PIC  X(08) VALUE 'JEPA2'.
           05  C-PGM-LHS16             PIC  X(08) VALUE 'LHS16'.
           05  C-PGM-LHS12             PIC  X(08) VALUE 'LHS12'.
           05  C-PGM-LWSP5             PIC  X(08) VALUE 'LWSP5'.
           05  C-PGM-LWPPI             PIC  X(08) VALUE 'LWPPI'.
           05  C-TRAN-ID               PIC  X(04) VALUE 'JEA2'.
           05  C-PGM-SSSHD             PIC  X(05) VALUE 'SSSHD'.
           05  C-PGM-SSSHE             PIC  X(05) VALUE 'SSSHE'.
           05  C-PGM-SSSAV             PIC  X(05) VALUE 'SSSAV'.
           05  C-COMM-LNTH             PIC S9(04) COMP SYNC VALUE +4000.
           05  C-PGM-PFP09             PIC  X(05) VALUE 'PFP09'.

      *                                ****************************     
      *                                *       C O N S T A N S
      *                                ****************************     
           COPY                        SSYBC.                           
                                                                        
      *                                ***********         ************ 
      *                                *     A T T R I B U T E S      *
      *                                ***********         ************ 
           COPY SSYBB.

      *                                ***********         ************
      *                                *   H E L P  W O R K  A R E A  *
      *                                ***********         ************
           COPY SSYBD.

      *                                ***********         ************
      *                                *     HILIGHTS                 *
      *                                ***********         ************
           COPY SSYBJ.

      *                                ***********         ************
      *                                *     SQL CODE                 *
      *                                ***********         ************
           COPY SSYBI.

      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************

       01  SWITCHES.

           05  S-CICS-RETURN           PIC  X(01) VALUE LOW-VALUES.
               88  S-CICS-RETURN-ON               VALUE HIGH-VALUES.

      *****************************************************************
      *                                                               *
      *                     W O R K   A R E A S                       *
      *                                                               *
      *****************************************************************

       01  WORKAREAS.

           05  W-START-CODE            PIC  X(02) VALUE SPACE.
           05  W-TRAN-ID               PIC  X(04) VALUE SPACE.
050324     05  W-SUB-PGM               PIC  X(05) VALUE SPACE.
           05  W-GAEIN-FG              PIC  X(01) VALUE SPACE.
           05  W-TX-SRVC-TP            PIC  X(05) VALUE SPACE.
           05  W-COMM-LNTH             PIC S9(04) COMP  SYNC VALUE +0.
           05  W-CURR-DATE.
               10  W-CURR-YYYY.
                   15  W-CURR-YY1      PIC  X(02).
                   15  W-CURR-YY2      PIC  X(02).
               10  W-CURR-MM           PIC  X(02).
               10  W-CURR-DD           PIC  X(02).
050324     05 W-SUB-SYSTEM-COMMON.
              10  W-SUB-AMT1           PIC S9(15) COMP-3.
              10  W-SUB-AMT2           PIC S9(15) COMP-3.
              10  W-FILLER             PIC X(034).
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
              10  W-SUB-CALLING-PGM    PIC X(005).
              10  W-SUB-STATUS.
                  15 L-COMM-ENG-FG-C   PIC  X(01).
                  15 L-COMM-SQL-C      PIC  X(04).
                  15 L-COMM-MSG-C      PIC  X(50).

PYJ    01  TSQ-REC.
           05  TS-SYS-TIME             PIC  X(08).
           05  FILLER                  PIC  X(01).
           05  TS-DATA                 PIC  X(300).

      *                                *************       ************
      *                                *        COMMON WORK AREA      *
      *                                *************       ************
           COPY                        SSYBG.

      *                                ***********         ************
      *                                *  HANDLE CONDITION CONSTANTS  *
      *                                ***********         ************
           COPY                        SSYBE.

      *                                *************       ************
      *                                *    PROGRAM SELF COMM AREA    *
      *                                *************       ************
PYJ   *    COPY                        SSYBF.
050203*
       COPY QMY00.

       01  W-COMM-AREA-REDFR REDEFINES    W-COMM-AREA.
      *i?I?450 BYTE
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
      *      ª¶K/?z?/ASSIGN FIELD
              10 W-COMM-XCTL-PDUEDT       PIC  X(008).
011218        10 W-COMM-UNION-TP          PIC  X(001).
              10 FIL                      PIC  X(3391).
      *---------------------------------------------------------**

       01  W-COMM-AREA-R               REDEFINES    W-COMM-AREA.
           05 FILLER                      PIC  X(700).
           05 W-COMM-SUB-HTS.
              10 FILLER                   PIC  X(030).
              10 W-COMM-HISTORY-PRD-FR    PIC  X(008).
              10 FILLER                   PIC  X(040).
              10 W-COMM-SUB-DATA.
                 15 FILLER                   PIC  X(002).
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

       01  W-COMM-AREA-ENG.

           05 W-COMM-ENG-KEY.
              10  W-COMM-RCVE-NO-YY     PIC X(04).
              10  W-COMM-RCVE-NO-TXOFF  PIC X(03).
              10  W-COMM-RCVE-NO-SEQNO  PIC X(07).
              10  W-COMM-RCVE-NO-SEQNOR    REDEFINES
                  W-COMM-RCVE-NO-SEQNO     PIC  9(007).
           05 W-COMM-ENG1.
              10  W-BUSNID              PIC X(10).
              10  W-COMM-RGST-OPEN-DT   PIC X(08).
              10  W-COMM-TRADENM        PIC X(60).
              10  W-COMM-BUSN-OWNER-TP  PIC X(01).
              10  W-COMM-HQBR-FG        PIC X(01).
              10  W-COMM-BUSNID-HQ      PIC X(10).
              10  W-COMM-RGST-OPEN-DT-HQ PIC X(08).
              10  W-COMM-APT-BLOCK      PIC X(80).
              10  W-COMM-APT-DONG       PIC X(12).
              10  W-COMM-APT-HO         PIC X(06).
              10  W-COMM-APT-BLOCK-HQ   PIC X(80).
              10  W-COMM-APT-DONG-HQ    PIC X(12).
              10  W-COMM-APT-HO-HQ      PIC X(06).
              10  W-COMM-UPCODE         PIC X(07).
              10  W-COMM-BUSNSECT-NM    PIC X(40).
              10  W-COMM-ITEM-NM        PIC X(90).
              10  W-COMM-BU-UPCODE-FG   PIC X(01).
              10  W-COMM-BU-UPCODE      PIC X(07).
              10  W-COMM-BU-BUSNSECT-NM PIC X(40).
              10  W-COMM-BU-ITEM-NM     PIC X(90).
              10  W-COMM-RESID          PIC X(13).
              10  W-COMM-TXPAYERTP      PIC X(01).
              10  W-COMM-NM             PIC X(30).
              10  W-RESID-HOUSE-HD      PIC X(13).
              10  W-TXPAYER-TP-HOUSE    PIC X(01).
              10  W-COMM-APT-BLOCK-RESID PIC X(80).
              10  W-COMM-APT-DONG-RESID PIC X(12).
              10  W-COMM-APT-HO-RESID   PIC X(06).
              10  W-COMM-COBUSN-FG      PIC X(01).

           05 W-COMM-ENG2.
              10  W-COMM-ENG2-R               OCCURS 4.
                  15  W-COMM-C-RESID          PIC X(13).
                  15  W-COMM-C-TXPR           PIC X(01).
                  15  W-COMM-C-BUSNID         PIC X(10).
                  15  W-COMM-C-RGST-OPEN-DT   PIC X(08).
                  15  W-COMM-C-NM             PIC X(60).
      *****************************************************************
      *                                                               *
      *                  M O D U L E   A R E A                        *
      *                                                               *
      *****************************************************************
      *****************************************************************
      *                                                               *
      *                 V S A M    I O     A R E A                    *
      *                                                               *
      *****************************************************************

      *                                *************       ************
      *                                *       MESSAGE VSAM WORK      *
      *                                *************       ************
           COPY                        SUY01.

      *                                *************       *************
      *                                *        HELP WORK AREA         *
      *                                *************       *************
           COPY                        SHY01.

      *****************************************************************
      *                                                               *
      *                  D B 2   W O R K   A R E A                    *
      *                                                               *
      *****************************************************************

      *                                ***********         ************
      *                                *    SQL COMMUNICATION AREA    *
      *                                ***********         ************
           EXEC SQL  INCLUDE  SQLCA
           END-EXEC.

      *           ******************************************************
      *           *        DTIA.TTIAA     (??[¶º/)                    
      *           ******************************************************

           EXEC SQL  INCLUDE    TIOAA
           END-EXEC.

      *           ******************************************************
      *           *        DTAA.TTAAA     (?/?3?/)                    
      *           ******************************************************

           EXEC SQL  INCLUDE    TAOAA
           END-EXEC.

      *           ******************************************************
      *           *        DRWA.TRWAD     (   tv?v?aπﬂ TABLE )        
      *           ******************************************************

           EXEC SQL  INCLUDE    RWOAD
           END-EXEC.

      *           ******************************************************
      *           *        DRWA.TRWAJ     (   π÷se?/?3?/  TABLE)      
      *           ******************************************************

           EXEC SQL  INCLUDE    RWOAJ
           END-EXEC.

      *           ******************************************************
      *           *        DRWA.TRWAK     (   π÷se?3Ωª    TABLE)      
      *           ******************************************************

           EXEC SQL  INCLUDE    RWOAK
           END-EXEC.

      *           ******************************************************
      *           *        DRWA.TRWAM     (   π÷se??[¶º/  TABLE)      
      *           ******************************************************

           EXEC SQL  INCLUDE    RWOAM
           END-EXEC.

      *           ******************************************************
      *           *        DRWA.TRWAN     (   π÷seh/?a?7v~TABLE)      
      *           ******************************************************

           EXEC SQL  INCLUDE    RWOAN
           END-EXEC.

      *           ******************************************************
      *           *        DRWA.TRWAL     (   π÷sei?n?ma?/            
      *           ******************************************************

           EXEC SQL  INCLUDE    RWOAL
           END-EXEC.


      ******************************************************************
      *                                                                *
      *                     H T S - A R E A                            *
      *  HTS?~  ?1i/?al?  DATA RECORD                                *
      ******************************************************************
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
           05  H-RTN-TP               PIC X(001).                       
           05  H-ERR-TP               PIC X(001).                       
                                                                        
      *****************************************************************
      *                                                               *
      *           E N D   O F  W O R K I N G  S T O R A G E           *
      *                                                               *
      *****************************************************************

       01  WS-END                      PIC  X(40)
           VALUE 'JEPA2 - WORKING STORAGE ENDS HERE'.

       EJECT

      *****************************************************************
      *                                                               *
      *                 L I N K A G E   S E C T I O N                 *
      *                                                               *
      *****************************************************************

       LINKAGE SECTION.

       01  DFHCOMMAREA.

           05  L-COMM-AREA             PIC  X(4000).

       EJECT
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
      *       - WHEN CLEAR KEY IS PRESSED ON INITIAL EXECUTION OF      *
      *         THIS PROGRAM THEN SEND A FINAL MESSAGE TO THE          *
      *         TERMINAL SCREEN.                                       *
      *                                                                *
      ******************************************************************

       INITIALIZATION                  SECTION.

           PERFORM S0100-INITIALIZATION.

           EJECT
      ******************************************************************
      *                                                                *
      *                     M  A  I  N  L  I  N  E                     *
      *                                                                *
      ******************************************************************

       MAINLINE                        SECTION.

           PERFORM S0200-MAIN-PROCESS.

           EJECT
      ******************************************************************
      *                                                                *
      *                    F I N A L I Z A T I O N                     *
      *                                                                *
      ******************************************************************

       FINALIZATION SECTION.

           PERFORM S9900-RETURN.

           EJECT
      ******************************************************************
      *                                                                *
      *               S 0 2 0 0 - M A I N - P R O C E S S              *
      *                                                                *
      ******************************************************************

       S0200-MAIN-PROCESS              SECTION.

      *tv?v?aπﬂ TABLE READ
           MOVE W-COMM-RCVE-NO-YY      TO RCVE-NO-YY     OF TRWAD.
           MOVE W-COMM-RCVE-NO-TXOFF   TO RCVE-NO-TXOFF  OF TRWAD.
           MOVE W-COMM-RCVE-NO-SEQNO   TO RCVE-NO-SEQNO  OF TRWAD.

           PERFORM S3000-SELECT-TRWAD.

           IF  SQLCODE   =  C-SQL-NORMAL

               PERFORM S1100-EDIT-CONFIRM
           ELSE
               CONTINUE                                                 

           END-IF.

       S0200-MAIN-PROCESS-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                     S U B R O U T I N E S                      *
      *                                                                *
      ******************************************************************
      ******************************************************************
      *                                                                *
      *               S 0 1 0 0 - I N I T I A L I Z A T I O N          *
      *                                                                *
      ******************************************************************

       S0100-INITIALIZATION            SECTION.

           EXEC  CICS ASSIGN   STARTCODE(W-START-CODE) END-EXEC.

           IF  W-START-CODE = 'TD'
                MOVE 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
                                         TO W-MSG-CONTENTS
                EXEC CICS SEND   FROM   (W-MSG-CONTENTS)
                                 LENGTH (C-CLEAR-MSG-LNTH)
                                 ERASE
                                 RESP   (W-RETURN-CODE)
                END-EXEC
                PERFORM S9900-RETURN
           ELSE
                PERFORM S9700-RETRIEVE
           END-IF.

           PERFORM S9600-GET-SYSTEM-DATA.

       S0100-INITIALIZATION-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *           S 1 1 0 0 - E D I T - C O N F I R M                  *
      *                                                                *
      ******************************************************************

       S1100-EDIT-CONFIRM              SECTION.

           MOVE    TX-SRVC-TP      OF TRWAD   TO W-TX-SRVC-TP.          

           IF  W-BUSNID =       SPACE     OR
               W-BUSNID =       LOW-VALUE

               CONTINUE
           ELSE

               PERFORM S3100-DB-TRWAJ-INSERT
               IF  W-COMM-UPCODE = SPACE       OR
                   W-COMM-UPCODE = LOW-VALUE
                   CONTINUE
               ELSE
                   PERFORM S3300-DB-TRWAK-INSERT
               END-IF
           END-IF.

           PERFORM S3500-DB-TRWAM-INSERT.

           IF  RESID-BUSNID OF TRWAD(11:1) = (SPACE OR LOW-VALUE)
               MOVE SPACE              TO W-GAEIN-FG
           ELSE
               MOVE 'Y'                TO W-GAEIN-FG
           END-IF.
      *-----------------------------------------------------------
      *??[¶⁄/?zŸ÷~÷ªa  i÷Êa
      *?~?1u3?v?~~?  ?a[~}?~s?a  ?/?/?~  vv?1[~?a?~??  v?i?
      *-----------------------------------------------------------
           IF  W-TX-SRVC-TP    = 'B0005'    AND
               W-GAEIN-FG NOT  = 'Y' AND
               W-COMM-BUSN-OWNER-TP = '5' AND
               W-COMM-HQBR-FG NOT   = 'Y'
               PERFORM S3900-DB-TRWAJ-INSERT-BON
           ELSE
               PERFORM S3700-DB-TRWAN-INSERT
           END-IF.

           IF  SQLCODE  =  C-SQL-NORMAL

               IF  W-TX-SRVC-TP = 'B0001' OR
                                  'B0002' OR
                                  'B0012'

      *            IF (W-COMM-COBUSN-FG NOT = 'Y')    AND
      *              ((W-COMM-BU-UPCODE-FG NOT = 'Y') OR
      *               (W-TX-SRVC-TP = 'B0001'    AND
      *                W-COMM-BU-UPCODE-FG NOT = 'Y') OR
      *               (W-TX-SRVC-TP = 'B0002'    OR
      *                W-TX-SRVC-TP = 'B0012'))
      *
      *                PERFORM S4900-PRINT-SELECT
      *
      *            ELSE
                       PERFORM S1200-EDIT-CONFIRM

      *            END-IF

               ELSE

      * ?v{VŸª?a?asa?/π÷seª∑?? SKIP
      *            IF  W-TX-SRVC-TP = 'B1010'
      *
      *                PERFORM S1200-EDIT-CONFIRM
      *            ELSE
      *                PERFORM S4900-PRINT-SELECT
      *            END-IF
                   PERFORM S4900-PRINT-SELECT
               END-IF
           END-IF.

       S1100-EDIT-CONFIRM-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *           S 1 2 0 0 - E D I T - C O N F I R M                  *
      *                                                                *
      ******************************************************************

       S1200-EDIT-CONFIRM              SECTION.

           IF  W-BUSNID = SPACE OR
               W-BUSNID = LOW-VALUE

      *       ?v{VŸª?a?asa?/?a  π÷se⁄÷J~==> π÷seª∑??SKIP
               CONTINUE

           ELSE

      *       ?/?3?/?a  π÷sewa?3Ωª
               IF  W-TX-SRVC-TP = 'B0001'
                   PERFORM S4100-DB-TRWAK-DEL-IN
               ELSE
                   CONTINUE
               END-IF

      *       ?/?3?/?a  i?nª⁄/?3?/t?i?n?ma?/
               IF  W-TX-SRVC-TP = 'B0001' OR
                                       'B0002' OR
                                       'B0012'
                   PERFORM S4300-DB-TRWAL-DEL-IN
               ELSE
                   CONTINUE
               END-IF
           END-IF.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               PERFORM S4900-PRINT-SELECT
           END-IF.

       S1200-EDIT-CONFIRM-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *            S 3 0 0 0 - S E L E C T - T R W A D                 *
      *                                                                *
      ******************************************************************

       S3000-SELECT-TRWAD              SECTION.

           EXEC SQL
                SELECT  TXPAYER_TP          ,
                        TXPAYER_ID          ,
                        RESID_BUSNID        ,
                        TXTP_CD             ,
                        RTN_TP              ,
                        RTN_SERIAL_NO       ,
                        ASS_YYMM_FR         ,
                        ASS_YYMM_TO         ,
                        TX_SRVC_TP          ,
                        RCVE_DT             ,
                        TX_OFFCR_RCVE       ,
                        USE_PURPOSE         ,
                        TREAT_STAUS         ,                           
                        ISSUE_DT            ,                           
                        BUSNID_DISTR_CS     ,                           
                        EXPIRE_DT           ,                           
                        ADMIT_DT            ,                           
                        ISSUE_QTY
                  INTO :TRWAD.TXPAYER-TP    ,
                       :TRWAD.TXPAYER-ID    ,
                       :TRWAD.RESID-BUSNID  ,
                       :TRWAD.TXTP-CD       ,
                       :TRWAD.RTN-TP        ,
                       :TRWAD.RTN-SERIAL-NO ,
                       :TRWAD.ASS-YYMM-FR   ,
                       :TRWAD.ASS-YYMM-TO   ,
                       :TRWAD.TX-SRVC-TP    ,
                       :TRWAD.RCVE-DT       ,
                       :TRWAD.TX-OFFCR-RCVE ,
                       :TRWAD.USE-PURPOSE   ,
                       :TRWAD.TREAT-STAUS   ,                           
                       :TRWAD.ISSUE-DT      ,                           
                       :TRWAD.BUSNID-DISTR-CS,                          
                       :TRWAD.EXPIRE-DT     ,                           
                       :TRWAD.ADMIT-DT      ,                           
                       :TRWAD.ISSUE-QTY
                  FROM  DRWA.TRWAD
                 WHERE  RCVE_NO_YY     = :TRWAD.RCVE-NO-YY
                   AND  RCVE_NO_TXOFF  = :TRWAD.RCVE-NO-TXOFF
                   AND  RCVE_NO_SEQNO  = :TRWAD.RCVE-NO-SEQNO
           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
                           C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S3000-SELECT-TRWAD'
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S3000-SELECT-TRWAD-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *            S 3 1 0 0 - D B - T R W A J - I N S E R T           *
      *                                                                *
      ******************************************************************

       S3100-DB-TRWAJ-INSERT      SECTION.

      *   π÷se?/?3?/  TABLE INSERT
           MOVE W-BUSNID               TO BUSNID       OF TRWAJ.
           MOVE W-COMM-RGST-OPEN-DT    TO RGST-OPEN-DT OF TRWAJ.

      *   π÷se⁄÷J~
           MOVE W-COMM-TRADENM         TO TRADE-NM OF TRWAJ.

      *   π÷se?/?3º÷?/?/?/
           MOVE W-COMM-APT-BLOCK       TO APT-BLOCK OF TRWAJ.

      *   π÷se?/?3º÷nª·,J~
           MOVE W-COMM-APT-DONG        TO APT-DONG  OF TRWAJ.
           MOVE W-COMM-APT-HO          TO APT-HO    OF TRWAJ.

           EXEC  SQL  INSERT  INTO
                      DRWA.TRWAJ
                            (  BUSNID                  ,
                               RGST_OPEN_DT            ,
                               TRADE_NM                ,
                               APT_BLOCK               ,
                               APT_DONG                ,
                               APT_HO    )
                      VALUES
                            ( :TRWAJ.BUSNID            ,
                              :TRWAJ.RGST-OPEN-DT      ,
                              :TRWAJ.TRADE-NM          ,
                              :TRWAJ.APT-BLOCK         ,
                              :TRWAJ.APT-DONG          ,
                              :TRWAJ.APT-HO  )
           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               IF  SQLCODE  =  -803

                   PERFORM  S3200-DB-TRWAJ-UPDATE

               ELSE

                   MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                   MOVE 'S3100-DB-TRWAJ-INSERT '
                                       TO W-ABEND-SECTION
                   PERFORM S9800-ABEND

               END-IF

           END-IF.

       S3100-DB-TRWAJ-INSERT-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 3 2 0 0 - D B - T R W A J - U P D A T E              *
      *                                                                *
      ******************************************************************

       S3200-DB-TRWAJ-UPDATE           SECTION.

           STRING W-CURR-YYYY  '-'
                  W-CURR-MM    '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAJ.

           EXEC  SQL   UPDATE   DRWA.TRWAJ
                 SET   TRADE_NM        = :TRWAJ.TRADE-NM     ,
                       APT_BLOCK       = :TRWAJ.APT-BLOCK    ,
                       APT_DONG        = :TRWAJ.APT-DONG     ,
                       APT_HO          = :TRWAJ.APT-HO       ,
                       CREAT_DT        = :TRWAJ.CREAT-DT
                 WHERE BUSNID          = :TRWAJ.BUSNID
                 AND   RGST_OPEN_DT    = :TRWAJ.RGST-OPEN-DT

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S3200-DB-TRWAJ-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S3200-DB-TRWAJ-UPDATE-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 3 3 0 0 - D B - T R W A K - I N S E R T           *
      *                                                                *
      ******************************************************************

       S3300-DB-TRWAK-INSERT      SECTION.

      *   π÷se?3Ωª    TABLE DELETE
           MOVE W-BUSNID            TO BUSNID       OF TRWAK.
           MOVE W-COMM-RGST-OPEN-DT TO RGST-OPEN-DT OF TRWAK.

           EXEC  SQL  DELETE
                      FROM   DRWA.TRWAK
                      WHERE  BUSNID          = :TRWAK.BUSNID
                        AND  RGST_OPEN_DT    = :TRWAK.RGST-OPEN-DT
                        AND  MAIN_BUSNTP_FG  = 'Y'
           END-EXEC.

      *   π÷se?3Ωª    TABLE INSERT
           IF  SQLCODE  =  C-SQL-NORMAL OR
               SQLCODE  =  C-SQL-NOTFND

               IF  W-COMM-UPCODE NOT = SPACE AND
                   W-COMM-UPCODE NOT = LOW-VALUE

      *       π÷se?3ΩªE~p/
                   MOVE W-COMM-UPCODE      TO BUSNTP-CD   OF TRWAK

      *       π÷se?a?3Ha~?
                   MOVE W-COMM-BUSNSECT-NM TO BUSNSECT-NM OF TRWAK

      *       π÷se?aΩª~s~?
                   MOVE W-COMM-ITEM-NM     TO ITEM-NM     OF TRWAK

      *       π÷se?a?3Ωª?awe
                   MOVE 'Y'            TO MAIN-BUSNTP-FG OF TRWAK

                   EXEC  SQL  INSERT  INTO
                              DRWA.TRWAK
                                    (  BUSNID                  ,
                                       RGST_OPEN_DT            ,
                                       BUSNTP_CD               ,
                                       BUSNSECT_NM             ,
                                       ITEM_NM                 ,
                                       MAIN_BUSNTP_FG  )
                              VALUES
                                    ( :TRWAK.BUSNID            ,
                                      :TRWAK.RGST-OPEN-DT      ,
                                      :TRWAK.BUSNTP-CD         ,
                                      :TRWAK.BUSNSECT-NM       ,
                                      :TRWAK.ITEM-NM           ,
                                      :TRWAK.MAIN-BUSNTP-FG  )
                   END-EXEC

                   IF  SQLCODE  =  C-SQL-NORMAL

                       CONTINUE

                   ELSE

                       IF  SQLCODE  =  -803

                           PERFORM  S3400-DB-TRWAK-UPDATE

                       ELSE

                           MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                           MOVE 'S3300-DB-TRWAK-INSERT '
                                               TO W-ABEND-SECTION
                           PERFORM S9800-ABEND

                       END-IF
                   END-IF
               ELSE
                   CONTINUE
               END-IF
           ELSE

               MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
               MOVE 'S2900-DELETE-TRWAK '
                                   TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S3300-DB-TRWAK-INSERT-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 3 4 0 0 - D B - T R W A K - U P D A T E              *
      *                                                                *
      ******************************************************************

       S3400-DB-TRWAK-UPDATE           SECTION.

           STRING W-CURR-YYYY  '-'
                  W-CURR-MM    '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAK.

           EXEC  SQL   UPDATE   DRWA.TRWAK
                 SET   BUSNSECT_NM     = :TRWAK.BUSNSECT-NM  ,
                       ITEM_NM         = :TRWAK.ITEM-NM      ,
                       CREAT_DT        = :TRWAK.CREAT-DT
                 WHERE BUSNID          = :TRWAK.BUSNID
                 AND   RGST_OPEN_DT    = :TRWAK.RGST-OPEN-DT
                 AND   BUSNTP_CD       = :TRWAK.BUSNTP-CD

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S3400-DB-TRWAK-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S3400-DB-TRWAK-UPDATE-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 3 5 0 0 - D B - T R W A M - I N S E R T           *
      *                                                                *
      ******************************************************************

       S3500-DB-TRWAM-INSERT      SECTION.

      *   π÷se??[¶º/  TABLE INSERT
           MOVE W-COMM-RESID           TO RESID        OF TRWAM.
           MOVE W-COMM-TXPAYERTP       TO TXPAYER-TP   OF TRWAM.

      *   π÷se?7~?
           MOVE W-COMM-NM              TO NM           OF TRWAM.

      *   π÷se[?ma?a
           MOVE W-RESID-HOUSE-HD       TO RESID-HOUSE-HD OF TRWAM.
           MOVE W-TXPAYER-TP-HOUSE     TO TXPAYER-TP-HOUSE OF TRWAM.

           EXEC  SQL  INSERT  INTO
                      DRWA.TRWAM
                            (  RESID                   ,
                               TXPAYER_TP              ,
                               NM                      ,
                               RESID_HOUSE_HD          ,
                               TXPAYER_TP_HOUSE    )
                      VALUES
                            ( :TRWAM.RESID             ,
                              :TRWAM.TXPAYER-TP        ,
                              :TRWAM.NM                ,
                              :TRWAM.RESID-HOUSE-HD    ,
                              :TRWAM.TXPAYER-TP-HOUSE  )
           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               IF  SQLCODE  =  -803

                   PERFORM  S3600-DB-TRWAM-UPDATE

               ELSE

                  MOVE C-ABEND-FG-DB2  TO W-ABEND-FG
                  MOVE 'S3500-DB-TRWAM-INSERT '
                                       TO W-ABEND-SECTION
                  PERFORM S9800-ABEND

               END-IF

           END-IF.

       S3500-DB-TRWAM-INSERT-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 3 6 0 0 - D B - T R W A M - U P D A T E              *
      *                                                                *
      ******************************************************************

       S3600-DB-TRWAM-UPDATE           SECTION.

           STRING W-CURR-YYYY  '-'
                  W-CURR-MM    '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAM.

           EXEC  SQL   UPDATE   DRWA.TRWAM
                 SET   NM               = :TRWAM.NM               ,
                       RESID_HOUSE_HD   = :TRWAM.RESID-HOUSE-HD   ,
                       TXPAYER_TP_HOUSE = :TRWAM.TXPAYER-TP-HOUSE ,
                       CREAT_DT         = :TRWAM.CREAT-DT
                 WHERE RESID            = :TRWAM.RESID
                 AND   TXPAYER_TP       = :TRWAM.TXPAYER-TP

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S3600-DB-TRWAM-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S3600-DB-TRWAM-UPDATE-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 3 7 0 0 - D B - T R W A N - I N S E R T           *
      *                                                                *
      ******************************************************************

       S3700-DB-TRWAN-INSERT      SECTION.

      *   π÷seh/?a?7v~TABLE INSERT
           MOVE W-RESID-HOUSE-HD       TO RESID-HOUSE-HD   OF TRWAN.
           MOVE W-TXPAYER-TP-HOUSE     TO TXPAYER-TP-HOUSE OF TRWAN.

      *   π÷se?a[~
           MOVE W-COMM-APT-BLOCK-RESID TO APT-BLOCK    OF TRWAN.
           MOVE W-COMM-APT-DONG-RESID  TO APT-DONG     OF TRWAN.
           MOVE W-COMM-APT-HO-RESID    TO APT-HO       OF TRWAN.

           EXEC  SQL  INSERT  INTO
                      DRWA.TRWAN
                            (  RESID_HOUSE_HD          ,
                               TXPAYER_TP_HOUSE        ,
                               APT_BLOCK               ,
                               APT_DONG                ,
                               APT_HO      )
                      VALUES
                            ( :TRWAN.RESID-HOUSE-HD    ,
                              :TRWAN.TXPAYER-TP-HOUSE  ,
                              :TRWAN.APT-BLOCK         ,
                              :TRWAN.APT-DONG          ,
                              :TRWAN.APT-HO            )
           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               IF  SQLCODE  =  -803

                   PERFORM  S3800-DB-TRWAN-UPDATE

               ELSE

                  MOVE C-ABEND-FG-DB2  TO W-ABEND-FG
                  MOVE 'S3700-DB-TRWAN-INSERT '
                                       TO W-ABEND-SECTION
                  PERFORM S9800-ABEND

               END-IF

           END-IF.

       S3700-DB-TRWAN-INSERT-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 3 8 0 0 - D B - T R W A N - U P D A T E              *
      *                                                                *
      ******************************************************************

       S3800-DB-TRWAN-UPDATE           SECTION.

           STRING W-CURR-YYYY '-'
                  W-CURR-MM '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAN.

           EXEC  SQL   UPDATE   DRWA.TRWAN
                 SET   APT_BLOCK        = :TRWAN.APT-BLOCK        ,
                       APT_DONG         = :TRWAN.APT-DONG         ,
                       APT_HO           = :TRWAN.APT-HO           ,
                       CREAT_DT         = :TRWAN.CREAT-DT
                 WHERE RESID_HOUSE_HD   = :TRWAN.RESID-HOUSE-HD
                 AND   TXPAYER_TP_HOUSE = :TRWAN.TXPAYER-TP-HOUSE

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S3800-DB-TRWAN-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S3800-DB-TRWAN-UPDATE-EXIT.
           EXIT.
           EJECT


      ******************************************************************
      *                                                                *
      *            S 3 9 0 0 - D B - T R W A J - I N S E R T - B O N   *
      *                                                                *
      ******************************************************************

       S3900-DB-TRWAJ-INSERT-BON  SECTION.

      *   vv?1?/?3?/  TABLE INSERT

           MOVE W-COMM-BUSNID-HQ       TO BUSNID       OF TRWAJ
           MOVE W-COMM-RGST-OPEN-DT-HQ TO RGST-OPEN-DT OF TRWAJ.

      *   π÷se⁄÷J~
           MOVE SPACE                TO TRADE-NM OF TRWAJ

      *   π÷sevv?1?/?/?/
           MOVE W-COMM-APT-BLOCK-HQ  TO APT-BLOCK OF TRWAJ

      *   π÷sevv?1?/?3º÷nª·,J~
           MOVE W-COMM-APT-DONG-HQ   TO APT-DONG  OF TRWAJ
           MOVE W-COMM-APT-HO-HQ     TO APT-HO    OF TRWAJ

               EXEC  SQL  INSERT  INTO
                          DRWA.TRWAJ
                                (  BUSNID                  ,
                                   RGST_OPEN_DT            ,
                                   TRADE_NM                ,
                                   APT_BLOCK               ,
                                   APT_DONG                ,
                                   APT_HO    )
                          VALUES
                                ( :TRWAJ.BUSNID            ,
                                  :TRWAJ.RGST-OPEN-DT      ,
                                  :TRWAJ.TRADE-NM          ,
                                  :TRWAJ.APT-BLOCK         ,
                                  :TRWAJ.APT-DONG          ,
                                  :TRWAJ.APT-HO  )
               END-EXEC

               IF  SQLCODE  =  C-SQL-NORMAL

                   CONTINUE

               ELSE

                   IF  SQLCODE  =  -803

                       PERFORM  S4000-DB-TRWAJ-UPDATE-BON

                   ELSE

                       MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                       MOVE 'S3900-DB-TRWAJ-INSERT-BON '
                                           TO W-ABEND-SECTION
                       PERFORM S9800-ABEND

                   END-IF
               END-IF.


       S3900-DB-TRWAJ-INSERT-BON-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 4 0 0 0 - D B - T R W A J - U P D A T E - B O N      *
      *                                                                *
      ******************************************************************

       S4000-DB-TRWAJ-UPDATE-BON       SECTION.

           STRING W-CURR-YYYY '-'
                  W-CURR-MM '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAJ.

           EXEC  SQL   UPDATE   DRWA.TRWAJ
                 SET   APT_BLOCK       = :TRWAJ.APT-BLOCK    ,
                       APT_DONG        = :TRWAJ.APT-DONG     ,
                       APT_HO          = :TRWAJ.APT-HO       ,
                       CREAT_DT        = :TRWAJ.CREAT-DT
                 WHERE BUSNID          = :TRWAJ.BUSNID
                 AND   RGST_OPEN_DT    = :TRWAJ.RGST-OPEN-DT

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S4000-DB-TRWAJ-UPDATE-BON '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4000-DB-TRWAJ-UPDATE-BON-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *            S 4 1 0 0 - D B - T R W A K - D E L - I N           *
      *                                                                *
      ******************************************************************

       S4100-DB-TRWAK-DEL-IN      SECTION.

      *   π÷se?3Ωª    TABLE DELETE
           MOVE W-BUSNID            TO BUSNID       OF TRWAK.
           MOVE W-COMM-RGST-OPEN-DT TO RGST-OPEN-DT OF TRWAK.

           EXEC  SQL  DELETE
                      FROM   DRWA.TRWAK
                      WHERE  BUSNID          = :TRWAK.BUSNID
                        AND  RGST_OPEN_DT    = :TRWAK.RGST-OPEN-DT
                        AND  MAIN_BUSNTP_FG  = 'N'
           END-EXEC.

      *   π÷se?3Ωª    TABLE INSERT
           IF  SQLCODE  =  C-SQL-NORMAL OR
               SQLCODE  =  C-SQL-NOTFND

               IF  W-COMM-BU-UPCODE NOT = SPACE AND
                   W-COMM-BU-UPCODE NOT = LOW-VALUE

      *       π÷se?3ΩªE~p/
                   MOVE W-COMM-BU-UPCODE      TO BUSNTP-CD OF TRWAK

      *       π÷sewa?3Ha~?
                   MOVE W-COMM-BU-BUSNSECT-NM TO BUSNSECT-NM OF TRWAK

      *       π÷sewaΩª~s~?
                   MOVE W-COMM-BU-ITEM-NM     TO ITEM-NM     OF TRWAK

      *       π÷sewa?3Ωª?awe
                   MOVE 'N'            TO MAIN-BUSNTP-FG OF TRWAK

                   EXEC  SQL  INSERT  INTO
                              DRWA.TRWAK
                                    (  BUSNID                  ,
                                       RGST_OPEN_DT            ,
                                       BUSNTP_CD               ,
                                       BUSNSECT_NM             ,
                                       ITEM_NM                 ,
                                       MAIN_BUSNTP_FG  )
                              VALUES
                                    ( :TRWAK.BUSNID            ,
                                      :TRWAK.RGST-OPEN-DT      ,
                                      :TRWAK.BUSNTP-CD         ,
                                      :TRWAK.BUSNSECT-NM       ,
                                      :TRWAK.ITEM-NM           ,
                                      :TRWAK.MAIN-BUSNTP-FG  )
                   END-EXEC

                   IF  SQLCODE  =  C-SQL-NORMAL

                       CONTINUE

                   ELSE

                       IF  SQLCODE  =  -803

                           PERFORM  S4200-DB-TRWAK-UPDATE

                       ELSE

                           MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                           MOVE 'S3000-DB-TRWAK-INSERT '
                                               TO W-ABEND-SECTION
                           PERFORM S9800-ABEND

                       END-IF

                   END-IF
               ELSE
                   CONTINUE
               END-IF

           ELSE

               MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
               MOVE 'S3000-DELETE-TRWAK '
                                   TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4100-DB-TRWAK-DEL-IN-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 4 2 0 0 - D B - T R W A K - U P D A T E              *
      *                                                                *
      ******************************************************************

       S4200-DB-TRWAK-UPDATE           SECTION.

           STRING W-CURR-YYYY '-'
                  W-CURR-MM '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAK.

           EXEC  SQL   UPDATE   DRWA.TRWAK
                 SET   BUSNSECT_NM     = :TRWAK.BUSNSECT-NM  ,
                       ITEM_NM         = :TRWAK.ITEM-NM      ,
                       CREAT_DT        = :TRWAK.CREAT-DT
                 WHERE BUSNID          = :TRWAK.BUSNID
                 AND   RGST_OPEN_DT    = :TRWAK.RGST-OPEN-DT
                 AND   BUSNTP_CD       = :TRWAK.BUSNTP-CD

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S4200-DB-TRWAK-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4200-DB-TRWAK-UPDATE-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *            S 4 3 0 0 - D B - T R W A L - D E L - I N           *
      *                                                                *
      ******************************************************************

       S4300-DB-TRWAL-DEL-IN      SECTION.

      *   π÷sei?nª⁄/?3?/t?i?n?ma?/TABLE DELETE
           MOVE W-BUSNID            TO BUSNID       OF TRWAL.
           MOVE W-COMM-RGST-OPEN-DT TO RGST-OPEN-DT OF TRWAL.

           EXEC  SQL  DELETE
                      FROM   DRWA.TRWAL
                      WHERE  BUSNID          = :TRWAL.BUSNID
                        AND  RGST_OPEN_DT    = :TRWAL.RGST-OPEN-DT
           END-EXEC.

      *   π÷sei?nª⁄/?3?/t?i?n?ma?/  TABLE INSERT
           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               PERFORM VARYING W-INDEX FROM 1 BY 1
                UNTIL  W-INDEX  >  04

                 IF ( W-COMM-C-RESID(W-INDEX) = SPACE OR
                      W-COMM-C-RESID(W-INDEX) = LOW-VALUE ) AND
                    ( W-COMM-C-BUSNID(W-INDEX) = SPACE OR
                      W-COMM-C-BUSNID(W-INDEX) = LOW-VALUE )
                     CONTINUE
                 ELSE
      *           ?a?7?v?atvuVJ~
                   IF   W-COMM-C-RESID(W-INDEX) = SPACE OR LOW-VALUE
                        MOVE W-COMM-C-BUSNID(W-INDEX) TO RESID OF TRWAL
                        IF   W-COMM-C-TXPR(W-INDEX) = SPACE OR LOW-VALUE
                             MOVE '8'        TO W-COMM-C-TXPR(W-INDEX)
                        END-IF
                   ELSE
                        MOVE W-COMM-C-RESID(W-INDEX)  TO RESID OF TRWAL
                   END-IF

      *           ?a?7?v??[¶º/?awe
                   MOVE W-COMM-C-TXPR(W-INDEX) TO TXPAYER-TP OF TRWAL

                   EXEC  SQL  INSERT  INTO
                              DRWA.TRWAL
                                    (  BUSNID                  ,
                                       RGST_OPEN_DT            ,
                                       RESID                   ,
                                       TXPAYER_TP   )
                              VALUES
                                    ( :TRWAL.BUSNID            ,
                                      :TRWAL.RGST-OPEN-DT      ,
                                      :TRWAL.RESID             ,
                                      :TRWAL.TXPAYER-TP  )
                   END-EXEC

                   IF  SQLCODE  =  C-SQL-NORMAL

                       CONTINUE

                   ELSE

                       IF  SQLCODE  =  -803

                           PERFORM  S4400-DB-TRWAL-UPDATE

                       ELSE

                           MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                           MOVE 'S3200-DB-TRWAL-INSERT '
                                               TO W-ABEND-SECTION
                           PERFORM S9800-ABEND

                       END-IF

                   END-IF

      *           π÷se??[¶º/  TABLE INSERT
                   IF  W-COMM-C-BUSNID(W-INDEX) = SPACE OR LOW-VALUE
      *               ?a?7?v?atvuVJ~
                       MOVE W-COMM-C-RESID(W-INDEX)
                                       TO RESID            OF TRWAM

      *               ?a?7?v??[¶º/?awe
                       MOVE W-COMM-C-TXPR(W-INDEX)
                                       TO TXPAYER-TP       OF TRWAM

                       MOVE W-COMM-C-NM(W-INDEX)
                                       TO NM               OF TRWAM
                       MOVE SPACE      TO RESID-HOUSE-HD   OF TRWAM
                                          TXPAYER-TP-HOUSE OF TRWAM

                       EXEC  SQL  INSERT  INTO
                                  DRWA.TRWAM
                                        (  RESID                   ,
                                           TXPAYER_TP              ,
                                           NM                      ,
                                           RESID_HOUSE_HD          ,
                                           TXPAYER_TP_HOUSE  )
                                  VALUES
                                        ( :TRWAM.RESID             ,
                                          :TRWAM.TXPAYER-TP        ,
                                          :TRWAM.NM                ,
                                          :TRWAM.RESID-HOUSE-HD    ,
                                          :TRWAM.TXPAYER-TP-HOUSE )
                       END-EXEC

                       IF  SQLCODE  =  C-SQL-NORMAL

                           CONTINUE

                       ELSE

                           IF  SQLCODE  =  -803

                               PERFORM  S4500-DB-TRWAM-UPDATE

                           ELSE

                               MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                               MOVE 'S3200-DB-TRWAM-INSERT '
                                                   TO W-ABEND-SECTION
                               PERFORM S9800-ABEND

                           END-IF

                       END-IF
                   ELSE
      *               π÷se?/?3?/  TABLE INSERT
      *               ?a?7?v?/?3?/uVJ~
                       MOVE W-COMM-C-BUSNID(W-INDEX)
                                       TO BUSNID           OF TRWAJ
      *               ha?3?z?/
                       MOVE W-COMM-C-RGST-OPEN-DT(W-INDEX)
                                       TO RGST-OPEN-DT     OF TRWAJ

                       MOVE W-COMM-C-NM(W-INDEX)
                                       TO TRADE-NM         OF TRWAJ
                       MOVE SPACE      TO APT-BLOCK        OF TRWAJ
                                          APT-DONG         OF TRWAJ
                                          APT-HO           OF TRWAJ
                       MOVE ZERO       TO TONG             OF TRWAJ
                                          BAN              OF TRWAJ

                       EXEC  SQL  INSERT  INTO
                                  DRWA.TRWAJ
                                        (  BUSNID                  ,
                                           RGST_OPEN_DT            ,
                                           TRADE_NM                ,
                                           APT_BLOCK               ,
                                           APT_DONG                ,
                                           APT_HO                  ,
                                           TONG                    ,
                                           BAN          )
                                  VALUES
                                        ( :TRWAJ.BUSNID            ,
                                          :TRWAJ.RGST-OPEN-DT      ,
                                          :TRWAJ.TRADE-NM          ,
                                          :TRWAJ.APT-BLOCK         ,
                                          :TRWAJ.APT-DONG          ,
                                          :TRWAJ.APT-HO            ,
                                          :TRWAJ.TONG              ,
                                          :TRWAJ.BAN     )
                       END-EXEC

                       IF  SQLCODE  =  C-SQL-NORMAL

                           CONTINUE

                       ELSE

                           IF  SQLCODE  =  -803

                               PERFORM  S4600-DB-TRWAJ-UPDATE

                           ELSE

                               MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
                               MOVE 'S3200-DB-TRWAJ-INSERT '
                                                   TO W-ABEND-SECTION
                               PERFORM S9800-ABEND

                           END-IF

                       END-IF
                   END-IF
                 END-IF
               END-PERFORM

           ELSE

               MOVE C-ABEND-FG-DB2 TO W-ABEND-FG
               MOVE 'S3200-DELETE-TRWAL '
                                   TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4300-DB-TRWAL-DEL-IN-EXIT.
           EXIT.
           EJECT


      ******************************************************************
      *                                                                *
      *         S 4 4 0 0 - D B - T R W A L - U P D A T E              *
      *                                                                *
      ******************************************************************

       S4400-DB-TRWAL-UPDATE           SECTION.

           STRING W-CURR-YYYY '-'
                  W-CURR-MM '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAL.

           EXEC  SQL   UPDATE   DRWA.TRWAL
                 SET   CREAT_DT        = :TRWAL.CREAT-DT
                 WHERE BUSNID          = :TRWAL.BUSNID
                 AND   RGST_OPEN_DT    = :TRWAL.RGST-OPEN-DT
                 AND   RESID           = :TRWAL.RESID
                 AND   TXPAYER_TP      = :TRWAL.TXPAYER-TP

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S4400-DB-TRWAL-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4400-DB-TRWAL-UPDATE-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *         S 4 5 0 0 - D B - T R W A M - U P D A T E              *
      *                                                                *
      ******************************************************************

       S4500-DB-TRWAM-UPDATE           SECTION.

           STRING W-CURR-YYYY '-'
                  W-CURR-MM '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAM.

           EXEC  SQL   UPDATE   DRWA.TRWAM
                 SET   NM               = :TRWAM.NM       ,
                       CREAT_DT         = :TRWAM.CREAT-DT
                 WHERE RESID            = :TRWAM.RESID
                 AND   TXPAYER_TP       = :TRWAM.TXPAYER-TP

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S4500-DB-TRWAM-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4500-DB-TRWAM-UPDATE-EXIT.
           EXIT.
           EJECT


      ******************************************************************
      *                                                                *
      *         S 4 6 0 0 - D B - T R W A J - U P D A T E              *
      *                                                                *
      ******************************************************************

       S4600-DB-TRWAJ-UPDATE           SECTION.

           STRING W-CURR-YYYY '-'
                  W-CURR-MM '-'
                  W-CURR-DD
           DELIMITED BY SIZE INTO CREAT-DT OF TRWAJ.

           EXEC  SQL   UPDATE   DRWA.TRWAJ
                 SET   TRADE_NM         = :TRWAJ.TRADE-NM ,
                       CREAT_DT         = :TRWAJ.CREAT-DT
                 WHERE BUSNID           = :TRWAJ.BUSNID
                 AND   RGST_OPEN_DT     = :TRWAJ.RGST-OPEN-DT

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL  OR
               SQLCODE  =  C-SQL-NOTFND

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-DB2     TO W-ABEND-FG
               MOVE 'S4600-DB-TRWAJ-UPDATE '
                                       TO W-ABEND-SECTION
               PERFORM S9800-ABEND

           END-IF.

       S4600-DB-TRWAJ-UPDATE-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                      S 4 7 0 0 - U P D A T E - I S S D T       *
      *                                                                *
      ******************************************************************

       S4700-UPDATE-ISSDT              SECTION.

           MOVE W-COMM-RCVE-NO-YY      TO RCVE-NO-YY     OF TRWAD.
           MOVE W-COMM-RCVE-NO-TXOFF   TO RCVE-NO-TXOFF  OF TRWAD.
           MOVE W-COMM-RCVE-NO-SEQNO   TO RCVE-NO-SEQNO  OF TRWAD.

           STRING W-CURR-YYYY
                  W-CURR-MM
                  W-CURR-DD
                  DELIMITED BY SIZE INTO ISSUE-DT OF TRWAD.

           EXEC  SQL  UPDATE   DRWA.TRWAD
                 SET  ISSUE_DT        = :TRWAD.ISSUE-DT
                 WHERE  RCVE_NO_YY    = :TRWAD.RCVE-NO-YY
                 AND    RCVE_NO_TXOFF = :TRWAD.RCVE-NO-TXOFF
                 AND    RCVE_NO_SEQNO = :TRWAD.RCVE-NO-SEQNO

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               MOVE  C-ABEND-FG-DB2    TO W-ABEND-FG
               MOVE 'S4700-UPDATE-ISSDT '
                                       TO W-ABEND-SECTION

               PERFORM    S9800-ABEND

           END-IF.

       S4700-UPDATE-ISSDT-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                 S 4 8 0 0 - M O V E - T A B L E 2 C O M M      *
      *                                                                *
      ******************************************************************
       S4800-MOVE-TABLE2COMM               SECTION.

           MOVE  SPACE                    TO  W-COMM-HTS-PRTID.
           MOVE  RCVE-NO-YY    OF TRWAD   TO  W-COMM-HTS-RCVEYY.
           MOVE  RCVE-NO-TXOFF OF TRWAD   TO  W-COMM-HTS-RCVETXOFF.
           MOVE  RCVE-NO-SEQNO OF TRWAD   TO  W-COMM-HTS-RCVESEQ.
           IF    W-TX-SRVC-TP = 'B0002' OR 'B0012'
                 MOVE  ADMIT-DT OF TRWAD  TO  W-COMM-HISTORY-PRD-FR
           END-IF.
           MOVE  'H'                      TO  W-COMM-HTS-FG.

       S4800-MOVE-TABLE2COMM-EXIT.
           EXIT.
      ******************************************************************
      *                                                                *
      *          S 4 9 0 0 - P R I N T - S E L E C T                   *
      *                                                                *
      ******************************************************************

       S4900-PRINT-SELECT              SECTION.

           PERFORM   S4700-UPDATE-ISSDT.

           PERFORM   S4800-MOVE-TABLE2COMM.

      *   [~pﬂ§??bŸ÷~÷·(Ωª}?[~p?[?Ê÷?)?(π÷se?)

           IF  W-TX-SRVC-TP = 'B1001'

      *        MOVE 'RWP5'         TO W-TRAN-ID
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

               MOVE 'LWP5'                 TO W-TRAN-ID
               MOVE C-PGM-LWSP5            TO W-SUB-PGM
               MOVE SPACE                  TO W-SUB-PRTID
               MOVE    0                   TO W-SUB-AMT1  W-SUB-AMT2

           END-IF.

      *   [~pﬂ§??bŸ÷~÷·(π›»¨?7⁄›Ê÷) ?(π÷se?)

           IF  W-TX-SRVC-TP = 'B1010'

      *        MOVE 'RWPJ'         TO W-TRAN-ID
               MOVE RCVE-NO-YY    OF TRWAD TO W-SUB-NO1  W-COMM-NO1
               MOVE RCVE-NO-TXOFF OF TRWAD TO W-SUB-NO2  W-COMM-NO2
               MOVE RCVE-NO-SEQNO OF TRWAD TO W-SUB-NO3  W-COMM-NO3

               MOVE TXPAYER-TP    OF TRWAD TO W-SUB-TXPAYER-TP
               MOVE RESID-BUSNID  OF TRWAD TO W-SUB-RESID-BUSNID
               MOVE TXTP-CD       OF TRWAD TO W-SUB-TXTP-CD
               MOVE ASS-YYMM-FR   OF TRWAD TO W-SUB-ASS-YYMM-FR
               MOVE ASS-YYMM-TO   OF TRWAD TO W-SUB-ASS-YYMM-TO
               MOVE BUSNID-DISTR-CS OF TRWAD TO W-SUB-BIGO
               MOVE SPACE                  TO W-SUB-PRTID
               MOVE SPACE                  TO W-SUB-ALL
               MOVE 'H'                    TO W-SUB-XCTL-CONFM

               MOVE 'LWPJ'                 TO W-TRAN-ID
               MOVE C-PGM-LWPPI            TO W-LINK-PGM
               MOVE SPACE                  TO W-SUB-PRTID
               MOVE    0                   TO W-SUB-AMT1  W-SUB-AMT2

           END-IF.

      *   ??[¶⁄/?zŸ÷~÷·(π÷se?)

           IF  W-TX-SRVC-TP = 'B0005' OR

      *   ??[¶Ÿ?~÷·(π÷se?)
                              'B0006' OR 'B0007' OR
                              'B0008'
               MOVE 'AF09'         TO W-TRAN-ID
PYJ            MOVE  C-PGM-PFP09         TO  W-LINK-PGM

           END-IF.

      *   ?/?3?/p?sŸ÷~÷·(π÷se?)

           IF  W-TX-SRVC-TP = 'B0001'

      *        MOVE 'TH12'         TO W-TRAN-ID
               MOVE RCVE-NO-YY    OF TRWAD TO W-SUB-NO1
               MOVE RCVE-NO-TXOFF OF TRWAD TO W-SUB-NO2
               MOVE RCVE-NO-SEQNO OF TRWAD TO W-SUB-NO3

               MOVE TXPAYER-TP  OF TRWAD   TO W-SUB-TXPAYER-TP
               MOVE RESID-BUSNID OF TRWAD  TO W-SUB-RESID-BUSNID
               MOVE TXTP-CD     OF TRWAD   TO W-SUB-TXTP-CD
               MOVE ASS-YYMM-FR OF TRWAD   TO W-SUB-ASS-YYMM-FR
               MOVE ASS-YYMM-TO OF TRWAD   TO W-SUB-ASS-YYMM-TO
               MOVE BUSNID-DISTR-CS OF TRWAD TO W-SUB-BIGO
               MOVE SPACE              TO  W-SUB-PRTID
               MOVE    SPACE           TO  W-SUB-ALL
               MOVE 'H'                TO  W-SUB-XCTL-CONFM

               MOVE    'LH12'          TO  W-TRAN-ID
               MOVE  C-PGM-LHS12      TO  W-SUB-PGM
      *        PERFORM S6000-SUB-PGM-CALL


           END-IF

      *   L??a?3?/?zŸ÷~÷·(π÷se?)

           IF  W-TX-SRVC-TP = 'B0002' OR 'B0012'

      *        MOVE 'TH16'         TO W-TRAN-ID

               MOVE RCVE-NO-YY    OF TRWAD TO W-SUB-NO1
               MOVE RCVE-NO-TXOFF OF TRWAD TO W-SUB-NO2
               MOVE RCVE-NO-SEQNO OF TRWAD TO W-SUB-NO3

               MOVE TXPAYER-TP  OF TRWAD   TO W-SUB-TXPAYER-TP
               MOVE RESID-BUSNID OF TRWAD  TO W-SUB-RESID-BUSNID
               MOVE TXTP-CD     OF TRWAD   TO W-SUB-TXTP-CD
               MOVE ASS-YYMM-FR OF TRWAD   TO W-SUB-ASS-YYMM-FR
               MOVE ASS-YYMM-TO OF TRWAD   TO W-SUB-ASS-YYMM-TO
               MOVE BUSNID-DISTR-CS OF TRWAD TO W-SUB-BIGO
               MOVE  ADMIT-DT OF TRWAD TO  W-SUB-BIGO(3:8)
               MOVE SPACE              TO  W-SUB-PRTID
               MOVE    SPACE           TO  W-SUB-ALL
               MOVE 'H'                TO  W-SUB-XCTL-CONFM

               MOVE    'LH16'          TO  W-TRAN-ID
               MOVE  C-PGM-LHS16      TO  W-SUB-PGM
      *        PERFORM S6000-SUB-PGM-CALL

           END-IF.

           PERFORM S5000-PRINT-PGM.

       S4900-PRINT-SELECT-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *          S 5 0 0 0 - P R I N T - P G M                         *
      *                                                                *
      ******************************************************************

       S5000-PRINT-PGM                 SECTION.

050203     IF  W-TRAN-ID  =  'AF09'   OR  'LWPJ'
               MOVE  SPACE               TO  W-COMM-XCTL-PRTID
               MOVE  RCVE-NO-YY    OF TRWAD
                                         TO  W-COMM-XCTL-RCVEYY
               MOVE  RCVE-NO-TXOFF OF TRWAD
                                         TO  W-COMM-XCTL-RCVETXOFF
               MOVE  RCVE-NO-SEQNO OF TRWAD
                                         TO  W-COMM-XCTL-RCVESEQ
               MOVE  'H'                 TO  W-COMM-XCTL-CONFM
                                                                        
               MOVE  W-COMM-SUB-PGM      TO  TS-DATA
               EXEC  CICS  SYNCPOINT   END-EXEC

               EXEC  CICS  LINK     PROGRAM (W-LINK-PGM)
                                    COMMAREA(W-COMM-AREA(1:4000))
                                    LENGTH  (C-COMM-LNTH)
                                    RESP    (W-RETURN-CODE)
               END-EXEC
               EXEC CICS SYNCPOINT ROLLBACK  END-EXEC

           ELSE

PYJ   *        EXEC    CICS      START
      *                          TRANSID(W-TRAN-ID)
      *                          FROM   (W-COMM-AREA(1:800))
      *                          LENGTH (C-COMMAREA-LNTH)
      *                          RESP   (W-RETURN-CODE)
      *        END-EXEC

               PERFORM  S6000-SUB-PGM-CALL
           END-IF.
PYJ   *    MOVE SPACE TO TSQ-REC.
      *    MOVE 'JEPA2 END'  TO  TS-DATA.
      *    MOVE W-TRAN-ID TO TS-DATA(20:10).
      *    EXEC  CICS WRITEQ    TS       QUEUE('JEPA2Q')
      *                                  FROM(TSQ-REC)
      *                                  END-EXEC.

       S5000-PRINT-PGM-EXIT.
           EXIT.
           EJECT
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
050516*        IF  L-COMM-ENG-FG-C  = SPACE
"     *            MOVE  L-COMM-MSG-C  TO H-BUSNID-DISTR-CS
"     *                                   H-ERR-DOCU
"     *            MOVE L-COMM-ENG-FG-C TO H-ERR-DOCU(1:1)
"     *            MOVE L-COMM-SQL-C    TO H-ERR-DOCU(2:4)
"     *            MOVE L-COMM-MSG-C    TO H-ERR-DOCU(6:50)
"     *            MOVE   '13'          TO  TREAT-STAUS OF TRWAD        
"     *            PERFORM S8000-START-JAPA3                            
"     *        ELSE
                   MOVE  'H'             TO  W-COMM-XCTL-CONFM

                   PERFORM  S6100-PRINT-PGM
050516*        END-IF
           ELSE
               ADD  +1                 TO A-ERROR-COUNT
      *        MOVE L-COMM-SQL         TO W-COMM-RC
      *        MOVE L-COMM-MSG         TO W-COMM-MSG
      *        MOVE L-COMM-ENG-FG      TO W-CM-SCREEN-FG

      *        MOVE  L-COMM-MSG-C       TO H-ERR-DOCU
               MOVE  L-COMM-MSG-C       TO H-BUSNID-DISTR-CS
               MOVE   '13'            TO  TREAT-STAUS OF TRWAD          
               PERFORM S8000-START-JAPA3                                
050516         PERFORM  S6200-UPDATE-TRWAD
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
      *                  S 6 1 0 0 - P R I N T - P G M                 *
      *                                                                *
      ******************************************************************

       S6100-PRINT-PGM                 SECTION.

           MOVE W-SUB-SYSTEM-COMMON(1:150)
                                       TO  W-SUBSYSTEM-COMMON.
           EXEC    CICS      START
                             TRANSID(W-TRAN-ID)
                             FROM   (W-COMM-AREA(1:4000))
                             LENGTH (C-COMM-LNTH)
      *                      TERMID (W-SUB-PRTID)
                             RESP   (W-RETURN-CODE)

           END-EXEC.


       S6100-PRINT-PGM-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                  S 6 2 0 0 - U P D A T E - T R W A D           *
      *                                                                *
      ******************************************************************

       S6200-UPDATE-TRWAD              SECTION.


           MOVE W-COMM-RCVE-NO-YY      TO RCVE-NO-YY     OF TRWAD.
           MOVE W-COMM-RCVE-NO-TXOFF   TO RCVE-NO-TXOFF  OF TRWAD.
           MOVE W-COMM-RCVE-NO-SEQNO   TO RCVE-NO-SEQNO  OF TRWAD.

           STRING W-CURR-YYYY
                  W-CURR-MM
                  W-CURR-DD
                  DELIMITED BY SIZE INTO ISSUE-DT OF TRWAD.

           MOVE W-TIME(1:2)            TO ISSUE-TIME OF TRWAD(1:2).
           MOVE W-TIME(4:2)            TO ISSUE-TIME OF TRWAD(3:2).
           MOVE W-TIME(7:2)            TO ISSUE-TIME OF TRWAD(5:2).

           EXEC  SQL  UPDATE   DRWA.TRWAD
                 SET  ISSUE_DT        = :TRWAD.ISSUE-DT
                     ,TREAT_STAUS     = :TRWAD.TREAT-STAUS
                     ,ISSUE_TIME      = :TRWAD.ISSUE-TIME
                 WHERE  RCVE_NO_YY    = :TRWAD.RCVE-NO-YY
                 AND    RCVE_NO_TXOFF = :TRWAD.RCVE-NO-TXOFF
                 AND    RCVE_NO_SEQNO = :TRWAD.RCVE-NO-SEQNO

           END-EXEC.

           IF  SQLCODE  =  C-SQL-NORMAL

               CONTINUE

           ELSE

               MOVE  C-ABEND-FG-DB2    TO W-ABEND-FG
               MOVE 'S6200-UPDATE-TRWAD '
                                       TO W-ABEND-SECTION

               PERFORM    S9800-ABEND

           END-IF.

       S6200-UPDATE-TRWAD-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *              S 8 0 0 0 - S T A R T - K A P A 3                 *
      *                                                                *
      ******************************************************************
       S8000-START-JAPA3       SECTION.                                 

           MOVE    TX-SRVC-TP      OF TRWAD   TO RCVE-TX-SRVC-TP.       
           MOVE    RCVE-NO-YY      OF TRWAD   TO H-RCVE-NO-YY.          
           MOVE    RCVE-NO-TXOFF   OF TRWAD   TO H-RCVE-NO-TXOFF.       
           MOVE    RCVE-NO-SEQNO   OF TRWAD   TO H-RCVE-NO-SEQNO.       
           MOVE    RTN-TP          OF TRWAD   TO H-RTN-TP.              
                                                                        
      *{Á˛~⁄÷Ha                                                       
           MOVE    TREAT-STAUS     OF TRWAD   TO H-TREAT-STAUS.         
                                                                        
      *u¨§∞ªz?/                                                       
           MOVE    ISSUE-DT        OF TRWAD   TO H-ISSUE-DT.            
                                                                        
      *ª¶K/?~h?                                                       
           MOVE    EXPIRE-DT       OF TRWAD   TO H-EXPIRE-DT.           
                                                                        
      * ABEND?aπﬂ                                                     
           IF  H-TREAT-STAUS  =  'ZZ' OR '13'                           
               CONTINUE                                                 
           ELSE                                                         
               MOVE    SPACE                  TO H-ERR-DOCU             
           END-IF.                                                      
                                                                        

           MOVE 'JAA3'            TO   W-START-TRN.                     
                                                                        
           EXEC CICS START    TRANSID (W-START-TRN)                     
                              INTERVAL(0)                               
                              FROM    (HTS-AREA)                        
                              LENGTH  (LENGTH OF HTS-AREA)              
                              RESP    (W-RETURN-CODE)                   
           END-EXEC.                                                    

      *    EXEC  CICS WRITEQ    TS       QUEUE('JEPA2Q')
      *                                  FROM(HTS-AREA)
      *                                  END-EXEC.

       S8000-START-JAPA3-EXIT.                                          
           EXIT.                                                        
           EJECT.                                                       
      ******************************************************************
      *                                                                *
      *            S 9 6 0 0 - G E T - S Y S T E M - D A T A           *
      *                                                                *
      ******************************************************************

       S9600-GET-SYSTEM-DATA           SECTION.

           EXEC  CICS  ASKTIME
                       ABSTIME (W-ABSTIME)
           END-EXEC.

           EXEC  CICS  FORMATTIME
                       ABSTIME (W-ABSTIME)
                       YEAR    (W-YEAR)
                       YYMMDD  (W-DATE)
                       TIME    (W-TIME)
                       DATESEP
                       TIMESEP
           END-EXEC.

           MOVE W-YEAR                 TO W-DB2DATE-YEAR.
           MOVE W-DB2DATE-YEAR(1:2)    TO W-CURR-YY1.
           MOVE W-DATE(1:2)            TO W-CURR-YY2.
           MOVE W-DATE(4:2)            TO W-CURR-MM.
           MOVE W-DATE(7:2)            TO W-CURR-DD.

       S9600-GET-SYSTEM-DATA-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *                   S 9 7 0 0 - R E T R I E V E                  *
      *                                                                *
      ******************************************************************

       S9700-RETRIEVE                  SECTION.

           EXEC CICS RETRIEVE         INTO   (W-COMM-AREA-ENG)
                                      LENGTH (LENGTH OF W-COMM-AREA-ENG)
                                      RESP   (W-RETURN-CODE)
           END-EXEC.

      *    EXEC  CICS WRITEQ    TS       QUEUE('JEPA2Q')
      *                                  FROM(W-COMM-AREA-ENG)
      *                                  END-EXEC.

           IF  W-RETURN-NORMAL

               CONTINUE

           ELSE

               MOVE C-ABEND-FG-CICS    TO W-ABEND-FG
               MOVE 'S9700-RETRIEVE '  TO W-ABEND-SECTION

               PERFORM S9800-ABEND

           END-IF.

       S9700-RETRIEVE-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                      S 9 8 0 0 - A B E N D                     *
      *                                                                *
      ******************************************************************

       S9800-ABEND                     SECTION.

           EXEC    CICS   SYNCPOINT
                          ROLLBACK
           END-EXEC.

           IF  W-ABEND-FG-DB2

               MOVE C-ABEND-DB2        TO W-ABEND
               MOVE SQLCODE            TO W-ABEND-CODE

           ELSE

               MOVE C-ABEND-CICS       TO W-ABEND
               MOVE W-RETURN-CODE      TO W-ABEND-CODE

           END-IF.

      * HTS {Á˛~FLOW Bah/
           MOVE   'ZZ'                TO  TREAT-STAUS OF TRWAD.         
           MOVE   W-ABEND-SECTION     TO  H-ERR-DOCU                    
                                          H-BUSNID-DISTR-CS .
           PERFORM S8000-START-JAPA3.                                   
050516     PERFORM S6200-UPDATE-TRWAD.

           PERFORM S9900-RETURN.

       S9800-ABEND-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *                     S 9 9 0 0 - R E T U R N                    *
      *                                                                *
      ******************************************************************

       S9900-RETURN                    SECTION.

           EXEC   CICS   RETURN
           END-EXEC.

       S9900-RETURN-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *              F I N A L   P R O G R A M   C O D I N G           *
      *                                                                *
      *              PROGRAM  ID  :  JEPA2                             *
      *                                                                *
      ******************************************************************
