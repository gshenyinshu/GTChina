      ****************************************************************
      *                                                              *
      *    I D E N T I F I C A T I O N   D I V I S I O N             *
      *                                                              *
      ****************************************************************
       IDENTIFICATION                    DIVISION.
       PROGRAM-ID.                       LCBPP94C.
       AUTHOR.                           FNS.
       INSTALLATION.                     ITPlus.
       DATE-WRITTEN.                     2003.09.03.
       DATE-COMPILED.

      ****************************************************************
      *  HANDLER     :mzE~p/  vi/{7  iE~                     *
      *  DESCRIPTION :mzE~p/a  vi/{7  a  ~K}/i~,     *
      *               hVv  v,vB~,u,uB~       *
      *               a}p}m/.(~u  ~})                 *
      *                                                              *
      *  TRANSACTION ID : BP94                                       *
      *  JSP       FILE : LCBPP940.JSP                               *
      *  JS        FILE : LCBPP940.JS                                *
      *  SERVLET   FILE : LCBPP94.JAVA                               *
      *  MAIN   PROGRAM : LCBPP94C                                   *
      *  SUB    PROGRAM : NONE                                       *
      *                                                              *
      *  TABLE                                           CRUD        *
      *  ==========================================================  *
      *  LCBD2P42.TP420 : mzE~p/  vi/{7a        RU         *
      *  LCBD2P43.TP430 : mzE~p/  ~ss                R          *
      *  LCBD2P44.TP440 : mzE~p/  Vma            R          *
      *  LCED2OG0.TOG00 : iI~/v                    R          *
      *  LCED24G0.T4GB0 : v//v7v~                  R          *
      *  SYSIBM.SYSTABLES  : DB2 CATALOG(TABLE INFO)      R          *
      *  SYSIBM.SYSCOLUMNS : DB2 CATALOG(COLUMN INFO)     R          *
      *                                                              *
      * viHISTORY                                                *
      * viz/    CSRuVJ~    3/    3a                *
      *  ==========   =========   ======   ========================  *
      *  2003/09/03              ~Be    BA~7                *
      *  2004/08/10              uJ~~    3jE~p/a  v,  *
      *                                    u  ~  A~/iA  *
      *                                    iEiEia  JBv&    *
      ****************************************************************

      ****************************************************************
      *                                                              *
      *    E N V I R O N M E N T   D I V I S I O N                   *
      *                                                              *
      ****************************************************************
       ENVIRONMENT                       DIVISION.

      ****************************************************************
      *                                                              *
      *    D A T A   D I V I S I O N                                 *
      *                                                              *
      ****************************************************************
       DATA                              DIVISION.

      ****************************************************************
      *                                                              *
      *    W O R K I N G - S T O R A G E   S E C T I O N             *
      *                                                              *
      ****************************************************************
       WORKING-STORAGE                   SECTION.

       01  WS-START                      PIC  X(040)  VALUE
           'LCBPP94C-WORKING STORAGE BEGINS HERE'.
      *--------------------------------------------------------------*
      *    S Q L C A                                                 *
      *--------------------------------------------------------------*
           EXEC  SQL   INCLUDE   SQLCA       END-EXEC.
      *--------------------------------------------------------------*
      *    LCBD2P42.TP420 :mzE~p/vi/{7                        *
      *--------------------------------------------------------------*
           EXEC  SQL   INCLUDE   LCBYP420    END-EXEC.
      *--------------------------------------------------------------*
      *    LCBD2P43.TP430 :mzE~p/~ss                            *
      *--------------------------------------------------------------*
           EXEC  SQL   INCLUDE   LCBYP430    END-EXEC.
      *--------------------------------------------------------------*
      *    LCED2OG0.TOG00(iI~/v)
      *--------------------------------------------------------------*
           EXEC  SQL   INCLUDE  LCEY0G00     END-EXEC.

      *--------------------------------------------------------------*
      *    LCED24G0.T4GB0(v//v7v~)
      *--------------------------------------------------------------*
           EXEC  SQL  INCLUDE  LCEY4GB0    END-EXEC.

      *--------------------------------------------------------------*
      *    C O N S T A N T S                                         *
      *--------------------------------------------------------------*
       01  CONSTANTS.
           05  C-COUNT               PIC  9(02) VALUE 10.
           05  C-PROG-ID             PIC  X(08) VALUE 'LCBPP94C'.

           05  C-LCBSPAB1            PIC  X(08) VALUE 'LCBSPAB1'.
           05  C-LCBSPAB2            PIC  X(08) VALUE 'LCBSPAB2'.
           05  C-LCH                 PIC  X(03) VALUE 'LCH'.
           05  C-LCF                 PIC  X(03) VALUE 'LCF'.
           05  C-LCE                 PIC  X(03) VALUE 'LCE'.
           05  C-LCB                 PIC  X(03) VALUE 'LCB'.
           05  C-LCBY                PIC  X(05) VALUE 'LCBTY'.
      *--------------------------------------------------------------*
      *    W O R K   A R E A S                                       *
      *--------------------------------------------------------------*
       01  WORK-AREAS.
           05  W-SYSTEM-DATE.
               10  W-SYSTEM-YEAR        PIC  X(04)  VALUE SPACE.
               10  W-SYSTEM-MON         PIC  X(02)  VALUE SPACE.
               10  W-SYSTEM-DAY         PIC  X(02)  VALUE SPACE.
           05  W-SYSTEM-TIME.
               10  W-SYSTEM-HH          PIC  X(02)  VALUE SPACE.
               10  W-SYSTEM-MM          PIC  X(02)  VALUE SPACE.
               10  W-SYSTEM-SS          PIC  X(02)  VALUE SPACE.
           05  W-SUB-PGM                PIC  X(08)  VALUE SPACE.
           05  W-SYS-CNT                PIC  S9(02)V COMP-3 VALUE +0.

           05  W-II                     PIC  9(03)  VALUE 0.
           05  W-JJ                     PIC  9(03)  VALUE 0.
           05  W-KK                     PIC  9(03)  VALUE 0.
           05  W-POS                    PIC  9(03)  VALUE 0.
           05  W-SIZE                   PIC  9(03)  VALUE 0.
           05  W-DEC-X                  PIC  X(08)
                                        VALUE X'0000000000000000'.
           05  W-DEC-X-R0   REDEFINES   W-DEC-X.
               07  W-DEC-9              PIC S9(15)  COMP-3.
           05  W-DEC-X-R1   REDEFINES   W-DEC-X.
               07  W-DEC-9V9            PIC S9(14)V9 COMP-3.
           05  W-DEC-X-R2   REDEFINES   W-DEC-X.
               07  W-DEC-9V99           PIC S9(13)V99 COMP-3.
           05  W-DEC-X-R3   REDEFINES   W-DEC-X.
               07  W-DEC-9V999          PIC S9(12)V999 COMP-3.
           05  W-DEC-X-R4   REDEFINES   W-DEC-X.
               07  W-DEC-9V9999         PIC S9(11)V9999 COMP-3.

           05  W-DEC-EDIT-0             PIC -(15)9.
           05  W-DEC-EDIT-1             PIC -(14)9.9.
           05  W-DEC-EDIT-2             PIC -(13)9.99.
           05  W-DEC-EDIT-3             PIC -(12)9.999.
           05  W-DEC-EDIT-4             PIC -(11)9.9999.
           05  W-DEC-EDIT-5             PIC -(10)9.99999.

           05  W-SINT-X                 PIC  X(02)  VALUE X'0000'.
           05  W-SINT-X-R   REDEFINES   W-SINT-X.
               07  W-SINT-9             PIC S9(04)  COMP.
           05  W-SINT-EDIT              PIC ----9.
           05  W-INT-X                  PIC  X(04)  VALUE X'00000000'.
           05  W-INT-X-R    REDEFINES   W-INT-X.
               07  W-INT-9              PIC S9(09)  COMP.
           05  W-INT-EDIT               PIC -(08)9.
           05  W-CHAR                   PIC  X(70)  VALUE SPACE.
           05  END-SW                   PIC  X(01)  VALUE SPACES.
           05  W-LEN                    PIC  9(03)  VALUE 0.
           05  W-WORD-TEXT              PIC  X(100).
           05  W-CALL-PGM               PIC  X(08).
      *---- KSCONV !!!
           05  W-IN-REC                  PIC  X(500).
           05  W-OUT-REC                 PIC  X(500).
           05  W-IN-LENG                 PIC S9(04) COMP.
           05  W-OUT-LENG                PIC S9(04) COMP.
           05  W-DIR                     PIC  X(01).
           05  W-RTCD                    PIC  X(02).
       01  W-SQL-AREA.
           05  W-SQL-TXT                PIC  X(06)  VALUE 'SQLCD-'.
           05  W-SQLCODE                PIC  ---9.

      ****************************************************************
      *    USERAREA : 4000 (1997 + 3)                                *
      ****************************************************************
       01  USERAREA.
            05 L-CONDITION.
               10  L-C-REQ-D                          PIC  X(008).
               10  L-C-REQ-SEQ-N                      PIC  X(003).
               10  L-C-CD-TBL-ID                      PIC  X(008).
               10  L-C-ALNC-MM                        PIC  X(150).
               10  L-C-IMD-POST-F                     PIC  X(001).
            05  L-SINGLE.
               10  L-S-TBL-NM                         PIC  X(030).
               10  L-S-REQ-TM                         PIC  X(006).
               10  L-S-REQ-K-ID                       PIC  X(008).
               10  L-S-ALNC-D                         PIC  X(008).
               10  L-S-ALNC-TM                        PIC  X(006).
               10  L-S-ALNC-K-ID                      PIC  X(008).
               10  L-S-RTN-D                          PIC  X(008).
               10  L-S-RTN-TM                         PIC  X(006).
               10  L-S-RTN-K-ID                       PIC  X(008).
               10  L-S-EFT-D                          PIC  X(008).
               10  L-S-EFT-TM                         PIC  X(006).
               10  L-S-REQ-EFT-D                      PIC  X(008).
               10  L-S-LINE-N                         PIC  9(002).
               10  L-S-SEND-MAIL-ID                   PIC  X(020).
               10  L-S-RECV-MAIL-ID                   PIC  X(020).
            05 L-MULTI.
               10  L-MULTI-ARRAY                      OCCURS 10.
                   15  L-M-COL                        PIC  X(030).
                   15  L-M-TYPE                       PIC  X(008).
                   15  L-M-LEN                        PIC  X(004).
                   15  L-M-BF                         PIC  X(070).
                   15  L-M-AF                         PIC  X(070).
                   15  L-M-CHD                        PIC  X(001).
            05  L-NEXT.
                10  L-N-COLNO                         PIC  9(003).
                10  L-N-POS                           PIC  9(003).
                10  L-N-SIZE                          PIC  9(003).
            05  L-FILLER.
                10  FILLER                            PIC X(1839).


      *    EXEC  SQL  BEGIN  DECLARE  SECTION  END-EXEC.

       01  HOST-AREAS.
           05  H-CD-TBL-ID              PIC  X(08).
           05  H-SYSTEM-D               PIC  X(08).
           05  H-SYSTEM-T               PIC  X(06).
           05  W-CD-TBL-ID              PIC  X(08).
           05  H-COLNO                  PIC S9(04)  COMP.
           05  W-COLNO                  PIC S9(04)  COMP.
           05  H-CREATOR                PIC  X(08).
           05  H-TBCREATOR              PIC  X(08).
           05  H-TBNAME                 PIC  X(18).
           05  H-NAME                   PIC  X(18).
           05  H-REMARKS                PIC  X(254).
           05  H-COLTYPE                PIC  X(08).
           05  H-LENGTH                 PIC S9(04)  COMP.
           05  H-SCALE                  PIC S9(04)  COMP.

      *    EXEC  SQL  END  DECLARE  SECTION  END-EXEC.

      *--------------------------------------------------------------*
      *        SYSIBM.SYSCOLUMNS CURSORVV                        *
      *--------------------------------------------------------------*
           EXEC  SQL
                 DECLARE  CURSOR_SYSCOLS
                 CURSOR   WITH HOLD FOR
                 SELECT   COLNO
                      ,   NAME
                      ,   REMARKS
                      ,   COLTYPE
                      ,   LENGTH
                      ,   SCALE
                   FROM   SYSIBM.SYSCOLUMNS
                  WHERE   TBCREATOR = :H-TBCREATOR
                    AND   TBNAME    = :H-TBNAME
                    AND   COLNO    >= :W-COLNO
               ORDER BY   COLNO
               OPTIMIZE   FOR 01 ROWS
                    FOR   FETCH  ONLY
                   WITH   UR
           END-EXEC.
      *
      ****************************************************************
      *                                                              *
      *    P A R A M E T E R S                                       *
      *                                                              *
      ****************************************************************
      ****************************************************************  
      *  LCBSPAA0 (mzE~p/  vau)HOST SYSTEM CALL      *  01
      ****************************************************************  
       01  LCBSPAA0-PARM.                                               
         02  LCBSPAA0-STRTAREA.                                         
           REPLACE  == (BNCS) ==     BY  == PAA0 ==.                    
           COPY  LCBYBSYH.                                              
           COPY  LCBYBHDR.                                              
           COPY  LCBYBICO.                                              
           COPY  LCBYBOCO.                                              
           REPLACE OFF.                                                 
                                                                        
         02  LCBSPAA0-USERAREA.                                         
           COPY  LCBYPAA0.                                              

      ****************************************************************  
      *  LCBSPAB1 (H/~/I  V SUB CALL AREA )                     
      ****************************************************************  
       01  LCBSPAB1-PARM.                                               
         02  LCBSPAB1-STRTAREA.                                         
           REPLACE  == (BNCS) ==     BY  == PAB1 ==.                    
           COPY  LCBYBSYH.                                              
           COPY  LCBYBHDR.                                              
           COPY  LCBYBICO.                                              
           COPY  LCBYBOCO.                                              
           REPLACE OFF.                                                 
                                                                        
         02  LCBSPAB1-USERAREA.                                         
           COPY  LCBYPAB1.                                              


      ****************************************************************  
      *  LCBSPAB2 (iIE~p/  viau)                      *  01
      ****************************************************************  
       01  LCBSPAB2-PARM.                                               
         02  LCBSPAB2-STRTAREA.                                         
           REPLACE  == (BNCS) ==  BY  == PAB2 ==.                       
           COPY  LCBYBSYH.                                              
           COPY  LCBYBHDR.                                              
           COPY  LCBYBICO.                                              
           COPY  LCBYBOCO.                                              
           REPLACE OFF.                                                 
                                                                        
         02  LCBSPAB2-USERAREA.                                         
           COPY  LCBYPAB2.                                              

      ****************************************************************
      *  LCBSU110 (} V/ vJE)
      ****************************************************************
       01  LCBSU110-PARM.
         02  LCBSU110-STRTAREA.
           REPLACE  == (BNCS) ==  BY  == U110 ==.
           COPY  LCBYBSYH.                                              
           COPY  LCBYBHDR.                                              
           COPY  LCBYBICO.                                              
           COPY  LCBYBOCO.                                              
           REPLACE OFF.                                                 

         02  LCBSU110-USERAREA.
           COPY  LCBYU110.

      *
       01  WS-END                       PIC  X(40)  VALUE
           'LCBPP94C - WORKING STORAGE ENDS HERE'.

      ****************************************************************
      *                                                              *
      *    L I N K A G E   S E C T I O N                             *
      *                                                              *
      ****************************************************************
       LINKAGE                          SECTION.

       01  DFHCOMMAREA.
         02  STRTAREA.
           REPLACE  == (BNCS) ==  BY  == STRT ==.
           COPY  LCBYBSYH.
           COPY  LCBYBHDR.
           COPY  LCBYBICO.
           COPY  LCBYBOCO.
           REPLACE OFF.

         02  STRT-SEND-DATA             PIC  X(4000).

      ****************************************************************
      *                                                              *
      *    P R O C E D U R E    D I V I S I O N                      *
      *                                                              *
      ****************************************************************
       PROCEDURE                        DIVISION.

      *--------------------------------------------------------------*
      *                 I N I T I A L I Z A T I O N                  *
      *--------------------------------------------------------------*
       INITIALIZATION                   SECTION.
           MOVE  STRT-SEND-DATA          TO  USERAREA.

           MOVE  C-PROG-ID               TO  STRT-BOCOM-ERR-PROG
           MOVE  'Y'                     TO  STRT-BOCOM-ERR-TYPE.

           ACCEPT  W-SYSTEM-DATE       FROM  DATE YYYYMMDD.
           ACCEPT  W-SYSTEM-TIME       FROM  TIME.

      * INPUT DATA VERIFICATION
           PERFORM  S0100-VERIFY-INPUT.

      *--------------------------------------------------------------*
      *                     M A I N L I N E                          *
      *--------------------------------------------------------------*
       MAINLINE                         SECTION.

           PERFORM                      S0000-COMM-TO-HOST

           EVALUATE  STRT-BNHDR-TRAN-ID(7:2)
               WHEN '10'
                     PERFORM  S0000-INQUIRY
                     MOVE 'NNNNNN'     TO  STRT-BOCOM-ERR-SUBMSG
               WHEN '20'
                     PERFORM  S0000-APPROVAL
                     IF  SQLCODE  =  0
                         PERFORM S0000-INQUIRY
                         MOVE 'llllllllllllllllllllllllll'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                     END-IF
               WHEN '30'
                     PERFORM  S0000-APPCANCEL
                     IF  SQLCODE  =  0
                         PERFORM S0000-INQUIRY
                         MOVE 'pppppppppppppppppppppppppp'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                     END-IF
               WHEN '40'
                     PERFORM  S0000-RETURN
                     IF  SQLCODE  =  0
                         PERFORM S0000-INQUIRY
                         MOVE 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIII'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                     END-IF
               WHEN '50'
                     PERFORM  S0000-RTNCANCEL
                     IF  SQLCODE  =  0
                         PERFORM S0000-INQUIRY
                         MOVE 'UUUUUUUUUUUUUUUUUUUUUUUUUUU'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                     END-IF
               WHEN  OTHER
                     MOVE 'E'              TO  STRT-BOCOM-ERR-TYPE
                     MOVE '00030E'         TO  STRT-BOCOM-ERR-SEQ
                     MOVE 'DDDDDDDDDD'     TO  STRT-BOCOM-ERR-SUBMSG
                     PERFORM               S0000-RETURN-CONTROL
           END-EVALUATE.


           MOVE  '00100I'               TO  STRT-BOCOM-ERR-SEQ
           MOVE  'N'                    TO  STRT-BOCOM-ERR-TYPE.


      *--------------------------------------------------------------*
      *                   F I N A L I Z A T I O N                    *
      *--------------------------------------------------------------*
       FINALIZATION                     SECTION.

           PERFORM                      S0000-RETURN-CONTROL.
      *==============================================================*
      *                                                              *
      *       S T A R T    V E R I F I C A T I O N   C H E C K       *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *            S 0 1 0 0 - V E R I F Y - I N P U T               *
      *                                                              *
      * vv/ JBv}m/
      ****************************************************************
       S0100-VERIFY-INPUT                SECTION.

           IF  NOT STRT-BNHDR-ENQURY
               MOVE L-C-CD-TBL-ID        TO  BP43-CD-TBL-ID
               PERFORM  S0000-SELECT-TP430

               IF  STRT-BNHDR-EMP-NO     =   BP43-CD-MNGR-EMP-N
                                         OR  BP43-SUB-CD-MNGR-EMP-N
                                         OR  BP43-ALNC-K-EMP-N
                                         OR  BP43-SUB-ALNC-K-EMP-N
               THEN NEXT SENTENCE
               ELSE
                   MOVE 'E'              TO  STRT-BOCOM-ERR-TYPE
                   MOVE '00000E'         TO  STRT-BOCOM-ERR-SEQ
                   MOVE 'EEEEEEEEEEEEEEEEEEEEEEE'
                                         TO  STRT-BOCOM-ERR-SUBMSG
                   GO                    TO  FINALIZATION
               END-IF
           END-IF.

       S0100-VERIFY-INPUT-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *           E N D    V E R I F I C A T I O N   C H E C K       *
      *                                                              *
      *==============================================================*

      *==============================================================*
      *                                                              *
      *             S T A R T   H/  ~/I  D B ~K             *
      *                                                              *
      *==============================================================*
      ****************************************************************
      *                                                              *
      *    S 0 0 0 0 - S E L E C T - T O G 0 0                       *
      *                                                              *
      *  TOG00 (//LOGON ID) SELECT
      *                                                              *
      ****************************************************************
       S0000-SELECT-TOG00                SECTION.

           EXEC  SQL
                 SELECT USE_K_NM
                 INTO  :DCLT0G00.USE-K-NM
                 FROM   LCED20G0.T0G00
                 WHERE  EMP_N            = :DCLT0G00.EMP-N
                 WITH    UR
           END-EXEC.

           EVALUATE SQLCODE
            WHEN  +0
                  CONTINUE
            WHEN  +100
                  MOVE  ZERO             TO  SQLCODE
                  MOVE  BP42-REQ-K-ID    TO  USE-K-NM OF DCLT0G00
            WHEN  OTHER
                  MOVE  'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
                  MOVE  'T0G00'          TO  STRT-BOCOM-ERR-TBLNAME
                  MOVE  'SELECT'         TO  STRT-BOCOM-ERR-FUNC
                  MOVE  SQLCODE          TO  STRT-BOCOM-ERR-STATUS
                  GO                     FINALIZATION
           END-EVALUATE.

       S0000-SELECT-TOG00-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S 0 0 0 0 - S E L E C T - T 4 G B 0                       *
      *                                                              *
      *  T4GB0 (v//v7v~) SELECT
      *                                                              *
      ****************************************************************
       S0000-SELECT-T4GB0                SECTION.

           EXEC  SQL
                 SELECT EM_ID
                 INTO  :DCLT4GB0.EM-ID
                 FROM   LCED24G0.T4GB0
                 WHERE  EMP_N            = :DCLT4GB0.EMP-N
                 WITH    UR
           END-EXEC.

           EVALUATE SQLCODE
            WHEN  +0
                  CONTINUE
            WHEN  +100
                  MOVE  ZERO             TO  SQLCODE
                  MOVE  SPACE            TO  EM-ID OF DCLT4GB0
            WHEN  OTHER
                  MOVE  'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
                  MOVE  'T4GB0'          TO  STRT-BOCOM-ERR-TBLNAME
                  MOVE  'SELECT'         TO  STRT-BOCOM-ERR-FUNC
                  MOVE  SQLCODE          TO  STRT-BOCOM-ERR-STATUS
                  GO                     FINALIZATION
           END-EVALUATE.

       S0000-SELECT-T4GB0-EXIT.
           EXIT.


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

      ****************************************************************
      *                                                              *
      *    S 0 6 0 0 - S E L E C T - P 4 3 0                         *
      *                                                              *
      *  TP430 (mzE~p/  I~x)SELECT                           *
      *                                                              *
      ****************************************************************
       S0000-SELECT-TP430                SECTION.

           EXEC  SQL
                 SELECT  ONLN_POST_PGM_ID
                      ,  CMN_C_CD
                      ,  SVR_SING_CD_F
                      ,  CD_MNGR_EMP_N
                      ,  SUB_CD_MNGR_EMP_N
                      ,  ALNC_K_EMP_N
                      ,  SUB_ALNC_K_EMP_N
                   INTO  :BP43-ONLN-POST-PGM-ID
                      ,  :BP43-CMN-C-CD
                      ,  :BP43-SVR-SING-CD-F
                      ,  :BP43-CD-MNGR-EMP-N
                      ,  :BP43-SUB-CD-MNGR-EMP-N
                      ,  :BP43-ALNC-K-EMP-N
                      ,  :BP43-SUB-ALNC-K-EMP-N
                   FROM  LCBD2P43.TP430
                  WHERE  CD_TBL_ID       = :BP43-CD-TBL-ID
                  WITH  UR
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  000
                     CONTINUE
               WHEN  +100
                     MOVE  'E'           TO  STRT-BOCOM-ERR-TYPE
                     MOVE '00000E'       TO  STRT-BOCOM-ERR-SEQ
                     MOVE  'YYYYYYYYYYYYYYYYYYYYYY'
                                         TO  STRT-BOCOM-ERR-SUBMSG
                     GO                  TO  FINALIZATION
               WHEN  OTHER
                     MOVE  'S0600'       TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE  'TP430'       TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE  'SELECT'      TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE       TO  STRT-BOCOM-ERR-STATUS
                     GO                  TO  FINALIZATION
           END-EVALUATE.

       S0000-SELECT-TP430-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *          S 0 7 0 0 - C O U N T - P 4 4 0                     *
      *                                                              *
      *  mzE~p/Vma  saJBv                                *
      *                                                              *
      ****************************************************************
       S0000-COUNT-TP440                 SECTION.

           MOVE  0                       TO  W-SYS-CNT.
           EXEC    SQL
                SELECT  COUNT(*)
                  INTO  :W-SYS-CNT
                  FROM  LCBD2P44.TP440
                 WHERE  CD_TBL_ID     = :BP42-CD-TBL-ID
                   AND  USE_F         = 'Y'
                  WITH  UR
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  000
                     CONTINUE
               WHEN  +100
                     MOVE  0             TO  W-SYS-CNT
               WHEN  OTHER
                     MOVE  'Y'           TO  STRT-BOCOM-ERR-TYPE
                     MOVE  'S0700'       TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE  'TP440'       TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE  'COUNT'       TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE       TO  STRT-BOCOM-ERR-STATUS
                     GO                  FINALIZATION
           END-EVALUATE.

       S0000-COUNT-TP440-EXIT.
           EXIT.

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
      *--------------------------------------------------------------*
      *  COMM  TO  HOST
      *--------------------------------------------------------------*
       S0000-COMM-TO-HOST                SECTION.

           INITIALIZE                    HOST-AREAS.
           MOVE  W-SYSTEM-DATE           TO   H-SYSTEM-D.
           MOVE  W-SYSTEM-TIME           TO   H-SYSTEM-T.

           IF   STRT-BNHDR-TRAN-ID(7:2)  =  '10'
                IF   L-N-COLNO                =   0
                     MOVE  0                  TO  W-COLNO
                                                  W-SIZE
                     MOVE  1                  TO  W-POS
                ELSE
                     MOVE  L-N-COLNO          TO  W-COLNO
                     MOVE  L-N-POS            TO  W-POS
                     MOVE  L-N-SIZE           TO  W-SIZE
                END-IF
           ELSE
                MOVE  0                       TO  W-COLNO
                                                  W-SIZE
                MOVE  1                       TO  W-POS
           END-IF.

       S0000-COMM-TO-HOST-EXIT.
           EXIT.

      *----------------------------------------------------------------*
      *              S 0 0 0 0 - I N Q U I R Y                         *
      *----------------------------------------------------------------*
       S0000-INQUIRY                    SECTION.
           INITIALIZE  L-MULTI.

           MOVE     0                   TO      W-II.
           MOVE     SPACES              TO      END-SW.

           PERFORM  S0000-SELECT.

           MOVE L-C-CD-TBL-ID(1:3)      TO  H-TBCREATOR(1:3).
           MOVE 'D2'                    TO  H-TBCREATOR(4:2).
           IF L-C-CD-TBL-ID(1:3) = 'LCE'
              MOVE L-C-CD-TBL-ID(5:2)   TO  H-TBCREATOR(6:2)
              MOVE '0'                  TO  H-TBCREATOR(8:1)
           ELSE
              MOVE L-C-CD-TBL-ID(5:3)   TO  H-TBCREATOR(6:3)
           END-IF.
           MOVE L-C-CD-TBL-ID(4:5)      TO  H-TBNAME(1:5).

           PERFORM  S0000-OPEN-CURSOR.

           PERFORM  S0000-FETCH-CURSOR  UNTIL   END-SW = 'Y'.

           PERFORM  S0000-CLOSE-CURSOR.

       S0000-INQUIRY-PROC-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - S E L E C T                            *
      *--------------------------------------------------------------*
       S0000-SELECT                     SECTION.

           INITIALIZE LCBTP420
           MOVE L-C-REQ-D              TO  BP42-CD-MDF-REQ-D
           MOVE L-C-REQ-SEQ-N          TO  BP42-CD-MDF-REQ-SEQ-N
           MOVE L-C-CD-TBL-ID          TO  BP42-CD-TBL-ID
      *    MOVE 500                    TO  BP42-BF-TXT-LEN
      *                                    BP42-AF-TXT-LEN

           EXEC  SQL
                 SELECT  REQ_TM
                      ,  REQ_K_ID
                      ,  ALNC_K_ID
                      ,  ALNC_D
                      ,  ALNC_TM
                      ,  RTN_K_ID
                      ,  RTN_D
                      ,  RTN_TM
                      ,  EFT_D
                      ,  EFT_TM
                      ,  REQ_EFT_D
                      ,  ALNC_MM
                      ,  BF_TXT
                      ,  AF_TXT
                   INTO  :BP42-REQ-TM
                      ,  :BP42-REQ-K-ID
                      ,  :BP42-ALNC-K-ID
                      ,  :BP42-ALNC-D
                      ,  :BP42-ALNC-TM
                      ,  :BP42-RTN-K-ID
                      ,  :BP42-RTN-D
                      ,  :BP42-RTN-TM
                      ,  :BP42-EFT-D
                      ,  :BP42-EFT-TM
                      ,  :BP42-REQ-EFT-D
                      ,  :BP42-ALNC-MM
                      ,  :BP42-BF-TXT
                      ,  :BP42-AF-TXT
                   FROM  LCBD2P42.TP420
                  WHERE  CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                    AND  CD_TBL_ID        = :BP42-CD-TBL-ID
                    AND  CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
                   WITH  UR
           END-EXEC.


           EVALUATE  SQLCODE
               WHEN  0
      *-- /{7
                     MOVE  BP42-REQ-TM      TO  L-S-REQ-TM
                     MOVE  BP42-REQ-K-ID    TO  EMP-N   OF DCLT0G00
                     PERFORM  S0000-SELECT-TOG00
                     MOVE  USE-K-NM OF DCLT0G00
                                            TO  L-S-REQ-K-ID
      *-- v
                     MOVE  BP42-ALNC-D      TO  L-S-ALNC-D
                     MOVE  BP42-ALNC-TM TO      L-S-ALNC-TM

                     MOVE  BP42-ALNC-K-ID   TO  EMP-N   OF DCLT0G00
                     PERFORM  S0000-SELECT-TOG00
                     MOVE  USE-K-NM OF DCLT0G00
                                            TO  L-S-ALNC-K-ID
      *-- u
                     MOVE  BP42-RTN-D       TO  L-S-RTN-D
                     MOVE  BP42-RTN-TM      TO  L-S-RTN-TM
                     MOVE  BP42-RTN-K-ID   TO  EMP-N   OF DCLT0G00
                     PERFORM  S0000-SELECT-TOG00
                     MOVE  USE-K-NM OF DCLT0G00
                                            TO  L-S-RTN-K-ID
      *-- S
                     MOVE  BP42-EFT-D       TO  L-S-EFT-D
                     MOVE  BP42-EFT-TM      TO  L-S-EFT-TM
                     MOVE  BP42-REQ-EFT-D   TO  L-S-REQ-EFT-D
                     MOVE  BP42-ALNC-MM     TO  L-C-ALNC-MM
                     PERFORM S0000-SELECT-TBLNM
                     IF  H-REMARKS NOT = SPACE
                         MOVE  H-REMARKS    TO  L-S-TBL-NM
                     ELSE
                         MOVE  BP42-CD-TBL-ID TO L-S-TBL-NM
                     END-IF
               WHEN  100
                     MOVE  'E'              TO  STRT-BOCOM-ERR-TYPE
                     MOVE '00000E'          TO  STRT-BOCOM-ERR-SEQ
                     MOVE 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
                                            TO  STRT-BOCOM-ERR-SUBMSG
                     PERFORM                S0000-RETURN-CONTROL
               WHEN  OTHER
                     MOVE 'Y'               TO  STRT-BOCOM-ERR-TYPE
                     MOVE 'S0000'           TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE 'LCBTP420'        TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE 'SELECT'          TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE          TO  STRT-BOCOM-ERR-STATUS
                     PERFORM                S0000-RETURN-CONTROL
           END-EVALUATE.

      *-- u~ /{7/i EMAIL SEND
           PERFORM  S0000-SET-MAIL-ID.

       S0000-SELECT-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - S E L E C T - T B L N M                *
      *--------------------------------------------------------------*
       S0000-SELECT-TBLNM               SECTION.

           MOVE ALL SPACES              TO  H-CREATOR
                                            H-NAME
                                            H-REMARKS
           MOVE BP42-CD-TBL-ID(1:3)     TO  H-CREATOR(1:3)
           MOVE 'D2'                    TO  H-CREATOR(4:2)
           IF BP42-CD-TBL-ID(1:3) = 'LCE'
              MOVE BP42-CD-TBL-ID(5:2)  TO  H-CREATOR(6:2)
              MOVE '0'                  TO  H-CREATOR(8:1)
           ELSE
              MOVE BP42-CD-TBL-ID(5:3)  TO  H-CREATOR(6:3)
           END-IF
           MOVE BP42-CD-TBL-ID(4:5)     TO  H-NAME(1:5)

           EXEC  SQL
                SELECT   REMARKS
                  INTO   :H-REMARKS
                  FROM   SYSIBM.SYSTABLES
                 WHERE   CREATOR   = :H-CREATOR
                   AND   NAME      = :H-NAME
                  WITH   UR
           END-EXEC.

       S0000-SELECT-TBLNM-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - S E T - M A I L - I D                  *
      *--------------------------------------------------------------*
       S0000-SET-MAIL-ID                SECTION.

      *-- MAIL ID SET
           IF  STRT-BNHDR-TRAN-ID(7:2)   = '40'
               MOVE  BP42-RTN-K-ID         TO  EMP-N   OF DCLT4GB0
               PERFORM  S0000-SELECT-T4GB0
               MOVE   EM-ID   OF DCLT4GB0  TO  L-S-SEND-MAIL-ID

      *-- /{7/ MAIL SET
               MOVE  BP42-REQ-K-ID         TO  EMP-N   OF DCLT4GB0
               PERFORM  S0000-SELECT-T4GB0
               MOVE   EM-ID   OF DCLT4GB0  TO  L-S-RECV-MAIL-ID
           END-IF.
       S0000-SET-MAIL-ID-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - O P E N - C U R S O R                  *
      *--------------------------------------------------------------*
       S0000-OPEN-CURSOR                SECTION.

           EXEC  SQL
                 OPEN  CURSOR_SYSCOLS
           END-EXEC.

           IF  SQLCODE  =  0
               CONTINUE
           ELSE
               MOVE 'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
               MOVE 'SYSCOLS'        TO  STRT-BOCOM-ERR-TBLNAME
               MOVE 'OPEN'           TO  STRT-BOCOM-ERR-FUNC
               MOVE  SQLCODE         TO  STRT-BOCOM-ERR-STATUS
               PERFORM               S0000-RETURN-CONTROL
           END-IF.

       S0000-OPEN-CURSOR-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - F E T C H - C U R S O R                *
      *--------------------------------------------------------------*
       S0000-FETCH-CURSOR               SECTION.

           INITIALIZE H-COLNO
                      H-NAME
                      H-REMARKS
                      H-COLTYPE
                      H-LENGTH
                      H-SCALE

           EXEC  SQL
                 FETCH  CURSOR_SYSCOLS
                  INTO  :H-COLNO
                     ,  :H-NAME
                     ,  :H-REMARKS
                     ,  :H-COLTYPE
                     ,  :H-LENGTH
                     ,  :H-SCALE
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1              TO  W-II
                     PERFORM              S0000-HOST-TO-COMM
               WHEN  100
                     IF  W-II             <=  0
                         MOVE  'E'        TO  STRT-BOCOM-ERR-TYPE
                         MOVE '00083I'    TO  STRT-BOCOM-ERR-SEQ
                         MOVE 'DB2 CATALOG(SYSCOLUMNS)'
                                          TO  STRT-BOCOM-ERR-SUBMSG
                         MOVE 'S0000'     TO  STRT-BOCOM-ERR-PARAGRAPH
                         MOVE 'SYSCOLS'   TO  STRT-BOCOM-ERR-TBLNAME
                         MOVE 'FETCH'     TO  STRT-BOCOM-ERR-FUNC
                         PERFORM          S0000-RETURN-CONTROL
                     END-IF
                     MOVE  W-II           TO  L-S-LINE-N
                     INITIALIZE               L-NEXT
                     MOVE  'Y'            TO  END-SW
               WHEN  OTHER
                     MOVE 'S0000'         TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE 'SYSCOLS'       TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE 'FETCH'         TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE        TO  STRT-BOCOM-ERR-STATUS
                     PERFORM              S0000-RETURN-CONTROL
           END-EVALUATE.

       S0000-FETCH-CURSOR-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *  FETCH}DATACOMM AREAMOVE
      *--------------------------------------------------------------*
       S0000-HOST-TO-COMM               SECTION.

           IF  W-II  <=  C-COUNT
               IF  H-REMARKS NOT = SPACE
                   MOVE  H-REMARKS     TO  L-M-COL(W-II)
               ELSE
                   MOVE  H-NAME        TO  L-M-COL(W-II)
               END-IF
               MOVE  H-COLTYPE         TO  L-M-TYPE(W-II)
               MOVE  H-LENGTH          TO  L-M-LEN (W-II)
               IF  W-POS <= BP42-BF-TXT-LEN
                   MOVE BP42-BF-TXT-LEN TO W-LEN
                   PERFORM S0000-TEXT-EDIT
               END-IF
           ELSE
               MOVE  'Y'               TO  END-SW
               MOVE  C-COUNT           TO  L-S-LINE-N
               MOVE  H-COLNO           TO  L-N-COLNO
               MOVE  W-POS             TO  L-N-POS
               MOVE  W-SIZE            TO  L-N-SIZE
           END-IF.

       S0000-HOST-TO-COMM-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - T E X T - E D I T                      *
      *--------------------------------------------------------------*
       S0000-TEXT-EDIT                  SECTION.

           IF  H-COLTYPE = 'DECIMAL'
               COMPUTE W-SIZE = ( H-LENGTH / 2 ) + 1
           ELSE
               MOVE  H-LENGTH  TO  W-SIZE
           END-IF

           EVALUATE  H-COLTYPE
               WHEN 'DECIMAL'
                 IF  BP42-BF-TXT-TEXT (W-POS:W-SIZE) NOT = SPACE
                     MOVE  X'0000000000000000' TO W-DEC-X
                     MOVE  W-SIZE  TO  W-JJ
                     MOVE  8       TO  W-KK
                     PERFORM UNTIL W-JJ < 1
                             MOVE BP42-BF-TXT-TEXT(W-POS + W-JJ - 1:1)
                                                TO W-DEC-X(W-KK:1)
                             SUBTRACT 1 FROM W-JJ
                             SUBTRACT 1 FROM W-KK
                     END-PERFORM
                         EVALUATE H-SCALE
                             WHEN 0
                                  MOVE W-DEC-9      TO W-DEC-EDIT-0
                                  MOVE W-DEC-EDIT-0 TO L-M-BF(W-II)
                             WHEN 1
                                  MOVE W-DEC-9V9    TO W-DEC-EDIT-1
                                  MOVE W-DEC-EDIT-1 TO L-M-BF(W-II)
                             WHEN 2
                                  MOVE W-DEC-9V99   TO W-DEC-EDIT-2
                                  MOVE W-DEC-EDIT-2 TO L-M-BF(W-II)
                             WHEN 3
                                  MOVE W-DEC-9V999  TO W-DEC-EDIT-3
                                  MOVE W-DEC-EDIT-3 TO L-M-BF(W-II)
                             WHEN 4
                                  MOVE W-DEC-9V9999 TO W-DEC-EDIT-4
                                  MOVE W-DEC-EDIT-4 TO L-M-BF(W-II)
                         END-EVALUATE
                 END-IF
                 IF  BP42-AF-TXT-TEXT (W-POS:W-SIZE) NOT = SPACE
                     MOVE  X'0000000000000000' TO W-DEC-X
                     MOVE  W-SIZE  TO  W-JJ
                     MOVE  8       TO  W-KK
                     PERFORM UNTIL W-JJ < 1
                             MOVE BP42-AF-TXT-TEXT(W-POS + W-JJ - 1:1)
                                                TO W-DEC-X(W-KK:1)
                             SUBTRACT 1 FROM W-JJ
                             SUBTRACT 1 FROM W-KK
                     END-PERFORM
                         EVALUATE H-SCALE
                             WHEN 0
                                  MOVE W-DEC-9      TO W-DEC-EDIT-0
                                  MOVE W-DEC-EDIT-0 TO L-M-AF(W-II)
                             WHEN 1
                                  MOVE W-DEC-9V9    TO W-DEC-EDIT-1
                                  MOVE W-DEC-EDIT-1 TO L-M-AF(W-II)
                             WHEN 2
                                  MOVE W-DEC-9V99   TO W-DEC-EDIT-2
                                  MOVE W-DEC-EDIT-2 TO L-M-AF(W-II)
                             WHEN 3
                                  MOVE W-DEC-9V999  TO W-DEC-EDIT-3
                                  MOVE W-DEC-EDIT-3 TO L-M-AF(W-II)
                             WHEN 4
                                  MOVE W-DEC-9V9999 TO W-DEC-EDIT-4
                                  MOVE W-DEC-EDIT-4 TO L-M-AF(W-II)
                         END-EVALUATE
                 END-IF

               WHEN 'SMALLINT'
                 IF  BP42-BF-TXT-TEXT (W-POS:W-SIZE) NOT = SPACE
                     MOVE BP42-BF-TXT-TEXT (W-POS:W-SIZE)
                                                TO W-SINT-X
                     MOVE W-SINT-9              TO W-SINT-EDIT
                     MOVE W-SINT-EDIT           TO L-M-BF(W-II)
                 END-IF
                 IF  BP42-AF-TXT-TEXT (W-POS:W-SIZE) NOT = SPACE
                     MOVE BP42-AF-TXT-TEXT (W-POS:W-SIZE)
                                                TO W-SINT-X
                     MOVE W-SINT-9              TO W-SINT-EDIT
                     MOVE W-SINT-EDIT           TO L-M-AF(W-II)
                 END-IF
               WHEN 'INTEGER'
                 IF  BP42-BF-TXT-TEXT (W-POS:W-SIZE) NOT = SPACE
                     MOVE BP42-BF-TXT-TEXT (W-POS:W-SIZE)
                                                TO W-INT-X
                     MOVE W-INT-9           TO W-INT-EDIT
                     MOVE W-INT-EDIT        TO L-M-BF(W-II)
                 END-IF
                 IF  BP42-AF-TXT-TEXT (W-POS:W-SIZE) NOT = SPACE
                     MOVE BP42-AF-TXT-TEXT (W-POS:W-SIZE)
                                                TO W-INT-X
                     MOVE W-INT-9           TO W-SINT-EDIT
                     MOVE W-INT-EDIT        TO L-M-AF(W-II)
                 END-IF
               WHEN 'CHAR'
                     MOVE BP42-BF-TXT-TEXT (W-POS:W-SIZE)
                                                TO L-M-BF(W-II)
                     MOVE BP42-AF-TXT-TEXT (W-POS:W-SIZE)
                                                TO L-M-AF(W-II)
               WHEN 'VARCHAR'
                     ADD  2                     TO W-POS
                     MOVE BP42-BF-TXT-TEXT (W-POS:W-SIZE)
                                                TO L-M-BF(W-II)
                     MOVE BP42-AF-TXT-TEXT (W-POS:W-SIZE)
                                                TO L-M-AF(W-II)
               WHEN 'TIMESTMP'
                     MOVE 26                    TO W-SIZE
                     MOVE BP42-BF-TXT-TEXT (W-POS:W-SIZE)
                                                TO L-M-BF(W-II)
                     MOVE BP42-AF-TXT-TEXT (W-POS:W-SIZE)
                                                TO L-M-AF(W-II)
             END-EVALUATE.

      *-- umzI~x CONVERSION
           IF  BP42-CD-TBL-ID(1:5)  = C-LCBY
               PERFORM  S0000-SERVER-TEXT-CONV
           END-IF.

           ADD  W-SIZE      TO     W-POS.
           INITIALIZE W-DEC-X
                      W-SINT-X
                      W-INT-X.

           IF  L-M-BF(W-II) NOT = L-M-AF(W-II)
               MOVE 'Y'   TO  L-M-CHD(W-II)
           ELSE
               MOVE 'N'   TO  L-M-CHD(W-II)
           END-IF.
       S0000-TEXT-EDIT-EXIT.
           EXIT.
      *--------------------------------------------------------------*
      *           S 0 0 0 0 - H AN N - C O N V E R S I O N           *
      *--------------------------------------------------------------*
       S0000-SERVER-TEXT-CONV            SECTION.
           MOVE  L-M-BF(W-II)            TO  W-IN-REC.
           MOVE  W-SIZE                  TO  W-IN-LENG.
           MOVE  W-SIZE                  TO  W-OUT-LENG.
           PERFORM  S0000-KS-CONVERT
           MOVE  W-OUT-REC(1:W-SIZE)     TO  L-M-BF(W-II).
      *
           MOVE  L-M-AF(W-II)            TO  W-IN-REC.
           MOVE  W-SIZE                  TO  W-IN-LENG.
           MOVE  W-SIZE                  TO  W-OUT-LENG.
           PERFORM  S0000-KS-CONVERT
           MOVE  W-OUT-REC(1:W-SIZE)     TO  L-M-AF(W-II).
       S0000-SERVER-TEXT-CONV-EXIT.
           EXIT.
      ****************************************************************
      *                                                              *
      *                 S 0 0 0 0 - K S - C O N V E R T              *
      *                                                              *
      ****************************************************************
       S0000-KS-CONVERT                  SECTION.

           MOVE  SPACE                   TO  W-OUT-REC W-RTCD.
           MOVE  'I'                     TO  W-DIR.

           CALL 'KSCONV'    USING  W-IN-REC
                                   W-OUT-REC
                                   W-OUT-LENG
                                   W-DIR
                                   W-RTCD.

           IF  W-RTCD  NOT = '  '
               MOVE  'E'           TO  STRT-BOCOM-ERR-TYPE
               MOVE  '00000E'      TO  STRT-BOCOM-ERR-SEQ
               MOVE  'KS CODE CONVERSION ERROR'
                                   TO  STRT-BOCOM-ERR-SUBMSG
               GO                  TO  FINALIZATION
           END-IF.

       S0000-KS-CONVERT-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - C L O S E - C U R S O R                *
      *--------------------------------------------------------------*
       S0000-CLOSE-CURSOR               SECTION.

           EXEC  SQL
                 CLOSE   CURSOR_SYSCOLS
           END-EXEC.

           IF  SQLCODE  =  0
               CONTINUE
           ELSE
               MOVE 'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
               MOVE 'SYSCOLS'        TO  STRT-BOCOM-ERR-TBLNAME
               MOVE 'CLOSE'          TO  STRT-BOCOM-ERR-FUNC
               MOVE  SQLCODE         TO  STRT-BOCOM-ERR-STATUS
               PERFORM               S0000-RETURN-CONTROL
           END-IF.

       S0000-CLOSE-CURSOR-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - A P P R O V A L                        *
      *                       (v)                               *
      *--------------------------------------------------------------*
       S0000-APPROVAL                   SECTION.

           MOVE L-C-REQ-D               TO BP42-CD-MDF-REQ-D
           MOVE L-C-CD-TBL-ID           TO BP42-CD-TBL-ID
           MOVE L-C-REQ-SEQ-N           TO BP42-CD-MDF-REQ-SEQ-N

              EXEC  SQL
                    SELECT   ALNC_D
                         ,   DATA_PRCS_C_CD
                         ,   PRE_POST_F
                         ,   REQ_EFT_D
                         ,   REQ_K_ID
                         ,   EFT_D
                         ,   EFT_TM
                         ,   RTN_D
                         ,   ALNC_MM
                         ,   BF_TXT
                         ,   AF_TXT
                      INTO   :BP42-ALNC-D
                         ,   :BP42-DATA-PRCS-C-CD
                         ,   :BP42-PRE-POST-F
                         ,   :BP42-REQ-EFT-D
                         ,   :BP42-REQ-K-ID
                         ,   :BP42-EFT-D
                         ,   :BP42-EFT-TM
                         ,   :BP42-RTN-D
                         ,   :BP42-ALNC-MM
                         ,   :BP42-BF-TXT
                         ,   :BP42-AF-TXT
                      FROM   LCBD2P42.TP420
                     WHERE   CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                       AND   CD_TBL_ID        = :BP42-CD-TBL-ID
                       AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
                      WITH   UR
              END-EXEC
           IF  SQLCODE  =  0
                  IF  BP42-EFT-D > SPACE
                      MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                      PERFORM S0000-INQUIRY
                      MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                      MOVE 'FFFFFFFFFFFFFFFFFFFFFFFF'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                      PERFORM           S0000-RETURN-CONTROL
                  END-IF
                  IF  BP42-RTN-D > SPACE
                      MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                      PERFORM S0000-INQUIRY
                      MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                      MOVE 'FFFFFFFFFFFFFFFFFFFFFFFF'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                      PERFORM           S0000-RETURN-CONTROL
                  END-IF
                  IF  BP42-ALNC-D > SPACE
                      MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                      PERFORM S0000-INQUIRY
                      MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                      MOVE 'FFFFFFFFFFFFFFFFFFFFFFFF'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                      PERFORM           S0000-RETURN-CONTROL
                  END-IF
           ELSE
                  MOVE 'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
                  MOVE 'LCBTP420'       TO  STRT-BOCOM-ERR-TBLNAME
                  MOVE 'SELECT'         TO  STRT-BOCOM-ERR-FUNC
                  MOVE  SQLCODE         TO  STRT-BOCOM-ERR-STATUS
                  PERFORM               S0000-RETURN-CONTROL
           END-IF
      *
      *-- A~/  I~x  va/waCHECK
      *
           IF  BP42-CD-TBL-ID  =  'LCBTP460'
               AND  BP42-DATA-PRCS-C-CD  =  'I'
               PERFORM  S1100-CALL-CHCK-PGM
           END-IF

      *
      *-- mzE~p/  ~ss  JBv
           MOVE  BP42-CD-TBL-ID         TO  BP43-CD-TBL-ID
           PERFORM  S0000-SELECT-TP430

      *-- u  mzE~p/I~x  -  ~u  h/l
           IF    BP43-SVR-SING-CD-F       = 'Y'
             AND L-C-IMD-POST-F    NOT = 'Y'
                 MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                 MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                 MOVE 'FFFFFFFFFFFFFFFFFFFFFFF'
                                       TO  STRT-BOCOM-ERR-SUBMSG
                 PERFORM           S0000-RETURN-CONTROL
           END-IF.

      *-- viE}~s  SET
           MOVE STRT-BNHDR-EMP-NO       TO  BP42-ALNC-K-ID
           MOVE H-SYSTEM-D              TO  BP42-ALNC-D
           MOVE H-SYSTEM-T              TO  BP42-ALNC-TM
           MOVE L-C-IMD-POST-F          TO  BP42-IMD-POST-F
           MOVE L-C-ALNC-MM             TO  BP42-ALNC-MM

      *-- ~ua  ia  HOST SUB LINK t  SERVER INTERFACE
           IF  L-C-IMD-POST-F  =  'Y'
               PERFORM  S0000-IMD-POSTING
           END-IF.

      *-- mzE~p/  vi/{7  UPDATE
           PERFORM  S0000-UPDATE-TP420.

       S0000-APPROVAL-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - I M D - P O S T I N G                  *
      *                       (~u)                           *
      *--------------------------------------------------------------*
       S0000-IMD-POSTING                SECTION.

      *--  HOST ~/Iv  ia-u  /~/j  CALL
           IF  BP43-SVR-SING-CD-F   = 'N'
               PERFORM  S0000-CALL-POST-PGM
           END-IF.

      *-- H/~/I  Vmav  ia INTERFACE SUB CALL
           PERFORM  S0000-COUNT-TP440
           IF  W-SYS-CNT     >  0
               PERFORM  S0000-SEND-SERVER
           END-IF.

      *-- iIE~p/  pvs  e  I~xa  ia  vi/}  u
           IF  BP43-CMN-C-CD  >  SPACE
               PERFORM  S0000-POSTING-TP860
           END-IF.

      *-- viS  iE  }~s  SET
              MOVE H-SYSTEM-D                 TO BP42-EFT-D.
              MOVE H-SYSTEM-T                 TO BP42-EFT-TM.

       S0000-IMD-POSTING-EXT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S 0 0 0 0 - C A L L - P O S T - P G M                     *
      *                                                              *
      *  HOST SYSTEMa  iamzI~xu SUB MODULE CALL     *
      *                                                              *
      ****************************************************************
       S0000-CALL-POST-PGM               SECTION.
           INITIALIZE  PAA0.                                            
                                                                        
      *--  u/~/j  JBv                                         
           IF  BP43-ONLN-POST-PGM-ID = SPACE
               MOVE 'E'                  TO  STRT-BOCOM-ERR-TYPE
               MOVE '00000E'             TO  STRT-BOCOM-ERR-SEQ
               MOVE 'EEEEEEEEEEEEEEEEEEEEE'
                                         TO  STRT-BOCOM-ERR-SUBMSG
               GO                        TO  FINALIZATION
           END-IF.
                                                                        
           MOVE  BP42-CD-TBL-ID          TO  PAA0-TBL-ID                
           MOVE  BP42-REQ-EFT-D          TO  PAA0-REQ-EFT-D             
           MOVE  BP42-REQ-K-ID           TO  PAA0-REQ-K-ID              
           MOVE  BP42-DATA-PRCS-C-CD     TO  PAA0-MDF-C                 
           MOVE  BP42-BF-TXT-TEXT        TO  PAA0-BF-TXT                
           MOVE  BP42-AF-TXT-TEXT        TO  PAA0-AF-TXT                
           MOVE  STRTAREA                TO  LCBSPAA0-STRTAREA.         
                                                                        
      *-- u  SUB/~/j  CALL                                   
           MOVE  BP43-ONLN-POST-PGM-ID   TO  W-SUB-PGM.                 
                                                                        
           EXEC  CICS  LINK  PROGRAM (W-SUB-PGM)                        
                             COMMAREA(LCBSPAA0-PARM)                    
                             LENGTH  (LENGTH OF LCBSPAA0-PARM)          
           END-EXEC.                                                    
      *
           IF    PAA0-BOCOM-ERR-TYPE     =   'N'                        
                 CONTINUE                                               
           ELSE                                                         
                 MOVE  LCBSPAA0-STRTAREA TO  STRTAREA                   
                 GO                      TO  FINALIZATION
           END-IF.                                                      

       S1000-CALL-POST-PGM-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S 1 1 0 0 - C A L L - C H C K - P G M                     *
      *                                                              *
      *  3jE~p/a  Ha1h1 (EFT-F = "N" CHECK)              *
      *                                                              *
      ****************************************************************
       S1100-CALL-CHCK-PGM               SECTION.
           INITIALIZE  PAA0.

      *--  u/~/j  JBv
           IF  BP43-ONLN-POST-PGM-ID = SPACE
               MOVE 'E'                  TO  STRT-BOCOM-ERR-TYPE
               MOVE '00000E'             TO  STRT-BOCOM-ERR-SEQ
               MOVE 'EEEEEEEEEEEEEEEEEEEEE'
                                         TO  STRT-BOCOM-ERR-SUBMSG
               GO                        TO  FINALIZATION
           END-IF.

           MOVE  BP42-CD-TBL-ID          TO  PAA0-TBL-ID
           MOVE  BP42-REQ-EFT-D          TO  PAA0-REQ-EFT-D
           MOVE  BP42-REQ-K-ID           TO  PAA0-REQ-K-ID
           MOVE  'R'                     TO  PAA0-MDF-C
           MOVE  BP42-BF-TXT-TEXT        TO  PAA0-BF-TXT
           MOVE  BP42-AF-TXT-TEXT        TO  PAA0-AF-TXT
           MOVE  STRTAREA                TO  LCBSPAA0-STRTAREA.

      *-- u  SUB/~/j  CALL
           MOVE  BP43-ONLN-POST-PGM-ID   TO  W-SUB-PGM.

           EXEC  CICS  LINK  PROGRAM (W-SUB-PGM)
                             COMMAREA(LCBSPAA0-PARM)
                             LENGTH  (LENGTH OF LCBSPAA0-PARM)
           END-EXEC.
      *
           IF    PAA0-BOCOM-ERR-TYPE     =   'N'
                 CONTINUE
           ELSE
                 MOVE  LCBSPAA0-STRTAREA TO  STRTAREA
                 GO                      TO  FINALIZATION
           END-IF.

       S1100-CALL-CHCK-PGM-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S 1 2 0 0 - C A L L - D L T - P M M                       *
      *                                                              *
      *  3jE~p/A  A~/  {~                      *
      *                                                              *
      ****************************************************************
       S1200-CALL-DLT-PGM                SECTION.
           INITIALIZE  PAA0.

      *--  u/~/j  JBv
           IF  BP43-ONLN-POST-PGM-ID = SPACE
               MOVE 'E'                  TO  STRT-BOCOM-ERR-TYPE
               MOVE '00000E'             TO  STRT-BOCOM-ERR-SEQ
               MOVE 'DDDDDDDDDDDDDDDDDDDDDD'
                                         TO  STRT-BOCOM-ERR-SUBMSG
               GO                        TO  FINALIZATION
           END-IF.

           MOVE  BP42-CD-TBL-ID          TO  PAA0-TBL-ID
           MOVE  BP42-REQ-EFT-D          TO  PAA0-REQ-EFT-D
           MOVE  BP42-REQ-K-ID           TO  PAA0-REQ-K-ID
           MOVE  'D'                     TO  PAA0-MDF-C
           MOVE  BP42-BF-TXT-TEXT        TO  PAA0-BF-TXT
           MOVE  BP42-AF-TXT-TEXT        TO  PAA0-AF-TXT
           MOVE  STRTAREA                TO  LCBSPAA0-STRTAREA.

      *-- u  SUB/~/j  CALL
           MOVE  BP43-ONLN-POST-PGM-ID   TO  W-SUB-PGM.

           EXEC  CICS  LINK  PROGRAM (W-SUB-PGM)
                             COMMAREA(LCBSPAA0-PARM)
                             LENGTH  (LENGTH OF LCBSPAA0-PARM)
           END-EXEC.
      *
           IF    PAA0-BOCOM-ERR-TYPE     =   'N'
                 CONTINUE
           ELSE
                 MOVE  LCBSPAA0-STRTAREA TO  STRTAREA
                 GO                      TO  FINALIZATION
           END-IF.

       S1200-CALL-DLT-PGM-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S 1 1 0 0 - S E N D - F I L E                             *
      *                                                              *
      *  H/~/I  Vmav  ia  INTERFACE SUB CALL            *
      ****************************************************************
       S0000-SEND-SERVER                 SECTION.

           INITIALIZE  PAB1.                                            
                                                                        
           MOVE  BP42-CD-TBL-ID          TO  PAB1-TBL-ID                
           MOVE  BP42-DATA-PRCS-C-CD     TO  PAB1-MDF-C                 
           MOVE  BP42-CD-MDF-REQ-D       TO  PAB1-REQ-D                 
           MOVE  BP42-CD-MDF-REQ-SEQ-N   TO  PAB1-REQ-SEQ-N             
           MOVE  BP42-REQ-EFT-D          TO  PAB1-REQ-EFT-D             
           MOVE  BP42-REQ-K-ID           TO  PAB1-REQ-K-ID              
           MOVE  BP42-BF-TXT-TEXT        TO  PAB1-BF-TXT                
           MOVE  BP42-AF-TXT-TEXT        TO  PAB1-AF-TXT                
           MOVE  STRTAREA                TO  LCBSPAB1-STRTAREA.         
                                                                        
      *--  SUB/~/j  LINK                                          
           EXEC  CICS  LINK  PROGRAM (C-LCBSPAB1)                       
                             COMMAREA(LCBSPAB1-PARM)                    
                             LENGTH  (LENGTH OF LCBSPAB1-PARM)          
           END-EXEC.                                                    
      *
           IF    PAB1-BOCOM-ERR-TYPE     =   'N'                        
                 CONTINUE                                               
           ELSE                                                         
                 MOVE  LCBSPAB1-STRTAREA TO  STRTAREA                   
                 GO                      TO  FINALIZATION
           END-IF.                                                      

       S0000-SEND-SERVER-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S 1 4 0 0 - P O S T I N G - P 8 6 0                       *
      *                                                              *
      *  mzE~p/  via  iIE~p/  I~x  u                *
      *                                                              *
      ****************************************************************
       S0000-POSTING-TP860               SECTION.
      *-- mzE~p/  I~x  iIE~p/  I~xa  
      *-- E~p/,E~p/~  }~sSET}
      *--  (maI~x  Bah/~  a7z/})
      *
      * ~1E~p/    - LCET4G20  (HD0047)
      * haJE~p/- LCHTL910  (HL0002)
      * HaE~p/    - LCHTH710  (031011)
      * 3jE~p/- LCBTP460  (HJ0014)
      *

           INITIALIZE  PAB2.
      *--  MOVE DATA

           MOVE  BP42-CD-TBL-ID          TO  PAB2-TBL-ID.
      *-- I~xID
           MOVE  BP42-DATA-PRCS-C-CD     TO  PAB2-MDF-C
      *-- iIweE~p/
           MOVE  BP43-CMN-C-CD           TO  PAB2-C-CD
      *-- Sha~z/
           MOVE  STRT-SYHDR-DATE         TO  PAB2-EFT-ST-D
      *-- S/z/
           MOVE  '99991231'              TO  PAB2-EFT-END-D

           MOVE  STRT-SYHDR-DATE         TO  PAB2-RG-SYS-D
           MOVE  STRT-SYHDR-TIME         TO  PAB2-RG-SYS-TM
           MOVE  BP42-REQ-K-ID           TO  PAB2-RG-K-ID
      *
           MOVE  STRT-SYHDR-DATE         TO  PAB2-RNM-SYS-D
           MOVE  STRT-SYHDR-TIME         TO  PAB2-RNM-SYS-TM
           MOVE  BP42-REQ-K-ID           TO  PAB2-RNM-K-ID.

      *-- vi Ka a
           MOVE  BP42-AF-TXT-TEXT        TO  PAB2-AF-TXT.

           MOVE  STRTAREA                TO  LCBSPAB2-STRTAREA.

      *--  SUB/~/j  LINK
           EXEC  CICS  LINK  PROGRAM (C-LCBSPAB2)
                             COMMAREA(LCBSPAB2-PARM)
                             LENGTH  (LENGTH OF LCBSPAB2-PARM)
           END-EXEC.

           EVALUATE  PAB2-BOCOM-ERR-TYPE
               WHEN  'N'
                     CONTINUE

               WHEN  OTHER
                     MOVE  LCBSPAB2-STRTAREA
                                         TO  STRTAREA
                     GO                  TO  FINALIZATION
           END-EVALUATE.

       S0000-POSTING-TP860-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - A P P C A N C E L                      *
      *                       (vB~)                           *
      *--------------------------------------------------------------*
       S0000-APPCANCEL                  SECTION.

           MOVE L-C-REQ-D               TO BP42-CD-MDF-REQ-D
           MOVE L-C-REQ-SEQ-N           TO BP42-CD-MDF-REQ-SEQ-N
           MOVE L-C-CD-TBL-ID           TO BP42-CD-TBL-ID
           EXEC  SQL
                    SELECT   EFT_D
                         ,   ALNC_D
                         ,   RTN_D
                      INTO   :BP42-EFT-D
                         ,   :BP42-ALNC-D
                         ,   :BP42-RTN-D
                      FROM   LCBD2P42.TP420
                     WHERE   CD_MDF_REQ_D = :BP42-CD-MDF-REQ-D
                       AND   CD_TBL_ID    = :BP42-CD-TBL-ID
                       AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
                      WITH   UR
           END-EXEC
           IF  SQLCODE  =  0
                  IF  BP42-EFT-D > SPACE
                      MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                      PERFORM S0000-INQUIRY
                      MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                      MOVE 'DDDDDDDDDDDDDDDDDDDDDD'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                      PERFORM           S0000-RETURN-CONTROL
                  END-IF
                  IF  BP42-RTN-D > SPACE
                      MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                      PERFORM S0000-INQUIRY
                      MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                      MOVE 'uuuuuuuuuuuuuuuuuuuuuuuu'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                      PERFORM           S0000-RETURN-CONTROL
                  END-IF
                  IF  BP42-ALNC-D <= SPACE
                      MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                      PERFORM S0000-INQUIRY
                      MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                      MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                      PERFORM           S0000-RETURN-CONTROL
                  END-IF
           ELSE
                  MOVE '00200I'         TO  STRT-BOCOM-ERR-SEQ
                  MOVE 'E'              TO  STRT-BOCOM-ERR-TYPE
                  MOVE 'WWWWWWWWWW'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                  MOVE 'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
                  MOVE 'LCBTP420'       TO  STRT-BOCOM-ERR-TBLNAME
                  MOVE 'SELECT'         TO  STRT-BOCOM-ERR-FUNC
                  MOVE  SQLCODE         TO  STRT-BOCOM-ERR-STATUS
                  PERFORM               S0000-RETURN-CONTROL
              END-IF

              MOVE ALL SPACES            TO BP42-ALNC-D
                                            BP42-ALNC-TM
                                            BP42-ALNC-K-ID
                                            BP42-IMD-POST-F
              EXEC  SQL
                    UPDATE   LCBD2P42.TP420
                       SET   ALNC_K_ID        = :BP42-ALNC-K-ID
                         ,   ALNC_D           = :BP42-ALNC-D
                         ,   ALNC_TM          = :BP42-ALNC-TM
                         ,   IMD_POST_F       = :BP42-IMD-POST-F
                     WHERE   CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                       AND   CD_TBL_ID        = :BP42-CD-TBL-ID
                       AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
           END-EXEC

           IF  SQLCODE  =  0
                  CONTINUE
           ELSE
                  MOVE 'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
                  MOVE 'LCBTP420'       TO  STRT-BOCOM-ERR-TBLNAME
                  MOVE 'UPDATE'         TO  STRT-BOCOM-ERR-FUNC
                  MOVE  SQLCODE         TO  STRT-BOCOM-ERR-STATUS
                  PERFORM               S0000-RETURN-CONTROL
           END-IF.

       S0000-APPCANCEL-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - R E T U R N                            *
      *                       (u)                               *
      *--------------------------------------------------------------*
       S0000-RETURN                     SECTION.

           MOVE L-C-REQ-D               TO  BP42-CD-MDF-REQ-D
           MOVE L-C-CD-TBL-ID           TO  BP42-CD-TBL-ID
           MOVE L-C-REQ-SEQ-N           TO  BP42-CD-MDF-REQ-SEQ-N
           EXEC  SQL
                 SELECT   EFT_D
                      ,   ALNC_D
                      ,   RTN_D
                      ,   CD_TBL_ID
                      ,   DATA_PRCS_C_CD
                      ,   REQ_EFT_D
                      ,   REQ_K_ID
                      ,   BF_TXT
                      ,   AF_TXT
                   INTO   :BP42-EFT-D
                      ,   :BP42-ALNC-D
                      ,   :BP42-RTN-D
                      ,   :BP42-CD-TBL-ID
                      ,   :BP42-DATA-PRCS-C-CD
                      ,   :BP42-REQ-EFT-D
                      ,   :BP42-REQ-K-ID
                      ,   :BP42-BF-TXT
                      ,   :BP42-AF-TXT
                   FROM   LCBD2P42.TP420
                  WHERE   CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                    AND   CD_TBL_ID        = :BP42-CD-TBL-ID
                    AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
                   WITH   UR
           END-EXEC
           IF  SQLCODE  =  0
               IF  BP42-EFT-D > SPACE
                   MOVE 'E'             TO  STRT-BOCOM-ERR-TYPE
                   PERFORM  S0000-INQUIRY
                   MOVE  '00000E'       TO  STRT-BOCOM-ERR-SEQ
                   MOVE 'WWWWWWWWWWWWWWWWWWWWWWWWWWW'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                   PERFORM  S0000-RETURN-CONTROL
               END-IF
               IF  BP42-ALNC-D > SPACE
                   MOVE 'E'             TO  STRT-BOCOM-ERR-TYPE
                   PERFORM  S0000-INQUIRY
                   MOVE  '00000E'       TO  STRT-BOCOM-ERR-SEQ
                   MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                   PERFORM  S0000-RETURN-CONTROL
               END-IF
               IF  BP42-RTN-D > SPACE
                   MOVE 'E'             TO  STRT-BOCOM-ERR-TYPE
                   PERFORM  S0000-INQUIRY
                   MOVE  '00000E'       TO  STRT-BOCOM-ERR-SEQ
                   MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE'
                                        TO  STRT-BOCOM-ERR-SUBMSG
                   PERFORM  S0000-RETURN-CONTROL
               END-IF
           ELSE
               MOVE 'S0000'             TO  STRT-BOCOM-ERR-PARAGRAPH
               MOVE 'LCBTP420'          TO  STRT-BOCOM-ERR-TBLNAME
               MOVE 'SELECT'            TO  STRT-BOCOM-ERR-FUNC
               MOVE  SQLCODE            TO  STRT-BOCOM-ERR-STATUS
               PERFORM  S0000-RETURN-CONTROL
           END-IF

      *-- H/~/I  Vmav  ia INTERFACE SUB CALL
           PERFORM  S0000-COUNT-TP440
           IF  W-SYS-CNT     >  0
               PERFORM  S0000-SEND-SERVER

      *--      (viS  iE  }~s  SET)
               MOVE H-SYSTEM-D            TO BP42-EFT-D
               MOVE H-SYSTEM-T            TO BP42-EFT-TM
           END-IF
      *
      *-- 3jE~p/A  A~/  {~
      *
           IF  BP42-CD-TBL-ID  =  'LCBTP460'
               AND  (BP42-DATA-PRCS-C-CD  =  'I' OR  'D')
               PERFORM  S1200-CALL-DLT-PGM
           END-IF

           MOVE STRT-BNHDR-EMP-NO         TO  BP42-RTN-K-ID
           MOVE L-C-ALNC-MM               TO  BP42-ALNC-MM

           EXEC  SQL
                 UPDATE   LCBD2P42.TP420
                    SET   RTN_K_ID         = :BP42-RTN-K-ID
                      ,   RTN_D            = :H-SYSTEM-D
                      ,   RTN_TM           = :H-SYSTEM-T
                      ,   EFT_D            = :BP42-EFT-D
                      ,   EFT_TM           = :BP42-EFT-TM
                      ,   ALNC_MM          = :BP42-ALNC-MM
                  WHERE   CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                    AND   CD_TBL_ID        = :BP42-CD-TBL-ID
                    AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
           END-EXEC

           IF  SQLCODE  =  0
               CONTINUE
           ELSE
               MOVE 'S0000'             TO  STRT-BOCOM-ERR-PARAGRAPH
               MOVE 'LCBTP420'          TO  STRT-BOCOM-ERR-TBLNAME
               MOVE 'UPDATE'            TO  STRT-BOCOM-ERR-FUNC
               MOVE  SQLCODE            TO  STRT-BOCOM-ERR-STATUS
               PERFORM  S0000-RETURN-CONTROL
           END-IF.

       S0000-RETURN-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *           S 0 0 0 0 - R T N C A N C E L                      *
      *                       (uB~)                           *
      *--------------------------------------------------------------*
       S0000-RTNCANCEL                  SECTION.

           MOVE  L-C-REQ-D              TO BP42-CD-MDF-REQ-D
           MOVE  L-C-CD-TBL-ID          TO BP42-CD-TBL-ID
           MOVE  L-C-REQ-SEQ-N          TO BP42-CD-MDF-REQ-SEQ-N
           EXEC  SQL
                 SELECT   EFT_D
                      ,   ALNC_D
                      ,   RTN_D
                      ,   CD_TBL_ID
                      ,   DATA_PRCS_C_CD
                   INTO   :BP42-EFT-D
                      ,   :BP42-ALNC-D
                      ,   :BP42-RTN-D
                      ,   :BP42-CD-TBL-ID
                      ,   :BP42-DATA-PRCS-C-CD
                   FROM   LCBD2P42.TP420
                  WHERE   CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                    AND   CD_TBL_ID        = :BP42-CD-TBL-ID
                    AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
                   WITH   UR
           END-EXEC

           EVALUATE  SQLCODE

               WHEN  000
                     IF  BP42-EFT-D > SPACE
                         MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                         PERFORM S0000-INQUIRY
                         MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                         MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE'
                                           TO  STRT-BOCOM-ERR-SUBMSG
                         PERFORM           S0000-RETURN-CONTROL
                     END-IF
                     IF  BP42-ALNC-D > SPACE
                         MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                         PERFORM S0000-INQUIRY
                         MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                         MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE'
                                           TO  STRT-BOCOM-ERR-SUBMSG
                         PERFORM           S0000-RETURN-CONTROL
                     END-IF
                     IF  BP42-RTN-D <= SPACE
                         MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                         PERFORM S0000-INQUIRY
                         MOVE  '00000E'    TO  STRT-BOCOM-ERR-SEQ
                         MOVE 'EEEEEEEEEEEEEEEEEEEEEEEE'
                                           TO  STRT-BOCOM-ERR-SUBMSG
                         PERFORM           S0000-RETURN-CONTROL
                     END-IF

               WHEN  +100
                     MOVE  'E'           TO  STRT-BOCOM-ERR-TYPE
                     MOVE '00000E'       TO  STRT-BOCOM-ERR-SEQ
                     MOVE  'HHHHHHHHHHHHHHHHHHHHHHHHHH'
                                         TO  STRT-BOCOM-ERR-SUBMSG
                     PERFORM              S0000-RETURN-CONTROL
               WHEN  OTHER
                     MOVE 'S0000'        TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE 'LCBTP420'     TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE 'SELECT'       TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE       TO  STRT-BOCOM-ERR-STATUS
                     PERFORM             S0000-RETURN-CONTROL
           END-EVALUATE.
      *
      *-- 3jE~p/  ma}  u{~wih/
      *
              IF  BP42-CD-TBL-ID  =  'LCBTP460'
                  AND  (BP42-DATA-PRCS-C-CD  =  'I'  OR  'D')
                  MOVE 'E'          TO  STRT-BOCOM-ERR-TYPE
                  PERFORM S0000-INQUIRY
                  MOVE '00000E'     TO  STRT-BOCOM-ERR-SEQ
                  MOVE 'HHHHHHHHHHHHHHHHHHHHHHHHH'
                                    TO  STRT-BOCOM-ERR-SUBMSG
                  PERFORM           S0000-RETURN-CONTROL
              END-IF

           MOVE ALL SPACES            TO BP42-RTN-D
                                         BP42-RTN-TM
                                         BP42-RTN-K-ID
           EXEC  SQL
                 UPDATE   LCBD2P42.TP420
                    SET   RTN_K_ID     = :BP42-RTN-K-ID
                      ,   RTN_D        = :BP42-RTN-D
                      ,   RTN_TM       = :BP42-RTN-TM
                  WHERE   CD_MDF_REQ_D = :BP42-CD-MDF-REQ-D
                    AND   CD_TBL_ID    = :BP42-CD-TBL-ID
                    AND   CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
           END-EXEC

           IF  SQLCODE  =  0
               CONTINUE
           ELSE
               MOVE 'S0000'          TO  STRT-BOCOM-ERR-PARAGRAPH
               MOVE 'LCBTP420'       TO  STRT-BOCOM-ERR-TBLNAME
               MOVE 'UPDATE'         TO  STRT-BOCOM-ERR-FUNC
               MOVE  SQLCODE         TO  STRT-BOCOM-ERR-STATUS
               PERFORM               S0000-RETURN-CONTROL
           END-IF.

       S0000-RTNCANCEL-EXIT.
           EXIT.

      *==============================================================*
      *                                                              *
      *           S T A R T   }am  ~/I  D B u             *
      *                                                              *
      *==============================================================*

      ****************************************************************
      *                                                              *
      *    S 0 6 0 0 - U P D A T E - P 4 2 0                         *
      *                                                              *
      *  TP420 (mzE~p/  vi/{7)                                *
      *                                                              *
      ****************************************************************
       S0000-UPDATE-TP420                SECTION.

           EXEC  SQL
                 UPDATE  LCBD2P42.TP420
                    SET  ALNC_K_ID        = :BP42-ALNC-K-ID
                      ,  ALNC_D           = :BP42-ALNC-D
                      ,  ALNC_TM          = :BP42-ALNC-TM
                      ,  IMD_POST_F       = :BP42-IMD-POST-F
                      ,  EFT_D            = :BP42-EFT-D
                      ,  EFT_TM           = :BP42-EFT-TM
                      ,  ALNC_MM          = :BP42-ALNC-MM
                  WHERE  CD_MDF_REQ_D     = :BP42-CD-MDF-REQ-D
                    AND  CD_TBL_ID        = :BP42-CD-TBL-ID
                    AND  CD_MDF_REQ_SEQ_N = :BP42-CD-MDF-REQ-SEQ-N
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  000
                     CONTINUE
               WHEN  +100
                     MOVE  'E'           TO  STRT-BOCOM-ERR-TYPE
                     MOVE  '00000E'      TO  STRT-BOCOM-ERR-SEQ
                     MOVE  'HHHHHHHHHHHHHHHHHHHHHHHHH'
                                         TO  STRT-BOCOM-ERR-SUBMSG
                     GO                  TO  FINALIZATION
               WHEN  OTHER
                     MOVE  'S0000'       TO  STRT-BOCOM-ERR-PARAGRAPH
                     MOVE  'TP420'       TO  STRT-BOCOM-ERR-TBLNAME
                     MOVE  'UPDATE'      TO  STRT-BOCOM-ERR-FUNC
                     MOVE  SQLCODE       TO  STRT-BOCOM-ERR-STATUS
                     GO                  TO  FINALIZATION
           END-EVALUATE.

       S0000-UPDATE-TP420-EXIT.
           EXIT.

      *--------------------------------------------------------------*
      *      C I C S     R E T U R N                                 *
      *--------------------------------------------------------------*
       S0000-RETURN-CONTROL             SECTION.

           MOVE  USERAREA                TO  STRT-SEND-DATA

           GOBACK.

       S0000-RETURN-CONTROL-EXIT.
           EXIT.

      ****************************************************************
      *    E N D    O F    P R O G R A M    ' L C B P P 9 4 C '      *
      ****************************************************************
