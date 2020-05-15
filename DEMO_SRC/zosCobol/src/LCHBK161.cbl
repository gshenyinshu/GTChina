      ****************************************************************
      *                                                              *
      *           I D E N T I F I C A T I O N  D I V I S I O N       *
      *                                                              *
      ****************************************************************
       IDENTIFICATION                    DIVISION.

       PROGRAM-ID.                       LCHBK161.
       AUTHOR.                           KIM MAN SIK.
       DATE-WRITTEN.                     2003-09-29.
       DATE-COMPILED.

      ****************************************************************
      *  HANDLER     : �����������Ǵ���޾ף����ϻ���������������  *
      *  DESCRIPTION : ����������������ڷ�͡������������������ -*
      * ����Ǽ�,�ݾ��ڷḦ�������鼭���Ǵ���޾���������SET  -*
      * �Ͽ����������������Ѵ٣���������                           *
      *  TRANSACTION ID : NONE                                       *
      *  JSP       FILE : NONE                                       *
      *  JS        FILE : NONE                                       *
      *  SERVLET   FILE : NONE                                       *
      *  MAIN   PROGRAM : LCHBK161                                   *
      *  SUB    PROGRAM : NONE                                       *
      *                                                              *
      *  TABLE                                                 CRUD  *
      *  ==========================================================  *
      *  LCHD2K14.TK140 (����FACTOR��������                 R    *
      *                                                              *
      *                                                              *
      * ����HISTORY                                                *
      * ��������     CSR��ȣ �۾��� �۾�����                 *
      *  ==========   =========   ======   ========================  *
      *  2003/09/29              �踸�� �����ۼ�                 *
      ****************************************************************

      ****************************************************************
      *                                                              *
      *         E N V I R O N M E N T   D I V I S I O N              *
      *                                                              *
      ****************************************************************
       ENVIRONMENT                       DIVISION.

       INPUT-OUTPUT                      SECTION.

       FILE-CONTROL.

           SELECT  I1-MCHT-FILE          ASSIGN  TO  LCHNC010.

           SELECT  I2-SLIP-FILE          ASSIGN  TO  LCHNC020.

           SELECT  O-MCHT-FILE           ASSIGN  TO  LCHNC030.


      ****************************************************************
      *                                                              *
      *         D A T A                 D I V I S I O N              *
      *                                                              *
      ****************************************************************
       DATA                              DIVISION.

       FILE                              SECTION.

      ****************************************************************
      *                                                              *
      *     I1-MCHT-FILE                          DDNAME - LCHNC010  *
      *                                                              *
      * -�ش��������������������������          ��              *
      *                                                              *
      ****************************************************************
       FD  I1-MCHT-FILE

           RECORDING  MODE           IS  F
��       RECORD     CONTAINS       50  CHARACTERS
           BLOCK      CONTAINS        0  RECORDS
           LABEL      RECORDS       ARE  STANDARD
           DATA       RECORD         IS  I1-MCHT-REC.

       01  I1-MCHT-REC.
      *��������ȣ
           05  I1-MCHT-MCHT-N            PIC  X(10).
           05  FILLER                    PIC  X(40).

      ****************************************************************
      *                                                              *
      *     I2-SLIP-FILE                          DDNAME - LCHNC020  *
      *                                                              *
      * -�ش�����������ǡ���ްǼ��ס��ݾ�����                    *
      *                                                              *
      ****************************************************************
       FD  I2-SLIP-FILE

           RECORDING  MODE           IS  F
��       RECORD     CONTAINS       24  CHARACTERS
           BLOCK      CONTAINS        0  RECORDS
           LABEL      RECORDS       ARE  STANDARD
           DATA       RECORD         IS  I2-SLIP-REC.

       01  I2-SLIP-REC.
      *��������ȣ
           05  I2-SLIP-MCHT-N            PIC  X(10).
      *����Ǽ�
           05  I2-SLIP-CNT               PIC  9(07).
      *����ݾ�
           05  I2-SLIP-AMT               PIC S9(13)  COMP-3.

      ****************************************************************
      *                                                              *
      *     O-MCHT-FILE                           DDNAME - LCHNC030  *
      *                                                              *
      * -�����������Ǵ���޾ף�              ������              *
      *                                                              *
      ****************************************************************
       FD  O-MCHT-FILE

           RECORDING  MODE           IS  F
           RECORD     CONTAINS       35  CHARACTERS
           BLOCK      CONTAINS        0  RECORDS
           LABEL      RECORDS       ARE  STANDARD
           DATA       RECORD         IS  O-MCHT-REC.

           COPY  LCHYK1B2.


      ****************************************************************
      *                                                              *
      *         W O R K I N G - S T O R A G E  S E C T I O N         *
      *                                                              *
      ****************************************************************
       WORKING-STORAGE                   SECTION.

       01  WS-BEGIN                      PIC  X(40)  VALUE
           'LCHBK161 - WORKING STORAGE BEGINS HERE'.

      ****************************************************************
      *                                                              *
      *    U S E R - A B E N D S                                     *
      *                                                              *
      ****************************************************************
       01  USER-ABENDS.

           05  U-ABEND-CODE              PIC S9(04)  VALUE +2001.

      ****************************************************************
      *                                                              *
      *                  A C C U M U L A T O R S                     *
      *                                                              *
      ****************************************************************
       01  ACCUMULATORS.

           05  A-INPUT-1-READ-CNT      PIC  9(09)  VALUE  0.
           05  A-INPUT-2-READ-CNT      PIC  9(09)  VALUE  0.
           05  A-WRITE-OUTPUT-CNT      PIC  9(09)  VALUE  0.
           05  A-ERROR-CNT             PIC  9(09)  VALUE  0.

      ****************************************************************
      *                                                              *
      *                  C O N S T A N T S                           *
      *                                                              *
      ****************************************************************
       01  CONSTANTS.

           05  C-PROG-ID                 PIC  X(08)  VALUE 'LCHBK161'.
           05  C-MAX-CNT                 PIC  9(02)  VALUE  10.
           05  C-BSNO                    PIC  X(02)  VALUE '06'.

      ****************************************************************
      *                                                              *
      *                    S W I T C H E S                           *
      *                                                              *
      ****************************************************************
       01  SWITCHES.

           05  S-END-OF-FILE-1           PIC  X(01) VALUE LOW-VALUES.
               88  S-NO-MORE-RECORDS-1              VALUE HIGH-VALUES.

           05  S-END-OF-FILE-2           PIC  X(01) VALUE LOW-VALUES.
               88  S-NO-MORE-RECORDS-2              VALUE HIGH-VALUES.

           05  S-END-OF-TK140            PIC  X(01) VALUE LOW-VALUES.
               88  S-NO-MORE-TK140                  VALUE HIGH-VALUES.

           05  S-AMT-SW                  PIC  X(01) VALUE LOW-VALUES.
               88  S-AMT-FOUND                      VALUE HIGH-VALUES.

      ****************************************************************
      *                                                              *
      *            W O R K   A R E A S                               *
      *                                                              *
      ****************************************************************
       01  WORK-AREAS.
           05  W-QUOTIENT                PIC S9(09)  COMP-3 VALUE +0.
           05  W-REMAINDER               PIC S9(09)  COMP-3 VALUE +0.
               88  W-REMAINDER-ZERO                  VALUE +0.

           05  W-COMMIT-FLG              PIC  X(01)  VALUE SPACE.
           05  W-SYSIN-YYMM.
               10  W-SYSIN-YYYY          PIC  9(04)  VALUE ZEROS.
               10  W-SYSIN-MM            PIC  9(02)  VALUE ZEROS.

           05  W-BS-SC                   PIC S9(03)  COMP-3 VALUE +0.
           05  W-I                       PIC  9(02)  VALUE ZEROS.

           05  W-SLS-CNT                 PIC S9(07)  COMP-3 VALUE +0.
           05  W-SLS-AMT                 PIC S9(13)  COMP-3 VALUE +0.
           05  W-WK-AMT                  PIC S9(13)  COMP-3 VALUE +0.

           05  W-DIS-AMT                 PIC -Z(12)9.
           05  W-DIS-BS                  PIC -ZZ9.
           05  W-DIS-M-CNT               PIC -Z,ZZ,ZZ9.

           05  W-BS06-CNT                PIC  9(02)  VALUE  ZEROS.

           05  W-BS06-TABLE.

               10  W-BS06-OCC  OCCURS  10 TIMES.

                   15  W-BS06-SLS-AMT    PIC S9(10).
                   15  W-BS06-SC         PIC S9(03).
                   15  W-BS06-M-CNT      PIC S9(07) COMP-3.

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
           EXEC  SQL  INCLUDE  SQLCA  END-EXEC.

      ****************************************************************
      *    TK140 (����FACTOR����������                           *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCHYK140  END-EXEC.


      ****************************************************************
      *    LCHYK1B1 ��FACTOR���������ǡ�LAYOUT)                  *
      ****************************************************************
           COPY  LCHYK1B1.


      ****************************************************************
      *                                                              *
      *                   C U R S O R S                              *
      *                                                            *
      ****************************************************************
      ****************************************************************
      *    CURSOR_HK14_1  ��������FACTOR������������������������ *
      ****************************************************************
           EXEC  SQL
                 DECLARE  CURSOR_HK14_1  CURSOR  FOR

                  SELECT  ITM_TXT
                       ,  BHV_POST_PNT

                    FROM  LCHD2K14.TK140
                   WHERE  BHV_ITM_CD  =  :C-BSNO

                   ORDER  BY  SUBSTR(ITM_TXT,1,1)  ASC
                       ,      ITM_TXT              DESC
                     FOR  FETCH  ONLY
           END-EXEC.

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
      *01  TABLES.

      ****************************************************************
      *                                                              *
      *    E N D    O F   W O R K I N G - S T O R A G E              *
      *                                                              *
      ****************************************************************
       01  WS-END                        PIC  X(40) VALUE
           'LCHBK161 - WORKING STORAGE ENDS HERE'.

      ****************************************************************
      *                                                              *
      *        P R O C E D U R E  D I V I S I O N                    *
      *                                                              *
      ****************************************************************
       PROCEDURE                         DIVISION.
       
        PERFORM EXECUTEPRG.
       
        EXECUTEPRG.
          PERFORM INITIALIZATION
          
          DISPLAY "END PROGRAM"
          
          PERFORM FINALIZATION.

      *==============================================================*
      *                                                              *
      *            S T A R T    B I Z   H A N D L E R                *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *          I N I T I A L Z A T I O N                           *
      *                                                              *
      * 1 �ʱ�ȭ���������Ѵ١���������������������������           *
      *                                                              *
      ****************************************************************
       INITIALIZATION                    SECTION.

           INITIALIZE  WORK-AREAS  ACCUMULATORS.

           MOVE      'Y'                 TO  STRT-BOCOM-ERR-TYPE.
           MOVE      C-PROG-ID           TO  STRT-BOCOM-ERR-PROG.

           PERFORM  S0300-OPEN-FILE.

           PERFORM  S0100-ACCEPT-RTN.

      ****************************************************************
      *                                                              *
      *             M A I N L I N E                                  *
      *                                                              *
      * 1 �Է��ڷḦ�������鼭���ش�������������Ǵ����ס�������-*
      *   �������������Ѵ�                                         *
      *                                                              *
      ****************************************************************
       MAINLINE                          SECTION.

       
           PERFORM  S0400-READ-INPUT-FILE-1.
           PERFORM  S0500-READ-INPUT-FILE-2.

           PERFORM  S0900-PROCESS-RTN    UNTIL  S-NO-MORE-RECORDS-1.

           MOVE      'N'                 TO  STRT-BOCOM-ERR-TYPE.

      ****************************************************************
      *                                                              *
      *             F I N A L I Z A T I O N                          *
      *                                                              *
      * 1 ���α׷����������Ѵ١����������������������������������� *
      *                                                              *
      ****************************************************************
       FINALIZATION                    SECTION.

           PERFORM  S1400-DISPLAY-RESULT.

           IF  STRT-BOCOM-ERR-TYPE  NOT = 'N'
               PERFORM  S1300-DISPLAY-ERRMSG
               MOVE     U-ABEND-CODE     TO  RETURN-CODE
           ELSE
               MOVE     +0000            TO  RETURN-CODE
           END-IF.

           PERFORM  S1200-CLOSE-FILE.

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
      ****************************************************************
      *                                                              *
      *            S0100-ACCEPT-RTN                                  *
      *                                                              *
      * 1  TK140(����FACTOR������������FETCH�ϸ鼭           *
      *   �׸��ڵ�'06'���ش��ϴ¡����ذ��������迭�����ִ´�     *
      *                                                              *
      ****************************************************************
       S0100-ACCEPT-RTN                  SECTION.

           PERFORM   VARYING W-I FROM 1 BY 1
                     UNTIL   W-I > 10
               MOVE  ZEROS               TO  W-BS06-SLS-AMT(W-I)
               MOVE  +0                  TO  W-BS06-SC     (W-I)
                                             W-BS06-M-CNT  (W-I)
           END-PERFORM.

           MOVE  0                       TO  W-I.


           PERFORM  S0600-OPEN-TK140.

           PERFORM  S0700-FETCH-TK140.
           PERFORM  S0200-MOVE-FACTORS
                    UNTIL  S-NO-MORE-TK140
                       OR  W-I  >  C-MAX-CNT.

           PERFORM  S0800-CLOSE-TK140.

       S0100-ACCEPT-RTN-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *            S0200-MOVE-FACTORS                                *
      *                                                              *
      * 1 �׸��ڵ�'06' �ش��ϴ¡����ذ��������迭�����ִ´�      *
      *                                                              *
      ****************************************************************
       S0200-MOVE-FACTORS                SECTION.

           INITIALIZE  LCHYK1B1.

           MOVE  HK14-ITM-TXT            TO  K1B1-DATA.

           ADD   1                       TO  W-I.
           MOVE  W-I                     TO  W-BS06-CNT.

           MOVE  K1B1-SLS-PER-AMT        TO  W-BS06-SLS-AMT(W-I).
           MOVE  HK14-BHV-POST-PNT       TO  W-BS06-SC     (W-I).

           IF  K1B1-SLS-SIGN       =     '-'

               COMPUTE    W-BS06-SLS-AMT(W-I)     =
                          W-BS06-SLS-AMT(W-I) * -1
           END-IF.

           PERFORM S0700-FETCH-TK140.

       S0200-MOVE-FACTORS-EXIT.
           EXIT.


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
      *               S0300-OPEN-FILE                                *
      *                                                              *
      * 1.����ϴ�SAM FILE��OPEN�Ѵ�.                          *
      *                                                              *
      ****************************************************************
       S0300-OPEN-FILE                   SECTION.

           OPEN  INPUT      I1-MCHT-FILE
                            I2-SLIP-FILE
                 OUTPUT     O-MCHT-FILE.

       S0300-OPEN-FILE-EXIT.
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
      *        S0400-READ-INPUT-FILE-1                               *
      *                                                              *
      * 1.������������������������д´١���                       *
      *                                                              *
      ****************************************************************
       S0400-READ-INPUT-FILE-1           SECTION.

           READ  I1-MCHT-FILE            AT  END
                 MOVE  HIGH-VALUES       TO  S-END-OF-FILE-1
                 GO                      TO
                                         S0400-READ-INPUT-FILE-1-EXIT
           END-READ.

           ADD   +1                      TO  A-INPUT-1-READ-CNT.

           DIVIDE  A-INPUT-1-READ-CNT    BY +10000
                                         GIVING    W-QUOTIENT
                                         REMAINDER W-REMAINDER.

           IF  W-REMAINDER-ZERO
               DISPLAY 'LCHBK161 - I1-MCHT-FILE READ COUNT : '
                                         A-INPUT-1-READ-CNT
           ELSE
               CONTINUE
           END-IF.

       S0400-READ-INPUT-FILE-1-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *        S0500-READ-INPUT-FILE-2                               *
      *                                                              *
      * 1.�����������ش��������Ǽ��ױݾ����������д´�           *
      *                                                              *
      ****************************************************************
       S0500-READ-INPUT-FILE-2           SECTION.

           READ  I2-SLIP-FILE            AT  END
                 MOVE  HIGH-VALUES       TO  S-END-OF-FILE-2
                 GO                      TO
                                         S0500-READ-INPUT-FILE-2-EXIT
           END-READ.

           ADD   +1                      TO  A-INPUT-2-READ-CNT.

           DIVIDE  A-INPUT-2-READ-CNT    BY +10000
                                         GIVING    W-QUOTIENT
                                         REMAINDER W-REMAINDER.

           IF  W-REMAINDER-ZERO
               DISPLAY 'LCHBK161 - I2-SLIP-FILE READ COUNT : '
                                         A-INPUT-2-READ-CNT
           ELSE
               CONTINUE
           END-IF.

       S0500-READ-INPUT-FILE-2-EXIT.
           EXIT.


      *==============================================================*
      *                                                              *
      *                   E N D    I N P U T   R E A D               *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T   Ÿ���ý���  D B ��ȸ             *
      *                                                              *
      *==============================================================*
      *NONE
      *==============================================================*
      *                                                              *
      *                 E N D   Ÿ���ý���  D B ��ȸ             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *           S T A R T   �ش硡�ý���  D B ��ȸ             *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *           S0600-OPEN-TK140                                   *
      *                                                              *
      *  TK140 ( ����FACTOR����������                            *
      * Ŀ������OPEN�Ѵ١���                                     *
      *                                                              *
      ****************************************************************
       S0600-OPEN-TK140                  SECTION.

           INITIALIZE  LCHTK140.

           EXEC  SQL
                 OPEN  CURSOR_HK14_1
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  000
                     CONTINUE

               WHEN  OTHER
                     MOVE  'Y'           TO  STRT-BOCOM-ERR-TYPE
                     MOVE  'S0600'       TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE  'TK140'       TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE  'OPEN'        TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE       TO  STRT-BOCOM-ERR-STATUS
                     MOVE  C-BSNO        TO  STRT-BOCOM-ERR-DATA
                     MOVE  'R'           TO  W-COMMIT-FLG
                     GO                  TO  FINALIZATION

           END-EVALUATE.

       S0600-OPEN-TK140-EXIT.
           EXIT.


      ****************************************************************
      *                                                              *
      *           SS0700-FETCH-TK140                                 *
      *                                                              *
      * ���� RECORD ����FETCH �Ѵ�                             *
      *                                                              *
      ****************************************************************
       S0700-FETCH-TK140                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_HK14_1
                  INTO  :HK14-ITM-TXT
                     ,  :HK14-BHV-POST-PNT
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  000
                     CONTINUE

               WHEN  +100
                     MOVE  HIGH-VALUE    TO  S-END-OF-TK140

               WHEN  OTHER
                     MOVE  'Y'           TO  STRT-BOCOM-ERR-TYPE
                     MOVE  'S0700'       TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE  'TK140'       TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE  'FETCH'       TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE       TO  STRT-BOCOM-ERR-STATUS
                     MOVE  C-BSNO        TO  STRT-BOCOM-ERR-DATA
                     MOVE  'R'           TO  W-COMMIT-FLG
                     GO                  TO  FINALIZATION

           END-EVALUATE.

       S0700-FETCH-TK140-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *           S0800-CLOSE-TK140                                  *
      *                                                              *
      * Ŀ����CLOSE �Ѵ١���                                     *
      *                                                              *
      ****************************************************************
       S0800-CLOSE-TK140                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_HK14_1
           END-EXEC.

           IF  SQLCODE  =  000
               CONTINUE
           ELSE
               MOVE  'Y'                 TO  STRT-BOCOM-ERR-TYPE
               MOVE  'S0700'             TO  STRT-BOCOM-ERR-PARAGRAPH
               MOVE  'TK140'             TO  STRT-BOCOM-ERR-TBLNAME
               MOVE  'CLOSE'             TO  STRT-BOCOM-ERR-FUNC
               MOVE  SQLCODE             TO  STRT-BOCOM-ERR-STATUS
               GO                        TO  FINALIZATION
           END-IF.

       S0800-CLOSE-TK140-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *               E N D   �ش硡�ý���  D B ��ȸ             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *          S T A R T    B U S I N E S S   L O G I C            *
      *                                                              *
      *==============================================================*

      ****************************************************************
      *                                                              *
      *         S0900-PROCESS-RTN                                    *
      *                                                              *
      * 1 �ش�����������ϰ������������������������ϡ����񱳡���   *
      *                                                              *
      *    I1-MCHT-MCHT-N  =   I2-SLIP-MCHT-N                        *
      *      : �Ǵ����ס�����������SET�ϰ�WRITE�Ѵ�          *
      *      : �����������ڷᡡ����RECORD�����д´�              *
      *      : ������⡡�ڷᡡ����RECORD�����д´�              *
      *                                                              *
      *    I1-MCHT-MCHT-N  >   I2-SLIP-MCHT-N                        *
      *      : ������⡡�ڷᡡ����RECORD�����д´�              *
      *                                                              *
      *    I1-MCHT-MCHT-N  <   I2-SLIP-MCHT-N                        *
      *      : �Ǵ�����'0'��SET�ϰ�WRITE�Ѵ�               *
      *      : �����������ڷᡡ����RECORD�����д´�              *
      *                                                              *
      ****************************************************************
       S0900-PROCESS-RTN                 SECTION.

           EVALUATE TRUE

               WHEN I1-MCHT-MCHT-N  =   I2-SLIP-MCHT-N

                    MOVE  I2-SLIP-AMT    TO  W-SLS-AMT
                    MOVE  I2-SLIP-CNT    TO  W-SLS-CNT

                    PERFORM  S1000-CHECK-AMT
                    PERFORM  S1100-WRITE-OUTPUT

                    PERFORM  S0400-READ-INPUT-FILE-1

               WHEN I1-MCHT-MCHT-N  >   I2-SLIP-MCHT-N

                    PERFORM  S0500-READ-INPUT-FILE-2

               WHEN OTHER

                    MOVE  +0             TO  W-SLS-AMT
                                             W-SLS-CNT

                    PERFORM  S1000-CHECK-AMT
                    PERFORM  S1100-WRITE-OUTPUT

                    PERFORM  S0400-READ-INPUT-FILE-1

           END-EVALUATE.


       S0900-PROCESS-RTN-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *         S1000-CHECK-AMT                                      *
      *                                                              *
      * 1 ����ס��Ը𿡡��ش��ϴ¡������������������Ѵ�          -*
      *                                                              *
      ****************************************************************
       S1000-CHECK-AMT                   SECTION.

           IF  W-SLS-CNT  >  0

               COMPUTE   W-WK-AMT  =  W-SLS-AMT / W-SLS-CNT
           ELSE
               MOVE       +0             TO  W-WK-AMT
           END-IF.

           MOVE      LOW-VALUE           TO  S-AMT-SW.
           MOVE      +0                  TO  W-BS-SC.

           PERFORM   VARYING  W-I FROM  1  BY  1
                       UNTIL  W-I >  W-BS06-CNT
                          OR  W-I >  10
                          OR  S-AMT-FOUND

               IF  W-WK-AMT         >=       W-BS06-SLS-AMT(W-I)

                   MOVE  W-BS06-SC(W-I)      TO  W-BS-SC
                   MOVE  HIGH-VALUES         TO  S-AMT-SW
                   ADD   +1                  TO  W-BS06-M-CNT(W-I)
               END-IF

           END-PERFORM.

           IF  W-WK-AMT    <  +0
               DISPLAY 'MINUS MCHT ==> ' I1-MCHT-MCHT-N ' ' W-WK-AMT.

       S1000-CHECK-AMT-EXIT.
           EXIT.
      *==============================================================*
      *                                                              *
      *              E N D    B U S I N E S S   L O G I C            *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *           S T A R T   �ش硡�ý���  D B �ݿ�             *
      *                                                              *
      *==============================================================*
      *NONE
      *==============================================================*
      *                                                              *
      *               E N D   �ش硡�ý���  D B �ݿ�             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T   Ÿ���ý���  D B �ݿ�             *
      *                                                              *
      *==============================================================*
      *NONE
      *==============================================================*
      *                                                              *
      *                 E N D   Ÿ���ý���  D B �ݿ�             *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T    O U T P U T   W R I T E             *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *               S1100-WRITE-OUTPUT                             *
      *                                                              *
      * 1.����ȡ�����SAM FILE��MOVE�ϰ�WRITE�Ѵ٣�          *
      *                                                              *
      ****************************************************************
       S1100-WRITE-OUTPUT                SECTION.

           INITIALIZE  LCHYK1B2.

           MOVE  I1-MCHT-MCHT-N          TO  K1B2-MCHT-N.
           MOVE  C-BSNO                  TO  K1B2-BS-NO.
           MOVE  W-WK-AMT                TO  K1B2-SLS-PER-AMT.
           MOVE  W-BS-SC                 TO  K1B2-BS-SC.

           WRITE LCHYK1B2.

           ADD   +1                      TO A-WRITE-OUTPUT-CNT.

       S1100-WRITE-OUTPUT-EXIT.
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
      *               S1200-CLOSE-FILE                               *
      *                                                              *
      * 1.�����SAM FILE��CLOSE�Ѵ�.                           *
      *                                                              *
      ****************************************************************
       S1200-CLOSE-FILE                  SECTION.

           CLOSE  I1-MCHT-FILE
                  I2-SLIP-FILE
                  O-MCHT-FILE.

       S1200-CLOSE-FILE-EXIT.
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
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *            S1300-DISPLAY-ERRMSG                              *
      *                                                              *
      * 1 DISPLAY ERROR MESSAGE.                                     *
      *                                                              *
      ****************************************************************
       S1300-DISPLAY-ERRMSG              SECTION.

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

       S1300-DISPLAY-ERRMSG-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *               S1400-DISPLAY-RESULT                           *
      *                                                              *
      * 1.�����������Ѵ� .                                       *
      *                                                              *
      ****************************************************************
       S1400-DISPLAY-RESULT              SECTION.

           DISPLAY  '*****  LCHBK161  WORK  RESULT  *****'.
           DISPLAY  ' INPUT-1  READ  COUNT  :' A-INPUT-1-READ-CNT .
           DISPLAY  ' INPUT-2  READ  COUNT  :' A-INPUT-2-READ-CNT .
           DISPLAY  ' OUTPUT WRITE   COUNT  :' A-WRITE-OUTPUT-CNT.
           DISPLAY  '************************************ '.
           DISPLAY '========================================='.
           DISPLAY '     AUTH AMT (>=)   BS SCR    MCHT-CNT      '.
           DISPLAY '========================================='.

           PERFORM   VARYING  W-I  FROM  1  BY  1
                       UNTIL  W-I  >  W-BS06-CNT

               MOVE    W-BS06-SLS-AMT(W-I)   TO  W-DIS-AMT
               MOVE    W-BS06-SC     (W-I)   TO  W-DIS-BS
               MOVE    W-BS06-M-CNT  (W-I)   TO  W-DIS-M-CNT
               DISPLAY  W-DIS-AMT   '        '
                       W-DIS-BS '    ' W-DIS-M-CNT
           END-PERFORM.

           DISPLAY '========================================='.


       S1400-DISPLAY-RESULT-EXIT.
           EXIT.
      *==============================================================*
      *                                                              *
      *                 E N D    R E S U L T   D I S P L A Y         *
      *                                                              *
      *==============================================================*

