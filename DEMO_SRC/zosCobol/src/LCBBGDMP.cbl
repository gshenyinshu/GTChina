      ****************************************************************
      *                                                              *
      *    I D E N T I F I C A T I O N    D I V I S I O N            *
      *                                                              *
      ****************************************************************

       IDENTIFICATION                    DIVISION.
       PROGRAM-ID.                       LCBBGDMP.
       AUTHOR.                           FNS.COM.
       DATE-WRITTEN                      2003-07-25.
       DATE-COMPILED.

      ****************************************************************
      *  HANDLER     :~/  t  aa/ TABLE UNLOAD            *
      *  DESCRIPTION :~/  t  aa/ TABLE UNLOAD            *
      *                                                              *
      *  TRANSACTION ID :                                            *
      *  JSP       FILE :                                            *
      *  JS        FILE :                                            *
      *  SERVLET   FILE :                                            *
      *  MAIN   PROGRAM : LCBBGDMP                                   *
      *                                                              *
      *  TABLE                                  CRUD                 *
      *  ==========================================================  *
      *                                                              *
      * viHISTORY                                                *
      * viz/      CSRuVJ~    3/    3a              *
      *  ==========   =========   ======   ========================  *
      *  2003/07/25              Bitv    BA~7                *
      ****************************************************************

      ****************************************************************
      *                                                              *
      *    E N V I R O N M E N T    D I V I S I O N                  *
      *                                                              *
      ****************************************************************
       ENVIRONMENT                       DIVISION.

       CONFIGURATION                     SECTION.

       SOURCE-COMPUTER.                  IBM.
       OBJECT-COMPUTER.                  IBM.

      ****************************************************************
      *                                                              *
      *    I N P U T - O U T P U T    S E C T I O N                  *
      *                                                              *
      ****************************************************************
       INPUT-OUTPUT                      SECTION.

       FILE-CONTROL.
           SELECT  OUT1-F  ASSIGN        TO  OUTSAM1
                   FILE    STATUS        IS  S-OUT1-STATUS.

           SELECT  OUT2-F  ASSIGN        TO  OUTSAM2
                   FILE    STATUS        IS  S-OUT2-STATUS.

           SELECT  OUT3-F  ASSIGN        TO  OUTSAM3
                   FILE    STATUS        IS  S-OUT3-STATUS.

           SELECT  OUT4-F  ASSIGN        TO  OUTSAM4
                   FILE    STATUS        IS  S-OUT4-STATUS.

           SELECT  OUT5-F  ASSIGN        TO  OUTSAM5
                   FILE    STATUS        IS  S-OUT5-STATUS.

           SELECT  OUT6-F  ASSIGN        TO  OUTSAM6
                   FILE    STATUS        IS  S-OUT6-STATUS.

           SELECT  OUT7-F  ASSIGN        TO  OUTSAM7
                   FILE    STATUS        IS  S-OUT7-STATUS.

           SELECT  OUT8-F  ASSIGN        TO  OUTSAM8
                   FILE    STATUS        IS  S-OUT8-STATUS.

           SELECT  OUT9-F  ASSIGN        TO  OUTSAM9
                   FILE    STATUS        IS  S-OUT9-STATUS.

      ****************************************************************
      *                                                              *
      *    D A T A    D I V I S I O N                                *
      *                                                              *
      ****************************************************************
       DATA                              DIVISION.

      ****************************************************************
      *                                                              *
      *    F I L E    S E C T I O N                                  *
      *                                                              *
      ****************************************************************
       FILE                              SECTION.
      ***  LCBTG210  ***
       FD  OUT1-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT1-R.
           10 OUT1-BSE-IRT-N       PIC X(4).
           10 OUT1-FILLER1         PIC X(1).
           10 OUT1-IRT-NM          PIC X(40).
           10 OUT1-FILLER2         PIC X(1).
           10 OUT1-AUTH-GRD-ID     PIC X(6).
           10 OUT1-FILLER3         PIC X(1).
           10 OUT1-RG-SYS-D        PIC X(8).
           10 OUT1-FILLER4         PIC X(1).
           10 OUT1-RG-SYS-TM       PIC X(6).
           10 OUT1-FILLER5         PIC X(1).
           10 OUT1-RG-K-ID         PIC X(8).
           10 OUT1-FILLER6         PIC X(1).
           10 OUT1-RNM-SYS-D       PIC X(8).
           10 OUT1-FILLER7         PIC X(1).
           10 OUT1-RNM-SYS-TM      PIC X(6).
           10 OUT1-FILLER8         PIC X(1).
           10 OUT1-RNM-K-ID        PIC X(8).
           10 OUT1-FILLER9         PIC X(1).

      ***  LCBTG220  ***
       FD  OUT2-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT2-R.
           10 OUT2-BSE-IRT-N       PIC X(4).
           10 OUT2-FILLER1         PIC X(1).
           10 OUT2-EFT-ST-D        PIC X(8).
           10 OUT2-FILLER2         PIC X(1).
           10 OUT2-USE-F           PIC X(1).
           10 OUT2-FILLER3         PIC X(1).
           10 OUT2-BSE-IRT         PIC -(2)9.9(4).
           10 OUT2-FILLER4         PIC X(1).
           10 OUT2-RG-SYS-D        PIC X(8).
           10 OUT2-FILLER5         PIC X(1).
           10 OUT2-RG-SYS-TM       PIC X(6).
           10 OUT2-FILLER6         PIC X(1).
           10 OUT2-RG-K-ID         PIC X(8).
           10 OUT2-FILLER7         PIC X(1).
           10 OUT2-RNM-SYS-D       PIC X(8).
           10 OUT2-FILLER8         PIC X(1).
           10 OUT2-RNM-SYS-TM      PIC X(6).
           10 OUT2-FILLER9         PIC X(1).
           10 OUT2-RNM-K-ID        PIC X(8).
           10 OUT2-FILLER10        PIC X(1).

      ***  LCBTG230  ***
       FD  OUT3-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT3-R.
           10 OUT3-AFCM-N          PIC X(4).
           10 OUT3-FILLER1         PIC X(1).
           10 OUT3-AFSM-N          PIC X(7).
           10 OUT3-FILLER2         PIC X(1).
           10 OUT3-BSN-PRDT-CD     PIC X(4).
           10 OUT3-FILLER3         PIC X(1).
           10 OUT3-LN-CD           PIC X(2).
           10 OUT3-FILLER4         PIC X(1).
           10 OUT3-IRT-KND-CD      PIC X(4).
           10 OUT3-FILLER5         PIC X(1).
           10 OUT3-EFT-ST-D        PIC X(8).
           10 OUT3-FILLER6         PIC X(1).
           10 OUT3-USE-F           PIC X(1).
           10 OUT3-FILLER7         PIC X(1).
           10 OUT3-IRT-N           PIC X(6).
           10 OUT3-FILLER8         PIC X(1).
           10 OUT3-AUTH-GRD-ID     PIC X(6).
           10 OUT3-FILLER9         PIC X(1).
           10 OUT3-IRT-TP-CD       PIC X(1).
           10 OUT3-FILLER10        PIC X(1).
           10 OUT3-STG-IRT-F       PIC X(1).
           10 OUT3-FILLER11        PIC X(1).
           10 OUT3-IRT             PIC -(2)9.9(4).
           10 OUT3-FILLER12        PIC X(1).
           10 OUT3-K1-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER13        PIC X(1).
           10 OUT3-K2-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER14        PIC X(1).
           10 OUT3-K3-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER15        PIC X(1).
           10 OUT3-K4-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER16        PIC X(1).
           10 OUT3-K5-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER17        PIC X(1).
           10 OUT3-K6-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER18        PIC X(1).
           10 OUT3-K7-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER19        PIC X(1).
           10 OUT3-CK-ITM-TXT-FRM-CD  PIC X(1).
           10 OUT3-FILLER20        PIC X(1).
           10 OUT3-KEY-1-DESC      PIC X(40).
           10 OUT3-FILLER21        PIC X(1).
           10 OUT3-KEY-2-DESC      PIC X(40).
           10 OUT3-FILLER22        PIC X(1).
           10 OUT3-KEY-3-DESC      PIC X(40).
           10 OUT3-FILLER23        PIC X(1).
           10 OUT3-KEY-4-DESC      PIC X(40).
           10 OUT3-FILLER24        PIC X(1).
           10 OUT3-KEY-5-DESC      PIC X(40).
           10 OUT3-FILLER25        PIC X(1).
           10 OUT3-KEY-6-DESC      PIC X(40).
           10 OUT3-FILLER26        PIC X(1).
           10 OUT3-KEY-7-DESC      PIC X(40).
           10 OUT3-FILLER27        PIC X(1).
           10 OUT3-C-KEY-DESC      PIC X(40).
           10 OUT3-FILLER28        PIC X(1).
           10 OUT3-RG-SYS-D        PIC X(8).
           10 OUT3-FILLER29        PIC X(1).
           10 OUT3-RG-SYS-TM       PIC X(6).
           10 OUT3-FILLER30        PIC X(1).
           10 OUT3-RG-K-ID         PIC X(8).
           10 OUT3-FILLER31        PIC X(1).
           10 OUT3-RNM-SYS-D       PIC X(8).
           10 OUT3-FILLER32        PIC X(1).
           10 OUT3-RNM-SYS-TM      PIC X(6).
           10 OUT3-FILLER33        PIC X(1).
           10 OUT3-RNM-K-ID        PIC X(8).
           10 OUT3-FILLER34        PIC X(1).

      ***  LCBTG240  ***
       FD  OUT4-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT4-R.
           10 OUT4-IRT-N           PIC X(6).
           10 OUT4-FILLER1         PIC X(1).
           10 OUT4-KEY-1-ST-VAL    PIC X(16).
           10 OUT4-FILLER2         PIC X(1).
           10 OUT4-KEY-1-END-VAL   PIC X(16).
           10 OUT4-FILLER3         PIC X(1).
           10 OUT4-KEY-2-ST-VAL    PIC X(16).
           10 OUT4-FILLER4         PIC X(1).
           10 OUT4-KEY-2-END-VAL   PIC X(16).
           10 OUT4-FILLER5         PIC X(1).
           10 OUT4-KEY-3-ST-VAL    PIC X(16).
           10 OUT4-FILLER6         PIC X(1).
           10 OUT4-KEY-3-END-VAL   PIC X(16).
           10 OUT4-FILLER7         PIC X(1).
           10 OUT4-KEY-4-ST-VAL    PIC X(16).
           10 OUT4-FILLER8         PIC X(1).
           10 OUT4-KEY-4-END-VAL   PIC X(16).
           10 OUT4-FILLER9         PIC X(1).
           10 OUT4-KEY-5-ST-VAL    PIC X(16).
           10 OUT4-FILLER10        PIC X(1).
           10 OUT4-KEY-5-END-VAL   PIC X(16).
           10 OUT4-FILLER11        PIC X(1).
           10 OUT4-KEY-6-ST-VAL    PIC X(16).
           10 OUT4-FILLER12        PIC X(1).
           10 OUT4-KEY-6-END-VAL   PIC X(16).
           10 OUT4-FILLER13        PIC X(1).
           10 OUT4-KEY-7-ST-VAL    PIC X(16).
           10 OUT4-FILLER14        PIC X(1).
           10 OUT4-KEY-7-END-VAL   PIC X(16).
           10 OUT4-FILLER15        PIC X(1).
           10 OUT4-C-KEY           PIC X(10).
           10 OUT4-FILLER16        PIC X(1).
           10 OUT4-EFT-ST-D        PIC X(8).
           10 OUT4-FILLER17        PIC X(1).
           10 OUT4-USE-F           PIC X(1).
           10 OUT4-FILLER18        PIC X(1).
           10 OUT4-IRT-1           PIC -(2)9.9(4).
           10 OUT4-FILLER19        PIC X(1).
           10 OUT4-IRT-2           PIC -(2)9.9(4).
           10 OUT4-FILLER20        PIC X(1).
           10 OUT4-RG-SYS-D        PIC X(8).
           10 OUT4-FILLER21        PIC X(1).
           10 OUT4-RG-SYS-TM       PIC X(6).
           10 OUT4-FILLER22        PIC X(1).
           10 OUT4-RG-K-ID         PIC X(8).
           10 OUT4-FILLER23        PIC X(1).
           10 OUT4-RNM-SYS-D       PIC X(8).
           10 OUT4-FILLER24        PIC X(1).
           10 OUT4-RNM-SYS-TM      PIC X(6).
           10 OUT4-FILLER25        PIC X(1).
           10 OUT4-RNM-K-ID        PIC X(8).
           10 OUT4-FILLER26        PIC X(1).

      ***  LCBTG290  ***
       FD  OUT5-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT5-R.
           10 OUT5-BSE-IRT-KND-CD  PIC X(4).
           10 OUT5-FILLER1         PIC X(1).
           10 OUT5-AFCM-N          PIC X(4).
           10 OUT5-FILLER2         PIC X(1).
           10 OUT5-BSN-PRDT-CD     PIC X(4).
           10 OUT5-FILLER3         PIC X(1).
           10 OUT5-EFT-ST-D        PIC X(8).
           10 OUT5-FILLER4         PIC X(1).
           10 OUT5-BSE-IRT-N       PIC X(4).
           10 OUT5-FILLER5         PIC X(1).
           10 OUT5-RG-SYS-D        PIC X(8).
           10 OUT5-FILLER6         PIC X(1).
           10 OUT5-RG-SYS-TM       PIC X(6).
           10 OUT5-FILLER7         PIC X(1).
           10 OUT5-RG-K-ID         PIC X(8).
           10 OUT5-FILLER8         PIC X(1).
           10 OUT5-RNM-SYS-D       PIC X(8).
           10 OUT5-FILLER9         PIC X(1).
           10 OUT5-RNM-SYS-TM      PIC X(6).
           10 OUT5-FILLER10        PIC X(1).
           10 OUT5-RNM-K-ID        PIC X(8).
           10 OUT5-FILLER11        PIC X(1).

      ***  LCBTG610  ***
       FD  OUT6-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT6-R.
           10 OUT6-SYS-ID          PIC X(2).
           10 OUT6-FILLER1         PIC X(1).
           10 OUT6-SYS-KEY-1       PIC X(10).
           10 OUT6-FILLER2         PIC X(1).
           10 OUT6-SYS-KEY-2       PIC X(10).
           10 OUT6-FILLER3         PIC X(1).
           10 OUT6-SYS-KEY-3       PIC X(10).
           10 OUT6-FILLER4         PIC X(1).
           10 OUT6-SYS-KEY-4       PIC X(10).
           10 OUT6-FILLER5         PIC X(1).
           10 OUT6-FEE-C-CD        PIC X(4).
           10 OUT6-FILLER6         PIC X(1).
           10 OUT6-EFT-ST-D        PIC X(8).
           10 OUT6-FILLER7         PIC X(1).
           10 OUT6-USE-F           PIC X(1).
           10 OUT6-FILLER8         PIC X(1).
           10 OUT6-EFT-END-D       PIC X(8).
           10 OUT6-FILLER9         PIC X(1).
           10 OUT6-AUTH-GRD-ID     PIC X(6).
           10 OUT6-FILLER10        PIC X(1).
           10 OUT6-KEY-1-DESC      PIC X(40).
           10 OUT6-FILLER11        PIC X(1).
           10 OUT6-KEY-2-DESC      PIC X(40).
           10 OUT6-FILLER12        PIC X(1).
           10 OUT6-KEY-3-DESC      PIC X(40).
           10 OUT6-FILLER13        PIC X(1).
           10 OUT6-KEY-4-DESC      PIC X(40).
           10 OUT6-FILLER14        PIC X(1).
           10 OUT6-KEY-5-DESC      PIC X(40).
           10 OUT6-FILLER15        PIC X(1).
           10 OUT6-KEY-6-DESC      PIC X(40).
           10 OUT6-FILLER16        PIC X(1).
           10 OUT6-KEY-7-DESC      PIC X(40).
           10 OUT6-FILLER17        PIC X(1).
           10 OUT6-C-KEY-DESC      PIC X(40).
           10 OUT6-FILLER18        PIC X(1).
           10 OUT6-KEY-1-N-F       PIC X(1).
           10 OUT6-FILLER19        PIC X(1).
           10 OUT6-KEY-2-N-F       PIC X(1).
           10 OUT6-FILLER20        PIC X(1).
           10 OUT6-KEY-3-N-F       PIC X(1).
           10 OUT6-FILLER21        PIC X(1).
           10 OUT6-KEY-4-N-F       PIC X(1).
           10 OUT6-FILLER22        PIC X(1).
           10 OUT6-KEY-5-N-F       PIC X(1).
           10 OUT6-FILLER23        PIC X(1).
           10 OUT6-KEY-6-N-F       PIC X(1).
           10 OUT6-FILLER24        PIC X(1).
           10 OUT6-KEY-7-N-F       PIC X(1).
           10 OUT6-FILLER25        PIC X(1).
           10 OUT6-C-KEY-N-F       PIC X(1).
           10 OUT6-FILLER26        PIC X(1).
           10 OUT6-FEE-DESC        PIC X(22).
           10 OUT6-FILLER27        PIC X(1).
           10 OUT6-FEE-FRM-CD      PIC X(2).
           10 OUT6-FILLER28        PIC X(1).
           10 OUT6-FEE-N           PIC -(9)9.
           10 OUT6-FILLER29        PIC X(1).
           10 OUT6-ACT-CD1         PIC X(8).
           10 OUT6-FILLER30        PIC X(1).
           10 OUT6-ACT-CD2         PIC X(8).
           10 OUT6-FILLER31        PIC X(1).
           10 OUT6-NQRY-MTD-CD     PIC X(4).
           10 OUT6-FILLER32        PIC X(1).
           10 OUT6-NQRY-MTD-DESC   PIC X(64).
           10 OUT6-FILLER33        PIC X(1).
           10 OUT6-CALC-MTD-CD     PIC X(4).
           10 OUT6-FILLER34        PIC X(1).
           10 OUT6-CALC-MTD-DESC   PIC X(64).
           10 OUT6-FILLER35        PIC X(1).
           10 OUT6-BSE-FEE         PIC -(10)9.9(3).
           10 OUT6-FILLER36        PIC X(1).
           10 OUT6-BSE-FEE-TP-CD   PIC X(2).
           10 OUT6-FILLER37        PIC X(1).
           10 OUT6-BSE-FEE-EFT-AMT  PIC -(14)9.9(3).
           10 OUT6-FILLER38        PIC X(1).
           10 OUT6-ADD-FEE         PIC -(10)9.9(3).
           10 OUT6-FILLER39        PIC X(1).
           10 OUT6-ADD-FEE-TP-CD   PIC X(2).
           10 OUT6-FILLER40        PIC X(1).
           10 OUT6-ADD-FEE-UNT-AMT  PIC -(14)9.9(3).
           10 OUT6-FILLER41        PIC X(1).
           10 OUT6-STG-FEE-TP-CD   PIC X(2).
           10 OUT6-FILLER42        PIC X(1).
           10 OUT6-MIN-FEE         PIC -(10)9.9(3).
           10 OUT6-FILLER43        PIC X(1).
           10 OUT6-MAX-FEE         PIC -(10)9.9(3).
           10 OUT6-FILLER44        PIC X(1).
           10 OUT6-MIN-MAX-FEE-TP-CD  PIC X(2).
           10 OUT6-FILLER45        PIC X(1).
           10 OUT6-RNE-MTD-DESC    PIC X(64).
           10 OUT6-FILLER46        PIC X(1).
           10 OUT6-MAX-RNE-FEE     PIC -(10)9.9(3).
           10 OUT6-FILLER47        PIC X(1).
           10 OUT6-RG-SYS-D        PIC X(8).
           10 OUT6-FILLER48        PIC X(1).
           10 OUT6-RG-SYS-TM       PIC X(6).
           10 OUT6-FILLER49        PIC X(1).
           10 OUT6-RG-K-ID         PIC X(8).
           10 OUT6-FILLER50        PIC X(1).
           10 OUT6-RNM-SYS-D       PIC X(8).
           10 OUT6-FILLER51        PIC X(1).
           10 OUT6-RNM-SYS-TM      PIC X(6).
           10 OUT6-FILLER52        PIC X(1).
           10 OUT6-RNM-K-ID        PIC X(8).
           10 OUT6-FILLER53        PIC X(1).

      ***  LCBTG620  ***
       FD  OUT7-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT7-R.
           10 OUT7-FEE-N           PIC -(9)9.
           10 OUT7-FILLER1         PIC X(1).
           10 OUT7-KEY-1-ST-VAL    PIC X(16).
           10 OUT7-FILLER2         PIC X(1).
           10 OUT7-KEY-1-END-VAL   PIC X(16).
           10 OUT7-FILLER3         PIC X(1).
           10 OUT7-KEY-2-ST-VAL    PIC X(16).
           10 OUT7-FILLER4         PIC X(1).
           10 OUT7-KEY-2-END-VAL   PIC X(16).
           10 OUT7-FILLER5         PIC X(1).
           10 OUT7-KEY-3-ST-VAL    PIC X(16).
           10 OUT7-FILLER6         PIC X(1).
           10 OUT7-KEY-3-END-VAL   PIC X(16).
           10 OUT7-FILLER7         PIC X(1).
           10 OUT7-KEY-4-ST-VAL    PIC X(16).
           10 OUT7-FILLER8         PIC X(1).
           10 OUT7-KEY-4-END-VAL   PIC X(16).
           10 OUT7-FILLER9         PIC X(1).
           10 OUT7-KEY-5-ST-VAL    PIC X(16).
           10 OUT7-FILLER10        PIC X(1).
           10 OUT7-KEY-5-END-VAL   PIC X(16).
           10 OUT7-FILLER11        PIC X(1).
           10 OUT7-KEY-6-ST-VAL    PIC X(16).
           10 OUT7-FILLER12        PIC X(1).
           10 OUT7-KEY-6-END-VAL   PIC X(16).
           10 OUT7-FILLER13        PIC X(1).
           10 OUT7-KEY-7-ST-VAL    PIC X(16).
           10 OUT7-FILLER14        PIC X(1).
           10 OUT7-KEY-7-END-VAL   PIC X(16).
           10 OUT7-FILLER15        PIC X(1).
           10 OUT7-C-KEY           PIC X(10).
           10 OUT7-FILLER16        PIC X(1).
           10 OUT7-EFT-ST-D        PIC X(8).
           10 OUT7-FILLER17        PIC X(1).
           10 OUT7-USE-F           PIC X(1).
           10 OUT7-FILLER18        PIC X(1).
           10 OUT7-EFT-END-D       PIC X(8).
           10 OUT7-FILLER19        PIC X(1).
           10 OUT7-STG-FEE         PIC -(10)9.9(3).
           10 OUT7-FILLER20        PIC X(1).
           10 OUT7-RG-SYS-D        PIC X(8).
           10 OUT7-FILLER21        PIC X(1).
           10 OUT7-RG-SYS-TM       PIC X(6).
           10 OUT7-FILLER22        PIC X(1).
           10 OUT7-RG-K-ID         PIC X(8).
           10 OUT7-FILLER23        PIC X(1).
           10 OUT7-RNM-SYS-D       PIC X(8).
           10 OUT7-FILLER24        PIC X(1).
           10 OUT7-RNM-SYS-TM      PIC X(6).
           10 OUT7-FILLER25        PIC X(1).
           10 OUT7-RNM-K-ID        PIC X(8).
           10 OUT7-FILLER26        PIC X(1).

      ***  LCBTG710  ***
       FD  OUT8-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT8-R.
           10 OUT8-MKTG-N          PIC X(5).
           10 OUT8-FILLER1         PIC X(1).
           10 OUT8-MKTG-EFT-ST-D   PIC X(8).
           10 OUT8-FILLER2         PIC X(1).
           10 OUT8-MKTG-DESC-TXT   PIC X(40).
           10 OUT8-FILLER3         PIC X(1).
           10 OUT8-MKTG-INFO-USE-F  PIC X(1).
           10 OUT8-FILLER4         PIC X(1).
           10 OUT8-MKTG-EFT-END-D  PIC X(8).
           10 OUT8-FILLER5         PIC X(1).
           10 OUT8-AUTH-GRD-ID     PIC X(6).
           10 OUT8-FILLER6         PIC X(1).
           10 OUT8-BSN-PRDT-CD     PIC X(4).
           10 OUT8-FILLER7         PIC X(1).
           10 OUT8-PRDT-PRTY       PIC -(4)9.
           10 OUT8-FILLER8         PIC X(1).
           10 OUT8-SCF-OBJ-K-F     PIC X(1).
           10 OUT8-FILLER9         PIC X(1).
           10 OUT8-MKTG-EFT-F      PIC X(1).
           10 OUT8-FILLER10        PIC X(1).
           10 OUT8-MAX-IRT         PIC -(3)9.9(2).
           10 OUT8-FILLER11        PIC X(1).
           10 OUT8-MIN-IRT         PIC -(3)9.9(2).
           10 OUT8-FILLER12        PIC X(1).
           10 OUT8-MAX-FEE-RT      PIC -(3)9.9(2).
           10 OUT8-FILLER13        PIC X(1).
           10 OUT8-MIN-FEE-RT      PIC -(3)9.9(2).
           10 OUT8-FILLER14        PIC X(1).
           10 OUT8-MAX-LN-LMT-AMT  PIC -(13)9.
           10 OUT8-FILLER15        PIC X(1).
           10 OUT8-MIN-LN-LMT-AMT  PIC -(13)9.
           10 OUT8-FILLER16        PIC X(1).
           10 OUT8-MKTG-EFT-OBJ-CD  PIC X(2).
           10 OUT8-FILLER17        PIC X(1).
           10 OUT8-MKTG-OFF-C-CD   PIC X(2).
           10 OUT8-FILLER18        PIC X(1).
           10 OUT8-MKTG-PRDT-C-CD  PIC X(2).
           10 OUT8-FILLER19        PIC X(1).
           10 OUT8-MKTG-IRT-EFT-TP-CD  PIC X(2).
           10 OUT8-FILLER20        PIC X(1).
           10 OUT8-MKTG-FEE-EFT-TP-CD  PIC X(2).
           10 OUT8-FILLER21        PIC X(1).
           10 OUT8-MKTG-LMT-TP-CD  PIC X(2).
           10 OUT8-FILLER22        PIC X(1).
           10 OUT8-K1-MKTG-ITM-CD  PIC X(4).
           10 OUT8-FILLER23        PIC X(1).
           10 OUT8-K2-MKTG-ITM-CD  PIC X(4).
           10 OUT8-FILLER24        PIC X(1).
           10 OUT8-K3-MKTG-ITM-CD  PIC X(4).
           10 OUT8-FILLER25        PIC X(1).
           10 OUT8-K4-MKTG-ITM-CD  PIC X(4).
           10 OUT8-FILLER26        PIC X(1).
           10 OUT8-K5-MKTG-ITM-CD  PIC X(4).
           10 OUT8-FILLER27        PIC X(1).
           10 OUT8-K6-MKTG-ITM-CD  PIC X(4).
           10 OUT8-FILLER28        PIC X(1).
           10 OUT8-RG-K-ID         PIC X(8).
           10 OUT8-FILLER29        PIC X(1).
           10 OUT8-RG-SYS-D        PIC X(8).
           10 OUT8-FILLER30        PIC X(1).
           10 OUT8-RG-SYS-TM       PIC X(6).
           10 OUT8-FILLER31        PIC X(1).
           10 OUT8-RNM-K-ID        PIC X(8).
           10 OUT8-FILLER32        PIC X(1).
           10 OUT8-RNM-SYS-D       PIC X(8).
           10 OUT8-FILLER33        PIC X(1).
           10 OUT8-RNM-SYS-TM      PIC X(6).
           10 OUT8-FILLER34        PIC X(1).

      ***  LCBTG720  ***
       FD  OUT9-F  LABEL     RECORDS     STANDARD
                   RECORDING MODE        IS   F.
       01  OUT9-R.
           10 OUT9-MKTG-N          PIC X(5).
           10 OUT9-FILLER1         PIC X(1).
           10 OUT9-KEY-1-ST-VAL    PIC X(16).
           10 OUT9-FILLER2         PIC X(1).
           10 OUT9-KEY-1-END-VAL   PIC X(16).
           10 OUT9-FILLER3         PIC X(1).
           10 OUT9-KEY-2-ST-VAL    PIC X(16).
           10 OUT9-FILLER4         PIC X(1).
           10 OUT9-KEY-2-END-VAL   PIC X(16).
           10 OUT9-FILLER5         PIC X(1).
           10 OUT9-KEY-3-ST-VAL    PIC X(16).
           10 OUT9-FILLER6         PIC X(1).
           10 OUT9-KEY-3-END-VAL   PIC X(16).
           10 OUT9-FILLER7         PIC X(1).
           10 OUT9-KEY-4-ST-VAL    PIC X(16).
           10 OUT9-FILLER8         PIC X(1).
           10 OUT9-KEY-4-END-VAL   PIC X(16).
           10 OUT9-FILLER9         PIC X(1).
           10 OUT9-KEY-5-ST-VAL    PIC X(16).
           10 OUT9-FILLER10        PIC X(1).
           10 OUT9-KEY-5-END-VAL   PIC X(16).
           10 OUT9-FILLER11        PIC X(1).
           10 OUT9-KEY-6-ST-VAL    PIC X(16).
           10 OUT9-FILLER12        PIC X(1).
           10 OUT9-KEY-6-END-VAL   PIC X(16).
           10 OUT9-FILLER13        PIC X(1).
           10 OUT9-MKTG-INFO-USE-F  PIC X(1).
           10 OUT9-FILLER14        PIC X(1).
           10 OUT9-MKTG-EFT-IRT-AMT  PIC -(11)9.9(2).
           10 OUT9-FILLER15        PIC X(1).
           10 OUT9-MKTG-EFT-FEE    PIC -(11)9.9(2).
           10 OUT9-FILLER16        PIC X(1).
           10 OUT9-MKTG-LN-LMT-AMT  PIC -(11)9.9(2).
           10 OUT9-FILLER17        PIC X(1).
           10 OUT9-RG-K-ID         PIC X(8).
           10 OUT9-FILLER18        PIC X(1).
           10 OUT9-RG-SYS-D        PIC X(8).
           10 OUT9-FILLER19        PIC X(1).
           10 OUT9-RG-SYS-TM       PIC X(6).
           10 OUT9-FILLER20        PIC X(1).
           10 OUT9-RNM-K-ID        PIC X(8).
           10 OUT9-FILLER21        PIC X(1).
           10 OUT9-RNM-SYS-D       PIC X(8).
           10 OUT9-FILLER22        PIC X(1).
           10 OUT9-RNM-SYS-TM      PIC X(6).
           10 OUT9-FILLER23        PIC X(1).

      ****************************************************************
      *                                                              *
      *    W O R K I N G - S T O R A G E    S E C T I O N            *
      *                                                              *
      ****************************************************************
       WORKING-STORAGE                   SECTION.

       01  W-BEGIN                      PIC  X(40)  VALUE
           'LCBBGDMP  -  WORKING STORAGE BEGINS HERE'.

      ****************************************************************
      *                                                              *
      *    U S E R    A B E N D                                      *
      *                                                              *
      ****************************************************************
       01  USER-ABENDS.

           05  U-ABEND.
               10  U-ABEND-CODE1         PIC  9(02)  VALUE  99.

      ****************************************************************
      *                                                              *
      *    A C C U M U L A T O R S                                   *
      *                                                              *
      ****************************************************************
       01  ACCUMULATORS.

           05  A-TG21-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG22-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG23-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG24-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG29-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG61-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG62-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG71-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TG72-READ-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT1-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT2-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT3-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT4-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT5-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT6-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT7-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT8-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-OUT9-WRIT-CNT           PIC  9(13)  VALUE  ZERO.
           05  A-TOTL-ERRO-CNT           PIC  9(13)  VALUE  ZERO.

      ****************************************************************
      *                                                              *
      *    C O N S T A N T S                                         *
      *                                                              *
      ****************************************************************
       01  CONSTANTS.

           05  C-PROG-ID                 PIC  X(08)  VALUE 'LCBBGDMP'.

      ****************************************************************
      *                                                              *
      *    S W I T C H E S                                           *
      *                                                              *
      ****************************************************************
       01  SWITCHES.

           05  S-NEXT-FLAG               PIC  X(01)  VALUE  LOW-VALUE.
               88  S-NEXT-NO                         VALUE  LOW-VALUE.
               88  S-NEXT-YES                        VALUE  HIGH-VALUE.

           05  S-DATA-END-CHECK          PIC  X(01)  VALUE  LOW-VALUE.
               88  S-MORE-DATA                       VALUE  LOW-VALUE.
               88  S-NO-DATA                         VALUE  HIGH-VALUE.

           03  S-OUT1-STATUS             PIC  X(002).
               88  S-OUT1-NORMAL                     VALUE '00'.

           03  S-OUT2-STATUS             PIC  X(002).
               88  S-OUT2-NORMAL                     VALUE '00'.

           03  S-OUT3-STATUS             PIC  X(002).
               88  S-OUT3-NORMAL                     VALUE '00'.

           03  S-OUT4-STATUS             PIC  X(002).
               88  S-OUT4-NORMAL                     VALUE '00'.

           03  S-OUT5-STATUS             PIC  X(002).
               88  S-OUT5-NORMAL                     VALUE '00'.

           03  S-OUT6-STATUS             PIC  X(002).
               88  S-OUT6-NORMAL                     VALUE '00'.

           03  S-OUT7-STATUS             PIC  X(002).
               88  S-OUT7-NORMAL                     VALUE '00'.

           03  S-OUT8-STATUS             PIC  X(002).
               88  S-OUT8-NORMAL                     VALUE '00'.

           03  S-OUT9-STATUS             PIC  X(002).
               88  S-OUT9-NORMAL                     VALUE '00'.

      ****************************************************************
      *                                                              *
      *    W O R K    A R E A S                                      *
      *                                                              *
      ****************************************************************
       01  WORK-AREAS.
           05  W-SYSTEM-DATETIME.
               10  W-SYSTEM-DATE         PIC  X(08).
               10  W-SYSTEM-TIME         PIC  X(06).
           05  W-USER-ID                 PIC  X(08).
           05  W-CNV-X                   PIC  X(08).
           05  W-CNV-N                   REDEFINES  W-CNV-X
                                         PIC S9(13)V9(3)    COMP.
           05  W-SQLCODE                 PIC  ----9.
           05  W-NDX.
               10  I                     PIC  9(04).
               10  J                     PIC  9(04).
           05  W-CONV.
               10  W-V-F                 PIC  X(01).
               10  W-V-VAL               PIC  9(13).
               10  W-CHAR                PIC  X(16).
               10  W-CHAR-R              REDEFINES W-CHAR.
                   15  W-CH              PIC  X(01)  OCCURS 16 TIMES.
               10  W-CH-9                PIC  9(01).
               10  W-NUM                 PIC  9(13)V9(03).
               10  W-Z-NUM               PIC  Z(11)9.999.
               10  W-E-CHAR              PIC  X(16).

      ****************************************************************
      *                                                              *
      *    P A R A M E T E R S                                       *
      *                                                              *
      ****************************************************************
      *    .NONE
      ****************************************************************
      *                                                              *
      *    T A B L E S                                               *
      *                                                              *
      ****************************************************************
      *    .NONE
      ****************************************************************
      *    S Q L C A                                                 *
      ****************************************************************
           EXEC  SQL  INCLUDE  SQLCA     END-EXEC.

      ****************************************************************
      *   ~e~~vv                                             *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG210  END-EXEC.

      ****************************************************************
      *   ~e~7v~                                             *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG220  END-EXEC.

      ****************************************************************
      *   ~~vv                                                 *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG230  END-EXEC.

      ****************************************************************
      *   mia~7v~                                             *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG240  END-EXEC.

      ****************************************************************
      *   ~e~/iE~                                         *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG290  END-EXEC.

      ****************************************************************
      *   aa/7v~                                               *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG610  END-EXEC.

      ****************************************************************
      *   miaaa/7v~                                           *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG620  END-EXEC.

      ****************************************************************
      *   /E~vv7v~                                           *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG710  END-EXEC.

      ****************************************************************
      *   /E7v~                                               *
      ****************************************************************
           EXEC  SQL  INCLUDE  LCBYG720  END-EXEC.

      ****************************************************************
      *                                                              *
      *    D E C L A R E    C U S O R S                              *
      *                                                              *
      ****************************************************************

      ****************************************************************
      *    CURSOR_G210 : ~vv~~vv                              *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G210  CURSOR  WITH  HOLD  FOR
                 SELECT   BSE_IRT_N
                 ,        IRT_NM
                 ,        AUTH_GRD_ID
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G21.TG210
                 ORDER BY BSE_IRT_N
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 1 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G220 : ~~vv                                  *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G220  CURSOR  WITH  HOLD  FOR
                 SELECT   BSE_IRT_N
                 ,        EFT_ST_D
                 ,        USE_F
                 ,        BSE_IRT
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G22.TG220
                 ORDER BY BSE_IRT_N
                 ,        EFT_ST_D
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 1 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G230 : ~~vv                                  *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G230  CURSOR  WITH  HOLD  FOR
                 SELECT   AFCM_N
                 ,        AFSM_N
                 ,        BSN_PRDT_CD
                 ,        LN_CD
                 ,        IRT_KND_CD
                 ,        EFT_ST_D
                 ,        USE_F
                 ,        IRT_N
                 ,        AUTH_GRD_ID
                 ,        IRT_TP_CD
                 ,        STG_IRT_F
                 ,        IRT
                 ,        K1_ITM_TXT_FRM_CD
                 ,        K2_ITM_TXT_FRM_CD
                 ,        K3_ITM_TXT_FRM_CD
                 ,        K4_ITM_TXT_FRM_CD
                 ,        K5_ITM_TXT_FRM_CD
                 ,        K6_ITM_TXT_FRM_CD
                 ,        K7_ITM_TXT_FRM_CD
                 ,        CK_ITM_TXT_FRM_CD
                 ,        KEY_1_DESC
                 ,        KEY_2_DESC
                 ,        KEY_3_DESC
                 ,        KEY_4_DESC
                 ,        KEY_5_DESC
                 ,        KEY_6_DESC
                 ,        KEY_7_DESC
                 ,        C_KEY_DESC
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G23.TG230
                 ORDER BY AFCM_N
                 ,        AFSM_N
                 ,        BSN_PRDT_CD
                 ,        LN_CD
                 ,        IRT_KND_CD
                 ,        EFT_ST_D
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 1 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G240 : ~7v~                                  *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G240  CURSOR  WITH  HOLD  FOR
                 SELECT   IRT_N
                 ,        KEY_1_ST_VAL
                 ,        KEY_1_END_VAL
                 ,        KEY_2_ST_VAL
                 ,        KEY_2_END_VAL
                 ,        KEY_3_ST_VAL
                 ,        KEY_3_END_VAL
                 ,        KEY_4_ST_VAL
                 ,        KEY_4_END_VAL
                 ,        KEY_5_ST_VAL
                 ,        KEY_5_END_VAL
                 ,        KEY_6_ST_VAL
                 ,        KEY_6_END_VAL
                 ,        KEY_7_ST_VAL
                 ,        KEY_7_END_VAL
                 ,        C_KEY
                 ,        EFT_ST_D
                 ,        USE_F
                 ,        IRT_1
                 ,        IRT_2
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G24.TG240
                 ORDER BY IRT_N
                 ,        KEY_1_ST_VAL
                 ,        KEY_1_END_VAL
                 ,        KEY_2_ST_VAL
                 ,        KEY_2_END_VAL
                 ,        KEY_3_ST_VAL
                 ,        KEY_3_END_VAL
                 ,        KEY_4_ST_VAL
                 ,        KEY_4_END_VAL
                 ,        KEY_5_ST_VAL
                 ,        KEY_5_END_VAL
                 ,        KEY_6_ST_VAL
                 ,        KEY_6_END_VAL
                 ,        KEY_7_ST_VAL
                 ,        KEY_7_END_VAL
                 ,        C_KEY
                 ,        EFT_ST_D
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 10 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G290 : ~~vv                                  *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G290  CURSOR  WITH  HOLD  FOR
                 SELECT   BSE_IRT_KND_CD
                 ,        AFCM_N
                 ,        BSN_PRDT_CD
                 ,        EFT_ST_D
                 ,        BSE_IRT_N
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G29.TG290
                 ORDER BY BSE_IRT_KND_CD
                 ,        AFCM_N
                 ,        BSN_PRDT_CD
                 ,        EFT_ST_D
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 1 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G610 : aa/7v~                                *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G610  CURSOR  WITH  HOLD  FOR
                 SELECT   SYS_ID
                 ,        SYS_KEY_1
                 ,        SYS_KEY_2
                 ,        SYS_KEY_3
                 ,        SYS_KEY_4
                 ,        FEE_C_CD
                 ,        EFT_ST_D
                 ,        USE_F
                 ,        EFT_END_D
                 ,        AUTH_GRD_ID
                 ,        KEY_1_DESC
                 ,        KEY_2_DESC
                 ,        KEY_3_DESC
                 ,        KEY_4_DESC
                 ,        KEY_5_DESC
                 ,        KEY_6_DESC
                 ,        KEY_7_DESC
                 ,        C_KEY_DESC
                 ,        KEY_1_N_F
                 ,        KEY_2_N_F
                 ,        KEY_3_N_F
                 ,        KEY_4_N_F
                 ,        KEY_5_N_F
                 ,        KEY_6_N_F
                 ,        KEY_7_N_F
                 ,        C_KEY_N_F
                 ,        FEE_DESC
                 ,        FEE_FRM_CD
                 ,        FEE_N
                 ,        ACT_CD1
                 ,        ACT_CD2
                 ,        NQRY_MTD_CD
                 ,        NQRY_MTD_DESC
                 ,        CALC_MTD_CD
                 ,        CALC_MTD_DESC
                 ,        BSE_FEE
                 ,        BSE_FEE_TP_CD
                 ,        BSE_FEE_EFT_AMT
                 ,        ADD_FEE
                 ,        ADD_FEE_TP_CD
                 ,        ADD_FEE_UNT_AMT
                 ,        STG_FEE_TP_CD
                 ,        MIN_FEE
                 ,        MAX_FEE
                 ,        MIN_MAX_FEE_TP_CD
                 ,        RNE_MTD_DESC
                 ,        MAX_RNE_FEE
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G61.TG610
                 ORDER BY SYS_ID
                 ,        SYS_KEY_1
                 ,        SYS_KEY_2
                 ,        SYS_KEY_3
                 ,        SYS_KEY_4
                 ,        FEE_C_CD
                 ,        EFT_ST_D
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 1 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G620 : miaaa/7v~                            *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G620  CURSOR  WITH  HOLD  FOR
                 SELECT   FEE_N
                 ,        KEY_1_ST_VAL
                 ,        KEY_1_END_VAL
                 ,        KEY_2_ST_VAL
                 ,        KEY_2_END_VAL
                 ,        KEY_3_ST_VAL
                 ,        KEY_3_END_VAL
                 ,        KEY_4_ST_VAL
                 ,        KEY_4_END_VAL
                 ,        KEY_5_ST_VAL
                 ,        KEY_5_END_VAL
                 ,        KEY_6_ST_VAL
                 ,        KEY_6_END_VAL
                 ,        KEY_7_ST_VAL
                 ,        KEY_7_END_VAL
                 ,        C_KEY
                 ,        EFT_ST_D
                 ,        USE_F
                 ,        EFT_END_D
                 ,        STG_FEE
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RG_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 ,        RNM_K_ID
                 FROM     LCBD2G62.TG620
                 ORDER BY FEE_N
                 ,        KEY_1_ST_VAL
                 ,        KEY_1_END_VAL
                 ,        KEY_2_ST_VAL
                 ,        KEY_2_END_VAL
                 ,        KEY_3_ST_VAL
                 ,        KEY_3_END_VAL
                 ,        KEY_4_ST_VAL
                 ,        KEY_4_END_VAL
                 ,        KEY_5_ST_VAL
                 ,        KEY_5_END_VAL
                 ,        KEY_6_ST_VAL
                 ,        KEY_6_END_VAL
                 ,        KEY_7_ST_VAL
                 ,        KEY_7_END_VAL
                 ,        C_KEY
                 ,        EFT_ST_D
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 10 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G710 : /E~vv7v~                            *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G710  CURSOR  WITH  HOLD  FOR
                 SELECT   MKTG_N
                 ,        MKTG_EFT_ST_D
                 ,        MKTG_DESC_TXT
                 ,        MKTG_INFO_USE_F
                 ,        MKTG_EFT_END_D
                 ,        AUTH_GRD_ID
                 ,        BSN_PRDT_CD
                 ,        PRDT_PRTY
                 ,        SCF_OBJ_K_F
                 ,        MKTG_EFT_F
                 ,        MAX_IRT
                 ,        MIN_IRT
                 ,        MAX_FEE_RT
                 ,        MIN_FEE_RT
                 ,        MAX_LN_LMT_AMT
                 ,        MIN_LN_LMT_AMT
                 ,        MKTG_EFT_OBJ_CD
                 ,        MKTG_OFF_C_CD
                 ,        MKTG_PRDT_C_CD
                 ,        MKTG_IRT_EFT_TP_CD
                 ,        MKTG_FEE_EFT_TP_CD
                 ,        MKTG_LMT_TP_CD
                 ,        K1_MKTG_ITM_CD
                 ,        K2_MKTG_ITM_CD
                 ,        K3_MKTG_ITM_CD
                 ,        K4_MKTG_ITM_CD
                 ,        K5_MKTG_ITM_CD
                 ,        K6_MKTG_ITM_CD
                 ,        RG_K_ID
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RNM_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 FROM     LCBD2G71.TG710
                 ORDER BY MKTG_N
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 1 ROWS
           END-EXEC.

      ****************************************************************
      *    CURSOR_G720 : /E7v~                                *
      ****************************************************************

           EXEC  SQL
                 DECLARE  CURSOR_G720  CURSOR  WITH  HOLD  FOR
                 SELECT   MKTG_N
                 ,        KEY_1_ST_VAL
                 ,        KEY_1_END_VAL
                 ,        KEY_2_ST_VAL
                 ,        KEY_2_END_VAL
                 ,        KEY_3_ST_VAL
                 ,        KEY_3_END_VAL
                 ,        KEY_4_ST_VAL
                 ,        KEY_4_END_VAL
                 ,        KEY_5_ST_VAL
                 ,        KEY_5_END_VAL
                 ,        KEY_6_ST_VAL
                 ,        KEY_6_END_VAL
                 ,        MKTG_INFO_USE_F
                 ,        MKTG_EFT_IRT_AMT
                 ,        MKTG_EFT_FEE
                 ,        MKTG_LN_LMT_AMT
                 ,        RG_K_ID
                 ,        RG_SYS_D
                 ,        RG_SYS_TM
                 ,        RNM_K_ID
                 ,        RNM_SYS_D
                 ,        RNM_SYS_TM
                 FROM     LCBD2G72.TG720
                 ORDER BY MKTG_N
                 ,        KEY_1_ST_VAL
                 ,        KEY_1_END_VAL
                 ,        KEY_2_ST_VAL
                 ,        KEY_2_END_VAL
                 ,        KEY_3_ST_VAL
                 ,        KEY_3_END_VAL
                 ,        KEY_4_ST_VAL
                 ,        KEY_4_END_VAL
                 ,        KEY_5_ST_VAL
                 ,        KEY_5_END_VAL
                 ,        KEY_6_ST_VAL
                 ,        KEY_6_END_VAL
                 FOR FETCH ONLY
                 WITH UR
                 OPTIMIZE FOR 10 ROWS
           END-EXEC.

      ****************************************************************
      *                                                              *
      *    E N D    O F    W O R K I N G - S T O R A G E             *
      *                                                              *
      ****************************************************************
       01  W-END                        PIC  X(40)  VALUE
           'LCBBGDMP *** WORKING STORAGE ENDS HERE  '.

      ****************************************************************
      *                                                              *
      *    L I N K A G E    S E C T I O N                            *
      *                                                              *
      ****************************************************************
      *   .NONE
      ****************************************************************
      *                                                              *
      *    P R O C E D U R E    D I V I S I O N                      *
      *                                                              *
      ****************************************************************
       PROCEDURE                         DIVISION.

      ****************************************************************
      *                                                              *
      *    M A I N    P R O C E S S                                  *
      *                                                              *
      ****************************************************************
       S0100-MAIN                        SECTION.

           PERFORM  S0200-INITIALIZATION.
      *    PERFORM  S0300-VERIFICATION-CHECK.
           PERFORM  S0400-BUSINESS-PROC.

       S0100-MAIN-EXIT.

           IF      RETURN-CODE              =   ZERO
               IF  A-TOTL-ERRO-CNT          =   ZERO
                   DISPLAY '  '
                   DISPLAY '***********************************'
                   DISPLAY '**** LCBBGDMP NORMAL COMPLETED ****'
                   DISPLAY '***********************************'
               ELSE
                   DISPLAY '  '
                   DISPLAY '***********************************'
                   DISPLAY '**** LCBBGDMP AB-NORMAL END    ****'
                   DISPLAY '***********************************'
               END-IF
           ELSE
                   EXEC  SQL  ROLLBACK   END-EXEC
                   DISPLAY '**************************************'
                   DISPLAY '**** LCBBGDMP JOB STOP WITH ERROR ****'
                   DISPLAY '**** ROLLBACK COMPLETED !!!!!!!!! ****'
                   DISPLAY '**************************************'
           END-IF.
      *
           DISPLAY '  '.
           DISPLAY '***********************************************'.
           DISPLAY '* TG210-READ-CNT : ' A-TG21-READ-CNT.
           DISPLAY '* TG220-READ-CNT : ' A-TG22-READ-CNT.
           DISPLAY '* TG230-READ-CNT : ' A-TG23-READ-CNT.
           DISPLAY '* TG240-READ-CNT : ' A-TG24-READ-CNT.
           DISPLAY '* TG290-READ-CNT : ' A-TG29-READ-CNT.
           DISPLAY '* TG610-READ-CNT : ' A-TG61-READ-CNT.
           DISPLAY '* TG620-READ-CNT : ' A-TG62-READ-CNT.
           DISPLAY '* TG710-READ-CNT : ' A-TG71-READ-CNT.
           DISPLAY '* TG720-READ-CNT : ' A-TG72-READ-CNT.
           DISPLAY '* OUTS1-WRIT-CNT : ' A-OUT1-WRIT-CNT.
           DISPLAY '* OUTS2-WRIT-CNT : ' A-OUT2-WRIT-CNT.
           DISPLAY '* OUTS3-WRIT-CNT : ' A-OUT3-WRIT-CNT.
           DISPLAY '* OUTS4-WRIT-CNT : ' A-OUT4-WRIT-CNT.
           DISPLAY '* OUTS5-WRIT-CNT : ' A-OUT5-WRIT-CNT.
           DISPLAY '* OUTS6-WRIT-CNT : ' A-OUT6-WRIT-CNT.
           DISPLAY '* OUTS7-WRIT-CNT : ' A-OUT7-WRIT-CNT.
           DISPLAY '* OUTS8-WRIT-CNT : ' A-OUT8-WRIT-CNT.
           DISPLAY '* OUTS9-WRIT-CNT : ' A-OUT9-WRIT-CNT.
           DISPLAY '* TOTAL-ERRO-CNT : ' A-TOTL-ERRO-CNT.
           DISPLAY '***********************************************'.
           DISPLAY '  '.

           CLOSE   OUT1-F  OUT2-F  OUT3-F  OUT4-F  OUT5-F
                   OUT6-F  OUT7-F  OUT8-F  OUT9-F.

           MOVE    FUNCTION CURRENT-DATE TO     W-SYSTEM-DATETIME.

           DISPLAY '##########################################'.
           DISPLAY '#### END-TIME   = '         W-SYSTEM-DATETIME.
           DISPLAY '##########################################'.

           STOP  RUN.

      ****************************************************************
      *                                                              *
      *    I N I T I A L I Z A T I O N                               *
      *                                                              *
      ****************************************************************
       S0200-INITIALIZATION              SECTION.

           INITIALIZE                    WORK-AREAS.

           MOVE  FUNCTION CURRENT-DATE   TO  W-SYSTEM-DATETIME.

      *   //ID
           MOVE  C-PROG-ID               TO  W-USER-ID.

           DISPLAY '##########################################'.
           DISPLAY '### LCBBGDMP START-TIME = ' W-SYSTEM-DATETIME.
           DISPLAY '##########################################'.

           OPEN     OUTPUT               OUT1-F.

           IF  NOT  S-OUT1-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM1 OPEN ERROR(' S-OUT1-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT2-F.

           IF  NOT  S-OUT2-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM2 OPEN ERROR(' S-OUT2-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT3-F.

           IF  NOT  S-OUT3-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM3 OPEN ERROR(' S-OUT3-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT4-F.

           IF  NOT  S-OUT4-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM4 OPEN ERROR(' S-OUT4-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT5-F.

           IF  NOT  S-OUT5-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM5 OPEN ERROR(' S-OUT5-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT6-F.

           IF  NOT  S-OUT6-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM6 OPEN ERROR(' S-OUT6-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT7-F.

           IF  NOT  S-OUT7-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM7 OPEN ERROR(' S-OUT7-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT8-F.

           IF  NOT  S-OUT8-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM8 OPEN ERROR(' S-OUT8-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           OPEN     OUTPUT               OUT9-F.

           IF  NOT  S-OUT9-NORMAL
               DISPLAY
               'S0200:ERROR=OUTSAM9 OPEN ERROR(' S-OUT9-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

       S0200-INITIALIZE-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    V E R I F I C A T I O N    C H E C K                      *
      *                                                              *
      ****************************************************************
      *S0300-VERIFICATION-CHECK          SECTION.
      *    NONE.
      *S0300-VERIFICATION-CHECK-EXIT.
      *    EXIT.
      *
      ****************************************************************
      *                                                              *
      *    B U S I N E S S    P R O C E S S                          *
      *                                                              *
      ****************************************************************
       S0400-BUSINESS-PROC               SECTION.

           PERFORM  S1100-TG210-UNLOAD.
           PERFORM  S1200-TG220-UNLOAD.
           PERFORM  S1300-TG230-UNLOAD.
           PERFORM  S1400-TG240-UNLOAD.
           PERFORM  S1500-TG290-UNLOAD.
           PERFORM  S1600-TG610-UNLOAD.
           PERFORM  S1700-TG620-UNLOAD.
           PERFORM  S1800-TG710-UNLOAD.
           PERFORM  S1900-TG720-UNLOAD.

       S0400-BUSINESS-PROC-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1100-TG210-UNLOAD                SECTION.

           DISPLAY  'STEP : S1100-TG210-UNLOAD'.

           PERFORM  S6100-OPEN-TG210.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7100-FETCH-TG210
              IF  NOT  S-NO-DATA
                  PERFORM  S2100-MOVE-TG210-TO-OUT1
                  PERFORM  S5100-WRITE-OUT1
              END-IF
           END-PERFORM.

           PERFORM  S8100-CLOSE-TG210.

       S1100-TG210-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1200-TG220-UNLOAD                SECTION.

           DISPLAY  'STEP : S1200-TG220-UNLOAD'.

           PERFORM  S6200-OPEN-TG220.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7200-FETCH-TG220
              IF  NOT  S-NO-DATA
                  PERFORM  S2200-MOVE-TG220-TO-OUT2
                  PERFORM  S5200-WRITE-OUT2
              END-IF
           END-PERFORM.

           PERFORM  S8200-CLOSE-TG220.

       S1200-TG220-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1300-TG230-UNLOAD                SECTION.

           DISPLAY  'STEP : S1300-TG230-UNLOAD'.

           PERFORM  S6300-OPEN-TG230.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7300-FETCH-TG230
              IF  NOT  S-NO-DATA
                  PERFORM  S2300-MOVE-TG230-TO-OUT3
                  PERFORM  S5300-WRITE-OUT3
              END-IF
           END-PERFORM.

           PERFORM  S8300-CLOSE-TG230.

       S1300-TG230-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1400-TG240-UNLOAD                SECTION.

           DISPLAY  'STEP : S1400-TG240-UNLOAD'.

           PERFORM  S6400-OPEN-TG240.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7400-FETCH-TG240
              IF  NOT  S-NO-DATA
                  PERFORM  S2400-MOVE-TG240-TO-OUT4
                  PERFORM  S5400-WRITE-OUT4
              END-IF
           END-PERFORM.

           PERFORM  S8400-CLOSE-TG240.

       S1400-TG240-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1500-TG290-UNLOAD                SECTION.

           DISPLAY  'STEP : S1500-TG290-UNLOAD'.

           PERFORM  S6500-OPEN-TG290.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7500-FETCH-TG290
              IF  NOT  S-NO-DATA
                  PERFORM  S2500-MOVE-TG290-TO-OUT5
                  PERFORM  S5500-WRITE-OUT5
              END-IF
           END-PERFORM.

           PERFORM  S8500-CLOSE-TG290.

       S1500-TG290-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1600-TG610-UNLOAD                SECTION.

           DISPLAY  'STEP : S1600-TG610-UNLOAD'.

           PERFORM  S6600-OPEN-TG610.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7600-FETCH-TG610
              IF  NOT  S-NO-DATA
                  PERFORM  S2600-MOVE-TG610-TO-OUT6
                  PERFORM  S5600-WRITE-OUT6
              END-IF
           END-PERFORM.

           PERFORM  S8600-CLOSE-TG610.

       S1600-TG610-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1700-TG620-UNLOAD                SECTION.

           DISPLAY  'STEP : S1700-TG620-UNLOAD'.

           PERFORM  S6700-OPEN-TG620.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7700-FETCH-TG620
              IF  NOT  S-NO-DATA
                  PERFORM  S2700-MOVE-TG620-TO-OUT7
                  PERFORM  S5700-WRITE-OUT7
              END-IF
           END-PERFORM.

           PERFORM  S8700-CLOSE-TG620.

       S1700-TG620-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1800-TG710-UNLOAD                SECTION.

           DISPLAY  'STEP : S1800-TG710-UNLOAD'.

           PERFORM  S6800-OPEN-TG710.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7800-FETCH-TG710
              IF  NOT  S-NO-DATA
                  PERFORM  S2800-MOVE-TG710-TO-OUT8
                  PERFORM  S5800-WRITE-OUT8
              END-IF
           END-PERFORM.

           PERFORM  S8800-CLOSE-TG710.

       S1800-TG710-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S1900-TG720-UNLOAD                SECTION.

           DISPLAY  'STEP : S1900-TG720-UNLOAD'.

           PERFORM  S6900-OPEN-TG720.

           MOVE  LOW-VALUE               TO  S-DATA-END-CHECK.
           PERFORM  UNTIL  S-NO-DATA
              PERFORM  S7900-FETCH-TG720
              IF  NOT  S-NO-DATA
                  PERFORM  S2900-MOVE-TG720-TO-OUT9
                  PERFORM  S5900-WRITE-OUT9
              END-IF
           END-PERFORM.

           PERFORM  S8900-CLOSE-TG720.

       S1900-TG720-UNLOAD-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2100-MOVE-TG210-TO-OUT1          SECTION.

           INITIALIZE                    OUT1-R.

           MOVE  BG21-BSE-IRT-N          TO  OUT1-BSE-IRT-N  .
           MOVE  ','                     TO  OUT1-FILLER1    .
           MOVE  BG21-IRT-NM             TO  OUT1-IRT-NM     .
           MOVE  ','                     TO  OUT1-FILLER2    .
           MOVE  BG21-AUTH-GRD-ID        TO  OUT1-AUTH-GRD-ID.
           MOVE  ','                     TO  OUT1-FILLER3    .
           MOVE  BG21-RG-SYS-D           TO  OUT1-RG-SYS-D   .
           MOVE  ','                     TO  OUT1-FILLER4    .
           MOVE  BG21-RG-SYS-TM          TO  OUT1-RG-SYS-TM  .
           MOVE  ','                     TO  OUT1-FILLER5    .
           MOVE  BG21-RG-K-ID            TO  OUT1-RG-K-ID    .
           MOVE  ','                     TO  OUT1-FILLER6    .
           MOVE  BG21-RNM-SYS-D          TO  OUT1-RNM-SYS-D  .
           MOVE  ','                     TO  OUT1-FILLER7    .
           MOVE  BG21-RNM-SYS-TM         TO  OUT1-RNM-SYS-TM .
           MOVE  ','                     TO  OUT1-FILLER8    .
           MOVE  BG21-RNM-K-ID           TO  OUT1-RNM-K-ID   .
           MOVE  ','                     TO  OUT1-FILLER9    .

       S2100-MOVE-TG210-TO-OUT1-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2200-MOVE-TG220-TO-OUT2          SECTION.

           INITIALIZE                    OUT2-R.

           MOVE  BG22-BSE-IRT-N          TO  OUT2-BSE-IRT-N .
           MOVE  ','                     TO  OUT2-FILLER1   .
           MOVE  BG22-EFT-ST-D           TO  OUT2-EFT-ST-D  .
           MOVE  ','                     TO  OUT2-FILLER2   .
           MOVE  BG22-USE-F              TO  OUT2-USE-F     .
           MOVE  ','                     TO  OUT2-FILLER3   .
           MOVE  BG22-BSE-IRT            TO  OUT2-BSE-IRT   .
           MOVE  ','                     TO  OUT2-FILLER4   .
           MOVE  BG22-RG-SYS-D           TO  OUT2-RG-SYS-D  .
           MOVE  ','                     TO  OUT2-FILLER5   .
           MOVE  BG22-RG-SYS-TM          TO  OUT2-RG-SYS-TM .
           MOVE  ','                     TO  OUT2-FILLER6   .
           MOVE  BG22-RG-K-ID            TO  OUT2-RG-K-ID   .
           MOVE  ','                     TO  OUT2-FILLER7   .
           MOVE  BG22-RNM-SYS-D          TO  OUT2-RNM-SYS-D .
           MOVE  ','                     TO  OUT2-FILLER8   .
           MOVE  BG22-RNM-SYS-TM         TO  OUT2-RNM-SYS-TM.
           MOVE  ','                     TO  OUT2-FILLER9   .
           MOVE  BG22-RNM-K-ID           TO  OUT2-RNM-K-ID  .
           MOVE  ','                     TO  OUT2-FILLER10  .

       S2200-MOVE-TG220-TO-OUT2-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2300-MOVE-TG230-TO-OUT3          SECTION.

           INITIALIZE                    OUT3-R.

           MOVE  BG23-AFCM-N             TO  OUT3-AFCM-N           .
           MOVE  ','                     TO  OUT3-FILLER1          .
           MOVE  BG23-AFSM-N             TO  OUT3-AFSM-N           .
           MOVE  ','                     TO  OUT3-FILLER2          .
           MOVE  BG23-BSN-PRDT-CD        TO  OUT3-BSN-PRDT-CD      .
           MOVE  ','                     TO  OUT3-FILLER3          .
           MOVE  BG23-LN-CD              TO  OUT3-LN-CD            .
           MOVE  ','                     TO  OUT3-FILLER4          .
           MOVE  BG23-IRT-KND-CD         TO  OUT3-IRT-KND-CD       .
           MOVE  ','                     TO  OUT3-FILLER5          .
           MOVE  BG23-EFT-ST-D           TO  OUT3-EFT-ST-D         .
           MOVE  ','                     TO  OUT3-FILLER6          .
           MOVE  BG23-USE-F              TO  OUT3-USE-F            .
           MOVE  ','                     TO  OUT3-FILLER7          .
           MOVE  BG23-IRT-N              TO  OUT3-IRT-N            .
           MOVE  ','                     TO  OUT3-FILLER8          .
           MOVE  BG23-AUTH-GRD-ID        TO  OUT3-AUTH-GRD-ID      .
           MOVE  ','                     TO  OUT3-FILLER9          .
           MOVE  BG23-IRT-TP-CD          TO  OUT3-IRT-TP-CD        .
           MOVE  ','                     TO  OUT3-FILLER10         .
           MOVE  BG23-STG-IRT-F          TO  OUT3-STG-IRT-F        .
           MOVE  ','                     TO  OUT3-FILLER11         .
           MOVE  BG23-IRT                TO  OUT3-IRT              .
           MOVE  ','                     TO  OUT3-FILLER12         .
           MOVE  BG23-K1-ITM-TXT-FRM-CD  TO  OUT3-K1-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER13         .
           MOVE  BG23-K2-ITM-TXT-FRM-CD  TO  OUT3-K2-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER14         .
           MOVE  BG23-K3-ITM-TXT-FRM-CD  TO  OUT3-K3-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER15         .
           MOVE  BG23-K4-ITM-TXT-FRM-CD  TO  OUT3-K4-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER16         .
           MOVE  BG23-K5-ITM-TXT-FRM-CD  TO  OUT3-K5-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER17         .
           MOVE  BG23-K6-ITM-TXT-FRM-CD  TO  OUT3-K6-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER18         .
           MOVE  BG23-K7-ITM-TXT-FRM-CD  TO  OUT3-K7-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER19         .
           MOVE  BG23-CK-ITM-TXT-FRM-CD  TO  OUT3-CK-ITM-TXT-FRM-CD.
           MOVE  ','                     TO  OUT3-FILLER20         .
           MOVE  BG23-KEY-1-DESC         TO  OUT3-KEY-1-DESC       .
           MOVE  ','                     TO  OUT3-FILLER21         .
           MOVE  BG23-KEY-2-DESC         TO  OUT3-KEY-2-DESC       .
           MOVE  ','                     TO  OUT3-FILLER22         .
           MOVE  BG23-KEY-3-DESC         TO  OUT3-KEY-3-DESC       .
           MOVE  ','                     TO  OUT3-FILLER23         .
           MOVE  BG23-KEY-4-DESC         TO  OUT3-KEY-4-DESC       .
           MOVE  ','                     TO  OUT3-FILLER24         .
           MOVE  BG23-KEY-5-DESC         TO  OUT3-KEY-5-DESC       .
           MOVE  ','                     TO  OUT3-FILLER25         .
           MOVE  BG23-KEY-6-DESC         TO  OUT3-KEY-6-DESC       .
           MOVE  ','                     TO  OUT3-FILLER26         .
           MOVE  BG23-KEY-7-DESC         TO  OUT3-KEY-7-DESC       .
           MOVE  ','                     TO  OUT3-FILLER27         .
           MOVE  BG23-C-KEY-DESC         TO  OUT3-C-KEY-DESC       .
           MOVE  ','                     TO  OUT3-FILLER28         .
           MOVE  BG23-RG-SYS-D           TO  OUT3-RG-SYS-D         .
           MOVE  ','                     TO  OUT3-FILLER29         .
           MOVE  BG23-RG-SYS-TM          TO  OUT3-RG-SYS-TM        .
           MOVE  ','                     TO  OUT3-FILLER30         .
           MOVE  BG23-RG-K-ID            TO  OUT3-RG-K-ID          .
           MOVE  ','                     TO  OUT3-FILLER31         .
           MOVE  BG23-RNM-SYS-D          TO  OUT3-RNM-SYS-D        .
           MOVE  ','                     TO  OUT3-FILLER32         .
           MOVE  BG23-RNM-SYS-TM         TO  OUT3-RNM-SYS-TM       .
           MOVE  ','                     TO  OUT3-FILLER33         .
           MOVE  BG23-RNM-K-ID           TO  OUT3-RNM-K-ID         .
           MOVE  ','                     TO  OUT3-FILLER34         .

       S2300-MOVE-TG230-TO-OUT3-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2400-MOVE-TG240-TO-OUT4          SECTION.

           INITIALIZE                    OUT4-R.

           MOVE  BG24-IRT-N              TO  OUT4-IRT-N        .
           MOVE  ','                     TO  OUT4-FILLER1      .

           MOVE  BG24-KEY-1-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-1-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER2      .

           MOVE  BG24-KEY-1-END-VAL      TO  W-CNV-X
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-1-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER3      .

           MOVE  BG24-KEY-2-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-2-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER4      .

           MOVE  BG24-KEY-2-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-2-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER5      .

           MOVE  BG24-KEY-3-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-3-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER6      .

           MOVE  BG24-KEY-3-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-3-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER7      .

           MOVE  BG24-KEY-4-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-4-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER8      .

           MOVE  BG24-KEY-4-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-4-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER9      .

           MOVE  BG24-KEY-5-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-5-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER10     .

           MOVE  BG24-KEY-5-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-5-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER11     .

           MOVE  BG24-KEY-6-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-6-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER12     .

           MOVE  BG24-KEY-6-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-6-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER13     .

           MOVE  BG24-KEY-7-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-7-ST-VAL .
           MOVE  ','                     TO  OUT4-FILLER14     .

           MOVE  BG24-KEY-7-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT4-KEY-7-END-VAL.
           MOVE  ','                     TO  OUT4-FILLER15     .

           MOVE  BG24-C-KEY              TO  OUT4-C-KEY        .
           MOVE  ','                     TO  OUT4-FILLER16     .
           MOVE  BG24-EFT-ST-D           TO  OUT4-EFT-ST-D     .
           MOVE  ','                     TO  OUT4-FILLER17     .
           MOVE  BG24-USE-F              TO  OUT4-USE-F        .
           MOVE  ','                     TO  OUT4-FILLER18     .
           MOVE  BG24-IRT-1              TO  OUT4-IRT-1        .
           MOVE  ','                     TO  OUT4-FILLER19     .
           MOVE  BG24-IRT-2              TO  OUT4-IRT-2        .
           MOVE  ','                     TO  OUT4-FILLER20     .
           MOVE  BG24-RG-SYS-D           TO  OUT4-RG-SYS-D     .
           MOVE  ','                     TO  OUT4-FILLER21     .
           MOVE  BG24-RG-SYS-TM          TO  OUT4-RG-SYS-TM    .
           MOVE  ','                     TO  OUT4-FILLER22     .
           MOVE  BG24-RG-K-ID            TO  OUT4-RG-K-ID      .
           MOVE  ','                     TO  OUT4-FILLER23     .
           MOVE  BG24-RNM-SYS-D          TO  OUT4-RNM-SYS-D    .
           MOVE  ','                     TO  OUT4-FILLER24     .
           MOVE  BG24-RNM-SYS-TM         TO  OUT4-RNM-SYS-TM   .
           MOVE  ','                     TO  OUT4-FILLER25     .
           MOVE  BG24-RNM-K-ID           TO  OUT4-RNM-K-ID     .
           MOVE  ','                     TO  OUT4-FILLER26     .

       S2400-MOVE-TG240-TO-OUT4-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2500-MOVE-TG290-TO-OUT5          SECTION.

           INITIALIZE                    OUT5-R.

           MOVE  BG29-BSE-IRT-KND-CD     TO  OUT5-BSE-IRT-KND-CD.
           MOVE  ','                     TO  OUT5-FILLER1       .
           MOVE  BG29-AFCM-N             TO  OUT5-AFCM-N        .
           MOVE  ','                     TO  OUT5-FILLER2       .
           MOVE  BG29-BSN-PRDT-CD        TO  OUT5-BSN-PRDT-CD   .
           MOVE  ','                     TO  OUT5-FILLER3       .
           MOVE  BG29-EFT-ST-D           TO  OUT5-EFT-ST-D      .
           MOVE  ','                     TO  OUT5-FILLER4       .
           MOVE  BG29-BSE-IRT-N          TO  OUT5-BSE-IRT-N     .
           MOVE  ','                     TO  OUT5-FILLER5       .
           MOVE  BG29-RG-SYS-D           TO  OUT5-RG-SYS-D      .
           MOVE  ','                     TO  OUT5-FILLER6       .
           MOVE  BG29-RG-SYS-TM          TO  OUT5-RG-SYS-TM     .
           MOVE  ','                     TO  OUT5-FILLER7       .
           MOVE  BG29-RG-K-ID            TO  OUT5-RG-K-ID       .
           MOVE  ','                     TO  OUT5-FILLER8       .
           MOVE  BG29-RNM-SYS-D          TO  OUT5-RNM-SYS-D     .
           MOVE  ','                     TO  OUT5-FILLER9       .
           MOVE  BG29-RNM-SYS-TM         TO  OUT5-RNM-SYS-TM    .
           MOVE  ','                     TO  OUT5-FILLER10      .
           MOVE  BG29-RNM-K-ID           TO  OUT5-RNM-K-ID      .
           MOVE  ','                     TO  OUT5-FILLER11      .

       S2500-MOVE-TG290-TO-OUT5-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2600-MOVE-TG610-TO-OUT6          SECTION.

           INITIALIZE                    OUT6-R.

           MOVE  BG61-SYS-ID             TO  OUT6-SYS-ID           .
           MOVE  ','                     TO  OUT6-FILLER1          .
           MOVE  BG61-SYS-KEY-1          TO  OUT6-SYS-KEY-1        .
           MOVE  ','                     TO  OUT6-FILLER2          .
           MOVE  BG61-SYS-KEY-2          TO  OUT6-SYS-KEY-2        .
           MOVE  ','                     TO  OUT6-FILLER3          .
           MOVE  BG61-SYS-KEY-3          TO  OUT6-SYS-KEY-3        .
           MOVE  ','                     TO  OUT6-FILLER4          .
           MOVE  BG61-SYS-KEY-4          TO  OUT6-SYS-KEY-4        .
           MOVE  ','                     TO  OUT6-FILLER5          .
           MOVE  BG61-FEE-C-CD           TO  OUT6-FEE-C-CD         .
           MOVE  ','                     TO  OUT6-FILLER6          .
           MOVE  BG61-EFT-ST-D           TO  OUT6-EFT-ST-D         .
           MOVE  ','                     TO  OUT6-FILLER7          .
           MOVE  BG61-USE-F              TO  OUT6-USE-F            .
           MOVE  ','                     TO  OUT6-FILLER8          .
           MOVE  BG61-EFT-END-D          TO  OUT6-EFT-END-D        .
           MOVE  ','                     TO  OUT6-FILLER9          .
           MOVE  BG61-AUTH-GRD-ID        TO  OUT6-AUTH-GRD-ID      .
           MOVE  ','                     TO  OUT6-FILLER10         .
           MOVE  BG61-KEY-1-DESC         TO  OUT6-KEY-1-DESC       .
           MOVE  ','                     TO  OUT6-FILLER11         .
           MOVE  BG61-KEY-2-DESC         TO  OUT6-KEY-2-DESC       .
           MOVE  ','                     TO  OUT6-FILLER12         .
           MOVE  BG61-KEY-3-DESC         TO  OUT6-KEY-3-DESC       .
           MOVE  ','                     TO  OUT6-FILLER13         .
           MOVE  BG61-KEY-4-DESC         TO  OUT6-KEY-4-DESC       .
           MOVE  ','                     TO  OUT6-FILLER14         .
           MOVE  BG61-KEY-5-DESC         TO  OUT6-KEY-5-DESC       .
           MOVE  ','                     TO  OUT6-FILLER15         .
           MOVE  BG61-KEY-6-DESC         TO  OUT6-KEY-6-DESC       .
           MOVE  ','                     TO  OUT6-FILLER16         .
           MOVE  BG61-KEY-7-DESC         TO  OUT6-KEY-7-DESC       .
           MOVE  ','                     TO  OUT6-FILLER17         .
           MOVE  BG61-C-KEY-DESC         TO  OUT6-C-KEY-DESC       .
           MOVE  ','                     TO  OUT6-FILLER18         .
           MOVE  BG61-KEY-1-N-F          TO  OUT6-KEY-1-N-F        .
           MOVE  ','                     TO  OUT6-FILLER19         .
           MOVE  BG61-KEY-2-N-F          TO  OUT6-KEY-2-N-F        .
           MOVE  ','                     TO  OUT6-FILLER20         .
           MOVE  BG61-KEY-3-N-F          TO  OUT6-KEY-3-N-F        .
           MOVE  ','                     TO  OUT6-FILLER21         .
           MOVE  BG61-KEY-4-N-F          TO  OUT6-KEY-4-N-F        .
           MOVE  ','                     TO  OUT6-FILLER22         .
           MOVE  BG61-KEY-5-N-F          TO  OUT6-KEY-5-N-F        .
           MOVE  ','                     TO  OUT6-FILLER23         .
           MOVE  BG61-KEY-6-N-F          TO  OUT6-KEY-6-N-F        .
           MOVE  ','                     TO  OUT6-FILLER24         .
           MOVE  BG61-KEY-7-N-F          TO  OUT6-KEY-7-N-F        .
           MOVE  ','                     TO  OUT6-FILLER25         .
           MOVE  BG61-C-KEY-N-F          TO  OUT6-C-KEY-N-F        .
           MOVE  ','                     TO  OUT6-FILLER26         .
           MOVE  BG61-FEE-DESC           TO  OUT6-FEE-DESC         .
           MOVE  ','                     TO  OUT6-FILLER27         .
           MOVE  BG61-FEE-FRM-CD         TO  OUT6-FEE-FRM-CD       .
           MOVE  ','                     TO  OUT6-FILLER28         .
           MOVE  BG61-FEE-N              TO  OUT6-FEE-N            .
           MOVE  ','                     TO  OUT6-FILLER29         .
           MOVE  BG61-ACT-CD1            TO  OUT6-ACT-CD1          .
           MOVE  ','                     TO  OUT6-FILLER30         .
           MOVE  BG61-ACT-CD2            TO  OUT6-ACT-CD2          .
           MOVE  ','                     TO  OUT6-FILLER31         .
           MOVE  BG61-NQRY-MTD-CD        TO  OUT6-NQRY-MTD-CD      .
           MOVE  ','                     TO  OUT6-FILLER32         .
           MOVE  BG61-NQRY-MTD-DESC      TO  OUT6-NQRY-MTD-DESC    .
           MOVE  ','                     TO  OUT6-FILLER33         .
           MOVE  BG61-CALC-MTD-CD        TO  OUT6-CALC-MTD-CD      .
           MOVE  ','                     TO  OUT6-FILLER34         .
           MOVE  BG61-CALC-MTD-DESC      TO  OUT6-CALC-MTD-DESC    .
           MOVE  ','                     TO  OUT6-FILLER35         .
           MOVE  BG61-BSE-FEE            TO  OUT6-BSE-FEE          .
           MOVE  ','                     TO  OUT6-FILLER36         .
           MOVE  BG61-BSE-FEE-TP-CD      TO  OUT6-BSE-FEE-TP-CD    .
           MOVE  ','                     TO  OUT6-FILLER37         .
           MOVE  BG61-BSE-FEE-EFT-AMT    TO  OUT6-BSE-FEE-EFT-AMT  .
           MOVE  ','                     TO  OUT6-FILLER38         .
           MOVE  BG61-ADD-FEE            TO  OUT6-ADD-FEE          .
           MOVE  ','                     TO  OUT6-FILLER39         .
           MOVE  BG61-ADD-FEE-TP-CD      TO  OUT6-ADD-FEE-TP-CD    .
           MOVE  ','                     TO  OUT6-FILLER40         .
           MOVE  BG61-ADD-FEE-UNT-AMT    TO  OUT6-ADD-FEE-UNT-AMT  .
           MOVE  ','                     TO  OUT6-FILLER41         .
           MOVE  BG61-STG-FEE-TP-CD      TO  OUT6-STG-FEE-TP-CD    .
           MOVE  ','                     TO  OUT6-FILLER42         .
           MOVE  BG61-MIN-FEE            TO  OUT6-MIN-FEE          .
           MOVE  ','                     TO  OUT6-FILLER43         .
           MOVE  BG61-MAX-FEE            TO  OUT6-MAX-FEE          .
           MOVE  ','                     TO  OUT6-FILLER44         .
           MOVE  BG61-MIN-MAX-FEE-TP-CD  TO  OUT6-MIN-MAX-FEE-TP-CD.
           MOVE  ','                     TO  OUT6-FILLER45         .
           MOVE  BG61-RNE-MTD-DESC       TO  OUT6-RNE-MTD-DESC     .
           MOVE  ','                     TO  OUT6-FILLER46         .
           MOVE  BG61-MAX-RNE-FEE        TO  OUT6-MAX-RNE-FEE      .
           MOVE  ','                     TO  OUT6-FILLER47         .
           MOVE  BG61-RG-SYS-D           TO  OUT6-RG-SYS-D         .
           MOVE  ','                     TO  OUT6-FILLER48         .
           MOVE  BG61-RG-SYS-TM          TO  OUT6-RG-SYS-TM        .
           MOVE  ','                     TO  OUT6-FILLER49         .
           MOVE  BG61-RG-K-ID            TO  OUT6-RG-K-ID          .
           MOVE  ','                     TO  OUT6-FILLER50         .
           MOVE  BG61-RNM-SYS-D          TO  OUT6-RNM-SYS-D        .
           MOVE  ','                     TO  OUT6-FILLER51         .
           MOVE  BG61-RNM-SYS-TM         TO  OUT6-RNM-SYS-TM       .
           MOVE  ','                     TO  OUT6-FILLER52         .
           MOVE  BG61-RNM-K-ID           TO  OUT6-RNM-K-ID         .
           MOVE  ','                     TO  OUT6-FILLER53         .

       S2600-MOVE-TG610-TO-OUT6-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2700-MOVE-TG620-TO-OUT7          SECTION.

           INITIALIZE                    OUT7-R.

           MOVE  BG62-FEE-N              TO  OUT7-FEE-N        .
           MOVE  ','                     TO  OUT7-FILLER1      .

           MOVE  BG62-KEY-1-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-1-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER2      .

           MOVE  BG62-KEY-1-END-VAL      TO  W-CNV-X
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-1-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER3      .

           MOVE  BG62-KEY-2-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-2-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER4      .

           MOVE  BG62-KEY-2-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-2-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER5      .

           MOVE  BG62-KEY-3-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-3-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER6      .

           MOVE  BG62-KEY-3-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-3-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER7      .

           MOVE  BG62-KEY-4-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-4-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER8      .

           MOVE  BG62-KEY-4-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-4-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER9      .

           MOVE  BG62-KEY-5-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-5-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER10     .

           MOVE  BG62-KEY-5-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-5-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER11     .

           MOVE  BG62-KEY-6-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-6-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER12     .

           MOVE  BG62-KEY-6-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-6-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER13     .

           MOVE  BG62-KEY-7-ST-VAL       TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-7-ST-VAL .
           MOVE  ','                     TO  OUT7-FILLER14     .

           MOVE  BG62-KEY-7-END-VAL      TO  W-CNV-X           .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT7-KEY-7-END-VAL.
           MOVE  ','                     TO  OUT7-FILLER15     .

           MOVE  BG62-C-KEY              TO  OUT7-C-KEY        .
           MOVE  ','                     TO  OUT7-FILLER16     .
           MOVE  BG62-EFT-ST-D           TO  OUT7-EFT-ST-D     .
           MOVE  ','                     TO  OUT7-FILLER17     .
           MOVE  BG62-USE-F              TO  OUT7-USE-F        .
           MOVE  ','                     TO  OUT7-FILLER18     .
           MOVE  BG62-EFT-END-D          TO  OUT7-EFT-END-D    .
           MOVE  ','                     TO  OUT7-FILLER19     .
           MOVE  BG62-STG-FEE            TO  OUT7-STG-FEE      .
           MOVE  ','                     TO  OUT7-FILLER20     .
           MOVE  BG62-RG-SYS-D           TO  OUT7-RG-SYS-D     .
           MOVE  ','                     TO  OUT7-FILLER21     .
           MOVE  BG62-RG-SYS-TM          TO  OUT7-RG-SYS-TM    .
           MOVE  ','                     TO  OUT7-FILLER22     .
           MOVE  BG62-RG-K-ID            TO  OUT7-RG-K-ID      .
           MOVE  ','                     TO  OUT7-FILLER23     .
           MOVE  BG62-RNM-SYS-D          TO  OUT7-RNM-SYS-D    .
           MOVE  ','                     TO  OUT7-FILLER24     .
           MOVE  BG62-RNM-SYS-TM         TO  OUT7-RNM-SYS-TM   .
           MOVE  ','                     TO  OUT7-FILLER25     .
           MOVE  BG62-RNM-K-ID           TO  OUT7-RNM-K-ID     .
           MOVE  ','                     TO  OUT7-FILLER26     .

       S2700-MOVE-TG620-TO-OUT7-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2800-MOVE-TG710-TO-OUT8          SECTION.

           INITIALIZE                    OUT8-R.

           MOVE  BG71-MKTG-N             TO  OUT8-MKTG-N            .
           MOVE  ','                     TO  OUT8-FILLER1           .
           MOVE  BG71-MKTG-EFT-ST-D      TO  OUT8-MKTG-EFT-ST-D     .
           MOVE  ','                     TO  OUT8-FILLER2           .
           MOVE  BG71-MKTG-DESC-TXT      TO  OUT8-MKTG-DESC-TXT     .
           MOVE  ','                     TO  OUT8-FILLER3           .
           MOVE  BG71-MKTG-INFO-USE-F    TO  OUT8-MKTG-INFO-USE-F   .
           MOVE  ','                     TO  OUT8-FILLER4           .
           MOVE  BG71-MKTG-EFT-END-D     TO  OUT8-MKTG-EFT-END-D    .
           MOVE  ','                     TO  OUT8-FILLER5           .
           MOVE  BG71-AUTH-GRD-ID        TO  OUT8-AUTH-GRD-ID       .
           MOVE  ','                     TO  OUT8-FILLER6           .
           MOVE  BG71-BSN-PRDT-CD        TO  OUT8-BSN-PRDT-CD       .
           MOVE  ','                     TO  OUT8-FILLER7           .
           MOVE  BG71-PRDT-PRTY          TO  OUT8-PRDT-PRTY         .
           MOVE  ','                     TO  OUT8-FILLER8           .
           MOVE  BG71-SCF-OBJ-K-F        TO  OUT8-SCF-OBJ-K-F       .
           MOVE  ','                     TO  OUT8-FILLER9           .
           MOVE  BG71-MKTG-EFT-F         TO  OUT8-MKTG-EFT-F        .
           MOVE  ','                     TO  OUT8-FILLER10          .
           MOVE  BG71-MAX-IRT            TO  OUT8-MAX-IRT           .
           MOVE  ','                     TO  OUT8-FILLER11          .
           MOVE  BG71-MIN-IRT            TO  OUT8-MIN-IRT           .
           MOVE  ','                     TO  OUT8-FILLER12          .
           MOVE  BG71-MAX-FEE-RT         TO  OUT8-MAX-FEE-RT        .
           MOVE  ','                     TO  OUT8-FILLER13          .
           MOVE  BG71-MIN-FEE-RT         TO  OUT8-MIN-FEE-RT        .
           MOVE  ','                     TO  OUT8-FILLER14          .
           MOVE  BG71-MAX-LN-LMT-AMT     TO  OUT8-MAX-LN-LMT-AMT    .
           MOVE  ','                     TO  OUT8-FILLER15          .
           MOVE  BG71-MIN-LN-LMT-AMT     TO  OUT8-MIN-LN-LMT-AMT    .
           MOVE  ','                     TO  OUT8-FILLER16          .
           MOVE  BG71-MKTG-EFT-OBJ-CD    TO  OUT8-MKTG-EFT-OBJ-CD   .
           MOVE  ','                     TO  OUT8-FILLER17          .
           MOVE  BG71-MKTG-OFF-C-CD      TO  OUT8-MKTG-OFF-C-CD     .
           MOVE  ','                     TO  OUT8-FILLER18          .
           MOVE  BG71-MKTG-PRDT-C-CD     TO  OUT8-MKTG-PRDT-C-CD    .
           MOVE  ','                     TO  OUT8-FILLER19          .
           MOVE  BG71-MKTG-IRT-EFT-TP-CD TO  OUT8-MKTG-IRT-EFT-TP-CD.
           MOVE  ','                     TO  OUT8-FILLER20          .
           MOVE  BG71-MKTG-FEE-EFT-TP-CD TO  OUT8-MKTG-FEE-EFT-TP-CD.
           MOVE  ','                     TO  OUT8-FILLER21          .
           MOVE  BG71-MKTG-LMT-TP-CD     TO  OUT8-MKTG-LMT-TP-CD    .
           MOVE  ','                     TO  OUT8-FILLER22          .
           MOVE  BG71-K1-MKTG-ITM-CD     TO  OUT8-K1-MKTG-ITM-CD    .
           MOVE  ','                     TO  OUT8-FILLER23          .
           MOVE  BG71-K2-MKTG-ITM-CD     TO  OUT8-K2-MKTG-ITM-CD    .
           MOVE  ','                     TO  OUT8-FILLER24          .
           MOVE  BG71-K3-MKTG-ITM-CD     TO  OUT8-K3-MKTG-ITM-CD    .
           MOVE  ','                     TO  OUT8-FILLER25          .
           MOVE  BG71-K4-MKTG-ITM-CD     TO  OUT8-K4-MKTG-ITM-CD    .
           MOVE  ','                     TO  OUT8-FILLER26          .
           MOVE  BG71-K5-MKTG-ITM-CD     TO  OUT8-K5-MKTG-ITM-CD    .
           MOVE  ','                     TO  OUT8-FILLER27          .
           MOVE  BG71-K6-MKTG-ITM-CD     TO  OUT8-K6-MKTG-ITM-CD    .
           MOVE  ','                     TO  OUT8-FILLER28          .
           MOVE  BG71-RG-K-ID            TO  OUT8-RG-K-ID           .
           MOVE  ','                     TO  OUT8-FILLER29          .
           MOVE  BG71-RG-SYS-D           TO  OUT8-RG-SYS-D          .
           MOVE  ','                     TO  OUT8-FILLER30          .
           MOVE  BG71-RG-SYS-TM          TO  OUT8-RG-SYS-TM         .
           MOVE  ','                     TO  OUT8-FILLER31          .
           MOVE  BG71-RNM-K-ID           TO  OUT8-RNM-K-ID          .
           MOVE  ','                     TO  OUT8-FILLER32          .
           MOVE  BG71-RNM-SYS-D          TO  OUT8-RNM-SYS-D         .
           MOVE  ','                     TO  OUT8-FILLER33          .
           MOVE  BG71-RNM-SYS-TM         TO  OUT8-RNM-SYS-TM        .
           MOVE  ','                     TO  OUT8-FILLER34          .

       S2800-MOVE-TG710-TO-OUT8-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *                                                              *
      ****************************************************************
       S2900-MOVE-TG720-TO-OUT9          SECTION.

           INITIALIZE                    OUT9-R.

           MOVE  BG72-MKTG-N             TO  OUT9-MKTG-N          .
           MOVE  ','                     TO  OUT9-FILLER1         .

           MOVE  BG72-KEY-1-ST-VAL       TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-1-ST-VAL    .
           MOVE  ','                     TO  OUT9-FILLER2         .

           MOVE  BG72-KEY-1-END-VAL      TO  W-CNV-X
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-1-END-VAL   .
           MOVE  ','                     TO  OUT9-FILLER3         .

           MOVE  BG72-KEY-2-ST-VAL       TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-2-ST-VAL    .
           MOVE  ','                     TO  OUT9-FILLER4         .

           MOVE  BG72-KEY-2-END-VAL      TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-2-END-VAL   .
           MOVE  ','                     TO  OUT9-FILLER5         .

           MOVE  BG72-KEY-3-ST-VAL       TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-3-ST-VAL    .
           MOVE  ','                     TO  OUT9-FILLER6         .

           MOVE  BG72-KEY-3-END-VAL      TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-3-END-VAL   .
           MOVE  ','                     TO  OUT9-FILLER7         .

           MOVE  BG72-KEY-4-ST-VAL       TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-4-ST-VAL    .
           MOVE  ','                     TO  OUT9-FILLER8         .

           MOVE  BG72-KEY-4-END-VAL      TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-4-END-VAL   .
           MOVE  ','                     TO  OUT9-FILLER9         .

           MOVE  BG72-KEY-5-ST-VAL       TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-5-ST-VAL    .
           MOVE  ','                     TO  OUT9-FILLER10        .

           MOVE  BG72-KEY-5-END-VAL      TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-5-END-VAL   .
           MOVE  ','                     TO  OUT9-FILLER11        .

           MOVE  BG72-KEY-6-ST-VAL       TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-6-ST-VAL    .
           MOVE  ','                     TO  OUT9-FILLER12        .

           MOVE  BG72-KEY-6-END-VAL      TO  W-CNV-X              .
           PERFORM  S3100-CONV-SKEY.
           MOVE  W-CHAR                  TO  OUT9-KEY-6-END-VAL   .
           MOVE  ','                     TO  OUT9-FILLER13        .

           MOVE  BG72-MKTG-INFO-USE-F    TO  OUT9-MKTG-INFO-USE-F .
           MOVE  ','                     TO  OUT9-FILLER14        .
           MOVE  BG72-MKTG-EFT-IRT-AMT   TO  OUT9-MKTG-EFT-IRT-AMT.
           MOVE  ','                     TO  OUT9-FILLER15        .
           MOVE  BG72-MKTG-EFT-FEE       TO  OUT9-MKTG-EFT-FEE    .
           MOVE  ','                     TO  OUT9-FILLER16        .
           MOVE  BG72-MKTG-LN-LMT-AMT    TO  OUT9-MKTG-LN-LMT-AMT .
           MOVE  ','                     TO  OUT9-FILLER17        .
           MOVE  BG72-RG-K-ID            TO  OUT9-RG-K-ID         .
           MOVE  ','                     TO  OUT9-FILLER18        .
           MOVE  BG72-RG-SYS-D           TO  OUT9-RG-SYS-D        .
           MOVE  ','                     TO  OUT9-FILLER19        .
           MOVE  BG72-RG-SYS-TM          TO  OUT9-RG-SYS-TM       .
           MOVE  ','                     TO  OUT9-FILLER20        .
           MOVE  BG72-RNM-K-ID           TO  OUT9-RNM-K-ID        .
           MOVE  ','                     TO  OUT9-FILLER21        .
           MOVE  BG72-RNM-SYS-D          TO  OUT9-RNM-SYS-D       .
           MOVE  ','                     TO  OUT9-FILLER22        .
           MOVE  BG72-RNM-SYS-TM         TO  OUT9-RNM-SYS-TM      .
           MOVE  ','                     TO  OUT9-FILLER23        .

       S2900-MOVE-TG720-TO-OUT9-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *   n/7v~ se/~ vJE                               *
      *                                                              *
      ****************************************************************
       S3100-CONV-SKEY                   SECTION.

           IF  W-CNV-X                   <   SPACE
               MOVE  W-CNV-N             TO  W-NUM
               PERFORM  S3200-CONV-NUM-TO-CHAR
           ELSE
               MOVE  W-CNV-X             TO  W-CHAR
           END-IF.

       S3100-CONV-SKEY-EXIT.
           EXIT.

       S3200-CONV-NUM-TO-CHAR            SECTION.

           MOVE  W-NUM                   TO  W-Z-NUM.
           MOVE  W-Z-NUM                 TO  W-CHAR.

           PERFORM  VARYING  J  FROM  1  BY  1  UNTIL  J  >  16
                IF  W-CH(J)              =  SPACE
                    CONTINUE
                ELSE
                    MOVE  W-CHAR(J:)     TO  W-E-CHAR
                    MOVE  16             TO  J
                END-IF
           END-PERFORM.

           MOVE  W-E-CHAR                TO  W-CHAR.

           PERFORM  VARYING  J  FROM  1  BY  1  UNTIL  J  >  13
                IF  W-CHAR(J:4)          =   '.000'
                    MOVE  SPACE          TO  W-CHAR(J:)
                    MOVE  16             TO  J
                END-IF
           END-PERFORM.

       S3200-CONV-NUM-TO-CHAR-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    S A M    P R O C E S S                                    *
      *                                                              *
      ****************************************************************
       S5100-WRITE-OUT1                  SECTION.

           WRITE   OUT1-R.

           IF  NOT  S-OUT1-NORMAL
               DISPLAY
               'S5100:ERROR=OUTSAM1 WRITE ERROR(' S-OUT1-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT1-WRIT-CNT.

       S5100-READ-OUT1-EXIT.
           EXIT.

       S5200-WRITE-OUT2                  SECTION.

           WRITE   OUT2-R.

           IF  NOT  S-OUT2-NORMAL
               DISPLAY
               'S5200:ERROR=OUTSAM2 WRITE ERROR(' S-OUT2-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT2-WRIT-CNT.

       S5200-READ-OUT2-EXIT.
           EXIT.

       S5300-WRITE-OUT3                  SECTION.

           WRITE   OUT3-R.

           IF  NOT  S-OUT3-NORMAL
               DISPLAY
               'S5300:ERROR=OUTSAM3 WRITE ERROR(' S-OUT3-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT3-WRIT-CNT.

       S5300-READ-OUT3-EXIT.
           EXIT.

       S5400-WRITE-OUT4                  SECTION.

           WRITE   OUT4-R.

           IF  NOT  S-OUT4-NORMAL
               DISPLAY
               'S5400:ERROR=OUTSAM4 WRITE ERROR(' S-OUT4-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT4-WRIT-CNT.

       S5400-READ-OUT4-EXIT.
           EXIT.

       S5500-WRITE-OUT5                  SECTION.

           WRITE   OUT5-R.

           IF  NOT  S-OUT5-NORMAL
               DISPLAY
               'S5500:ERROR=OUTSAM5 WRITE ERROR(' S-OUT5-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT5-WRIT-CNT.

       S5500-READ-OUT5-EXIT.
           EXIT.

       S5600-WRITE-OUT6                  SECTION.

           WRITE   OUT6-R.

           IF  NOT  S-OUT6-NORMAL
               DISPLAY
               'S5600:ERROR=OUTSAM6 WRITE ERROR(' S-OUT6-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT6-WRIT-CNT.

       S5600-READ-OUT6-EXIT.
           EXIT.

       S5700-WRITE-OUT7                  SECTION.

           WRITE   OUT7-R.

           IF  NOT  S-OUT7-NORMAL
               DISPLAY
               'S5700:ERROR=OUTSAM7 WRITE ERROR(' S-OUT7-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT7-WRIT-CNT.

       S5700-READ-OUT7-EXIT.
           EXIT.

       S5800-WRITE-OUT8                  SECTION.

           WRITE   OUT8-R.

           IF  NOT  S-OUT8-NORMAL
               DISPLAY
               'S5800:ERROR=OUTSAM8 WRITE ERROR(' S-OUT8-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT8-WRIT-CNT.

       S5800-READ-OUT8-EXIT.
           EXIT.

       S5900-WRITE-OUT9                  SECTION.

           WRITE   OUT9-R.

           IF  NOT  S-OUT9-NORMAL
               DISPLAY
               'S5900:ERROR=OUTSAM9 WRITE ERROR(' S-OUT9-STATUS ')'
               MOVE  U-ABEND-CODE1       TO  RETURN-CODE
               PERFORM  S0100-MAIN-EXIT
           END-IF.

           ADD     1                     TO  A-OUT9-WRIT-CNT.

       S5900-READ-OUT9-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *
      *    D B I O    P R O C E S S                                  *
      *                                                              *
      ****************************************************************
       S6100-OPEN-TG210                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G210
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6100:DB ERROR TG210 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6100-OPEN-TG210-EXIT.
           EXIT.

       S6200-OPEN-TG220                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G220
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6200:DB ERROR TG220 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6200-OPEN-TG220-EXIT.
           EXIT.

       S6300-OPEN-TG230                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G230
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6300:DB ERROR TG230 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6300-OPEN-TG230-EXIT.
           EXIT.

       S6400-OPEN-TG240                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G240
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6400:DB ERROR TG240 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6400-OPEN-TG240-EXIT.
           EXIT.

       S6500-OPEN-TG290                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G290
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6500:DB ERROR TG290 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6500-OPEN-TG290-EXIT.
           EXIT.

       S6600-OPEN-TG610                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G610
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6600:DB ERROR TG610 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6600-OPEN-TG610-EXIT.
           EXIT.

       S6700-OPEN-TG620                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G620
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6700:DB ERROR TG620 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6700-OPEN-TG620-EXIT.
           EXIT.

       S6800-OPEN-TG710                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G710
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6800:DB ERROR TG710 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6800-OPEN-TG710-EXIT.
           EXIT.

       S6900-OPEN-TG720                  SECTION.

           EXEC  SQL
                 OPEN  CURSOR_G720
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S6900:DB ERROR TG720 OPEN=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S6900-OPEN-TG720-EXIT.
           EXIT.

       S7100-FETCH-TG210                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G210
                 INTO  :BG21-BSE-IRT-N
                 ,     :BG21-IRT-NM
                 ,     :BG21-AUTH-GRD-ID
                 ,     :BG21-RG-SYS-D
                 ,     :BG21-RG-SYS-TM
                 ,     :BG21-RG-K-ID
                 ,     :BG21-RNM-SYS-D
                 ,     :BG21-RNM-SYS-TM
                 ,     :BG21-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG21-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7100:DB ERROR TG210 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7100-FETCH-TG210-EXIT.
           EXIT.

       S7200-FETCH-TG220                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G220
                 INTO  :BG22-BSE-IRT-N
                 ,     :BG22-EFT-ST-D
                 ,     :BG22-USE-F
                 ,     :BG22-BSE-IRT
                 ,     :BG22-RG-SYS-D
                 ,     :BG22-RG-SYS-TM
                 ,     :BG22-RG-K-ID
                 ,     :BG22-RNM-SYS-D
                 ,     :BG22-RNM-SYS-TM
                 ,     :BG22-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG22-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7200:DB ERROR TG220 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7200-FETCH-TG220-EXIT.
           EXIT.

       S7300-FETCH-TG230                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G230
                 INTO  :BG23-AFCM-N
                 ,     :BG23-AFSM-N
                 ,     :BG23-BSN-PRDT-CD
                 ,     :BG23-LN-CD
                 ,     :BG23-IRT-KND-CD
                 ,     :BG23-EFT-ST-D
                 ,     :BG23-USE-F
                 ,     :BG23-IRT-N
                 ,     :BG23-AUTH-GRD-ID
                 ,     :BG23-IRT-TP-CD
                 ,     :BG23-STG-IRT-F
                 ,     :BG23-IRT
                 ,     :BG23-K1-ITM-TXT-FRM-CD
                 ,     :BG23-K2-ITM-TXT-FRM-CD
                 ,     :BG23-K3-ITM-TXT-FRM-CD
                 ,     :BG23-K4-ITM-TXT-FRM-CD
                 ,     :BG23-K5-ITM-TXT-FRM-CD
                 ,     :BG23-K6-ITM-TXT-FRM-CD
                 ,     :BG23-K7-ITM-TXT-FRM-CD
                 ,     :BG23-CK-ITM-TXT-FRM-CD
                 ,     :BG23-KEY-1-DESC
                 ,     :BG23-KEY-2-DESC
                 ,     :BG23-KEY-3-DESC
                 ,     :BG23-KEY-4-DESC
                 ,     :BG23-KEY-5-DESC
                 ,     :BG23-KEY-6-DESC
                 ,     :BG23-KEY-7-DESC
                 ,     :BG23-C-KEY-DESC
                 ,     :BG23-RG-SYS-D
                 ,     :BG23-RG-SYS-TM
                 ,     :BG23-RG-K-ID
                 ,     :BG23-RNM-SYS-D
                 ,     :BG23-RNM-SYS-TM
                 ,     :BG23-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG23-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7300:DB ERROR TG230 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7300-FETCH-TG230-EXIT.
           EXIT.

       S7400-FETCH-TG240                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G240
                 INTO  :BG24-IRT-N
                 ,     :BG24-KEY-1-ST-VAL
                 ,     :BG24-KEY-1-END-VAL
                 ,     :BG24-KEY-2-ST-VAL
                 ,     :BG24-KEY-2-END-VAL
                 ,     :BG24-KEY-3-ST-VAL
                 ,     :BG24-KEY-3-END-VAL
                 ,     :BG24-KEY-4-ST-VAL
                 ,     :BG24-KEY-4-END-VAL
                 ,     :BG24-KEY-5-ST-VAL
                 ,     :BG24-KEY-5-END-VAL
                 ,     :BG24-KEY-6-ST-VAL
                 ,     :BG24-KEY-6-END-VAL
                 ,     :BG24-KEY-7-ST-VAL
                 ,     :BG24-KEY-7-END-VAL
                 ,     :BG24-C-KEY
                 ,     :BG24-EFT-ST-D
                 ,     :BG24-USE-F
                 ,     :BG24-IRT-1
                 ,     :BG24-IRT-2
                 ,     :BG24-RG-SYS-D
                 ,     :BG24-RG-SYS-TM
                 ,     :BG24-RG-K-ID
                 ,     :BG24-RNM-SYS-D
                 ,     :BG24-RNM-SYS-TM
                 ,     :BG24-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG24-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7400:DB ERROR TG240 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7400-FETCH-TG240-EXIT.
           EXIT.

       S7500-FETCH-TG290                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G290
                 INTO  :BG29-BSE-IRT-KND-CD
                 ,     :BG29-AFCM-N
                 ,     :BG29-BSN-PRDT-CD
                 ,     :BG29-EFT-ST-D
                 ,     :BG29-BSE-IRT-N
                 ,     :BG29-RG-SYS-D
                 ,     :BG29-RG-SYS-TM
                 ,     :BG29-RG-K-ID
                 ,     :BG29-RNM-SYS-D
                 ,     :BG29-RNM-SYS-TM
                 ,     :BG29-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG29-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7500:DB ERROR TG290 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7500-FETCH-TG290-EXIT.
           EXIT.

       S7600-FETCH-TG610                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G610
                 INTO  :BG61-SYS-ID
                 ,     :BG61-SYS-KEY-1
                 ,     :BG61-SYS-KEY-2
                 ,     :BG61-SYS-KEY-3
                 ,     :BG61-SYS-KEY-4
                 ,     :BG61-FEE-C-CD
                 ,     :BG61-EFT-ST-D
                 ,     :BG61-USE-F
                 ,     :BG61-EFT-END-D
                 ,     :BG61-AUTH-GRD-ID
                 ,     :BG61-KEY-1-DESC
                 ,     :BG61-KEY-2-DESC
                 ,     :BG61-KEY-3-DESC
                 ,     :BG61-KEY-4-DESC
                 ,     :BG61-KEY-5-DESC
                 ,     :BG61-KEY-6-DESC
                 ,     :BG61-KEY-7-DESC
                 ,     :BG61-C-KEY-DESC
                 ,     :BG61-KEY-1-N-F
                 ,     :BG61-KEY-2-N-F
                 ,     :BG61-KEY-3-N-F
                 ,     :BG61-KEY-4-N-F
                 ,     :BG61-KEY-5-N-F
                 ,     :BG61-KEY-6-N-F
                 ,     :BG61-KEY-7-N-F
                 ,     :BG61-C-KEY-N-F
                 ,     :BG61-FEE-DESC
                 ,     :BG61-FEE-FRM-CD
                 ,     :BG61-FEE-N
                 ,     :BG61-ACT-CD1
                 ,     :BG61-ACT-CD2
                 ,     :BG61-NQRY-MTD-CD
                 ,     :BG61-NQRY-MTD-DESC
                 ,     :BG61-CALC-MTD-CD
                 ,     :BG61-CALC-MTD-DESC
                 ,     :BG61-BSE-FEE
                 ,     :BG61-BSE-FEE-TP-CD
                 ,     :BG61-BSE-FEE-EFT-AMT
                 ,     :BG61-ADD-FEE
                 ,     :BG61-ADD-FEE-TP-CD
                 ,     :BG61-ADD-FEE-UNT-AMT
                 ,     :BG61-STG-FEE-TP-CD
                 ,     :BG61-MIN-FEE
                 ,     :BG61-MAX-FEE
                 ,     :BG61-MIN-MAX-FEE-TP-CD
                 ,     :BG61-RNE-MTD-DESC
                 ,     :BG61-MAX-RNE-FEE
                 ,     :BG61-RG-SYS-D
                 ,     :BG61-RG-SYS-TM
                 ,     :BG61-RG-K-ID
                 ,     :BG61-RNM-SYS-D
                 ,     :BG61-RNM-SYS-TM
                 ,     :BG61-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG61-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7600:DB ERROR TG610 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7600-FETCH-TG610-EXIT.
           EXIT.

       S7700-FETCH-TG620                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G620
                 INTO  :BG62-FEE-N
                 ,     :BG62-KEY-1-ST-VAL
                 ,     :BG62-KEY-1-END-VAL
                 ,     :BG62-KEY-2-ST-VAL
                 ,     :BG62-KEY-2-END-VAL
                 ,     :BG62-KEY-3-ST-VAL
                 ,     :BG62-KEY-3-END-VAL
                 ,     :BG62-KEY-4-ST-VAL
                 ,     :BG62-KEY-4-END-VAL
                 ,     :BG62-KEY-5-ST-VAL
                 ,     :BG62-KEY-5-END-VAL
                 ,     :BG62-KEY-6-ST-VAL
                 ,     :BG62-KEY-6-END-VAL
                 ,     :BG62-KEY-7-ST-VAL
                 ,     :BG62-KEY-7-END-VAL
                 ,     :BG62-C-KEY
                 ,     :BG62-EFT-ST-D
                 ,     :BG62-USE-F
                 ,     :BG62-EFT-END-D
                 ,     :BG62-STG-FEE
                 ,     :BG62-RG-SYS-D
                 ,     :BG62-RG-SYS-TM
                 ,     :BG62-RG-K-ID
                 ,     :BG62-RNM-SYS-D
                 ,     :BG62-RNM-SYS-TM
                 ,     :BG62-RNM-K-ID
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG62-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7700:DB ERROR TG620 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7700-FETCH-TG620-EXIT.
           EXIT.

       S7800-FETCH-TG710                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G710
                 INTO  :BG71-MKTG-N
                 ,     :BG71-MKTG-EFT-ST-D
                 ,     :BG71-MKTG-DESC-TXT
                 ,     :BG71-MKTG-INFO-USE-F
                 ,     :BG71-MKTG-EFT-END-D
                 ,     :BG71-AUTH-GRD-ID
                 ,     :BG71-BSN-PRDT-CD
                 ,     :BG71-PRDT-PRTY
                 ,     :BG71-SCF-OBJ-K-F
                 ,     :BG71-MKTG-EFT-F
                 ,     :BG71-MAX-IRT
                 ,     :BG71-MIN-IRT
                 ,     :BG71-MAX-FEE-RT
                 ,     :BG71-MIN-FEE-RT
                 ,     :BG71-MAX-LN-LMT-AMT
                 ,     :BG71-MIN-LN-LMT-AMT
                 ,     :BG71-MKTG-EFT-OBJ-CD
                 ,     :BG71-MKTG-OFF-C-CD
                 ,     :BG71-MKTG-PRDT-C-CD
                 ,     :BG71-MKTG-IRT-EFT-TP-CD
                 ,     :BG71-MKTG-FEE-EFT-TP-CD
                 ,     :BG71-MKTG-LMT-TP-CD
                 ,     :BG71-K1-MKTG-ITM-CD
                 ,     :BG71-K2-MKTG-ITM-CD
                 ,     :BG71-K3-MKTG-ITM-CD
                 ,     :BG71-K4-MKTG-ITM-CD
                 ,     :BG71-K5-MKTG-ITM-CD
                 ,     :BG71-K6-MKTG-ITM-CD
                 ,     :BG71-RG-K-ID
                 ,     :BG71-RG-SYS-D
                 ,     :BG71-RG-SYS-TM
                 ,     :BG71-RNM-K-ID
                 ,     :BG71-RNM-SYS-D
                 ,     :BG71-RNM-SYS-TM
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG71-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7800:DB ERROR TG710 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7800-FETCH-TG710-EXIT.
           EXIT.

       S7900-FETCH-TG720                 SECTION.

           EXEC  SQL
                 FETCH  CURSOR_G720
                 INTO  :BG72-MKTG-N
                 ,     :BG72-KEY-1-ST-VAL
                 ,     :BG72-KEY-1-END-VAL
                 ,     :BG72-KEY-2-ST-VAL
                 ,     :BG72-KEY-2-END-VAL
                 ,     :BG72-KEY-3-ST-VAL
                 ,     :BG72-KEY-3-END-VAL
                 ,     :BG72-KEY-4-ST-VAL
                 ,     :BG72-KEY-4-END-VAL
                 ,     :BG72-KEY-5-ST-VAL
                 ,     :BG72-KEY-5-END-VAL
                 ,     :BG72-KEY-6-ST-VAL
                 ,     :BG72-KEY-6-END-VAL
                 ,     :BG72-MKTG-INFO-USE-F
                 ,     :BG72-MKTG-EFT-IRT-AMT
                 ,     :BG72-MKTG-EFT-FEE
                 ,     :BG72-MKTG-LN-LMT-AMT
                 ,     :BG72-RG-K-ID
                 ,     :BG72-RG-SYS-D
                 ,     :BG72-RG-SYS-TM
                 ,     :BG72-RNM-K-ID
                 ,     :BG72-RNM-SYS-D
                 ,     :BG72-RNM-SYS-TM
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     ADD   1             TO  A-TG72-READ-CNT

               WHEN  100
                     MOVE  HIGH-VALUE    TO  S-DATA-END-CHECK

               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S7900:DB ERROR TG720 FETCH=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S7900-FETCH-TG720-EXIT.
           EXIT.

       S8100-CLOSE-TG210                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G210
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8100:DB ERROR TG210 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8100-CLOSE-TG210-EXIT.
           EXIT.

       S8200-CLOSE-TG220                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G220
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8200:DB ERROR TG220 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8200-CLOSE-TG220-EXIT.
           EXIT.

       S8300-CLOSE-TG230                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G230
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8300:DB ERROR TG230 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8300-CLOSE-TG230-EXIT.
           EXIT.

       S8400-CLOSE-TG240                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G240
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8400:DB ERROR TG240 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8400-CLOSE-TG240-EXIT.
           EXIT.

       S8500-CLOSE-TG290                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G290
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8500:DB ERROR TG290 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8500-CLOSE-TG290-EXIT.
           EXIT.

       S8600-CLOSE-TG610                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G610
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8600:DB ERROR TG610 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8600-CLOSE-TG610-EXIT.
           EXIT.

       S8700-CLOSE-TG620                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G620
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8700:DB ERROR TG620 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8700-CLOSE-TG620-EXIT.
           EXIT.

       S8800-CLOSE-TG710                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G710
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8800:DB ERROR TG710 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8800-CLOSE-TG710-EXIT.
           EXIT.

       S8900-CLOSE-TG720                 SECTION.

           EXEC  SQL
                 CLOSE  CURSOR_G720
           END-EXEC.

           EVALUATE  SQLCODE
               WHEN  0
                     CONTINUE
               WHEN  OTHER
                     MOVE  SQLCODE       TO  W-SQLCODE
                     DISPLAY  'S8900:DB ERROR TG720 CLOSE=' W-SQLCODE
                     MOVE  U-ABEND-CODE1 TO  RETURN-CODE
                     PERFORM  S0100-MAIN-EXIT
           END-EVALUATE.

       S8900-CLOSE-TG720-EXIT.
           EXIT.
      ****************************************************************
      *                                                              *
      *    E N D    O F    P R O G R A M                             *
      *                                                              *
      ****************************************************************
