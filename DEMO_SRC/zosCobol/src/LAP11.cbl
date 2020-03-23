      ******************************************************************
      *                                                                *
      *         I D E N T I F I C A T I O N   D I V I S I O N          *
      *                                                                *
      ******************************************************************

       IDENTIFICATION     DIVISION.

       PROGRAM-ID.        LAP11.
       AUTHOR.            ITPlus.
       INSTALLATION.      ITPlus.
       DATE-WRITTEN.      2003.10.29.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *                    L A P 1 1                                   *
      *                                                                *
      *  PROGRAM TYPE   -  ONLINE COBOL                                *
      *                                                                *
      *  FUNCTION       - ?/?3?/p?s?v{7Úç?(ha?v?)»·??               *
      *                                                                *
      *  TRANSACTION    -  LA11                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; LAP11                       *
      *                                                                *
      *  INPUT PARMS    -  COMMUNICATION AREA     -   4000 BYTE        *
      *                                                                *
      *  OUTPUT PARMS   -  NONE                                        *
      *                                                                *
      *  TABLES         -  NONE                                        *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  I/O FILES      -  NONE                                        *
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
      *  DATE       S.E.            DESCRIPTION                        *
      * ==========  ==============  ================================== *
      * 2003/10/29  ITPlus          INITIAL WRITTEN                    *
      *                                                                *
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

       01  WS-START                    PIC X(40)
           VALUE 'LAP11 - WORKING STORAGE BEGINS HERE'.


      ******************************************************************
      *                                                                *
      *                    A C C U M U L A T O R S                     *
      *                                                                *
      ******************************************************************

       01  ACCUMULATORS.

           05  A-FETCH-COUNT           PIC S9(04) COMP SYNC VALUE +0.

           05  A-ERROR-COUNT           PIC S9(04) COMP SYNC VALUE +0.
               88  A-ERROR-COUNT-ZERO             VALUE +0.
               88  A-ERROR-COUNT-ONE              VALUE +1.

           05  A-SPACE-COUNT           PIC S9(04) COMP SYNC VALUE +0.
               88  A-SPACE-COUNT-ZERO             VALUE +0.
               88  A-SPACE-COUNT-ONE              VALUE +1.

           05  A-FETCH-CNT             PIC S9(04) COMP SYNC VALUE +0.

      ******************************************************************
      *                                                                *
      *                       C O N S T A N T S                        *
      *                                                                *
      ******************************************************************

       01  CONSTANTS.

           05  C-PGM-LAP11            PIC  X(08) VALUE 'LAP11'.
           05  C-PGM-LA11             PIC  X(08) VALUE 'LA11'.
           05  C-PGM-SSSHE            PIC  X(08) VALUE 'SSSHE'.
           05  C-PGM-SSSAX            PIC  X(08) VALUE 'SSSAX'.
           05  C-PGM-SSSAA            PIC  X(08) VALUE 'SSSAA'.
           05  C-PGM-SSSDI            PIC  X(08) VALUE 'SSSDI'.
           05  C-PGM-LAS10            PIC  X(08) VALUE 'LAS10'.

      *                                *-------------------------------
      *                                *  USER  MESSAGE     CODES
      *                                *-------------------------------

           05  C-MSG-CS00005           PIC  X(07) VALUE 'CS00005'.
           05  C-MSG-GS71011           PIC  X(07) VALUE 'GS71011'.
           05  C-MSG-AT00019           PIC  X(07) VALUE 'AT00019'.
040909     05  C-MSG-AT00051           PIC  X(07) VALUE 'AT00051'.
           05  C-MSG-AT15600           PIC  X(07) VALUE 'AT15600'.
           05  C-MSG-AT21980           PIC  X(07) VALUE 'AT21980'.
           05  C-MSG-AT33900           PIC  X(07) VALUE 'AT33900'.
           05  C-MSG-AT23010           PIC  X(07) VALUE 'AT23010'.
           05  C-MSG-AT70020           PIC  X(07) VALUE 'AT70020'.
           05  C-MSG-AT33200           PIC  X(07) VALUE 'AT33200'.
           05  C-MSG-AT22010           PIC  X(07) VALUE 'AT22010'.
           05  C-MSG-AT31000           PIC  X(07) VALUE 'AT31000'.
           05  C-MSG-AT38710           PIC  X(07) VALUE 'AT38710'.
           05  C-MSG-AT20570           PIC  X(07) VALUE 'AT20570'.
           05  C-MSG-AT88020           PIC  X(07) VALUE 'AT88020'.
           05  C-MSG-AT15150           PIC  X(07) VALUE 'AT15150'.
           05  C-MSG-AT20250           PIC  X(07) VALUE 'AT20250'.
           05  C-MSG-AT36400           PIC  X(07) VALUE 'AT36400'.
           05  C-MSG-AT70015           PIC  X(07) VALUE 'AT70015'.
           05  C-MSG-AT70070           PIC  X(07) VALUE 'AT70070'.
           05  C-MSG-AT70050           PIC  X(07) VALUE 'AT70050'.
           05  C-MSG-AT70080           PIC  X(07) VALUE 'AT70080'.
           05  C-MSG-AT70060           PIC  X(07) VALUE 'AT70060'.
           05  C-MSG-AT70065           PIC  X(07) VALUE 'AT70065'.
           05  C-MSG-AT01270           PIC  X(07) VALUE 'AT01270'.
           05  C-MSG-AT15500           PIC  X(07) VALUE 'AT15500'.
           05  C-MSG-AT20090           PIC  X(07) VALUE 'AT20090'.

           05  C-MSG-AT32100           PIC  X(07) VALUE 'AT32100'.
           05  C-MSG-AT01560           PIC  X(07) VALUE 'AT01560'.
           05  C-MSG-AT70000           PIC  X(07) VALUE 'AT70000'.

      *****************************************************************
      *                                                               *
      *                        S W I T C H E S                        *
      *                                                               *
      *****************************************************************

       01  SWITCHES.

           05  S-CICS-RETURN           PIC  X(01) VALUE LOW-VALUES.
               88 S-CICS-RETURN-ON                VALUE HIGH-VALUES.

           05  S-ERROR                 PIC  X(01) VALUE LOW-VALUES.
               88 S-ERROR-ON                      VALUE HIGH-VALUES.

           05  S-PROCESS               PIC  X(01) VALUE LOW-VALUES.
               88 S-DO-NOT-PROCESS                VALUE HIGH-VALUES.

           05  S-OCCR                  PIC  X(01) VALUE LOW-VALUES.
               88 S-DO-NOT-OCCR                   VALUE HIGH-VALUES.

      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************

       01  WORKAREAS.

           05  W-TRANID               PIC  X(04) VALUE SPACES.
           05  W-TERMID               PIC  X(04) VALUE SPACES.
           05  W-SYSID                PIC  X(04) VALUE SPACES.
           05  W-ABEND-FG             PIC  X(01) VALUE SPACES.
           05  W-CNT                  PIC  9(03) VALUE 0.
           05  W-SQL                  PIC  ---9.
           05  W-I                    PIC S9(04) COMP SYNC VALUE +0.
           05  W-COUNT                PIC S9(09) COMP-3 VALUE +0.
           05  W-TELNO                PIC  X(12) VALUE SPACE.
           05  W-OPEN-YY              PIC  9(04) VALUE  0.              
           05  W-OPEN-DT              PIC  9(02) VALUE  0.              
           05  W-TEL-ED.
               10  W-TEL1             PIC  X(04) JUST RIGHT.
               10  W-TEL2             PIC  X(04) JUST RIGHT.
               10  W-TEL3             PIC  X(04) JUST RIGHT.
           05  W-SELE-YEAR            PIC  X(04).
           05  W-SELE-YEAR1           PIC  X(04).
           05  W-SELE-YEAR-R          REDEFINES   W-SELE-YEAR1.
               10 W-DIVI-YEAR-R       PIC  9(04).
           05  W-AREABD-CHK           PIC  9(06)  VALUE 999999.
           05  W-INDEX3               PIC  9(02)  VALUE  0.             

           05  W-K-TXOFF              PIC  X(03)  VALUE  SPACE.         
           05  W-K-YEAR               PIC  X(04)  VALUE  SPACE.         
           05  W-K-NO                 PIC  X(07)  VALUE  SPACE.         

040603     05  W-APT-DONG             PIC  Z(12).
           05  W-AHO                  PIC  ZZZZZZ.
           05  W-AHOR                 REDEFINES   W-AHO.
               10  W-AHO-R            PIC  X(06).

           05  W-DB2-DT               PIC  X(08)  VALUE  SPACE.         

           05  W-ALCHFG.
               10 W-ALCHFG1           PIC  X(01).
               10 W-ALCHFG2           PIC  X(01).
               10 W-ALCHFG3           PIC  X(01).

           05  W-HANGUL-SAN           PIC  X(04)  VALUE 'XXX'.

           05  W-TXOFFCR-NO-MSG.
               10 FILLER               PIC X(30) VALUE
                           'YYYYYYYYYYYYYYYYYYYYYY'.
               10 W-TXOFFCR-NO-MSG1.
                  15 W-TXOFFCR-CD      PIC X(04).
               10 W-TXOFFCR-NO-MSG2    PIC X(16) VALUE
                           'UUUUUUUUUUUU'.

           05  W-OPEN-DT-MSG.
               10 W-OPEN-MSG1          PIC X(22) VALUE
                           'UUUUUUUUUUUU'.
               10 W-OPEN-MSG2.
                  15 W-OPEN-MSG-YY     PIC X(04).
                  15 FILLER            PIC X(01) VALUE '/'.
                  15 W-OPEN-MSG-MM     PIC X(02).
                  15 FILLER            PIC X(01) VALUE '/'.
                  15 W-OPEN-MSG-DD     PIC X(02).
               10 W-OPEN-MSG3          PIC X(16) VALUE
                           'uUUuuuuuuuu'.

           05  W-ABEND-CICS.
              10 FILLER               PIC  X(14) VALUE 'CICS ERROR!! '.
              10 W-ABEND-SECTION      PIC  X(40) VALUE SPACES.

      *****************************************************************
      *                                                               *
      *                 M O D U L E         A R E A                   *
      *                                                               *
      *****************************************************************
      *                                ***********         ************
      *                                *  HANDLE CONDITION CONSTANTS 1*
      *                                ***********         ************

           COPY SSYBE.

      *                                ******************************** 
      *                                *     WORK  COMMON  AREA       * 
      *                                ******************************** 
                                                                        
           COPY SSYBG.                                                  
                                                                        
      *                                ***********         ************
      *                                *       COMMON  CONSTANT       *
      *                                ***********         ************

           COPY SSYBC.

      *                                ********************************
      *                                *            ADDR  EDIT
      *                                ********************************

           COPY                        SSYAX.

      *                                ********************************
      *                                *    DATE CHECK PUS  AREA      *
      *                                ********************************

           COPY                        SSYDI.


      *                                ********************************
      *                                *    wi?E?V  }Ý¤?            *
      *                                ********************************

           COPY SSYHE.

      *                                ********************************
      *                                *     NUMERIC                  *
      *                                ********************************

           COPY SSYAA.

      *                                ******************************** 
      *                                *     DB2 STATUS SQL CODE      * 
      *                                ******************************** 
                                                                        
           COPY                        SSYBI.                           
                                                                        
      * +--------------------------------+
      * ? LAS10u3?7n?E~p/A?G/?(iE}¬Úçá)?
      * +--------------------------------+
       01  W-LAS10-AREA.
      **  ?awe1:u3?7n?E~p/2:?/?3?/uVJ~3:I?}?tv?v?z[~[s?/wa
           05  W-L-GUBUN-CD              PIC  X(01).
      **  ?~?/?v{7Úç?(?awe?:?1?,?3?)
           05  W-L-TXOFF-CD              PIC  X(03).
      **  ?/?3?/p?suVJ~?(?awe?:?2?,?awe?:?4l?W-BUSNID(1:3)?/æÖ?)
           05  W-L-BUSNID                PIC  X(10).
      **  u3?7n?E~p/?(?awe?:?1?)
           05  W-L-LGDONG-CD             PIC  X(10).
      **  I?}?tv?v?z[~[s?/wa?('Y'/'N' )
           05  W-L-UNITY-TXOFF           PIC  X(01).
      **   RETURN CODE
           05  W-L-RTN-CODE              PIC  X(01).

      *                                ***********         ************
      *                                *     HANDLE AID IDENTIFER     *
      *                                ***********         ************

           COPY DFHAID.

      *****************************************************************
      *
      *                 V S A M    I O    A R E A
      *
      *****************************************************************

      *                                *-------------------------------
      *                                *        MSG VSAM LAYOUT
      *                                *-------------------------------
           COPY                        SUY01.


      *                                ***********         ************
      *                                *  PROGRAM SELF COMM AREA      *
      *                                ***********         ************

450    COPY QMY00.

            05 W-CM-PGM-RR    REDEFINES W-PRIVATE.

      *[¦¼S[?saÚç
               10  W-CM-LGDONG-TXOFF         PIC X(03).

      *?3?auVJ~
               10  W-CM-RCVETX               PIC X(03).
               10  W-CM-RQSTYR               PIC X(04).
               10  W-CM-RCVENO               PIC 9(07).
      *p?s»¦J?
               10  W-CM-RTNFG                PIC X(01).
               10  W-CM-RTNNM                PIC X(30).
0429  *~?[??~?~?,?aJAæÖ¹ß?a½»??
               10  W-CM-AIVSTFG              PIC X(01).
      *?3?a?z?/
               10  W-CM-RQSTDT               PIC X(08).
      *ÚÖJ~    
               10  W-CM-SANGHO               PIC X(60).
      *?atvuVJ~
               10  W-CM-RESID                PIC X(13).
               10  W-CM-RESID-TP             PIC X(01).
040903         10  W-CM-MARYFG               PIC X(20).
      *?7~?    
               10  W-CM-NM                   PIC X(30).
      *?/?3¼Ö?VJA
               10  W-CM-TELNO1               PIC X(04).
               10  W-CM-TELNO2               PIC X(04).
               10  W-CM-TELNO3               PIC X(04).
      *?/Hb  ?VJA
               10  W-CM-TELNOA               PIC X(04).
               10  W-CM-TELNOB               PIC X(04).
               10  W-CM-TELNOC               PIC X(04).
      *L?ma?v
               10  W-CM-PHONEA               PIC X(04).
               10  W-CM-PHONEB               PIC X(04).
               10  W-CM-PHONEC               PIC X(04).
      *u3?7n?  
               10  W-CM-DONGCD               PIC X(10).
               10  W-CM-DONGCD-C             PIC X(01).
               10  W-CM-DONGNM               PIC X(60).
      *ÚÝ
               10  W-CM-SBUNJI               PIC X(04).
      *uV?~    
               10  W-CM-BUNJI                PIC S9(04) COMP.
      *J~      
               10  W-CM-HO                   PIC S9(04) COMP.
      *I?      
               10  W-CM-TONG                 PIC S9(04) COMP.
      *u?      
               10  W-CM-BAN                  PIC S9(04) COMP.
      *?/?/?/?.ÚÖh/?.hVsi~?
               10  W-CM-ABLOCK               PIC X(80).
      *?/?/?/  n?
               10  W-CM-ADONG                PIC X(12).
      *?/?/?/  J~
               10  W-CM-AHO                  PIC X(06).
      * E-MAIL 
               10  W-CM-EMAIL                PIC X(50).
      *[¦¼Sm?mÖ¼/
               10  W-CM-OFFCR-CD             PIC X(04).
               10  W-CM-OFFCR-CD-C           PIC X(01).
               10  W-CM-OFFCR-NM             PIC X(20).
      *?s?V~?[¦Ú/?3?/?/¸»n~?/?/?3?/
               10  W-CM-MENUM                PIC X(10).
               10  W-CM-MENUM-C              PIC X(01).
               10  W-CM-MENUM-NM             PIC X(60).
      *?a?3½»E~p/
               10  W-CM-JUUP                 PIC X(07).
               10  W-CM-JUUP-C               PIC X(01).
      *wa?3½»?/wa
               10  W-CM-GUGB                 PIC X(01).
      *?3Ha    
               10  W-CM-UP                   PIC X(30).
      *½»~s    
               10  W-CM-JO                   PIC X(50).
      *ha?3?z?/
               10  W-CM-RGST-OPEN-DT         PIC X(08).
      *½»?3?v?a
               10  W-CM-EMPCNT               PIC S9(04) COMP.
      *iE}çÚ/?3?/wa
               10  W-CM-GWANFG               PIC X(01).
      *?/?3¼Ö~Ý¼S
               10  W-CM-AREABD               PIC S9(13)V9999 COMP-3.
      *?/?3¼Ö    
               10  W-CM-SAGB                 PIC X(01).
      *»¶maia?shV?a
               10  W-CM-RENT-CNT             PIC S9(04) COMP.
      *?/?~?/vv
               10  W-CM-JABON                PIC S9(15) COMP-3.
      *H/?v?/?
               10  W-CM-TABON                PIC S9(15) COMP-3.
      *?a??~?}?awe
               10  W-CM-ALCHFG               PIC X(03).
               10  W-CM-ALCHFG-C             PIC X(01).
               10  W-CM-ALCHNM               PIC X(30).
      *Êß[~[?awe
               10  W-CM-SPETAX               PIC X(01).
               10  W-CM-SPETNM               PIC X(30).
      *?/»á[?maÚÖ?/wa
               10  W-CM-EDUTFG               PIC X(01).
      *i?n»Ú/?3?/?/wa(Y/N)
               10  W-CM-CO-GB                PIC X(01).
      *Bi?/?  
               10  W-CM-CHUL-AMT             PIC S9(15) COMP-3.
      *?7?·»z?/
               10  W-CM-BUILD-DT             PIC X(08).
      *i?n»Ú/?3?/  ?v?v
               10  W-CM-CO-CNT               PIC S9(09) COMP-3.
      *?~we?    
               10  W-CM-CO-RATE              PIC S9(03)V99 COMP-3.
      *iA[¦»?J?  
               10  W-CM-BUSNTP               PIC  X(01).
               10  W-CM-BUSNTP-C             PIC  X(01).
      *?/?3¼Ö?awe
               10  W-CM-OWNFG                PIC  X(01).

      *[?m¬¼?[~
      *?awe
               10  W-CM-ADDRTP               PIC X(01).
      *u3?7n?  
               10  W-CM-DONGCD-S             PIC X(10).
      *ÚÝ
               10  W-CM-SBUNJI-S             PIC X(04).
      *uV?~    
               10  W-CM-BUNJI-S              PIC S9(04) COMP.
      *J~      
               10  W-CM-HO-S                 PIC S9(04) COMP.
      *I?      
               10  W-CM-TONG-S               PIC S9(04) COMP.
      *u?      
               10  W-CM-BAN-S                PIC S9(04) COMP.
      *?/?/?/?.ÚÖh/?.hVsi~?
               10  W-CM-ABLOCK-S             PIC X(80).
      *?/?/?/  n?
               10  W-CM-ADONG-S              PIC X(12).
      *?/?/?/  J~
               10  W-CM-AHO-S                PIC X(06).

      *»¦LÖ¸3[~?a¹ß
      *}?h/iE{7
               10  W-CM-LICETX               PIC X(03).
      *}?h/?awe
               10  W-CM-LICETP               PIC X(01).
      *}?h/uVJ~
               10  W-CM-LICENO               PIC X(30).
      *}?h/~Ý¼S
               10  W-CM-LICEBD               PIC S9(9)V9(4) COMP-3.

      ******************************************************************
      *                                                                *
      *                    D B 2   W O R K   A R E A                   *
      *                                                                *
      ******************************************************************
                                                                        
      *                                ***********         ************
      *                                *    SQL COMMUNICATION AREA    *
      *                                ***********         ************

           EXEC SQL  INCLUDE  SQLCA    END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTAA.TTAAA        *
      *                                ********************************

           EXEC SQL  INCLUDE TAOAA
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAU        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAU
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAG        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAG
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTAA.TTAAC        *
      *                                ********************************

           EXEC SQL  INCLUDE TAOAC
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAR        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAR
           END-EXEC.


      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAA        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAA
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAB        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAB
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAC        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAC
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAE        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAE
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAF        *
      *                                ********************************

           EXEC SQL  INCLUDE TBOAF
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTBA.TTBAM        *
      *                                ********************************
           EXEC SQL  INCLUDE TBOAM
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTJA.TTIAA        *
      *                                ********************************

           EXEC SQL  INCLUDE TIOAA
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTIA.TTIAB        *
      *                                ********************************

           EXEC SQL  INCLUDE TIOAB
           END-EXEC.


      *                                ********************************
      *                                *    DCL FOR DTJA.TTJAB        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOAB
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTJA.TTJBA        *
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
      *                                *    DCL FOR DTJB.TTJBH        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOBH
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DTJA.TTJAD        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOAD
           END-EXEC.


      *                                ********************************
      *                                *    DCL FOR DTJA.TTJAC        *
      *                                ********************************

           EXEC SQL  INCLUDE TJOAC
           END-EXEC.

      *                                ********************************
      *                                *    DCL FOR DRWA.TRWAD        *
      *                                ********************************
           EXEC SQL  INCLUDE RWOAD
           END-EXEC.


      *****************************************************************
      *                                                               *
      *           E N D   O F  W O R K I N G  S T O R A G E           *
      *                                                               *
      *****************************************************************

       01  WS-END                      PIC X(40)
           VALUE 'LAP11 - WORKING STORAGE ENDS HERE'.

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

       PROCEDURE                       DIVISION.


      ******************************************************************
      *                                                                *
      *                  I N I T I A L I Z A T I O N                   *
      *                                                                *
      *    -?v?/?vJA~Ý¹¦Ú?p¬¸ç¹vDATA??  u?l?m/                 *
      *                                                                *
      ******************************************************************

       INITIALIZATION                  SECTION.

           MOVE  DFHCOMMAREA      TO W-COMM-AREA.

           MOVE  SPACE            TO W-COMM-RC.

      ******************************************************************
      *                                                                *
      *                  M  A  I  N  L  I  N  E                        *
      *                                                                *
      ******************************************************************

       MAINLINE                        SECTION.

           PERFORM  S0100-MAIN-PROCESS.

       EJECT

      ******************************************************************
      *                                                                *
      *                    F I N A L I Z A T I O N                     *
      *                                                                *
      *        - CICS RETURN                                           *
      *                                                                *
      ******************************************************************

       FINALIZATION                    SECTION.

           IF  W-COMM-MSG              =  SPACE   AND
               W-MSG-ID                >  SPACE

               PERFORM  S9000-READ-SUV010

           END-IF.

      *    ERROR  CHECK
           IF  NOT A-ERROR-COUNT-ZERO   AND
               W-COMM-RC  =  SPACES  OR  LOW-VALUE

               MOVE  'RC01'             TO W-COMM-RC

           END-IF.

           MOVE  W-COMM-AREA        TO DFHCOMMAREA.

           PERFORM  S9900-RETURN.

       EJECT

      ******************************************************************
      *                     S U B R O U T I N E S                      *
      ******************************************************************
      ******************************************************************
      *                                                                *
      *               S 0 1 0 0 - M A I N - P R O C E S S              *
      *                                                                *
      ******************************************************************

       S0100-MAIN-PROCESS SECTION.

           EVALUATE  W-COMM-STEP

0427           WHEN  1
      *~?[¦»zqa  [¦¼S?/}?
                     PERFORM  S0110-ONE-PROCESS

               WHEN  2
      *?/?/CHECKt?  {çþ~
040909               IF (W-CM-RCVETX  =  LOW-VALUE  OR  SPACE)
   "                 OR (W-CM-RQSTYR  =  LOW-VALUE  OR  SPACE)
   "                    ADD  1               TO A-ERROR-COUNT
   "                    MOVE C-MSG-AT00051   TO W-MSG-ID
   "  *?3?auVJ~?~?¦»?l~m/?.JA~Ý½»ñ/Ka  ?a¼ß?3}/ù·?~?~
   "                 ELSE
                         PERFORM  S0200-TWO-PROCESS
040909               END-IF

               WHEN  OTHER
                     ADD   1                  TO  A-ERROR-COUNT
                     MOVE  'STEP-ERR '        TO  W-COMM-MSG

           END-EVALUATE.

           MOVE  'Y'                   TO  W-COMM-END-FG.

       S0100-MAIN-PROCESS-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *               S 0 1 1 0 - O N E - P R O C E S S                *
      *                                                                *
      ******************************************************************

       S0110-ONE-PROCESS SECTION.

           MOVE  W-CM-MENUM               TO  BUSNID  OF TTAAA
           PERFORM  S5500-SELECT-TTAAA

           IF  SQLCODE  =  C-SQL-NORMAL
               MOVE TRADE-NM1  OF TTAAA      TO W-CM-SANGHO
                                                W-CM-MENUM-NM
               MOVE RGST-OPEN-DT OF TTAAA    TO W-CM-RGST-OPEN-DT
               MOVE LGDONG-CD  OF TTAAA      TO W-CM-DONGCD
               MOVE SAN-BUNJI  OF TTAAA      TO W-CM-SBUNJI
               MOVE BUNJI      OF TTAAA      TO W-CM-BUNJI
               MOVE HO         OF TTAAA      TO W-CM-HO
               MOVE TONG       OF TTAAA      TO W-CM-TONG
               MOVE BAN        OF TTAAA      TO W-CM-BAN
               MOVE RESID-CHIEF OF TTAAA     TO W-CM-RESID
               MOVE TXPAYER-TP-CHIEF OF TTAAA   TO W-CM-RESID-TP
               MOVE CHIEF-NM         OF TTAAA   TO W-CM-NM

               MOVE LGDONG-CD OF TTAAA     TO LGDONG-CD OF TTJAD

               PERFORM   S5900-SELECT-TTJAD

               MOVE SI-DO     OF TTJAD     TO W-SSSAX-SI-DO
               MOVE GU-SI-GUN OF TTJAD     TO W-SSSAX-GU-SI-GUN
               MOVE DONG-UEP-MYUN OF TTJAD TO W-SSSAX-DONG-EUP-MYUN
               MOVE GA-RHEE   OF TTJAD     TO W-SSSAX-GA-RI

               CALL C-PGM-SSSAX  USING W-SSSAX-AREA

               MOVE W-SSSAX-OUTPUT     TO W-CM-DONGNM

               MOVE +60                TO W-SSSHE-I-LENGTH
               MOVE W-CM-DONGNM        TO W-SSSHE-I-DATA

               CALL C-PGM-SSSHE       USING W-SSSHE-AREA

               IF  W-SSSHE-STATUS  = SPACE

                   MOVE W-SSSHE-I-DATA TO W-CM-DONGNM

               ELSE

                   MOVE SPACE          TO W-CM-DONGNM

               END-IF

           END-IF.

       S0110-ONE-PROCESS-EXIT.
           EXIT.
           EJECT
      ******************************************************************
      *                                                                *
      *           S 0 2 0 0 - T W O - P R O C E S S                    *
      *                                                                *
      ******************************************************************

       S0200-TWO-PROCESS                SECTION.

0428       PERFORM     S0210-MENUM-PROC.

           PERFORM     S9100-GET-SYSTEM-DATA.
           MOVE W-DB2DATE(1:4)         TO W-DB2-DT(1:4)
           MOVE W-DB2DATE(6:2)         TO W-DB2-DT(5:2)
           MOVE W-DB2DATE(9:2)         TO W-DB2-DT(7:2)

           MOVE ZERO                   TO W-CM-RCVENO

           INITIALIZE  TRWAD
                       TTBAA
                       TTBAB
                       TTBAG.

           IF  A-ERROR-COUNT  =  ZERO
      *??[¦¼/  t?  E~p/CHECK{çþ~
               MOVE W-DB2-DT               TO RQST-DT  OF TTBAA
               MOVE RQST-DT  OF TTBAA      TO W-CM-RQSTDT

               MOVE W-CM-RCVETX            TO TXOFF-CD    OF TTBAA
                                              TXOFF-CD    OF TTBAB

               PERFORM    S1700-VALI-DATA-CHECK
           END-IF.

           IF  A-ERROR-COUNT  = ZERO

      *»·??}?  n¦»~H/h/  ?7ÚÖ?v  iÖæa¹¦  {çþ~
               PERFORM    S2600-INPUT-DATA-MOVE

               PERFORM    S4800-INPUT-DUPL-CHECK

               IF  SQLCODE = C-SQL-NORMAL OR
                   SQLCODE = -811

                   ADD  1               TO A-ERROR-COUNT
                   MOVE C-MSG-AT15600   TO W-MSG-ID
      *?~t~  »·??o?  ?v{7Úç  »·l~m/

               ELSE

      *?3?auVJ~  ?/n?wa?/  {çþ~
      *SSSDI CALL}/?/  {çþ~?~}Ý»?  h/?/?vm/
                   PERFORM    S2500-CURT-DATE-PUS-CHK

                   MOVE W-SSSDI-DATE   TO TREAT-DUEDT OF TTBAA
                                          TREAT-DUEDT OF TRWAD

      *?3?a[?saÚç  t?  ?3?auVJ~  ?p?7
                   PERFORM    S3000-TRWAD-RCVE-NO-CRET

                   MOVE SPACE          TO TRNS-AGENCY    OF TRWAD

                   MOVE W-COMM-TXOFF-CD
                                       TO TRNS-AGENCY    OF TRWAD(1:3)

                   MOVE W-CM-RESID     TO TXPAYER-ID     OF TRWAD
                                          RESID-BUSNID   OF TRWAD

                   MOVE W-CM-RESID-TP  TO TXPAYER-TP     OF  TRWAD
                   MOVE SPACE          TO TX-SRVC-TP     OF  TRWAD

      *~Ý¼3¹¦  ?a}?  Ùß?~{çþ~  ?~t/?~  {çþ~?~}?  ?3?a}?  ??~
                   MOVE W-DB2-DT       TO RCVE-DT        OF  TRWAD

      *?3?am?mÖ¼/h/  ùÖ?vm?mÖ¼/h/  o?
                   MOVE W-COMM-TX-OFFCR-CD   TO TX-OFFCR-RCVE  OF TRWAD
                   MOVE SPACE                TO TX-OFFCR-APPV  OF TRWAD

031117*?v{7?/?/SET
      *p?s»¦J?'7'r~l?'8'?ziÖæa  ?vi~p?sm?mÖ¼/h/  ?/l~~?
      *            IF  ((W-CM-RTNFG = '7' OR '8') AND
      *                (W-COMM-TX-OFFCR-CD(1:1) NOT = 'A' ))
      *
    *                MOVE '21'     TO TREAT-STAUS    OF TRWAD
      *                MOVE 'A0004'  TO TX-SRVC-TP     OF TRWAD
      *                MOVE SPACE    TO RCVE-METHOD    OF TRWAD
      *                MOVE ZERO     TO ISSUE-QTY      OF TRWAD
      *                                 ACTL-ISSUE-QTY OF TRWAD
      *                MOVE SPACE    TO RESID-RQSTR    OF TRWAD
      *                                 TREAT-DUEDT    OF TRWAD
      *            ELSE

                       MOVE '21'     TO TREAT-STAUS    OF TRWAD
                       MOVE 'A2002'  TO TX-SRVC-TP     OF TRWAD
                       MOVE '1'      TO RCVE-METHOD    OF TRWAD
040320                 MOVE 'Y'      TO RTN-TP         OF TRWAD
040320                 MOVE '1'      TO TREAT-METHOD   OF TRWAD
040320                 MOVE  0       TO ISSUE-QTY      OF TRWAD
                                        ACTL-ISSUE-QTY OF TRWAD
                       MOVE W-CM-RESID
                                     TO RESID-RQSTR    OF TRWAD

                       MOVE W-CM-RESID-TP  TO TXPAYER-TP-RQSTR
                                                       OF  TRWAD

      *            END-IF

      *tv?vTABEL¹¦INSERT {çþ~                    
                   PERFORM  S4700-TRWAD-INSERT

                   IF  SQLCODE = -803

      *tv?vTABEL¹¦INSERT?~?3?auVJ~h/  ?pvsu¬Úp?~  {çþ~

                       MOVE ZERO       TO W-INDEX
                       ADD +1          TO RCVE-NO-SEQNO  OF TRWAD
                       MOVE RCVE-NO-SEQNO         OF TRWAD
                                       TO RCVE-NO        OF TTBAA
                                          W-CM-RCVENO

                       PERFORM   VARYING  W-INDEX FROM +1 BY +1
                                           UNTIL W-INDEX > 105

                           PERFORM    S4700-TRWAD-INSERT

                           IF  SQLCODE = -803

                               IF  W-INDEX = 100

                                   ADD +1
                                       TO A-ERROR-COUNT
                                   ADD +110
                                       TO W-INDEX
                               ELSE

                                    ADD +1
                                       TO RCVE-NO-SEQNO  OF TRWAD

                               END-IF

                           ELSE

                               ADD +110
                                       TO W-INDEX
                               MOVE RCVE-NO-SEQNO  OF TRWAD
                                       TO RCVE-NO      OF TTBAA
                                          W-CM-RCVENO
                           END-IF

                       END-PERFORM

                   END-IF

                   IF  A-ERROR-COUNT = ZERO

                       MOVE ZERO       TO W-INDEX

                       MOVE RCVE-YEAR OF TTBAA
                                       TO RCVE-YEAR OF TTBAB
                                          RCVE-YEAR OF TTBAC
                                          RCVE-YEAR OF TTBAM

                       MOVE RCVE-NO   OF TTBAA
                                       TO RCVE-NO   OF TTBAB
                                          RCVE-NO   OF TTBAC
                                          RCVE-NO   OF TTBAM

      *?/KaiE?~??  }?h5?v?~?.?.?.  
                       PERFORM    S1000-ALL-TABLE-INSERT

                   ELSE

                       ADD  1        TO A-ERROR-COUNT
                       MOVE C-MSG-AT21980  TO W-MSG-ID
      *?3?auVJ~h/  ?pvsu¬Úpo¦¸6ù°l~m/?.

                   END-IF

               END-IF

           END-IF.

           IF  A-ERROR-COUNT  = ZERO
      *[?m¬¼?[~
               IF  W-CM-ADDRTP         =  '1'  OR  '2'
                   PERFORM  S0300-SONG-PROC
               END-IF

      *»¦LÖ¸3[~?a¹ß
               IF  W-CM-LICETX         =  SPACE  OR  LOW-VALUE
                   CONTINUE
               ELSE
                   PERFORM  S0600-LICE-PROC
               END-IF
           END-IF.

           IF  A-ERROR-COUNT       >  1
               MOVE  C-MSG-AT33900    TO  W-MSG-ID
           END-IF.

           IF  NOT A-ERROR-COUNT-ZERO
               EXEC CICS SYNCPOINT ROLLBACK
               END-EXEC
           END-IF.

       S0200-TWO-PROCESS-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 0 2 1 0 - M E N U M - P R O C                      *
      *                                                                *
      ******************************************************************

       S0210-MENUM-PROC               SECTION.

           IF   W-CM-RTNFG  = '3' OR
                W-CM-RTNFG  = '7' OR
                W-CM-RTNFG  = '8'

                IF  W-CM-BUSNTP = '1' OR '2' OR '3'

                    PERFORM     S1900-MENSE-CODE-CHK

                ELSE

                    ADD  +1             TO A-ERROR-COUNT
                    MOVE 'Y'            TO W-CM-BUSNTP-C
                    MOVE C-MSG-AT23010  TO W-MSG-ID

                END-IF

           ELSE

      *¸»n~?/?3?/
               IF  W-CM-RTNFG  =  '9'

                   IF  W-CM-MENUM    = SPACE OR LOW-VALUE

                        ADD  +1             TO A-ERROR-COUNT
                        MOVE 'Y'            TO W-CM-MENUM-C
                        MOVE C-MSG-GS71011  TO W-MSG-ID

                   ELSE

                        MOVE W-CM-MENUM     TO BUSNID OF TTAAA
                        PERFORM      S5500-SELECT-TTAAA
                        IF  SQLCODE  =  C-SQL-NORMAL
                            IF  CLOSE-DT  OF TTAAA  > SPACE
                                CONTINUE
                            ELSE
                                ADD  +1             TO A-ERROR-COUNT
                                MOVE 'Y'            TO W-CM-MENUM-C
                                MOVE C-MSG-GS71011  TO W-MSG-ID
                            END-IF
                        ELSE
                            ADD  +1             TO A-ERROR-COUNT
                            MOVE 'Y'            TO W-CM-MENUM-C
                            MOVE C-MSG-GS71011  TO W-MSG-ID
                        END-IF

                   END-IF

               ELSE

                   IF  W-CM-MENUM  =  SPACE OR LOW-VALUE

                        CONTINUE

                   ELSE

                        ADD  +1                  TO A-ERROR-COUNT
                        MOVE 'Y'                 TO W-CM-MENUM-C
                        MOVE C-MSG-AT70020       TO W-MSG-ID
      **p?s»¦J?  ?s?V?(~?[¦á)uVJ~??  JB?v}/ù·?~?~?.

                   END-IF
               END-IF

           END-IF.

       S0210-MENUM-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 0 3 0 0 - S O N G - P R O C                        *
      *                                                                *
      ******************************************************************

       S0300-SONG-PROC                SECTION.

           MOVE W-CM-RCVETX            TO TXOFF-CD   OF TTBAR           
           MOVE W-CM-RQSTYR            TO RCVE-YEAR  OF TTBAR           
           MOVE W-CM-RCVENO            TO RCVE-NO    OF TTBAR           
                                                                        
           MOVE W-CM-RCVETX            TO TXOFF-CD       OF TTBAR.      
           MOVE W-CM-RQSTYR            TO RCVE-YEAR      OF TTBAR.      
           MOVE W-CM-RCVENO            TO RCVE-NO        OF TTBAR.      
                                                                        
           MOVE W-CM-ADDRTP            TO ADDR-TP       OF TTBAR.       
           IF  W-CM-SBUNJI-S           =  LOW-VALUE
               MOVE  SPACE             TO SAN-BUNJI OF TTBAR
           ELSE
               MOVE W-CM-SBUNJI-S      TO SAN-BUNJI OF TTBAR            
           END-IF.
           MOVE W-CM-DONGCD-S          TO LGDONG-CD     OF TTBAR.       
                                                                        
           MOVE W-CM-BUNJI-S           TO BUNJI         OF TTBAR.       
           MOVE W-CM-HO-S              TO HO            OF TTBAR.       
           MOVE W-CM-BAN-S             TO BAN           OF TTBAR.       
           MOVE W-CM-TONG-S            TO TONG          OF TTBAR.       
                                                                        
           IF  W-CM-ABLOCK-S   =  LOW-VALUE OR SPACE                    
                                                                        
               MOVE SPACE             TO APT-BLOCK  OF TTBAR            
                                         APT-BLOCK2 OF TTBAR            
                                                                        
           ELSE                                                         
                                                                        
               MOVE W-CM-ABLOCK-S     TO APT-BLOCK  OF TTBAR            
                                         APT-BLOCK2 OF TTBAR            
                                                                        
               MOVE APT-BLOCK  OF TTBAR                                 
                                       TO W-SSSHE-I-DATA                
               MOVE +30                TO W-SSSHE-I-LENGTH              
                                                                        
               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH                 
                                       W-SSSHE-I-DATA                   
                                       W-SSSHE-STATUS                   
                                                                        
               MOVE W-SSSHE-I-DATA     TO APT-BLOCK  OF TTBAR           
                                                                        
               MOVE APT-BLOCK2 OF TTBAR                                 
                                       TO W-SSSHE-I-DATA                
               MOVE +80                TO W-SSSHE-I-LENGTH              
                                                                        
               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH                 
                                       W-SSSHE-I-DATA                   
                                       W-SSSHE-STATUS                   
                                                                        
               MOVE W-SSSHE-I-DATA     TO APT-BLOCK2 OF TTBAR           
                                                                        
           END-IF                                                       
                                                                        
           IF  W-CM-ADONG-S  =  LOW-VALUE OR SPACE                      
                                                                        
               MOVE SPACE              TO APT-DONG  OF TTBAR            
                                                                        
           ELSE                                                         
                                                                        
               MOVE W-CM-ADONG-S       TO APT-DONG  OF TTBAR            
               MOVE SPACE              TO W-SSSHE-I-DATA                
               MOVE APT-DONG  OF TTBAR TO W-SSSHE-I-DATA                
               MOVE +6                 TO W-SSSHE-I-LENGTH              
                                                                        
               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH                 
                                       W-SSSHE-I-DATA                   
                                       W-SSSHE-STATUS                   
                                                                        
               MOVE W-SSSHE-I-DATA     TO APT-DONG  OF TTBAR            
                                                                        
           END-IF.                                                      
                                                                        
           IF  W-CM-AHO-S  =   LOW-VALUE  OR SPACE                      
                                                                        
               MOVE SPACE              TO APT-HO    OF TTBAR            
                                                                        
           ELSE                                                         
                                                                        
               MOVE W-CM-AHO-S         TO  APT-HO    OF TTBAR           
                                           W-SSSAA-IN-DATA

               MOVE SPACE              TO  W-SSSAA-STATUS

               CALL  C-PGM-SSSAA  USING    W-SSSAA-IN-DATA
                                           W-SSSAA-OUT-DATA
                                           W-SSSAA-OUT-LOWCNT
                                           W-SSSAA-STATUS

               IF  W-SSSAA-STATUS  =  SPACE

                   MOVE W-SSSAA-OUT-DATA
                                       TO  W-AHO
                   MOVE W-AHO-R        TO  APT-HO  OF TTBAR
               END-IF
                                                                        
           END-IF.                                                      
                                                                        
           PERFORM   S6500-INSERT-TTBAR.                                
                                                                        
           IF  SQLCODE = C-SQL-NORMAL                                   
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
                                                                        
               PERFORM    S6600-DB-UPDATE-TTBAR                         
                                                                        
           END-IF.                                                      
                                                                        
       S0300-SONG-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 0 6 0 0 - L I C E - P R O C                        *
      *                                                                *
      ******************************************************************

       S0600-LICE-PROC                SECTION.

           INITIALIZE        TTBAU.                                     
                                                                        
      *?3?auVJ~                                                       
           MOVE W-CM-RCVETX            TO TXOFF-CD  OF TTBAU            
           MOVE W-CM-RQSTYR            TO RCVE-YEAR OF TTBAU            
           MOVE W-CM-RCVENO            TO RCVE-NO   OF TTBAU            
                                                                        
           MOVE W-CM-DONGCD            TO LGDONG-CD OF TTBAU            
                                                                        
      *¹Ö?3}?h/?a¹ß                                                   
           MOVE W-CM-LICETX            TO LICENSE-TXOFF-CD OF TTBAU     
           MOVE W-CM-LICETP            TO LICENSE-TP       OF TTBAU     
           MOVE W-CM-LICENO            TO LICENSE-NO       OF TTBAU     
           MOVE W-CM-LICEBD            TO LICENSE-AREA-BD  OF TTBAU     
                                                                        
           PERFORM    S6700-SQL-INSERT-TTBAU                            
                                                                        
           IF  SQLCODE  = -803                                          
                                                                        
               PERFORM    S6800-SQL-UPDATE-TTBAU                        

           END-IF.
                                                                        
       S0600-LICE-PROC-EXIT.                                            
           EXIT.                                                        
                                                                        
       EJECT                                                            
                                                                        
      ******************************************************************
      *                                                                *
      *           S 1 0 0 0 - A L L - T A B L E - I N S E R T          *
      *                                                                *
      ******************************************************************

       S1000-ALL-TABLE-INSERT         SECTION.

      *»·??n¦»~H/??  ?3?aTABEL¹¦INSERT{çþ~
           MOVE W-CM-RCVETX            TO TXOFF-CD  OF TTBAA
                                          TXOFF-CD  OF TTBAB
                                          TXOFF-CD  OF TTBAC
                                          TXOFF-CD  OF TTBAM

           MOVE W-COMM-TXOFF-CD        TO TXOFF-CD-SRVC OF TTBAA.
           MOVE W-COMM-TX-OFFCR-CD     TO TX-OFFCR-SRVC OF TTBAA.

           PERFORM    S4200-INSERT-TTBAA.

           IF  SQLCODE = -803

               ADD  1                 TO A-ERROR-COUNT
               MOVE C-MSG-AT15600     TO W-MSG-ID
      *?~t~  {çþ~}?  ?v{7Úç  »·l~m/?.

           ELSE

               PERFORM    S4300-INSERT-TTBAB

               IF  W-CM-EMAIL = SPACE  OR LOW-VALUES

                   CONTINUE

               ELSE

                   PERFORM    S4310-INSERT-TTBAM

               END-IF

               IF  W-CM-JUUP = SPACE OR
                   W-CM-JUUP = LOW-VALUE

                   CONTINUE

               ELSE

                   PERFORM    S4400-INSERT-TTBAC

               END-IF

           END-IF.

       S1000-ALL-TABLE-INSERT-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 7 0 0 - V A L I - D A T A - C H E C K            *
      *                                                                *
      ******************************************************************

       S1700-VALI-DATA-CHECK            SECTION.

      * ha?3?z?/
           MOVE W-CM-RGST-OPEN-DT  TO RGST-OPEN-DT OF TTBAA.

      * ÚÖJ~CHECK{çþ~
           IF   W-CM-SANGHO  =  SPACE OR LOW-VALUES

                MOVE SPACE              TO TRADE-NM  OF TTBAB
                                           TRADE-NM1 OF TTBAB

           ELSE

               MOVE W-CM-SANGHO        TO TRADE-NM  OF TTBAB
                                          TRADE-NM1 OF TTBAB

               MOVE SPACE              TO W-SSSHE-I-DATA
               MOVE TRADE-NM OF TTBAB
                                       TO W-SSSHE-I-DATA
               MOVE +30                TO W-SSSHE-I-LENGTH

               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                       W-SSSHE-I-DATA
                                       W-SSSHE-STATUS

               MOVE W-SSSHE-I-DATA     TO TRADE-NM OF TTBAB

      *ÚÖJ~?1}?~s
               MOVE SPACE              TO W-SSSHE-I-DATA
               MOVE TRADE-NM1 OF TTBAB TO W-SSSHE-I-DATA
               MOVE +60                TO W-SSSHE-I-LENGTH

               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                       W-SSSHE-I-DATA
                                       W-SSSHE-STATUS

               MOVE W-SSSHE-I-DATA     TO TRADE-NM1 OF TTBAB

           END-IF.

           MOVE W-CM-RESID             TO RESID OF TTIAA.
           MOVE W-CM-RESID-TP          TO TXPAYER-TP OF TTIAA.

           PERFORM      S5300-SELECT-TTIAA.

           IF  SQLCODE = C-SQL-NORMAL

      * ?a[~?~  ?VJAuVJ~
               IF  (W-CM-TELNOA  = SPACE OR LOW-VALUES) AND
                   (W-CM-TELNOB  = SPACE OR LOW-VALUES) AND
                   (W-CM-TELNOC  = SPACE OR LOW-VALUES)

                   MOVE TELNO OF TTIAA   TO W-TEL-ED
                   MOVE W-TEL1           TO W-CM-TELNOA
                   MOVE W-TEL2           TO W-CM-TELNOB
                   MOVE W-TEL3           TO W-CM-TELNOC

                   MOVE W-TEL-ED         TO RES-TELNO  OF TTBAB

               ELSE

                   MOVE  SPACE              TO W-TELNO
                   STRING  W-CM-TELNOA W-CM-TELNOB W-CM-TELNOC
                           DELIMITED BY SIZE INTO W-TELNO
                   END-STRING
                   MOVE W-TELNO         TO RES-TELNO OF TTBAB

               END-IF

               MOVE RESID OF TTIAA
                                   TO RESID-CHIEF      OF TTBAA

               MOVE TXPAYER-TP  OF TTIAA
                                   TO TXPAYER-TP-CHIEF OF TTBAA

           END-IF.

040903     IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '07' OR '14' OR '33' OR '34')
               MOVE 'AAAA'           TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '09' OR '10' OR '17')
               MOVE 'BBBBBBBB'       TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '08')
               MOVE 'CCCCCCCC'       TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '11' OR '55')
               MOVE 'DDDDDDD'       TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '12')
               MOVE 'YYYYYYYYY'     TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '13')
               MOVE 'YYYYYYYYY'      TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '15')
               MOVE 'UUUUUUUU'       TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '16')
               MOVE 'UUUUUUUU'       TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '18')
               MOVE 'HHHHHHHH'       TO W-CM-MARYFG
           ELSE
           IF  (ORG-RESID-CD OF TTIAA = '40') AND
               (ORG-CHNG-CD OF TTIAA = '20')
               MOVE 'YYYYYYYY'       TO W-CM-MARYFG
           ELSE
           IF   ORG-RESID-CD OF TTIAA = '51'
               MOVE 'TTTTTTTTT'       TO W-CM-MARYFG
           ELSE                                                         
           IF   ORG-RESID-CD OF TTIAA = '53'
               MOVE 'RRRRRR'       TO W-CM-MARYFG
           ELSE                                                         
           IF   ORG-RESID-CD OF TTIAA = '52'
               MOVE 'EEEEEEEE'       TO W-CM-MARYFG
040903     END-IF.                                                      

      * ?/?3¼Ö  ?VJAuVJ~CHECK{çþ~    
           IF  (W-CM-TELNO1  =  SPACE OR  LOW-VALUES) AND
               (W-CM-TELNO2  =  SPACE OR  LOW-VALUES) AND
               (W-CM-TELNO3  =  SPACE OR  LOW-VALUES)

                MOVE SPACE              TO TELNO OF TTBAB

           ELSE

               MOVE  SPACE              TO W-TELNO
               STRING  W-CM-TELNO1 W-CM-TELNO2 W-CM-TELNO3
                       DELIMITED BY SIZE INTO W-TELNO
               END-STRING

               MOVE W-TELNO         TO TELNO OF TTBAB

           END-IF.

      * L?ma?VJAuVJ~  A?G/
           IF  (W-CM-PHONEA  =  SPACE OR LOW-VALUES) AND
               (W-CM-PHONEB  =  SPACE OR LOW-VALUES) AND
               (W-CM-PHONEC  =  SPACE OR LOW-VALUES)

                MOVE SPACE             TO CELL-PHONE1 OF TTBAB

           ELSE

                MOVE  SPACE            TO W-TELNO
                STRING  W-CM-PHONEA W-CM-PHONEB W-CM-PHONEC
                        DELIMITED BY SIZE INTO W-TELNO
                END-STRING
                MOVE W-TELNO         TO CELL-PHONE1 OF TTBAB

           END-IF.

0428       IF  W-CM-MENUM  =  SPACE OR LOW-VALUE
               MOVE SPACE          TO BUSNID-JUST-BEF OF TTBAB
           ELSE
               MOVE W-CM-MENUM     TO BUSNID-JUST-BEF OF TTBAB
           END-IF.

           MOVE SPACE                   TO W-CM-DONGNM
                                           DONG-UEP-MYUN OF TTJAD
                                           GA-RHEE       OF TTJAD.

           MOVE W-CM-DONGCD             TO LGDONG-CD     OF TTJAD.

           PERFORM      S5900-SELECT-TTJAD.

           IF   SQLCODE = C-SQL-NOTFND

                ADD  +1                  TO A-ERROR-COUNT
                MOVE 'Y'                 TO W-CM-DONGCD-C
                MOVE C-MSG-AT33200       TO W-MSG-ID
      *u3?7n?  E~p/??  JB?v}/ù·?~?~?.

           ELSE

                MOVE TXOFF-CD OF TTJAD TO  W-CM-LGDONG-TXOFF
                MOVE W-CM-DONGCD       TO LGDONG-CD     OF TTBAB

                MOVE SPACE             TO W-SSSAX-INPUT
                                          W-SSSAX-OUTPUT

                STRING  SI-DO OF TTJAD GU-SI-GUN OF TTJAD
                        DONG-UEP-MYUN OF TTJAD GA-RHEE OF TTJAD
                   DELIMITED BY SIZE INTO W-SSSAX-INPUT
                END-STRING

                CALL  C-PGM-SSSAX  USING   W-SSSAX-INPUT
                                           W-SSSAX-OUTPUT

                MOVE W-SSSAX-OUTPUT TO W-CM-DONGNM

      *iE}?u3?7n?CHECK
                INITIALIZE  W-LAS10-AREA
                MOVE '3'               TO W-L-GUBUN-CD
                MOVE W-COMM-TXOFF-CD   TO W-L-TXOFF-CD
                PERFORM  S9800-LAS10-CALL

                IF W-COMM-TXOFF-CD     =  TXOFF-CD  OF TTJAD  OR
                   W-L-UNITY-TXOFF     =  'Y'
                   CONTINUE

                ELSE

                    ADD  +1                  TO A-ERROR-COUNT
                    MOVE 'Y'                 TO W-CM-DONGCD-C
                    MOVE C-MSG-AT22010       TO W-MSG-ID

               END-IF

           END-IF.

      *ÚÝuV?~
           IF  W-CM-SBUNJI      = LOW-VALUE
               MOVE SPACE          TO SAN-BUNJI OF TTBAB
           ELSE
               MOVE W-CM-SBUNJI    TO SAN-BUNJI OF TTBAB
           END-IF.

      * uV?~
           MOVE W-CM-BUNJI     TO  BUNJI OF TTBAB

      * J~
           MOVE  W-CM-HO           TO HO  OF TTBAB.

      * x??S
           IF  W-CM-ABLOCK =  SPACE  OR  LOW-VALUES

               MOVE SPACE              TO APT-BLOCK  OF TTBAB
                                          APT-BLOCK1 OF TTBAB
                                          APT-BLOCK2 OF TTBAB

           ELSE

               MOVE W-CM-ABLOCK        TO APT-BLOCK  OF TTBAB
                                          APT-BLOCK1 OF TTBAB
                                          APT-BLOCK2 OF TTBAB

      *APT-BLOCK2
               MOVE SPACE              TO W-SSSHE-I-DATA

               MOVE APT-BLOCK2 OF TTBAB
                                       TO W-SSSHE-I-DATA

               MOVE +80                TO W-SSSHE-I-LENGTH

               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                       W-SSSHE-I-DATA
                                       W-SSSHE-STATUS

               MOVE W-SSSHE-I-DATA     TO APT-BLOCK2 OF TTBAB

      *APT-BLOCK1
               MOVE SPACE              TO W-SSSHE-I-DATA

               MOVE APT-BLOCK1 OF TTBAB
                                       TO W-SSSHE-I-DATA

               MOVE +30                TO W-SSSHE-I-LENGTH

               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                       W-SSSHE-I-DATA
                                       W-SSSHE-STATUS

               MOVE W-SSSHE-I-DATA     TO APT-BLOCK1 OF TTBAB

      *APT-BLOCK
               MOVE SPACE              TO W-SSSHE-I-DATA

               MOVE APT-BLOCK  OF TTBAB
                                       TO W-SSSHE-I-DATA

               MOVE +20                TO W-SSSHE-I-LENGTH

               CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                       W-SSSHE-I-DATA
                                       W-SSSHE-STATUS

               MOVE W-SSSHE-I-DATA     TO APT-BLOCK  OF TTBAB

           END-IF.

      * ?/?/?/n?CHECK{çþ~
           IF  W-CM-ADONG  =  SPACE OR  LOW-VALUES

               MOVE SPACE              TO APT-DONG  OF TTBAB
                                          APT-DONG1 OF TTBAB

           ELSE

               MOVE +6                 TO W-SSSHE-I-LENGTH
               MOVE W-CM-ADONG         TO W-SSSHE-I-DATA

               CALL C-PGM-SSSHE     USING W-SSSHE-AREA

               IF  W-SSSHE-STATUS  = SPACE
                   MOVE W-SSSHE-I-DATA TO  APT-DONG1 OF TTBAB
               END-IF

               MOVE +4                 TO W-SSSHE-I-LENGTH

               MOVE W-CM-ADONG         TO W-SSSHE-I-DATA
               CALL C-PGM-SSSHE     USING W-SSSHE-AREA

               IF  W-SSSHE-STATUS  = SPACE

                   MOVE W-SSSHE-I-DATA TO  APT-DONG OF TTBAB

               END-IF

           END-IF.

      * ?/?/?/J~CHECK{çþ~
           IF  W-CM-AHO  =  SPACE OR  LOW-VALUE

               MOVE SPACE              TO APT-HO  OF TTBAB
                                          APT-HO1 OF TTBAB

           ELSE

               MOVE W-CM-AHO           TO  W-SSSAA-IN-DATA

               MOVE SPACE              TO  W-SSSAA-STATUS

               CALL  C-PGM-SSSAA  USING    W-SSSAA-IN-DATA
                                           W-SSSAA-OUT-DATA
                                           W-SSSAA-OUT-LOWCNT
                                           W-SSSAA-STATUS

               IF  W-SSSAA-STATUS  =  SPACE

                   MOVE W-SSSAA-OUT-DATA
                                       TO  W-AHO

                   MOVE W-AHO-R(3:4)   TO  APT-HO  OF TTBAB
                   MOVE W-AHO-R        TO  APT-HO1 OF TTBAB
                                           W-CM-AHO
               END-IF

           END-IF.

      * I?CHECK{çþ~
           MOVE W-CM-TONG             TO TONG OF TTBAB

      *u?CHECK{çþ~
           MOVE W-CM-BAN              TO BAN  OF TTBAB

      *?a??~?}?awe
           IF   W-CM-ALCHFG = SPACE OR W-CM-ALCHFG = LOW-VALUES

                MOVE SPACE              TO W-CM-ALCHNM
                                           ALCOHOL-TP OF TTBAB

           ELSE

                MOVE W-CM-ALCHFG        TO ALCOHOL-TP    OF TTBAB
                MOVE W-CM-ALCHFG        TO W-ALCHFG

                IF  W-CM-ALCHFG(1:1) = '1' OR
                    W-CM-ALCHFG(1:1) = '2' OR
                    W-CM-ALCHFG(1:1) = '3' OR
                    W-CM-ALCHFG(1:1) = '4' OR
                    W-CM-ALCHFG(1:1) = '5'

                    PERFORM     S1800-ALCHOL-CODE-CHK

                ELSE

                    ADD  +1             TO A-ERROR-COUNT
                    MOVE 'Y'            TO W-CM-ALCHFG-C
                    MOVE C-MSG-AT36400  TO W-MSG-ID

                END-IF

           END-IF.

      *?a?3½»
           IF   W-CM-JUUP = SPACE OR W-CM-JUUP = LOW-VALUES

                CONTINUE

           ELSE

                MOVE W-CM-JUUP          TO STD-INCM-RT-CD OF TTJAC
                MOVE W-DB2DATE(1:4)     TO W-SELE-YEAR1

                COMPUTE W-DIVI-YEAR-R  =  W-DIVI-YEAR-R - 1

                MOVE W-DIVI-YEAR-R      TO W-SELE-YEAR
                                           ATTRIBUTE-YEAR OF TTJAC

                COMPUTE W-DIVI-YEAR-R  =  W-DIVI-YEAR-R - 1

                PERFORM      S6100-SELECT-TTJAC

                IF   SQLCODE = C-SQL-NORMAL OR
                     SQLCODE = -811

                     MOVE W-SELE-YEAR   TO
                                           ATTRIBUTE-YEAR OF TTJAC

                     PERFORM      S6200-SELECT-TTJAC1

                     IF   SQLCODE = C-SQL-NOTFND

                          ADD  +1             TO A-ERROR-COUNT
                          MOVE 'Y'            TO W-CM-JUUP-C
                          MOVE C-MSG-AT31000  TO W-MSG-ID

                     END-IF

                ELSE

                     MOVE W-SELE-YEAR1  TO
                                           ATTRIBUTE-YEAR OF TTJAC

                     PERFORM      S6200-SELECT-TTJAC1

                     IF   SQLCODE = C-SQL-NOTFND

                          ADD  +1             TO A-ERROR-COUNT
                          MOVE 'Y'            TO W-CM-JUUP-C
                          MOVE C-MSG-AT31000  TO W-MSG-ID

                     END-IF

                END-IF

           END-IF.

           IF  (W-CM-RTNFG  = '8') AND
               (W-CM-BUSNTP = '3')

               IF  W-CM-JUUP = '522080' OR '522079'

                   CONTINUE

               ELSE

                   ADD  +1             TO A-ERROR-COUNT
                   MOVE 'Y'            TO W-CM-JUUP-C
                   MOVE C-MSG-AT38710  TO W-MSG-ID
      *iAÊß?/?3?/h/  ?/l?l~m/?.JB?v}/ù·?~?~?.

               END-IF

           END-IF.

      * ~Ý¼S
           MOVE W-CM-AREABD           TO  AREA-BD  OF TTBAB.

      *½»?3?vCHECK{çþ~
           IF   W-CM-EMPCNT = ZERO

                MOVE ZERO              TO  EMP-CNT  OF  TTBAB

      *½»?3?v?~  ?4?/~?  ?v{VÙ»?a  ?/wa?'wa?'
                MOVE 'N'               TO WITHHD-DUTY-FG OF TTBAB
040320          MOVE SPACE             TO WITHHD-DUTY-TP OF TTBAB

           ELSE

      *½»?3?v?~  »æ?/~?  ?v{VÙ»?a  ?/wa?'?/?'
                MOVE 'Y'               TO WITHHD-DUTY-FG OF TTBAB
                MOVE W-CM-EMPCNT       TO  EMP-CNT  OF  TTBAB
                MOVE '1'               TO WITHHD-DUTY-TP OF TTBAB

           END-IF.

      *?/vv?
           IF  W-CM-JABON   =  ZERO
               MOVE ZERO               TO CAPT-HISOWN OF TTBAB
           ELSE
               COMPUTE CAPT-HISOWN OF TTBAB  = W-CM-JABON * 10000
           END-IF.

      * H/?v?/vv
           IF  W-CM-TABON   =  ZERO
               MOVE ZERO               TO CAPT-OTH-PRSN OF TTBAB
           ELSE
               COMPUTE CAPT-OTH-PRSN OF TTBAB  = W-CM-TABON * 10000
           END-IF.

      * iE}çÚ/?3CHECK{çþ~
           MOVE  W-CM-GWANFG       TO APPV-BUSN-FG      OF TTBAB

      * ?/»á[?CHECK{çþ~?z?a}?~s¹¦Úç½¦æ¦
           MOVE  W-CM-EDUTFG       TO EDUTX-FG          OF TTBAB

      * waiAiAm?mÖ¼/  ?~uViE?~ CHECK    
           IF  W-CM-OFFCR-CD <= SPACE

               MOVE W-CM-DONGCD            TO LGDONG-CD OF TTJBH

               IF W-CM-SBUNJI = LOW-VALUE

                    MOVE SPACE         TO SAN-BUNJI OF TTJBH

               ELSE

                    MOVE W-CM-SBUNJI   TO SAN-BUNJI OF TTJBH

               END-IF

               MOVE W-CM-BUNJI         TO BUNJI-FR  OF TTJBH
               MOVE W-CM-HO            TO HO-FR     OF TTJBH

      *?/?3?/p?s?~  [?saÚç  ?awe?4?~  h/l?}/?~qase¹¦  [¦¼Sm?mÖ¼/l?
      *u3?7n?E~p/  I¦»~x¬»a  [?saÚç¹¦  }am?}/l?  m?mÖ¼/??  h/?/¹¶
               MOVE W-CM-LGDONG-TXOFF
                                       TO TXOFF-CD  OF TTJBH

      *?zuÝá,hÝ»~?,iAÊß»Ý  wah/m?mÖ¼/= [?~s?awe?:3
      *~?[?m?m?= [?~s?awe?:?4
               IF  W-CM-BUSNTP < '4'

                   MOVE '3'            TO TX-OFFCR-CD-TP OF TTJBH

               ELSE

                   MOVE '1'            TO TX-OFFCR-CD-TP OF TTJBH

               END-IF

               PERFORM  S6400-SELECT-TTJBH

           END-IF.

      * [¦¼Sm?mÖ¼/CHECK{çþ~    
           IF  W-CM-OFFCR-CD = SPACE OR LOW-VALUES

                ADD +1                 TO A-ERROR-COUNT
                MOVE 'Y'               TO W-CM-OFFCR-CD-C
                MOVE C-MSG-AT00019     TO W-MSG-ID
      *[¦¼S  m?mÖ¼/??  »·??}/ù·?~?~

           ELSE

               IF  W-CM-OFFCR-CD(1:1) = 'C' OR 'D' OR 'S' OR 'P'

                   MOVE SPACE          TO ASSIGN-PRD-TO OF TTJBC
                   MOVE W-CM-OFFCR-CD  TO TX-OFFCR-CD   OF TTJBC

      *?/?3?/p?s?~  [?saÚç  ?awe?4?~  h/l?}/?~qase¹¦  [¦¼Sm?mÖ¼/l?
      *u3?7n?E~p/  I¦»~x¬»a  [?saÚç¹¦  }am?}/l?  m?mÖ¼/??  h/?/¹¶
                   MOVE W-CM-LGDONG-TXOFF
                                       TO TXOFF-CD       OF TTJBC

                   PERFORM  S6300-SELECT-TTJBC

                   IF  A-ERROR-COUNT-ZERO
                       PERFORM  S2300-TTJBC-NOT-CHECK-A
                   END-IF

                   EVALUATE   SQLCODE

                       WHEN   C-SQL-NOTFND

                              ADD  +1            TO A-ERROR-COUNT
                              MOVE 'Y'           TO W-CM-OFFCR-CD-C
                              MOVE C-MSG-AT00019 TO W-MSG-ID
      *[¦¼S  m?mÖ¼/??  JB?v}/ù·?~?~?.

                       WHEN   -811

                              ADD +1             TO A-ERROR-COUNT
                              MOVE 'Y'           TO W-CM-OFFCR-CD-C
                              MOVE C-MSG-AT20090 TO W-MSG-ID

                   END-EVALUATE
               ELSE

                   ADD +1              TO A-ERROR-COUNT
                   MOVE 'Y'            TO W-CM-OFFCR-CD-C
                   MOVE C-MSG-AT00019  TO W-MSG-ID
      *[¦¼S  m?mÖ¼/??  JB?v}/ù·?~?~?.

               END-IF

           END-IF.

      *?/?3?/E-MAIL?a[~  t?  x~tzuVJ~  Bah/
           IF  W-CM-EMAIL = SPACE  OR LOW-VALUES

               CONTINUE

           ELSE

               MOVE  W-CM-EMAIL         TO EMAIL-ADDRESS OF TTBAM

           END-IF.

           MOVE 'N'                    TO BUSN-SHARE-FG   OF TTBAB.

      *i?n»Ú/?3?/?/wa
           IF  W-CM-CO-GB                   =  'Y'
      *Bi?/?
               COMPUTE IVST-MONEY  OF TTBAB =  W-CM-CHUL-AMT  *  10000
      *?7?·»z
               MOVE W-CM-BUILD-DT          TO JOIN-DT     OF TTBAB
               MOVE 'Y'                    TO BUSN-SHARE-FG  OF TTBAB
           END-IF.

       S1700-VALI-DATA-CHECK-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 8 0 0 - A L C H O L - C O D E - C H K            *
      *                                                                *
      ******************************************************************

       S1800-ALCHOL-CODE-CHK            SECTION.

      * ?a??~?}?CHECK{çþ~    

           IF  W-CM-ALCHFG(1:1) = '1' OR
               W-CM-ALCHFG(1:1) = '2' OR
               W-CM-ALCHFG(1:1) = '3' OR
               W-CM-ALCHFG(1:1) = '4'

                IF (W-ALCHFG2 = SPACE OR LOW-VALUE)  AND
                   (W-ALCHFG3 = SPACE OR LOW-VALUE)

                    MOVE '272'          TO CD-ID1        OF TTJAB
                    MOVE W-CM-ALCHFG(1:1) TO CD-ID2      OF TTJAB

                    PERFORM      S5800-SELECT-TTJAB

                    IF   SQLCODE  =  C-SQL-NOTFND

                         ADD  +1              TO A-ERROR-COUNT
                         MOVE 'Y'             TO W-CM-ALCHFG-C
                         MOVE C-MSG-AT20250   TO W-MSG-ID

                     ELSE

                         MOVE SPACE              TO W-SSSHE-I-DATA
                         MOVE DECODE  OF TTJAB   TO W-SSSHE-I-DATA
                         MOVE +30                TO W-SSSHE-I-LENGTH
                         CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                                 W-SSSHE-I-DATA
                                                 W-SSSHE-STATUS
                         MOVE W-SSSHE-I-DATA     TO W-CM-ALCHNM

                     END-IF

                ELSE
                    ADD  +1             TO A-ERROR-COUNT
                    MOVE 'Y'            TO W-CM-ALCHFG-C
                    MOVE C-MSG-AT36400  TO W-MSG-ID
                END-IF

           ELSE

                IF  W-CM-ALCHFG(1:1) = '5'

                    MOVE '266'          TO CD-ID1        OF TTJAB
                    MOVE W-CM-ALCHFG    TO CD-ID2        OF TTJAB

                    PERFORM      S5800-SELECT-TTJAB

                    IF   SQLCODE  =  C-SQL-NOTFND

                         ADD  +1              TO A-ERROR-COUNT
                         MOVE 'Y'             TO W-CM-ALCHFG-C
                         MOVE C-MSG-AT20250   TO W-MSG-ID

                    ELSE

                         MOVE SPACE              TO W-SSSHE-I-DATA
                         MOVE DECODE  OF TTJAB   TO W-SSSHE-I-DATA
                         MOVE +30                TO W-SSSHE-I-LENGTH
                         CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                                 W-SSSHE-I-DATA
                                                 W-SSSHE-STATUS
                         MOVE W-SSSHE-I-DATA     TO W-CM-ALCHNM

                    END-IF

                END-IF

           END-IF.

       S1800-ALCHOL-CODE-CHK-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *           S 1 9 0 0 - M E N S E -  C O D E - C H K             *
      *                                                                *
      ******************************************************************

0428   S1900-MENSE-CODE-CHK             SECTION.

      * ~?[??~?~CHECK{çþ~    

           IF  W-CM-MENUM   = SPACE OR LOW-VALUE

               ADD  +1                  TO A-ERROR-COUNT
               MOVE 'Y'                 TO W-CM-MENUM-C
               MOVE C-MSG-AT70020       TO W-MSG-ID

           ELSE

               MOVE W-CM-MENUM          TO BUSNID OF TTAAA

               PERFORM      S5500-SELECT-TTAAA

               IF  A-ERROR-COUNT-ZERO
                   IF  SQLCODE = C-SQL-NOTFND

                       ADD  +1              TO A-ERROR-COUNT
                       MOVE 'Y'             TO W-CM-MENUM-C
                       MOVE C-MSG-AT70015   TO W-MSG-ID

      ** t~p?so?  ?/?3?/»·l~m/?.    

                   ELSE
                       IF (BUSN-OWNER-TP OF TTAAA = '4') AND
                          (W-CM-MENUM(4:2)       >= '90' AND
                           W-CM-MENUM(4:2)       <= '99')
                           IF  CLOSE-DT  OF TTAAA  > SPACE
                               PERFORM  S1910-CLOSE-YES-PROC
                           ELSE
                               PERFORM  S1920-CLOSE-NO-PROC
                           END-IF
                       ELSE
                           ADD  +1                TO A-ERROR-COUNT
                           MOVE 'Y'               TO W-CM-MENUM-C
                           MOVE C-MSG-AT70050     TO W-MSG-ID
                       END-IF
                   END-IF
               END-IF
           END-IF.

       S1900-MENSE-CODE-CHK-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 1 0 - C L O S E - Y E S - P R O C              *
      *                                                                *
      ******************************************************************

       S1910-CLOSE-YES-PROC             SECTION.

           IF W-CM-RTNFG = '3'

              PERFORM     S2000-PAUP-CHK-PROC

           ELSE

              IF  W-CM-RTNFG = '7'

                  PERFORM     S2100-PAUP-CHK-PRO2

               ELSE

                  PERFORM     S2150-PAUP-CHK-PRO3

               END-IF

           END-IF.


       S1910-CLOSE-YES-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 2 0 - C L O S E - N O - P R O C                *
      *                                                                *
      ******************************************************************

       S1920-CLOSE-NO-PROC              SECTION.

      *?7?7t~i?
           MOVE  W-CM-MENUM             TO  BUSNID  OF TTBAA.
           MOVE  RGST-OPEN-DT OF TTAAA  TO  RGST-OPEN-DT  OF TTBAA.
           MOVE  '2'                    TO  RCVE-TP       OF TTBAA.

           PERFORM  S6900-SELECT-TTBAA-M

           IF  A-ERROR-COUNT-ZERO

               IF  SQLCODE              =   C-SQL-NOTFND

                   CONTINUE

               ELSE

                   ADD  +1            TO A-ERROR-COUNT
                   MOVE 'Y'           TO W-CM-MENUM-C
                   MOVE 'RC03'        TO W-COMM-RC
                   MOVE W-K-TXOFF     TO W-COMM-MSG(1:3)
                   MOVE '-'           TO W-COMM-MSG(4:1)
                   MOVE W-K-YEAR      TO W-COMM-MSG(5:4)
                   MOVE '-'           TO W-COMM-MSG(9:1)
                   MOVE W-K-NO        TO W-COMM-MSG(10:7)

               END-IF

           END-IF.

      *L¦¸3t~i?
           IF  A-ERROR-COUNT-ZERO
               MOVE  W-CM-MENUM             TO  BUSNID  OF TTBAA
               MOVE  RGST-OPEN-DT OF TTAAA  TO  RGST-OPEN-DT  OF TTBAA
               MOVE  '3'                    TO  RCVE-TP       OF TTBAA

               PERFORM  S6900-SELECT-TTBAA-M

               IF  A-ERROR-COUNT-ZERO

                   IF  SQLCODE              =   C-SQL-NOTFND

                       CONTINUE

                   ELSE

                       ADD  +1            TO A-ERROR-COUNT
                       MOVE 'Y'           TO W-CM-MENUM-C
                       MOVE 'RC02'        TO W-COMM-RC
                       MOVE W-K-TXOFF     TO W-COMM-MSG(1:3)
                       MOVE '-'           TO W-COMM-MSG(4:1)
                       MOVE W-K-YEAR      TO W-COMM-MSG(5:4)
                       MOVE '-'           TO W-COMM-MSG(9:1)
                       MOVE W-K-NO        TO W-COMM-MSG(10:7)

                   END-IF

               END-IF
           END-IF.

      *?a?3t~i?
           IF  A-ERROR-COUNT-ZERO
               MOVE  W-CM-MENUM             TO  BUSNID  OF TTBAA
               MOVE  RGST-OPEN-DT OF TTAAA  TO  RGST-OPEN-DT  OF TTBAA
               MOVE  '4'                    TO  RCVE-TP       OF TTBAA

               PERFORM  S6900-SELECT-TTBAA-M

               IF  A-ERROR-COUNT-ZERO

                   IF  SQLCODE              =   C-SQL-NOTFND

      *?a?3t~i?hV?~  ?4?/~?DB PROCESS
                       PERFORM  S1960-DB-PROC

                   ELSE

                       PERFORM  S7000-SELECT-TTBAG

                       IF  A-ERROR-COUNT-ZERO

                           PERFORM  S1950-TTBAG-CHK

                       END-IF
                   END-IF

               END-IF
           END-IF.

       S1920-CLOSE-NO-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 5 0 - T T B A G - C H K                        *
      *                                                                *
      ******************************************************************

       S1950-TTBAG-CHK                  SECTION.

           IF  W-CM-RTNFG        =  '3'
               IF  SUSPEND-CLOSE-CS OF TTBAG  = 'G05'
                   CONTINUE
               ELSE
                   ADD  +1             TO A-ERROR-COUNT
                   MOVE 'Y'            TO W-CM-MENUM-C
                   MOVE C-MSG-AT70060  TO W-MSG-ID
               END-IF
           ELSE
               IF  W-CM-RTNFG    =  '7'
                   IF  SUSPEND-CLOSE-CS OF TTBAG  = 'G11'
                       CONTINUE
                   ELSE
                       ADD  +1             TO A-ERROR-COUNT
                       MOVE 'Y'            TO W-CM-MENUM-C
                       MOVE C-MSG-AT70065  TO W-MSG-ID
                   END-IF
               ELSE
                   IF  W-CM-RTNFG   =  '8'
                       IF  SUSPEND-CLOSE-CS OF TTBAG  = 'G12'
                           CONTINUE
                       ELSE
                           ADD  +1             TO A-ERROR-COUNT
                           MOVE 'Y'            TO W-CM-MENUM-C
                           MOVE C-MSG-AT70065  TO W-MSG-ID
                       END-IF
                   END-IF
               END-IF
           END-IF.

       S1950-TTBAG-CHK-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 6 0 - D B - P R O C                            *
      *                                                                *
      ******************************************************************

       S1960-DB-PROC                    SECTION.

           INITIALIZE  TRWAD
                       TTBAA
                       TTBAG.

           PERFORM  S9100-GET-SYSTEM-DATA.

           MOVE W-DB2DATE(1:4)         TO W-DB2-DT(1:4)
           MOVE W-DB2DATE(6:2)         TO W-DB2-DT(5:2)
           MOVE W-DB2DATE(9:2)         TO W-DB2-DT(7:2)

      *?3?a[?saÚç  t?  ?3?auVJ~  ?p?7

           PERFORM    S3000-TRWAD-RCVE-NO-CRET

           IF  A-ERROR-COUNT-ZERO

               PERFORM S1970-TRWAD-PROC
               PERFORM S1980-TTBAA-PROC
               PERFORM S1990-TTBAG-PROC

           END-IF.

       S1960-DB-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 7 0 - T R W A D - P R O C                      *
      *                                                                *
      ******************************************************************

       S1970-TRWAD-PROC                 SECTION.

           MOVE RESID-CHIEF OF TTAAA      TO TXPAYER-ID     OF TRWAD
           MOVE BUSNID OF TTAAA           TO RESID-BUSNID   OF TRWAD
           MOVE TXPAYER-TP-CHIEF OF TTAAA TO TXPAYER-TP     OF  TRWAD

           EVALUATE  W-CM-RTNFG
               WHEN  '3'
                    MOVE 'D4011'  TO TX-SRVC-TP     OF TRWAD
               WHEN  '7'
                    MOVE 'D0003'  TO TX-SRVC-TP     OF TRWAD
               WHEN  '8'
                    MOVE 'D0003'  TO TX-SRVC-TP     OF TRWAD
           END-EVALUATE.

           MOVE '1'               TO RCVE-METHOD    OF TRWAD
           MOVE '1'               TO TREAT-METHOD   OF TRWAD
           MOVE '1'               TO DISTR-METHOD   OF TRWAD
           MOVE W-DB2-DT          TO RCVE-DT        OF TRWAD
           MOVE W-COMM-TX-OFFCR-CD   TO TX-OFFCR-RCVE  OF TRWAD
           MOVE '21'              TO TREAT-STAUS    OF TRWAD

      *tv?vTABEL¹¦INSERT {çþ~                    
           PERFORM  S4700-TRWAD-INSERT.

           IF  SQLCODE = -803

      *tv?vTABEL¹¦INSERT?~?3?auVJ~h/  ?pvsu¬Úp?~  {çþ~

               MOVE ZERO       TO W-INDEX
               ADD +1          TO RCVE-NO-SEQNO  OF TRWAD
               MOVE RCVE-NO-SEQNO         OF TRWAD
                               TO RCVE-NO        OF TTBAA

               PERFORM   VARYING  W-INDEX FROM +1 BY +1
                                   UNTIL W-INDEX > 105

                   PERFORM    S4700-TRWAD-INSERT

                   IF  SQLCODE = -803

                       IF  W-INDEX = 100

                           ADD +1
                               TO A-ERROR-COUNT
                           ADD +110
                               TO W-INDEX
                       ELSE

                            ADD +1
                               TO RCVE-NO-SEQNO  OF TRWAD

                       END-IF

                   ELSE

                       ADD +110       TO W-INDEX
                       MOVE RCVE-NO-SEQNO  OF TRWAD
                                      TO RCVE-NO      OF TTBAA
                   END-IF

               END-PERFORM

           END-IF.

       S1970-TRWAD-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 8 0 - T T B A A - P R O C                      *
      *                                                                *
      ******************************************************************

       S1980-TTBAA-PROC                 SECTION.

           MOVE W-DB2-DT                  TO RQST-DT  OF TTBAA.
           MOVE '4'                       TO RCVE-TP  OF TTBAA.
           MOVE RGST-OPEN-DT  OF TTAAA    TO RGST-OPEN-DT  OF TTBAA.
           MOVE W-CM-MENUM                TO BUSNID  OF TTBAA.
           MOVE W-COMM-TX-OFFCR-CD        TO TX-OFFCR-SRVC  OF TTBAA.
           MOVE TX-OFFCR-CD OF TTAAA      TO TX-OFFCR-DETRM  OF TTBAA.
           MOVE TXOFF-CD    OF TTAAA      TO TXOFF-CD-PR     OF TTBAA.
           MOVE W-COMM-TXOFF-CD           TO TXOFF-CD-SRVC   OF TTBAA.
           MOVE 'N'                       TO PROCESS-END-FG  OF TTBAA.
           MOVE 'Y'                       TO RTN-FG   OF TTBAA.
           MOVE SPACE                     TO TREAT-DT OF TTBAA.
           MOVE RESID-CHIEF OF TTAAA      TO RESID-CHIEF OF TTBAA
           MOVE TXPAYER-TP-CHIEF OF TTAAA TO TXPAYER-TP-CHIEF OF TTBAA
           MOVE BUSN-OWNER-TP    OF TTAAA TO BUSN-OWNER-TP    OF TTBAA

           PERFORM  S4200-INSERT-TTBAA.

       S1980-TTBAA-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 1 9 9 0 - T T B A G - P R O C                      *
      *                                                                *
      ******************************************************************

       S1990-TTBAG-PROC                 SECTION.

           MOVE TXOFF-CD  OF TTBAA    TO TXOFF-CD   OF TTBAG
           MOVE RCVE-NO   OF TTBAA    TO RCVE-NO    OF TTBAG
           MOVE RCVE-YEAR OF TTBAA    TO RCVE-YEAR  OF TTBAG

           MOVE W-DB2-DT               TO CLOSE-DT OF TTBAG.

           EVALUATE  W-CM-RTNFG
               WHEN  '3'
                    MOVE 'G05'         TO SUSPEND-CLOSE-CS OF TTBAG
               WHEN  '7'
                    MOVE 'G11'         TO SUSPEND-CLOSE-CS OF TTBAG
               WHEN  '8'
                    MOVE 'G12'         TO SUSPEND-CLOSE-CS OF TTBAG
           END-EVALUATE.

           MOVE W-CM-AIVSTFG           TO ACTL-IVST-FG OF TTBAG
040519*    MOVE 'Y'                    TO CLOSE-RTN-TP OF TTBAG,
040519     MOVE '3'                    TO CLOSE-RTN-TP OF TTBAG,

           PERFORM  S7100-INSERT-TTBAG.

       S1990-TTBAG-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 2 0 0 0 - P A U P - C H K - P R O C                *
      *                                                                *
      ******************************************************************

       S2000-PAUP-CHK-PROC              SECTION.

      * ?a?3CHECK{çþ~    

           MOVE BUSNID       OF TTAAA   TO BUSNID       OF TTAAC.
           MOVE RGST-OPEN-DT OF TTAAA   TO RGST-OPEN-DT OF TTAAC.

           PERFORM      S5600-MAX-TTAAC.

           IF  SQLCODE = C-SQL-NOTFND OR
               SQLCODE = -305

               ADD  +1                  TO A-ERROR-COUNT
               MOVE 'Y'                 TO W-CM-MENUM-C
               MOVE C-MSG-AT70080       TO W-MSG-ID

      **?a?3}?  ?/?3?/h/  ?/l?l~m/?.

           ELSE

               PERFORM      S5700-SELECT-TTAAC

               IF  SQLCODE = C-SQL-NOTFND

                   ADD  +1                  TO A-ERROR-COUNT
                   MOVE 'Y'                 TO W-CM-MENUM-C
                   MOVE C-MSG-AT70070       TO W-MSG-ID

      ** ~?[??~?~}?  I¦»~H/h/  ?~??I¦»~x¬¹?  ?4ù°l~m/?.

               ELSE

                   IF  HISTORY-TP  OF TTAAC = 'G05'

                       CONTINUE

                   ELSE

                       ADD  +1                  TO A-ERROR-COUNT
                       MOVE 'Y'                 TO W-CM-MENUM-C
                       MOVE C-MSG-AT70060       TO W-MSG-ID

                   END-IF


               END-IF

           END-IF.

       S2000-PAUP-CHK-PROC-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 2 1 0 0 - P A U P - C H K - P R O 2                *
      *                                                                *
      ******************************************************************

       S2100-PAUP-CHK-PRO2              SECTION.

      * ?a?3CHECK{çþ~    

           MOVE BUSNID       OF TTAAA   TO BUSNID       OF TTAAC.
           MOVE RGST-OPEN-DT OF TTAAA   TO RGST-OPEN-DT OF TTAAC.

           PERFORM      S5600-MAX-TTAAC.

           IF  SQLCODE = C-SQL-NOTFND OR
               SQLCODE = -305

               ADD  +1                  TO A-ERROR-COUNT
               MOVE 'Y'                 TO W-CM-MENUM-C
               MOVE C-MSG-AT70080       TO W-MSG-ID
      **?a?3}?  ?/?3?/h/  ?/l?l~m/?.

           ELSE

               PERFORM      S5700-SELECT-TTAAC

               IF  SQLCODE = C-SQL-NOTFND

                   ADD  +1                  TO A-ERROR-COUNT
                   MOVE 'Y'                 TO W-CM-MENUM-C
                   MOVE C-MSG-AT70070       TO W-MSG-ID
      ** ~?[??~?~}Ýá(?a?3}Ýá)n¦»~H/h/  ?~??I¦»~x¬¹?  ?4ù°l~m/?.

               ELSE

                   IF  HISTORY-TP  OF TTAAC = 'G11'

                       CONTINUE

                   ELSE

                       ADD  +1                  TO A-ERROR-COUNT
                       MOVE 'Y'                 TO W-CM-MENUM-C
                       MOVE C-MSG-AT70065       TO W-MSG-ID
      **?a?3?/»¦h/  iA~?[?  i??3?a?3?~  ?/l?l~m/?.
                   END-IF

               END-IF

           END-IF.


       S2100-PAUP-CHK-PRO2-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 2 1 5 0 - P A U P - C H K - P R O 3                *
      *                                                                *
      ******************************************************************

       S2150-PAUP-CHK-PRO3              SECTION.

      * ?a?3CHECK{çþ~    

           MOVE BUSNID       OF TTAAA   TO BUSNID       OF TTAAC.
           MOVE RGST-OPEN-DT OF TTAAA   TO RGST-OPEN-DT OF TTAAC.

           PERFORM      S5600-MAX-TTAAC.

           IF  SQLCODE = C-SQL-NOTFND OR
               SQLCODE = -305

               ADD  +1                  TO A-ERROR-COUNT
               MOVE 'Y'                 TO W-CM-MENUM-C
               MOVE C-MSG-AT70080       TO W-MSG-ID
      **?a?3}?  ?/?3?/h/  ?/l?l~m/?.

           ELSE

               PERFORM      S5700-SELECT-TTAAC

               IF  SQLCODE = C-SQL-NOTFND

                   ADD  +1                  TO A-ERROR-COUNT
                   MOVE 'Y'                 TO W-CM-MENUM-C
                   MOVE C-MSG-AT70070       TO W-MSG-ID
      ** ~?[??~?~}Ýá(?a?3}Ýá)n¦»~H/h/  ?~??I¦»~x¬¹?  ?4ù°l~m/?.

               ELSE

                   IF  HISTORY-TP  OF TTAAC = 'G12'

                       CONTINUE

                   ELSE

                       ADD  +1                  TO A-ERROR-COUNT
                       MOVE 'Y'                 TO W-CM-MENUM-C
                       MOVE C-MSG-AT70065       TO W-MSG-ID
      **?a?3?/»¦h/  iA~?[?  i??3?a?3?~  ?/l?l~m/?.
                   END-IF

               END-IF

           END-IF.


       S2150-PAUP-CHK-PRO3-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 2 3 0 0 - T T J B C - N O T - C H E C K - A        *
      *                                                                *
      ******************************************************************

       S2300-TTJBC-NOT-CHECK-A          SECTION.

           IF   SQLCODE  = C-SQL-NOTFND

                ADD  +1                  TO A-ERROR-COUNT
                MOVE 'Y'                 TO W-CM-OFFCR-CD-C
                MOVE C-MSG-AT00019       TO W-MSG-ID
      *[¦¼S  m?mÖ¼/??  »·??}/ù·?~?~?.
           ELSE

                MOVE W-CM-OFFCR-CD       TO TX-OFFCR-DETRM OF TTBAA

                MOVE RESID  OF TTJBC     TO RESID  OF TTJBD
                MOVE TXPAYER-TP OF TTJBC TO TXPAYER-TP  OF TTJBD
                PERFORM  S6310-SELECT-TTJBD

                IF  SQLCODE  =  C-SQL-NORMAL
                    MOVE SPACE              TO W-SSSHE-I-DATA
                    MOVE NM   OF TTJBD      TO W-SSSHE-I-DATA
                    MOVE +20                TO W-SSSHE-I-LENGTH
                    CALL C-PGM-SSSHE USING  W-SSSHE-I-LENGTH
                                            W-SSSHE-I-DATA
                                            W-SSSHE-STATUS
                    MOVE W-SSSHE-I-DATA     TO W-CM-OFFCR-NM
                END-IF

           END-IF.

       S2300-TTJBC-NOT-CHECK-A-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 2 5 0 0 - C U R T - D A T E - P U S - C H K        *
      *                                                                *
      ******************************************************************

       S2500-CURT-DATE-PUS-CHK         SECTION.

           MOVE W-DB2DATE(1:4)         TO W-SSSDI-DATE(1:4)
           MOVE W-DB2DATE(6:2)         TO W-SSSDI-DATE(5:2)
           MOVE W-DB2DATE(9:2)         TO W-SSSDI-DATE(7:2)
           MOVE 'A'                    TO W-SSSDI-CTL.
           MOVE 'J'                    TO W-SSSDI-HYIL.
           MOVE +1                     TO W-SSSDI-ILSUR.
           MOVE  1                     TO W-INDEX3.

           PERFORM  UNTIL  W-INDEX3 > 6

               PERFORM UNTIL   W-SSSDI-HYIL NOT = 'J'

                   MOVE SPACE          TO W-SSSDI-HYIL

                   EXEC SQL SET CURRENT PACKAGESET = 'NTA'
                   END-EXEC

                   CALL C-PGM-SSSDI    USING  W-SSSDI-AREA

                   EXEC SQL SET CURRENT PACKAGESET = '   '
                   END-EXEC

                   MOVE +1             TO W-SSSDI-ILSUR

               END-PERFORM

               MOVE 'J'                TO W-SSSDI-HYIL
               ADD 1                   TO W-INDEX3

           END-PERFORM.

           IF  W-SSSDI-STATUS = 'DE'

               EXEC SQL SET CURRENT PACKAGESET = '   '
               END-EXEC

               ADD  1              TO A-ERROR-COUNT
               MOVE 'S2500-SSSDI-ERROR'
                                   TO W-COMM-MSG


           END-IF.

       S2500-CURT-DATE-PUS-CHK-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *       S 2 6 0 0 - I N P UT - D A T A - M O V E                 *
      *                                                                *
      ******************************************************************

       S2600-INPUT-DATA-MOVE           SECTION.

           IF   W-CM-BUSNTP = '4' OR
                W-CM-BUSNTP = '5' OR
                W-CM-BUSNTP = '6'

                MOVE '4'               TO BUSN-OWNER-TP     OF TTBAA

           ELSE

                MOVE W-CM-BUSNTP       TO BUSN-OWNER-TP     OF TTBAA

           END-IF.

           MOVE W-CM-LGDONG-TXOFF      TO TXOFF-CD-PR       OF TTBAA.
           MOVE SPACE                  TO PRE-IVST-FG       OF TTBAB.

           MOVE W-DB2DATE(1:4)         TO RCVE-YEAR         OF TTBAA.
           MOVE '1'                    TO RCVE-TP           OF TTBAA.
           MOVE 'N'                    TO PROCESS-END-FG    OF TTBAA.
           MOVE 'Y'                    TO RTN-FG            OF TTBAA.
040320     MOVE W-CM-OFFCR-CD          TO TX-OFFCR-CD       OF TTBAB.
           MOVE W-CM-RTNFG             TO BUSNID-DIST-TP    OF TTBAB.
0529       IF  W-CM-RTNFG              =  '3' OR '7' OR '8'
               MOVE 'Y'                TO VAT-FG            OF TTBAB
           ELSE
               MOVE SPACE              TO VAT-FG            OF TTBAB
           END-IF.
           MOVE W-CM-BUSNTP            TO VAT-TP            OF TTBAB.

           IF   W-CM-JUUP  = SPACE OR
                W-CM-JUUP  = LOW-VALUE

                MOVE SPACE             TO BUSNTP-CD         OF TTBAC

           ELSE

                MOVE W-CM-JUUP         TO BUSNTP-CD         OF TTBAC

           END-IF.

           IF   W-CM-UP    = SPACE      OR
                W-CM-UP    = LOW-VALUE

                MOVE SPACE             TO BUSNSECT-NM       OF TTBAC

           ELSE

                MOVE W-CM-UP           TO BUSNSECT-NM       OF TTBAC

           END-IF.

           IF   W-CM-JO  = SPACE OR
                W-CM-JO  = LOW-VALUE

                MOVE SPACE             TO ITEM-NM           OF TTBAC

           ELSE

                MOVE W-CM-JO           TO ITEM-NM           OF TTBAC

           END-IF.

           MOVE 'Y'                    TO MAIN-BUSNTP-FG    OF TTBAC.
           MOVE W-CM-OWNFG             TO BUSN-OWN-TP       OF TTBAB.

           IF   W-CM-BUSNTP = '5' OR '6'

                MOVE 'Y'               TO APPV-CORP-FG      OF TTBAB

           ELSE

                MOVE SPACE             TO APPV-CORP-FG      OF TTBAB

           END-IF.

      *æ¦?b?v?a?/?~?v[?H?p?s?/wa
            MOVE SPACE             TO FORE-EXCT-FG      OF TTBAB
      *iEÚç¼Ö~?m?½¦æ¦?/wa
            MOVE SPACE             TO TXOFF-EXCT-FG     OF TTBAB

      *Êß[~[?awe
           IF   W-CM-SPETAX = SPACE OR LOW-VALUE

                MOVE SPACE             TO CONSMTX-ASS-TP    OF TTBAB

           ELSE

                MOVE W-CM-SPETAX       TO CONSMTX-ASS-TP    OF TTBAB

           END-IF.

       S2600-INPUT-DATA-MOVE-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *                D B 2   A R E A                                 *
      *                                                                *
      ******************************************************************

      ******************************************************************
      *                                                                *
      *           S 3 0 0 0 - T R W A D - R C V E - N O - C R E T      *
      *                                                                *
      ******************************************************************

       S3000-TRWAD-RCVE-NO-CRET        SECTION.

           MOVE W-CM-RCVETX            TO RCVE-NO-TXOFF  OF TRWAD.
           MOVE W-DB2-DT               TO RCVE-NO-YY     OF TRWAD.

           EXEC SQL SELECT MAX(RCVE_NO_SEQNO)
                      INTO :TRWAD.RCVE-NO-SEQNO
                      FROM  DRWA.TRWAD
                      WHERE RCVE_NO_TXOFF  = :TRWAD.RCVE-NO-TXOFF
                        AND RCVE_NO_YY     = :TRWAD.RCVE-NO-YY
                        AND RCVE_NO_SEQNO  <  7000000
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL

               IF RCVE-NO-SEQNO OF TRWAD = 6999999

                  ADD  1               TO A-ERROR-COUNT
                  MOVE C-MSG-AT15500   TO W-MSG-ID

               ELSE

                   ADD +1              TO RCVE-NO-SEQNO  OF TRWAD
                   MOVE RCVE-NO-SEQNO OF TRWAD
                                       TO RCVE-NO   OF TTBAA
                                          W-CM-RCVENO

                   MOVE RCVE-NO-YY OF TRWAD
                                       TO RCVE-YEAR OF TTBAA
                                          W-CM-RQSTYR

                   MOVE RCVE-NO-TXOFF OF TRWAD
                                       TO TXOFF-CD  OF TTBAA

               END-IF

           ELSE

               IF  SQLCODE = -305

                   MOVE +0000001       TO RCVE-NO-SEQNO OF TRWAD
                   MOVE RCVE-NO-SEQNO OF TRWAD
                                       TO RCVE-NO       OF TTBAA
                                          W-CM-RCVENO
                   MOVE RCVE-NO-YY OF TRWAD
                                       TO RCVE-YEAR     OF TTBAA
                                          W-CM-RQSTYR

                   MOVE RCVE-NO-TXOFF OF TRWAD
                                       TO TXOFF-CD  OF TTBAA

               ELSE

                   ADD   1                   TO  A-ERROR-COUNT
                   MOVE  SQLCODE             TO  W-SQL
                   MOVE  W-SQL               TO  W-COMM-RC
                   MOVE  'S3000-TRWAD-ERR'   TO  W-COMM-MSG

               END-IF

           END-IF.

       S3000-TRWAD-RCVE-NO-CRET-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 4 2 0 0 - I N S E R T - T T B A A                  *
      *                                                                *
      ******************************************************************

       S4200-INSERT-TTBAA              SECTION.

           EXEC  SQL    INSERT
                        INTO   DTBA.TTBAA
                             ( TXOFF_CD,
                               RCVE_YEAR,
                               RCVE_NO,
                               RESID_CHIEF,
                               BUSN_OWNER_TP,
                               TXPAYER_TP_CHIEF,
                               RQST_DT,
                               RTN_FG,
                               RCVE_TP,
                               BUSNID,
                               TX_OFFCR_SRVC,
                               TX_OFFCR_DETRM,
                               TX_OFFCR_CONF,
                               RGST_OPEN_DT,
                               PROCESS_END_FG,
                               TREAT_DT,
                               TREAT_DUEDT,
                               TXOFF_CD_SRVC,
                               TXOFF_CD_PR)

                        VALUES

                            ( :TTBAA.TXOFF-CD,
                              :TTBAA.RCVE-YEAR,
                              :TTBAA.RCVE-NO,
                              :TTBAA.RESID-CHIEF,
                              :TTBAA.BUSN-OWNER-TP,
                              :TTBAA.TXPAYER-TP-CHIEF,
                              :TTBAA.RQST-DT,
                              :TTBAA.RTN-FG,
                              :TTBAA.RCVE-TP,
                              :TTBAA.BUSNID,
                              :TTBAA.TX-OFFCR-SRVC,
                              :TTBAA.TX-OFFCR-DETRM,
                              :TTBAA.TX-OFFCR-CONF,
                              :TTBAA.RGST-OPEN-DT,
                              :TTBAA.PROCESS-END-FG,
                              :TTBAA.TREAT-DT,
                              :TTBAA.TREAT-DUEDT,
                              :TTBAA.TXOFF-CD-SRVC,
                              :TTBAA.TXOFF-CD-PR)

           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = -803

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S4200-TTBAA-ERR'   TO  W-COMM-MSG

           END-IF.

       S4200-INSERT-TTBAA-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *           S 4 3 0 0 - I N S E R T - T T B A B                  *
      *                                                                *
      ******************************************************************

       S4300-INSERT-TTBAB               SECTION.

           EXEC  SQL    INSERT
                        INTO   DTBA.TTBAB
                             ( TXOFF_CD,
                               RCVE_YEAR,
                               RCVE_NO,
                               TRADE_NM,
                               TELNO,
                               RES_TELNO,
                               BUSNID_JUST_BEF,
                               BUSN_OWN_TP,
                               RESID_BUSNID_OWNER,
                               HQBR_FG,
                               RENT_DEPOSIT_AMT,
                               MON_RENTAMT,
                               AREA_BD,
                               CAPT_HISOWN,
                               CAPT_OTH_PRSN,
                               BUSNID_DIST_TP,
                               TXPAYER_TP_OWNER,
                               BUSN_YEAR_FR_MM,
                               BUSN_YEAR_FR_DD,
                               BUSN_YEAR_TO_MM,
                               BUSN_YEAR_TO_DD,
                               COMP_TP_CD,
                               CORP_ID,
                               CORP_CHAR_CD,
                               TOT_STK_QTY,
                               FACE_AMT_1STK,
                               CAPT,
                               SETUP_DT,
                               CORP_TP_CD,
                               PUB_CORP_FG,
                               BUSNID_HQ,
                               JOIN_DT_HQBR,
                               JOIN_DT,
                               EMP_CNT,
                               LGDONG_CD,
                               SAN_BUNJI,
                               BUNJI,
                               HO,
                               APT_BLOCK,
                               APT_DONG,
                               APT_HO,
                               TONG,
                               BAN,
                               BUSN_SHARE_FG,
                               PUBPROF_TP,
                               CHNG_RQST_FG,
040320                         TX_OFFCR_CD,
                               WITHHD_DUTY_FG,
040320                         WITHHD_DUTY_TP,
                               CHNG_RQST_DT,
                               CHNG_DUEDT,
                               ALCOHOL_TP,
                               EDUTX_FG,
                               CONSMTX_ASS_TP,
                               IVST_CNTRY_1,
                               IVST_CNTRY_2,
                               IVST_CNTRY_3,
                               IVST_RT_1,
                               IVST_RT_2,
                               IVST_RT_3,
                               CITIZENSHIP,
                               APPV_BUSN_FG,
                               IVST_MONEY,
                               APPV_CORP_FG,
                               PUBPROF_FG,
                               PUBPROF_AGENT,
                               PRE_IVST_FG,
                               VAT_FG,
                               VAT_TP,
                               PUB_JOB_TP,
                               FORE_EXCT_FG,
                               TXOFF_EXCT_FG,
      *                        SECRET_NO,
                               TRADE_NM1,
                               APT_BLOCK1,
                               APT_DONG1,
                               APT_HO1,
                               CELL_PHONE1,
                               APT_BLOCK2)

                        VALUES

                             (:TTBAB.TXOFF-CD,
                              :TTBAB.RCVE-YEAR,
                              :TTBAB.RCVE-NO,
                              :TTBAB.TRADE-NM,
                              :TTBAB.TELNO,
                              :TTBAB.RES-TELNO,
                              :TTBAB.BUSNID-JUST-BEF,
                              :TTBAB.BUSN-OWN-TP,
                              :TTBAB.RESID-BUSNID-OWNER,
                              :TTBAB.HQBR-FG,
                              :TTBAB.RENT-DEPOSIT-AMT,
                              :TTBAB.MON-RENTAMT,
                              :TTBAB.AREA-BD,
                              :TTBAB.CAPT-HISOWN,
                              :TTBAB.CAPT-OTH-PRSN,
                              :TTBAB.BUSNID-DIST-TP,
                              :TTBAB.TXPAYER-TP-OWNER,
                              :TTBAB.BUSN-YEAR-FR-MM,
                              :TTBAB.BUSN-YEAR-FR-DD,
                              :TTBAB.BUSN-YEAR-TO-MM,
                              :TTBAB.BUSN-YEAR-TO-DD,
                              :TTBAB.COMP-TP-CD,
                              :TTBAB.CORP-ID,
                              :TTBAB.CORP-CHAR-CD,
                              :TTBAB.TOT-STK-QTY,
                              :TTBAB.FACE-AMT-1STK,
                              :TTBAB.CAPT,
                              :TTBAB.SETUP-DT,
                              :TTBAB.CORP-TP-CD,
                              :TTBAB.PUB-CORP-FG,
                              :TTBAB.BUSNID-HQ,
                              :TTBAB.JOIN-DT-HQBR,
                              :TTBAB.JOIN-DT,
                              :TTBAB.EMP-CNT,
                              :TTBAB.LGDONG-CD,
                              :TTBAB.SAN-BUNJI,
                              :TTBAB.BUNJI,
                              :TTBAB.HO,
                              :TTBAB.APT-BLOCK,
                              :TTBAB.APT-DONG,
                              :TTBAB.APT-HO,
                              :TTBAB.TONG,
                              :TTBAB.BAN,
                              :TTBAB.BUSN-SHARE-FG,
                              :TTBAB.PUBPROF-TP,
                              :TTBAB.CHNG-RQST-FG,
                              :TTBAB.TX-OFFCR-CD,
                              :TTBAB.WITHHD-DUTY-FG,
                              :TTBAB.WITHHD-DUTY-TP,
                              :TTBAB.CHNG-RQST-DT,
                              :TTBAB.CHNG-DUEDT,
                              :TTBAB.ALCOHOL-TP,
                              :TTBAB.EDUTX-FG,
                              :TTBAB.CONSMTX-ASS-TP,
                              :TTBAB.IVST-CNTRY-1,
                              :TTBAB.IVST-CNTRY-2,
                              :TTBAB.IVST-CNTRY-3,
                              :TTBAB.IVST-RT-1,
                              :TTBAB.IVST-RT-2,
                              :TTBAB.IVST-RT-3,
                              :TTBAB.CITIZENSHIP,
                              :TTBAB.APPV-BUSN-FG,
                              :TTBAB.IVST-MONEY,
                              :TTBAB.APPV-CORP-FG,
                              :TTBAB.PUBPROF-FG,
                              :TTBAB.PUBPROF-AGENT,
                              :TTBAB.PRE-IVST-FG,
                              :TTBAB.VAT-FG,
                              :TTBAB.VAT-TP,
                              :TTBAB.PUB-JOB-TP,
                              :TTBAB.FORE-EXCT-FG,
                              :TTBAB.TXOFF-EXCT-FG,
      *                       :TTBAB.SECRET-NO,
                              :TTBAB.TRADE-NM1,
                              :TTBAB.APT-BLOCK1,
                              :TTBAB.APT-DONG1,
                              :TTBAB.APT-HO1,
                              :TTBAB.CELL-PHONE1,
                              :TTBAB.APT-BLOCK2)

           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S4300-TTBAB-ERR'   TO  W-COMM-MSG

           END-IF.

       S4300-INSERT-TTBAB-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *           S 4 3 1 0 - I N S E R T - T T B A M                  *
      *                                                                *
      ******************************************************************

       S4310-INSERT-TTBAM               SECTION.

           EXEC  SQL    INSERT
                        INTO   DTBA.TTBAM
                             ( TXOFF_CD,
                               RCVE_YEAR,
                               RCVE_NO,
                               EMAIL_ADDRESS)
                        VALUES

                             (:TTBAM.TXOFF-CD,
                              :TTBAM.RCVE-YEAR,
                              :TTBAM.RCVE-NO,
                              :TTBAM.EMAIL-ADDRESS)

           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL

                CONTINUE

           ELSE

               ADD   1                   TO  A-ERROR-COUNT
               MOVE  SQLCODE             TO  W-SQL
               MOVE  W-SQL               TO  W-COMM-RC
               MOVE  'S4310-TTBAM-ERR'   TO  W-COMM-MSG

           END-IF.

       S4310-INSERT-TTBAM-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *           S 4 4 0 0 - I N S E R T - T T B A C                  *
      *                                                                *
      ******************************************************************

       S4400-INSERT-TTBAC               SECTION.

           EXEC  SQL    INSERT
                        INTO   DTBA.TTBAC
                             ( TXOFF_CD,
                               RCVE_YEAR,
                               RCVE_NO,
                               BUSNTP_CD,
                               MAIN_BUSNTP_FG,
                               BUSNSECT_NM,
                               ITEM_NM )
                        VALUES

                             ( :TTBAC.TXOFF-CD,
                               :TTBAC.RCVE-YEAR,
                               :TTBAC.RCVE-NO,
                               :TTBAC.BUSNTP-CD,
                               :TTBAC.MAIN-BUSNTP-FG,
                               :TTBAC.BUSNSECT-NM,
                               :TTBAC.ITEM-NM )

           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S4400-TTBAC-ERR'   TO  W-COMM-MSG

           END-IF.

       S4400-INSERT-TTBAC-EXIT.
           EXIT.
       EJECT


      ******************************************************************
      *                                                                *
      *           S 4 7 0 0 - T R W A D - I N S E R T                  *
      *                                                                *
      ******************************************************************

       S4700-TRWAD-INSERT               SECTION.

           EXEC  SQL    INSERT
                        INTO   DRWA.TRWAD
                             ( RCVE_NO_YY,
                               RCVE_NO_TXOFF,
                               RCVE_NO_SEQNO,
                               TXPAYER_TP,
                               TXPAYER_ID,
                               RESID_BUSNID,
                               RESID_RQSTR,
040320                         TXPAYER_TP_RQSTR,
040320                         RTN_TP,
040320                         TREAT_METHOD,
                               DISTR_METHOD,
                               TX_SRVC_TP,
                               TREAT_STAUS,
                               RCVE_METHOD,
                               ISSUE_QTY,
                               ACTL_ISSUE_QTY,
                               TREAT_DUEDT,
                               TX_OFFCR_RCVE,
                               TX_OFFCR_APPV,
                               RCVE_DT,
                               TRNS_AGENCY)

                        VALUES

                             ( :TRWAD.RCVE-NO-YY,
                               :TRWAD.RCVE-NO-TXOFF,
                               :TRWAD.RCVE-NO-SEQNO,
                               :TRWAD.TXPAYER-TP,
                               :TRWAD.TXPAYER-ID,
                               :TRWAD.RESID-BUSNID,
                               :TRWAD.RESID-RQSTR,
                               :TRWAD.TXPAYER-TP-RQSTR,
                               :TRWAD.RTN-TP,
                               :TRWAD.TREAT-METHOD,
                               :TRWAD.DISTR-METHOD,
                               :TRWAD.TX-SRVC-TP,
                               :TRWAD.TREAT-STAUS,
                               :TRWAD.RCVE-METHOD,
                               :TRWAD.ISSUE-QTY,
                               :TRWAD.ACTL-ISSUE-QTY,
                               :TRWAD.TREAT-DUEDT,
                               :TRWAD.TX-OFFCR-RCVE,
                               :TRWAD.TX-OFFCR-APPV,
                               :TRWAD.RCVE-DT,
                               :TRWAD.TRNS-AGENCY)

           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = -803

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S4700-TRWAD-ERR'   TO  W-COMM-MSG

           END-IF.

       S4700-TRWAD-INSERT-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 4 8 0 0 - I N P U T - D U P L - C H E C K          *
      *                                                                *
      ******************************************************************

       S4800-INPUT-DUPL-CHECK           SECTION.

           EXEC  SQL   SELECT B.TXOFF_CD,
                              B.LGDONG_CD,
                              B.SAN_BUNJI,
                              B.BUNJI,
                              B.HO,
                              A.RESID_CHIEF,
                              A.RGST_OPEN_DT
                        INTO :TTBAB.TXOFF-CD,
                             :TTBAB.LGDONG-CD,
                             :TTBAB.SAN-BUNJI,
                             :TTBAB.BUNJI,
                             :TTBAB.HO,
                             :TTBAA.RESID-CHIEF,
                             :TTBAA.RGST-OPEN-DT
                        FROM  DTBA.TTBAA A, DTBA.TTBAB B
                        WHERE B.TXOFF_CD        = :TTBAB.TXOFF-CD
                          AND B.LGDONG_CD       = :TTBAB.LGDONG-CD
                          AND B.SAN_BUNJI       = :TTBAB.SAN-BUNJI
                          AND B.BUNJI           = :TTBAB.BUNJI
                          AND B.HO              = :TTBAB.HO
                          AND B.APT_DONG1       = :TTBAB.APT-DONG1
                          AND B.APT_HO1         = :TTBAB.APT-HO1
                          AND B.VAT_TP          = :TTBAB.VAT-TP
                          AND B.BUSNID_DIST_TP  = :TTBAB.BUSNID-DIST-TP
                          AND A.RESID_CHIEF     = :TTBAA.RESID-CHIEF
                          AND A.RGST_OPEN_DT    = :TTBAA.RGST-OPEN-DT
                          AND A.BUSN_OWNER_TP IN ( '1','2','3','4')
                          AND A.PROCESS_END_FG  = 'N'
                          AND A.TXOFF_CD        = B.TXOFF_CD
                          AND A.RCVE_YEAR       = B.RCVE_YEAR
                          AND A.RCVE_NO         = B.RCVE_NO
           END-EXEC.

           IF  SQLCODE = C-SQL-NORMAL  OR
               SQLCODE = C-SQL-NOTFND  OR
               SQLCODE = -811

               CONTINUE

           ELSE

               ADD   1                   TO  A-ERROR-COUNT
               MOVE  SQLCODE             TO  W-SQL
               MOVE  W-SQL               TO  W-COMM-RC
               MOVE  'S4800-TTBAB-ERR'   TO  W-COMM-MSG

           END-IF.

       S4800-INPUT-DUPL-CHECK-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *    S 5 3 0 0 - S E L E C T - T T I A A                        *
      *                                                               *
      *****************************************************************

       S5300-SELECT-TTIAA              SECTION.

           EXEC  SQL  SELECT  NM,
                              TXPAYER_TP,
                              ORG_RESID_CD,
                              ORG_CHNG_CD,
                              TELNO
                        INTO  :TTIAA.NM,
                              :TTIAA.TXPAYER-TP,
                              :TTIAA.ORG-RESID-CD,
                              :TTIAA.ORG-CHNG-CD,
                              :TTIAA.TELNO
                        FROM  DTIA.TTIAA
                       WHERE  RESID        = :TTIAA.RESID
                         AND  TXPAYER_TP   = :TTIAA.TXPAYER-TP
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S5300-TTIAA-ERR'   TO  W-COMM-MSG

           END-IF.

       S5300-SELECT-TTIAA-EXIT.
           EXIT.
       EJECT


      *****************************************************************
      *                                                               *
      *    S 5 5 0 0 - S E L E C T - T T A A A                        *
      *                                                               *
      *****************************************************************

       S5500-SELECT-TTAAA              SECTION.

           EXEC  SQL
                 SELECT RGST_OPEN_DT, BUSN_OWNER_TP,
                        STAT_CD_BUSN_OWNER, CLOSE_DT,
                        TRADE_NM1,
                        LGDONG_CD,
                        SAN_BUNJI,
                        BUNJI,
                        HO,
                        TONG,
                        BAN,
                        CHIEF_NM,
                        RESID_CHIEF,
                        TXPAYER_TP_CHIEF
                        INTO  :TTAAA.RGST-OPEN-DT,
                              :TTAAA.BUSN-OWNER-TP,
                              :TTAAA.STAT-CD-BUSN-OWNER,
                              :TTAAA.CLOSE-DT,
                              :TTAAA.TRADE-NM1,
                              :TTAAA.LGDONG-CD,
                              :TTAAA.SAN-BUNJI,
                              :TTAAA.BUNJI,
                              :TTAAA.HO,
                              :TTAAA.TONG,
                              :TTAAA.BAN,
                              :TTAAA.CHIEF-NM,
                              :TTAAA.RESID-CHIEF,
                              :TTAAA.TXPAYER-TP-CHIEF
                        FROM  DTAA.TTAAA
                        WHERE BUSNID  = :TTAAA.BUSNID
                          AND LAST_FG = 'Y'
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND OR
                SQLCODE = -811

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S5500-TTAAA-ERR'   TO  W-COMM-MSG

           END-IF.

       S5500-SELECT-TTAAA-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *    S 5 6 0 0 - M A X - T T A A C                              *
      *                                                               *
      *****************************************************************

       S5600-MAX-TTAAC                 SECTION.

           EXEC  SQL
                 SELECT MAX(HISTORY_PRD_FR)
                        INTO  :TTAAC.HISTORY-PRD-FR
                        FROM  DTAA.TTAAC
                        WHERE BUSNID       = :TTAAC.BUSNID
                          AND RGST_OPEN_DT = :TTAAC.RGST-OPEN-DT
                          AND HISTORY_TP   LIKE  'G__'
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = -305

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S5600-TTAAC-ERR'   TO  W-COMM-MSG


           END-IF.

       S5600-MAX-TTAAC-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *    S 5 7 0 0 - S E L E C T - T T A A C                        *
      *                                                               *
      *****************************************************************

       S5700-SELECT-TTAAC              SECTION.

           EXEC  SQL
                 SELECT HISTORY_TP
                        INTO  :TTAAC.HISTORY-TP
                        FROM  DTAA.TTAAC
                        WHERE BUSNID         = :TTAAC.BUSNID
                          AND RGST_OPEN_DT   = :TTAAC.RGST-OPEN-DT
                          AND HISTORY_PRD_FR = :TTAAC.HISTORY-PRD-FR
                          AND HISTORY_TP     LIKE 'G__'
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S5700-TTAAC-ERR'   TO  W-COMM-MSG

           END-IF.

       S5700-SELECT-TTAAC-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *    S 5 8 0 0 - S E L E C T - T T J A B                        *
      *                                                               *
      *****************************************************************

       S5800-SELECT-TTJAB              SECTION.

           EXEC  SQL
                 SELECT DECODE
                        INTO :TTJAB.DECODE
                        FROM  DTJA.TTJAB
                        WHERE CD_ID1=:TTJAB.CD-ID1
                        AND   CD_ID2=:TTJAB.CD-ID2
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL  OR
                SQLCODE = C-SQL-NOTFND

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S5800-TTJAB-ERR'   TO  W-COMM-MSG

           END-IF.

       S5800-SELECT-TTJAB-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *    S 5 9 0 0 - S E L E C T - T T J A D                        *
      *                                                               *
      *****************************************************************

       S5900-SELECT-TTJAD              SECTION.

           EXEC  SQL
                 SELECT SI_DO,
                        GU_SI_GUN,
                        DONG_UEP_MYUN,
                        GA_RHEE,
                        TXOFF_CD
                        INTO  :TTJAD.SI-DO,
                              :TTJAD.GU-SI-GUN,
                              :TTJAD.DONG-UEP-MYUN,
                              :TTJAD.GA-RHEE,
                              :TTJAD.TXOFF-CD
                        FROM  DTJA.TTJAD
                        WHERE LGDONG_CD = :TTJAD.LGDONG-CD
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S5900-TTJAD-ERR'   TO  W-COMM-MSG

           END-IF.

       S5900-SELECT-TTJAD-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *     S 6 1 0 0 - S E L E C T - T T J A C                       *
      *                                                               *
      *****************************************************************

       S6100-SELECT-TTJAC              SECTION.

           EXEC  SQL
                 SELECT ATTRIBUTE_YEAR
                        INTO :TTJAC.ATTRIBUTE-YEAR
                        FROM  DTJA.TTJAC
                        WHERE ATTRIBUTE_YEAR  = :TTJAC.ATTRIBUTE-YEAR
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND OR
                SQLCODE = -811

                CONTINUE

           ELSE

               ADD   1                   TO  A-ERROR-COUNT
               MOVE  SQLCODE             TO  W-SQL
               MOVE  W-SQL               TO  W-COMM-RC
               MOVE  'S6100-TTJAC-ERR'   TO  W-COMM-MSG

           END-IF.

       S6100-SELECT-TTJAC-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *     S 6 2 0 0 - S E L E C T - T T J A C 1                     *
      *                                                               *
      *****************************************************************

       S6200-SELECT-TTJAC1             SECTION.

           EXEC  SQL
                 SELECT STD_INCM_RT_CD
                        INTO :TTJAC.STD-INCM-RT-CD
                        FROM  DTJA.TTJAC
                        WHERE STD_INCM_RT_CD  = :TTJAC.STD-INCM-RT-CD
                          AND ATTRIBUTE_YEAR  = :TTJAC.ATTRIBUTE-YEAR
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND OR
                SQLCODE = -811

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S6200-TTJAC-ERR'   TO  W-COMM-MSG

           END-IF.

       S6200-SELECT-TTJAC1-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *   S 6 3 0 0 - S E L E C T - T T J B C
      *                                                               *
      *****************************************************************

       S6300-SELECT-TTJBC             SECTION.

           EXEC  SQL
                 SELECT TX_OFFCR_CD,
                        RESID,
                        TXPAYER_TP
                        INTO :TTJBC.TX-OFFCR-CD,
                             :TTJBC.RESID,
                             :TTJBC.TXPAYER-TP
                        FROM  DTJB.TTJBC
                        WHERE TXOFF_CD      = :TTJBC.TXOFF-CD
                        AND   TX_OFFCR_CD   = :TTJBC.TX-OFFCR-CD
                        AND   ASSIGN_PRD_TO = :TTJBC.ASSIGN-PRD-TO
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S6300-TTJBC-ERR'   TO  W-COMM-MSG

           END-IF.

       S6300-SELECT-TTJBC-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *   S 6 3 1 0 - S E L E C T - T T J B D                         *
      *                                                               *
      *****************************************************************

       S6310-SELECT-TTJBD             SECTION.

           EXEC  SQL
                 SELECT NM
                        INTO :TTJBD.NM
                        FROM  DTJB.TTJBD
                        WHERE RESID         = :TTJBD.RESID
                        AND   TXPAYER_TP    = :TTJBD.TXPAYER-TP
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S6310-TTJBD-ERR'   TO  W-COMM-MSG

           END-IF.

       S6310-SELECT-TTJBD-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *             S 6 4 0 0 - S E L E C T - T T J B H                *
      *                                                                *
      ******************************************************************

       S6400-SELECT-TTJBH          SECTION.

           EXEC  SQL  SELECT  TX_OFFCR_CD
                        INTO :TTJBH.TX-OFFCR-CD
                        FROM  DTJB.TTJBH
                       WHERE  TXOFF_CD       = :TTJBH.TXOFF-CD
                        AND   TX_OFFCR_CD_TP = :TTJBH.TX-OFFCR-CD-TP
                        AND   SAN_BUNJI      = :TTJBH.SAN-BUNJI
                        AND   LGDONG_CD      = :TTJBH.LGDONG-CD
                        AND ((BUNJI_FR      <  :TTJBH.BUNJI-FR )
                         OR  (BUNJI_FR       = :TTJBH.BUNJI-FR
                        AND   HO_FR         <= :TTJBH.HO-FR ))
                        AND ((BUNJI_TO      >  :TTJBH.BUNJI-FR)
                         OR  (BUNJI_TO       = :TTJBH.BUNJI-FR
                        AND   HO_TO         >= :TTJBH.HO-FR))
           END-EXEC.

           EVALUATE   SQLCODE

               WHEN   C-SQL-NORMAL

                      IF ( W-CM-OFFCR-CD = TX-OFFCR-CD OF TTJBH ) OR
                         ( W-CM-OFFCR-CD = SPACE OR LOW-VALUE)

                          MOVE TX-OFFCR-CD OF TTJBH
                                        TO TX-OFFCR-DETRM OF TTBAA
                                           W-CM-OFFCR-CD

                      ELSE

                          ADD +1       TO A-ERROR-COUNT
                          MOVE TX-OFFCR-CD OF TTJBH
                                       TO W-TXOFFCR-CD
                          MOVE W-TXOFFCR-NO-MSG
                                       TO W-COMM-MSG

                      END-IF

               WHEN   C-SQL-NOTFND

                      CONTINUE

               WHEN   -811

                      ADD +1              TO A-ERROR-COUNT
                      MOVE C-MSG-AT20090  TO W-MSG-ID

               WHEN   OTHER

                      ADD   1                   TO  A-ERROR-COUNT
                      MOVE  SQLCODE             TO  W-SQL
                      MOVE  W-SQL               TO  W-COMM-RC
                      MOVE  'S6400-TTJBH-ERR'   TO  W-COMM-MSG

           END-EVALUATE.

       S6400-SELECT-TTJBH-EXIT.

           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *               S 6 5 0 0 - I N S E R T - T T B A R              *
      *                                                                *
      ******************************************************************
                                                                        
       S6500-INSERT-TTBAR              SECTION.                         
                                                                        
           EXEC  SQL  INSERT                                            
                      INTO   DTBA.TTBAR                                 
                           ( TXOFF_CD,                                  
                             RCVE_YEAR,                                 
                             RCVE_NO,                                   
                             LGDONG_CD,                                 
                             SAN_BUNJI,                                 
                             BUNJI,                                     
                             HO,                                        
                             APT_BLOCK,                                 
                             APT_DONG,                                  
                             APT_HO,                                    
                             BAN,                                       
                             TONG,                                      
                             ADDR_TP,                                   
                             APT_BLOCK2)                                
                      VALUES                                            
                         ( :TTBAR.TXOFF-CD,                             
                           :TTBAR.RCVE-YEAR,                            
                           :TTBAR.RCVE-NO,                              
                           :TTBAR.LGDONG-CD,                            
                           :TTBAR.SAN-BUNJI,                            
                           :TTBAR.BUNJI,                                
                           :TTBAR.HO,                                   
                           :TTBAR.APT-BLOCK,                            
                           :TTBAR.APT-DONG,                             
                           :TTBAR.APT-HO,                               
                           :TTBAR.BAN,                                  
                           :TTBAR.TONG,                                 
                           :TTBAR.ADDR-TP,                              
                           :TTBAR.APT-BLOCK2)                           
                                                                        
           END-EXEC.                                                    
                                                                        
           IF   SQLCODE = C-SQL-NORMAL OR                               
                SQLCODE = -803                                          
                                                                        
                CONTINUE                                                
                                                                        
           ELSE                                                         
                                                                        
               ADD   1                   TO  A-ERROR-COUNT              
               MOVE  SQLCODE             TO  W-SQL                      
               MOVE  W-SQL               TO  W-COMM-RC                  
               MOVE  'S6500-TTBAR-ERR'   TO  W-COMM-MSG                 
                                                                        
           END-IF.                                                      
                                                                        
       S6500-INSERT-TTBAR-EXIT.                                         
           EXIT.                                                        
       EJECT                                                            
                                                                        
      ***************************************************************** 
      *                                                               * 
      *              S 6 6 0 0 - D B - U P D A T E - T T B A R        * 
      *                                                               * 
      ***************************************************************** 
                                                                        
       S6600-DB-UPDATE-TTBAR           SECTION.                         
                                                                        
           EXEC SQL UPDATE DTBA.TTBAR                                   
                    SET    ADDR_TP          = :TTBAR.ADDR-TP,           
                           LGDONG_CD        = :TTBAR.LGDONG-CD,         
                           SAN_BUNJI        = :TTBAR.SAN-BUNJI,         
                           BUNJI            = :TTBAR.BUNJI,             
                           HO               = :TTBAR.HO,                
                           APT_BLOCK        = :TTBAR.APT-BLOCK,         
                           APT_DONG         = :TTBAR.APT-DONG,          
                           APT_HO           = :TTBAR.APT-HO,            
                           TONG             = :TTBAR.TONG,              
                           BAN              = :TTBAR.BAN,               
                           APT_BLOCK2       = :TTBAR.APT-BLOCK2         
                    WHERE  TXOFF_CD       = :TTBAR.TXOFF-CD             
                      AND  RCVE_YEAR      = :TTBAR.RCVE-YEAR            
                      AND  RCVE_NO        = :TTBAR.RCVE-NO              
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL                                   
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
                                                                        
               ADD   1                   TO  A-ERROR-COUNT              
               MOVE  SQLCODE             TO  W-SQL                      
               MOVE  W-SQL               TO  W-COMM-RC                  
               MOVE  'S6600-TTBAR-ERR'   TO  W-COMM-MSG                 
                                                                        
           END-IF.                                                      
                                                                        
       S6600-DB-UPDATE-TTBAR-EXIT.                                      
           EXIT.                                                        
       EJECT                                                            
                                                                        
      ******************************************************************
      *                                                                *
      *            S 6 7 0 0 - S Q L - I N S E R T - T T B A U         *
      *                                                                *
      ******************************************************************
                                                                        
       S6700-SQL-INSERT-TTBAU          SECTION.                         
                                                                        
           EXEC SQL INSERT                                              
                      INTO    DTBA.TTBAU                                
                             (TXOFF_CD,                                 
                              RCVE_YEAR,                                
                              RCVE_NO,                                  
                              LICENSE_TXOFF_CD,                         
                              LICENSE_TP,                               
                              LICENSE_NO,                               
                              LICENSE_AREA_BD,                          
                              LGDONG_CD)                                
                     VALUES                                             
                            (:TTBAU.TXOFF-CD,                           
                             :TTBAU.RCVE-YEAR,                          
                             :TTBAU.RCVE-NO,                            
                             :TTBAU.LICENSE-TXOFF-CD,                   
                             :TTBAU.LICENSE-TP,                         
                             :TTBAU.LICENSE-NO,                         
                             :TTBAU.LICENSE-AREA-BD,                    
                             :TTBAU.LGDONG-CD)                          
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL OR                                
               SQLCODE = -803                                           
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
                                                                        
               ADD   1                   TO  A-ERROR-COUNT              
               MOVE  SQLCODE             TO  W-SQL                      
               MOVE  W-SQL               TO  W-COMM-RC                  
               MOVE  'S6700-TTBAU-ERR'   TO  W-COMM-MSG                 
                                                                        
           END-IF.                                                      
                                                                        
       S6700-SQL-INSERT-TTBAU-EXIT.                                     
           EXIT.                                                        
           EJECT                                                        
                                                                        
                                                                        
      ******************************************************************
      *                                                                *
      *            S 6 8 0 0 - S Q L - U P D A T E - T T B A U         *
      *                                                                *
      ******************************************************************
                                                                        
       S6800-SQL-UPDATE-TTBAU          SECTION.                         
                                                                        
           EXEC SQL UPDATE  DTBA.TTBAU                                  
                       SET  LICENSE_TXOFF_CD = :TTBAU.LICENSE-TXOFF-CD, 
                            LICENSE_TP       = :TTBAU.LICENSE-TP,       
                            LICENSE_NO       = :TTBAU.LICENSE-NO,       
                            LICENSE_AREA_BD  = :TTBAU.LICENSE-AREA-BD,  
                            LGDONG_CD        = :TTBAU.LGDONG-CD         
                     WHERE  TXOFF_CD         = :TTBAU.TXOFF-CD          
                       AND  RCVE_YEAR        = :TTBAU.RCVE-YEAR         
                       AND  RCVE_NO          = :TTBAU.RCVE-NO           
                                                                        
           END-EXEC.                                                    
                                                                        
           IF  SQLCODE = C-SQL-NORMAL OR                                
               SQLCODE = C-SQL-NOTFND                                   
                                                                        
               CONTINUE                                                 
                                                                        
           ELSE                                                         
                                                                        
               ADD   1                   TO  A-ERROR-COUNT              
               MOVE  SQLCODE             TO  W-SQL                      
               MOVE  W-SQL               TO  W-COMM-RC                  
               MOVE  'S6800-TTBAU-ERR'   TO  W-COMM-MSG                 
                                                                        
           END-IF.                                                      
                                                                        
       S6800-SQL-UPDATE-TTBAU-EXIT.                                     
           EXIT.                                                        
           EJECT                                                        
                                                                        
      *****************************************************************
      *                                                               *
      *    S 6 9 0 0 - S E L E C T - T T B A A - M                    *
      *                                                               *
      *****************************************************************

       S6900-SELECT-TTBAA-M            SECTION.

           EXEC  SQL
                 SELECT TXOFF_CD
                       ,RCVE_YEAR
                       ,RCVE_NO
                  INTO  :W-K-TXOFF
                       ,:W-K-YEAR
                       ,:W-K-NO
                  FROM  DTBA.TTBAA
                  WHERE BUSNID          = :TTAAA.BUSNID
                    AND RGST_OPEN_DT    = :TTAAA.RGST-OPEN-DT
                    AND PROCESS_END_FG <> 'Y'
                    AND RCVE_TP         = :TTBAA.RCVE-TP
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND OR
                SQLCODE = -811

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S6900-TTBAA-ERR'   TO  W-COMM-MSG

           END-IF.

       S6900-SELECT-TTBAA-M-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *    S 7 0 0 0 - S E L E C T - T T B A G                        *
      *                                                               *
      *****************************************************************

       S7000-SELECT-TTBAG              SECTION.

           EXEC  SQL
                 SELECT SUSPEND_CLOSE_CS
                  INTO  :TTBAG.SUSPEND-CLOSE-CS
                  FROM  DTBA.TTBAG
                  WHERE TXOFF_CD        = :W-K-TXOFF
                    AND RCVE_YEAR       = :W-K-YEAR
                    AND RCVE_NO         = :W-K-NO
           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = C-SQL-NOTFND

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S7000-TTBAG-ERR'   TO  W-COMM-MSG

           END-IF.

       S7000-SELECT-TTBAG-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *           S 7 1 0 0 - I N S E R T - T T B A G                  *
      *                                                                *
      ******************************************************************

       S7100-INSERT-TTBAG              SECTION.

           EXEC  SQL    INSERT
                        INTO   DTBA.TTBAG
                             ( TXOFF_CD
                              ,RCVE_YEAR
                              ,RCVE_NO
                              ,SUSPEND_PRD_FR
                              ,SUSPEND_PRD_TO
                              ,CLOSE_DT
                              ,SUSPEND_CLOSE_CS
                              ,BUSNID_WITHRL_TP
                              ,ACTL_IVST_FG
                              ,CLOSE_RTN_TP
                              ,BATCH_TP
                              ,SAYU_GITA  )

                        VALUES

                            ( :TTBAG.TXOFF-CD
                             ,:TTBAG.RCVE-YEAR
                             ,:TTBAG.RCVE-NO
                             ,:TTBAG.SUSPEND-PRD-FR
                             ,:TTBAG.SUSPEND-PRD-TO
                             ,:TTBAG.CLOSE-DT
                             ,:TTBAG.SUSPEND-CLOSE-CS
                             ,:TTBAG.BUSNID-WITHRL-TP
                             ,:TTBAG.ACTL-IVST-FG
                             ,:TTBAG.CLOSE-RTN-TP
                             ,:TTBAG.BATCH-TP
                             ,:TTBAG.SAYU-GITA  )

           END-EXEC.

           IF   SQLCODE = C-SQL-NORMAL OR
                SQLCODE = -803

                CONTINUE

           ELSE

                ADD   1                   TO  A-ERROR-COUNT
                MOVE  SQLCODE             TO  W-SQL
                MOVE  W-SQL               TO  W-COMM-RC
                MOVE  'S7100-TTBAG-ERR'   TO  W-COMM-MSG

           END-IF.

       S7100-INSERT-TTBAG-EXIT.
           EXIT.
       EJECT

      ******************************************************************
      *                                                                *
      *                   S 9 0 0 0 - R E A D - S U V 0 1              *
      *                                                                *
      ******************************************************************
       S9000-READ-SUV010               SECTION.

           EXEC CICS READ     FILE     ('SUV010')
                              INTO     (W-MESSAGE)
                              RIDFLD   (W-MSG-ID)
                              RESP     (W-RETURN-CODE)
           END-EXEC.

           IF  W-RETURN-NORMAL

               MOVE W-MSG-CONTENTS     TO W-COMM-MSG

           ELSE

               MOVE 'MESSAGE NOT-FOUND'
                                       TO W-COMM-MSG

           END-IF.

       S9000-READ-SUV010-EXIT.
           EXIT.

      ******************************************************************
      *                                                                *
      *            S 9 1 0 0 - G E T - S Y S T E M - D A T A           *
      *                                                                *
      ******************************************************************
                                                                        
       S9100-GET-SYSTEM-DATA SECTION.                                   
                                                                        
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
                                                                        
       S9100-GET-SYSTEM-DATA-EXIT.                                      
           EXIT.                                                        
           EJECT                                                        
      ******************************************************************
      *                                                                *
      *                 S 9 8 0 0 - L A S 1 0 - C A L L                *
      *                                                                *
      ******************************************************************

       S9800-LAS10-CALL                SECTION.

           EXEC SQL  SET CURRENT PACKAGESET='NTA'
           END-EXEC

           CALL C-PGM-LAS10  USING  W-LAS10-AREA

           EXEC SQL SET CURRENT PACKAGESET='   '
           END-EXEC.

       S9800-LAS10-CALL-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *                   S 9 9 0 0 - R E T U R N                      *
      *                                                                *
      *                     - RETURN TO CICS                           *
      *                                                                *
      ******************************************************************

       S9900-RETURN                    SECTION.

           EXEC CICS RETURN
           END-EXEC.

       S9900-RETURN-EXIT.
           EXIT.
       EJECT

      *****************************************************************
      *                                                               *
      *      ?/?~?/?j?a?/?~Èßwawe»·l~m/  ..END OF PROGRAM           *
      *                                                               *
      *****************************************************************
