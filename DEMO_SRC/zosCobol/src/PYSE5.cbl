      ******************************************************************
      *                                                                *
      *         I D E N T I F I C A T I O N   D I V I S I O N          *
      *                                                                *
      ******************************************************************

       IDENTIFICATION                  DIVISION.

       PROGRAM-ID.                     PYSE5.
       AUTHOR.                         KIM.S.H.
       INSTALLATION.                   ONTA.
       DATE-WRITTEN.                   2005.06.14.
       DATE-COMPILED.

      ******************************************************************
      *                                                                *
      *                    P    Y    S    E    5                       *
      *                                                                *
      *  FUNCTION       - iA~s}°ÚÝæ?C~?Z?7                           *
      *                                                                *
      *  TRANSACTION    -  NONE                                        *
      *  IDENTIFIER                                                    *
      *                                                                *
      *  ENTRY POINTS   -  TOP OF PROGRAM; PYSE5                       *
      *                                                                *
      *  INPUT PARMS    -  NONE                                        *
      *                                                                *
      *  OUTPUT PARMS   -  SEE DETAIL                                  *
      *                                                                *
      *  INPUT  PARMS   - L-PYSE5-AREA                                 *
      *                                                                *
      *                   L-PYSE5-TXTP-CD      [?~s                  *
      *                   L-PYSE5-HWUN-GWA     J?iAj?n~?awe          *
      *                   L-PYSE5-DETRM-TP     i¬¼7?awe              *
      *                   L-PYSE5-BUSN-TP      ?/?3?/?awe            *
      *                                                                *
      *                   L-PYSE5-IDX1         }°ÚÝæ?C~1             *
      *                   L-PYSE5-IDX2         }°ÚÝæ?C~2             *
      *                   L-PYSE5-IDX3         }°ÚÝæ?C~3             *
      *                   L-PYSE5-IDX4         }°ÚÝæ?C~4             *
      *                   L-PYSE5-IDX5         }°ÚÝæ?C~5             *
      *                   L-PYSE5-IDX6         }°ÚÝæ?C~6             *
      *                   L-PYSE5-RETURN-STATUS STATUS CODE            *
      *                                                                *
      *  INPUT FILES    -  NONE                                        *
      *                                                                *
      *  OUTPUT FILES   -  NONE                                        *
      *                                                                *
      *  TABLES         -                                              *
      *                                                                *
      *  SWITCHES       -  S-CICS-RETURN                               *
      *                    LOW-VALUES    WHEN PSEUDO CONVERSATIONAL    *
      *                    HIGH-VALUES   WHEN CICS RETURN              *
      *                                                                *
      *  EXITS          -  NORMAL   - RETURN TO USER TERMINAL FOR      *
      *                               TERMINAL INPUT.                  *
      *                                                                *
      *                 -  ABNORMAL - NONE                             *
      *                                                                *
      *  PARAMETER      -                                              *
      *                                                                *
      *          L-PYSE5-HWUN-GWA :                                    *
      *                    '1' ;J?j?n~                               *
      *                    '2' :iAj?n~                               *
      *                                                                *
      *          L-PYSE5-RESULT-STATUS :                               *
      *                    ' ' : NORMAL DATA                           *
      *                    '1' :[?~sE~p/ERROR                        *
      *                    '2' :J?iA?aweERROR                        *
      *                    '3' :i¬¼7?aweERROR                        *
      *                    'E' : OTHER DB2 ERROR                       *
      *                                                                *
      *  MODIFICATIONS  -                                              *
      *                                                                *
      *    DATE         S.E.                  DESCRIPTION              *
      *  --------  --------------  ---------------------------------   *
      *  05/06/14  KIM.S.H         INITIAL CODING                      *
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

       01  WS-START                    PIC  X(40)
           VALUE 'PYSE5 - WORKING STORAGE BEGINS HERE'.

      ****************************************************************
      *                                                              *
      *                     A C C U M U L A T O R S                  *
      *                                                              *
      ****************************************************************

       01  ACCUMULATORS.

           05  A-ERROR-COUNT           PIC S9(04)  COMP SYNC VALUE +0.

      ****************************************************************
      *                                                              *
      *                     C O N S T A N T S                        *
      *                                                              *
      ****************************************************************

       01  CONSTANTS.

           05  C-RETURN-NORMAL         PIC  X(01)  VALUE SPACE.
           05  C-RETURN-1              PIC  X(01)  VALUE '1'.
           05  C-RETURN-2              PIC  X(01)  VALUE '2'.
           05  C-RETURN-3              PIC  X(01)  VALUE '3'.
           05  C-RETURN-E              PIC  X(01)  VALUE 'E'.

      ******************************************************************
      *                                                                *
      *                       W O R K - A R E A S                      *
      *                                                                *
      ******************************************************************

       01  WORKAREAS.

           05  W-MY-WORK.
               10  W-INDEX             PIC  X(02) VALUE SPACE.
               10  W-INDEX-R           REDEFINES  W-INDEX
                                       PIC  9(02).

      **********************
      ***  J?  j?  n~  ***
      **********************

           05  W-A-CODE-VALUE.

001            10  FILLER                  PIC  X(20)  VALUE
                   '10 01 02 03 04 05 06'.
002            10  FILLER                  PIC  X(20)  VALUE
                   '11 01 02 03 04 10 11'.
003            10  FILLER                  PIC  X(20)  VALUE
                   '12 01 02 03 04 10 12'.
004            10  FILLER                  PIC  X(20)  VALUE
                   '13 01 02 03 04 10 13'.
005            10  FILLER                  PIC  X(20)  VALUE
                   '14 01 02 03 04 10 14'.
006            10  FILLER                  PIC  X(20)  VALUE
                   '15 01 02 03 04 05 07'.
007            10  FILLER                  PIC  X(20)  VALUE
                   '16 01 02 03 04 10 15'.
008            10  FILLER                  PIC  X(20)  VALUE
                   '17 01 02 03 04 10 16'.
009            10  FILLER                  PIC  X(20)  VALUE
                   '21 01 02 03 04 10 17'.
010            10  FILLER                  PIC  X(20)  VALUE
                   '22 01 02 03 04 05 08'.
011            10  FILLER                  PIC  X(20)  VALUE
                   '23 01 02 03 04 05 09'.
012            10  FILLER                  PIC  X(20)  VALUE
                   '31 01 02 03 18 99 19'.
013            10  FILLER                  PIC  X(20)  VALUE
                   '32 01 02 03 22 99 23'.
014            10  FILLER                  PIC  X(20)  VALUE
                   '33 01 02 03 22 99 24'.
015            10  FILLER                  PIC  X(20)  VALUE
                   '34 01 02 03 99 99 25'.
016            10  FILLER                  PIC  X(20)  VALUE
                   '35 01 02 03 99 99 26'.
017            10  FILLER                  PIC  X(20)  VALUE
                   '36 01 02 03 99 99 21'.
018            10  FILLER                  PIC  X(20)  VALUE
                   '41 01 02 27 99 99 28'.
019            10  FILLER                  PIC  X(20)  VALUE
                   '42 01 02 27 99 99 31'.
020            10  FILLER                  PIC  X(20)  VALUE
                   '43 01 02 27 99 99 32'.
021            10  FILLER                  PIC  X(20)  VALUE
                   '44 01 02 27 99 99 33'.
022            10  FILLER                  PIC  X(20)  VALUE
                   '45 01 02 27 99 99 34'.
023            10  FILLER                  PIC  X(20)  VALUE
                   '46 01 02 99 99 99 35'.
024            10  FILLER                  PIC  X(20)  VALUE
                   '51 01 60 99 99 99 61'.
025            10  FILLER                  PIC  X(20)  VALUE
                   '52 01 60 99 99 99 61'.
026            10  FILLER                  PIC  X(20)  VALUE
                   '53 01 63 99 99 99 64'.
027            10  FILLER                  PIC  X(20)  VALUE
                   '54 01 63 99 99 99 64'.
028            10  FILLER                  PIC  X(20)  VALUE
                   '55 01 69 99 99 99 70'.
029            10  FILLER                  PIC  X(20)  VALUE
                   '56 01 69 99 99 99 70'.
030            10  FILLER                  PIC  X(20)  VALUE
                   '57 01 72 99 99 99 73'.
031            10  FILLER                  PIC  X(20)  VALUE
                   '58 01 72 99 99 99 73'.
032            10  FILLER                  PIC  X(20)  VALUE
                   '61 01 66 99 99 99 67'.
033            10  FILLER                  PIC  X(20)  VALUE
                   '62 01 66 99 99 99 67'.
034            10  FILLER                  PIC  X(20)  VALUE
                   '63 01 66 99 99 99 67'.
035            10  FILLER                  PIC  X(20)  VALUE
                   '64 01 66 99 99 99 67'.
036            10  FILLER                  PIC  X(20)  VALUE
                   '65 01 66 99 99 99 67'.
037            10  FILLER                  PIC  X(20)  VALUE
                   '66 01 66 99 99 99 67'.
038            10  FILLER                  PIC  X(20)  VALUE
                   '67 01 66 99 99 99 67'.
039            10  FILLER                  PIC  X(20)  VALUE
                   '68 01 66 99 99 99 67'.
040            10  FILLER                  PIC  X(20)  VALUE
                   '70 01 99 99 99 99 75'.
041            10  FILLER                  PIC  X(20)  VALUE
                   '71 01 99 99 99 99 75'.
042            10  FILLER                  PIC  X(20)  VALUE
                   '72 01 99 99 99 99 75'.
043            10  FILLER                  PIC  X(20)  VALUE
                   '73 01 99 99 99 99 75'.
044            10  FILLER                  PIC  X(20)  VALUE
                   '74 01 99 99 99 99 75'.
045            10  FILLER                  PIC  X(20)  VALUE
                   '75 01 99 99 99 99 75'.
046            10  FILLER                  PIC  X(20)  VALUE
                   '77 01 99 99 99 99 76'.
047            10  FILLER                  PIC  X(20)  VALUE
                   '78 01 99 99 99 99 76'.
048            10  FILLER                  PIC  X(20)  VALUE
                   '79 01 99 99 99 99 76'.
049            10  FILLER                  PIC  X(20)  VALUE
                   '80 01 99 99 99 99 76'.
050            10  FILLER                  PIC  X(20)  VALUE
                   '81 01 76 99 99 99 77'.
051            10  FILLER                  PIC  X(20)  VALUE
                   '83 01 99 99 99 99 76'.
052            10  FILLER                  PIC  X(20)  VALUE
                   '85 01 99 99 99 99 75'.
053            10  FILLER                  PIC  X(20)  VALUE
                   '86 01 99 99 99 99 75'.
054            10  FILLER                  PIC  X(20)  VALUE
                   '87 01 99 99 99 99 78'.
055            10  FILLER                  PIC  X(20)  VALUE
                   '88 01 99 99 99 99 79'.
056            10  FILLER                  PIC  X(20)  VALUE
                   '89 01 99 99 99 99 80'.
057            10  FILLER                  PIC  X(20)  VALUE
                   '90 01 99 99 99 99 80'.
058            10  FILLER                  PIC  X(20)  VALUE
                   '91 01 99 99 99 99 80'.
059            10  FILLER                  PIC  X(20)  VALUE
                   '92 01 99 99 99 99 80'.
060            10  FILLER                  PIC  X(20)  VALUE
                   '93 01 99 99 99 99 80'.
061            10  FILLER                  PIC  X(20)  VALUE
                   '94 01 99 99 99 99 80'.
062            10  FILLER                  PIC  X(20)  VALUE
                   '95 01 99 99 99 99 80'.
063            10  FILLER                  PIC  X(20)  VALUE
                   '96 01 99 99 99 99 80'.
064            10  FILLER                  PIC  X(20)  VALUE
                   '97 01 99 99 99 99 80'.
065            10  FILLER                  PIC  X(20)  VALUE
                   '98 01 99 99 99 99 80'.

           05  W-A-INDEX-TABLE   REDEFINES  W-A-CODE-VALUE.
               10  W-A-INDEX-TAB    OCCURS  65  TIMES
                                   INDEXED  BY  W-I-IDX.
                   15  W-A-TXTP-CD     PIC  X(02).
                   15  W-A-X           OCCURS  6   TIMES.
                       20  FILLER      PIC  X(01).
                       20  W-A-INDEX   PIC  X(02).

      **********************
      ***  iA  j?  n~  ***
      **********************

           05  W-B-CODE-VALUE.

001            10  FILLER                  PIC  X(20)  VALUE
                   '10 01 02 36 99 99 37'.
002            10  FILLER                  PIC  X(20)  VALUE
                   '11 01 02 36 99 99 38'.
003            10  FILLER                  PIC  X(20)  VALUE
                   '12 01 02 36 99 99 39'.
004            10  FILLER                  PIC  X(20)  VALUE
                   '13 01 02 36 99 99 40'.
005            10  FILLER                  PIC  X(20)  VALUE
                   '14 01 02 36 99 99 41'.
006            10  FILLER                  PIC  X(20)  VALUE
                   '15 01 02 36 99 99 42'.
007            10  FILLER                  PIC  X(20)  VALUE
                   '16 01 02 36 99 99 43'.
008            10  FILLER                  PIC  X(20)  VALUE
                   '17 01 02 36 99 99 44'.
009            10  FILLER                  PIC  X(20)  VALUE
                   '21 01 02 36 99 99 45'.
010            10  FILLER                  PIC  X(20)  VALUE
                   '22 01 02 36 99 99 46'.
011            10  FILLER                  PIC  X(20)  VALUE
                   '23 01 02 36 99 99 47'.
012            10  FILLER                  PIC  X(20)  VALUE
                   '31 01 02 36 99 99 48'.
013            10  FILLER                  PIC  X(20)  VALUE
                   '32 01 02 36 99 99 50'.
014            10  FILLER                  PIC  X(20)  VALUE
                   '33 01 02 36 99 99 51'.
015            10  FILLER                  PIC  X(20)  VALUE
                   '34 01 02 36 99 99 52'.
016            10  FILLER                  PIC  X(20)  VALUE
                   '35 01 02 36 99 99 53'.
017            10  FILLER                  PIC  X(20)  VALUE
                   '36 01 02 36 99 99 49'.
018            10  FILLER                  PIC  X(20)  VALUE
                   '41 01 02 36 99 99 54'.
019            10  FILLER                  PIC  X(20)  VALUE
                   '42 01 02 36 99 99 55'.
020            10  FILLER                  PIC  X(20)  VALUE
                   '43 01 02 36 99 99 56'.
021            10  FILLER                  PIC  X(20)  VALUE
                   '44 01 02 36 99 99 57'.
022            10  FILLER                  PIC  X(20)  VALUE
                   '45 01 02 36 99 99 58'.
023            10  FILLER                  PIC  X(20)  VALUE
                   '46 01 02 36 99 99 59'.
024            10  FILLER                  PIC  X(20)  VALUE
                   '51 01 60 99 99 99 62'.
025            10  FILLER                  PIC  X(20)  VALUE
                   '52 01 60 99 99 99 62'.
026            10  FILLER                  PIC  X(20)  VALUE
                   '53 01 63 99 99 99 65'.
027            10  FILLER                  PIC  X(20)  VALUE
                   '54 01 63 99 99 99 65'.
028            10  FILLER                  PIC  X(20)  VALUE
                   '55 01 69 99 99 99 71'.
029            10  FILLER                  PIC  X(20)  VALUE
                   '56 01 69 99 99 99 71'.
030            10  FILLER                  PIC  X(20)  VALUE
                   '57 01 72 99 99 99 74'.
031            10  FILLER                  PIC  X(20)  VALUE
                   '58 01 72 99 99 99 74'.
032            10  FILLER                  PIC  X(20)  VALUE
                   '61 01 66 99 99 99 68'.
033            10  FILLER                  PIC  X(20)  VALUE
                   '62 01 66 99 99 99 68'.
034            10  FILLER                  PIC  X(20)  VALUE
                   '63 01 66 99 99 99 68'.
035            10  FILLER                  PIC  X(20)  VALUE
                   '64 01 66 99 99 99 68'.
036            10  FILLER                  PIC  X(20)  VALUE
                   '65 01 66 99 99 99 68'.
037            10  FILLER                  PIC  X(20)  VALUE
                   '66 01 66 99 99 99 68'.
038            10  FILLER                  PIC  X(20)  VALUE
                   '67 01 66 99 99 99 68'.
039            10  FILLER                  PIC  X(20)  VALUE
                   '68 01 66 99 99 99 68'.
040            10  FILLER                  PIC  X(20)  VALUE
                   '70 01 99 99 99 99 75'.
041            10  FILLER                  PIC  X(20)  VALUE
                   '71 01 99 99 99 99 75'.
042            10  FILLER                  PIC  X(20)  VALUE
                   '72 01 99 99 99 99 75'.
043            10  FILLER                  PIC  X(20)  VALUE
                   '73 01 99 99 99 99 75'.
044            10  FILLER                  PIC  X(20)  VALUE
                   '74 01 99 99 99 99 75'.
045            10  FILLER                  PIC  X(20)  VALUE
                   '75 01 99 99 99 99 75'.
046            10  FILLER                  PIC  X(20)  VALUE
                   '77 01 99 99 99 99 76'.
047            10  FILLER                  PIC  X(20)  VALUE
                   '78 01 99 99 99 99 76'.
048            10  FILLER                  PIC  X(20)  VALUE
                   '79 01 99 99 99 99 76'.
049            10  FILLER                  PIC  X(20)  VALUE
                   '80 01 99 99 99 99 76'.
050            10  FILLER                  PIC  X(20)  VALUE
                   '81 01 76 99 99 99 77'.
051            10  FILLER                  PIC  X(20)  VALUE
                   '83 01 99 99 99 99 76'.
052            10  FILLER                  PIC  X(20)  VALUE
                   '85 01 99 99 99 99 75'.
053            10  FILLER                  PIC  X(20)  VALUE
                   '86 01 99 99 99 99 75'.
054            10  FILLER                  PIC  X(20)  VALUE
                   '87 01 99 99 99 99 78'.
055            10  FILLER                  PIC  X(20)  VALUE
                   '88 01 99 99 99 99 79'.
056            10  FILLER                  PIC  X(20)  VALUE
                   '89 01 99 99 99 99 80'.
057            10  FILLER                  PIC  X(20)  VALUE
                   '90 01 99 99 99 99 80'.
058            10  FILLER                  PIC  X(20)  VALUE
                   '91 01 99 99 99 99 80'.
059            10  FILLER                  PIC  X(20)  VALUE
                   '92 01 99 99 99 99 80'.
060            10  FILLER                  PIC  X(20)  VALUE
                   '93 01 99 99 99 99 80'.
061            10  FILLER                  PIC  X(20)  VALUE
                   '94 01 99 99 99 99 80'.
062            10  FILLER                  PIC  X(20)  VALUE
                   '95 01 99 99 99 99 80'.
063            10  FILLER                  PIC  X(20)  VALUE
                   '96 01 99 99 99 99 80'.
064            10  FILLER                  PIC  X(20)  VALUE
                   '97 01 99 99 99 99 80'.
065            10  FILLER                  PIC  X(20)  VALUE
                   '98 01 99 99 99 99 80'.

           05  W-B-INDEX-TABLE   REDEFINES  W-B-CODE-VALUE.
               10  W-B-INDEX-TAB    OCCURS  65  TIMES
                                   INDEXED  BY  W-J-IDX.

                   15  W-B-TXTP-CD     PIC  X(02).
                   15  W-B-X           OCCURS  6   TIMES.
                       20  FILLER      PIC  X(01).
                       20  W-B-INDEX   PIC  X(02).

           05  S-SEARCH-ERROR          PIC  X(03) VALUE SPACE.

      ****************************************************************
      *                                                              *
      *       E N D   O F   W O R K I N G - S T O R A G E            *
      *                                                              *
      **************************************************************** *

       01  WS-END                      PIC  X(40)
           VALUE 'PYSE5 - WORKING STORAGE ENDS HERE'.

           EJECT
      ******************************************************************
      *                                                                *
      *                 L I N K A G E   S E C T I O N                  *
      *                                                                *
      ******************************************************************

       LINKAGE                         SECTION.

       01  L-PYSE5-PARM.

           05  L-PYSE5-INPUT.
               10  L-PYSE5-TXTP-CD     PIC  X(02).
               10  L-PYSE5-HWUN-GWA    PIC  X(01).
               10  L-PYSE5-DETRM-TP    PIC  X(01).
               10  L-PYSE5-BUSN-TP     PIC  X(01).

           05  L-PYSE5-OUTPUT.
               10  L-PYSE5-IDX1        PIC  X(02).
               10  L-PYSE5-IDX2        PIC  X(02).
               10  L-PYSE5-IDX3        PIC  X(02).
               10  L-PYSE5-IDX4        PIC  X(02).
               10  L-PYSE5-IDX5        PIC  X(02).
               10  L-PYSE5-IDX6        PIC  X(02).
               10  L-PYSE5-RETURN-STATUS
                                       PIC  X(01).

           EJECT
      ******************************************************************
      *                                                                *
      *              P R O C E D U R E   D I V I S I O N               *
      *                                                                *
      ******************************************************************

       PROCEDURE                       DIVISION  USING  L-PYSE5-PARM.

      ******************************************************************
      *                                                                *
      *                     I N I T I A L I Z E                        *
      *                                                                *
      ******************************************************************

       INITIALIZATION                  SECTION.

           INITIALIZE                  ACCUMULATORS.

      ******************************************************************
      *                                                                *
      *                        M A I N L I N E                         *
      *                                                                *
      ******************************************************************

       MAINLINE                        SECTION.

           PERFORM  S0100-MAIN-PROCESS.

      ******************************************************************
      *                                                                *
      *                    F I N A L I Z A T I O N                     *
      *                                                                *
      ******************************************************************

       FINALIZATION                    SECTION.

           GOBACK.

           EJECT
      *================================================================*
      *                                                                *
      *>>>>>>>>>            S U B R O U T I N E S             <<<<<<<<<*
      *                                                                *
      *================================================================*

      ******************************************************************
      *                                                                *
      *               S 0 1 0 0 - M A I N - P R O C E S S              *
      *                                                                *
      ******************************************************************

       S0100-MAIN-PROCESS              SECTION.

           MOVE SPACE                  TO L-PYSE5-OUTPUT
                                          S-SEARCH-ERROR.

      *   J?j?n~
           IF  L-PYSE5-HWUN-GWA        =  '1'

               SET     W-I-IDX         TO 1

               SEARCH  W-A-INDEX-TAB   AT END
                   MOVE 'NDF'          TO S-SEARCH-ERROR

                   WHEN W-A-TXTP-CD  (W-I-IDX)   =  L-PYSE5-TXTP-CD
                       MOVE W-A-INDEX(W-I-IDX 1) TO L-PYSE5-IDX1
                       MOVE W-A-INDEX(W-I-IDX 2) TO L-PYSE5-IDX2
                       MOVE W-A-INDEX(W-I-IDX 3) TO L-PYSE5-IDX3
                       MOVE W-A-INDEX(W-I-IDX 4) TO L-PYSE5-IDX4
                       MOVE W-A-INDEX(W-I-IDX 5) TO L-PYSE5-IDX5
                       MOVE W-A-INDEX(W-I-IDX 6) TO L-PYSE5-IDX6

               IF  S-SEARCH-ERROR      =  SPACE

                   IF  L-PYSE5-TXTP-CD =  '31'
                       PERFORM S0200-DIVIDE-DETAIL
                   END-IF
                   MOVE SPACE          TO L-PYSE5-RETURN-STATUS

               ELSE
                   MOVE C-RETURN-1     TO L-PYSE5-RETURN-STATUS
               END-IF

           ELSE

      *     iAj?n~
             IF  L-PYSE5-HWUN-GWA      =  '2'

               SET     W-J-IDX         TO 1

               SEARCH  W-B-INDEX-TAB   AT END
                   MOVE 'NDF'          TO S-SEARCH-ERROR

                   WHEN W-B-TXTP-CD  (W-J-IDX)   =  L-PYSE5-TXTP-CD
                       MOVE W-B-INDEX(W-J-IDX 1) TO L-PYSE5-IDX1
                       MOVE W-B-INDEX(W-J-IDX 2) TO L-PYSE5-IDX2
                       MOVE W-B-INDEX(W-J-IDX 3) TO L-PYSE5-IDX3
                       MOVE W-B-INDEX(W-J-IDX 4) TO L-PYSE5-IDX4
                       MOVE W-B-INDEX(W-J-IDX 5) TO L-PYSE5-IDX5
                       MOVE W-B-INDEX(W-J-IDX 6) TO L-PYSE5-IDX6

               IF  S-SEARCH-ERROR      =  SPACE
                   MOVE SPACE          TO L-PYSE5-RETURN-STATUS
               ELSE
                   MOVE C-RETURN-1     TO L-PYSE5-RETURN-STATUS
               END-IF

             ELSE
               MOVE C-RETURN-2         TO L-PYSE5-RETURN-STATUS
             END-IF

           END-IF.

       S0100-MAIN-PROCESS-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *             S 0 2 0 0 - D I V I D E - D E T A I L              *
      *                                                                *
      ******************************************************************

       S0200-DIVIDE-DETAIL             SECTION.

      ***?vi~we
           EVALUATE  L-PYSE5-DETRM-TP
               WHEN  '1'
               WHEN  '2'
               WHEN  '3'
               WHEN  '5'
               WHEN  '6'
               WHEN  '7'

                   CONTINUE

      ***?v{Vwe
               WHEN  '4'
               WHEN  '8'

                   MOVE L-PYSE5-IDX6   TO W-INDEX
                   ADD  1              TO W-INDEX-R
                   MOVE W-INDEX        TO L-PYSE5-IDX6

           END-EVALUATE.

       S0200-DIVIDE-DETAIL-EXIT.
           EXIT.
           EJECT

      ******************************************************************
      *                                                                *
      *             E N D   O F   P R O G R A M      PYSE5             *
      *                                                                *
      ******************************************************************
