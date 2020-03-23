      ****************************************************************
      *          I D E N T I F I C A T I O N  D I V I S I O N        *
      ****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    LCBSTCPI.
       AUTHOR.        FNS.
       DATE-WRITTEN.  2004.02.23.
       DATE-COMPILED.


      ****************************************************************
      *        E N V I R O N M E N T    D I V I S I O N              *
      ****************************************************************
       ENVIRONMENT DIVISION.

      ****************************************************************
      *        D A T A                  D I V I S I O N              *
      ****************************************************************
       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01  SOC-ERR.
           05  SOC-ERR-MSG               PIC X(26).
           05  FILLER                    PIC X(11)
                VALUE IS ' RETCODE = '.
           05  SOC-RETCODE               PIC -----.
           05  FILLER                    PIC X(9)
                VALUE IS ' ERRNO = '.
           05  SOC-ERRNO                 PIC 9(8).
           05  FILLER                    PIC X(01).
           05  SOC-ERR-KEY               PIC X(30).

       01  W-RESPONSE                    PIC S9(08) COMP VALUE 0.
       01  W-DBUG-IN                     PIC X(4096) VALUE SPACES.
       01  W-NUM-ITEMS                   PIC S9(04) COMP SYNC VALUE +0.
       01  W-QUEUE-ITEM-ONE              PIC S9(04) COMP SYNC VALUE +1.
       01  W-RCV-CNT                     PIC 9(04)  VALUE 0.

      ****************************************************************
      *    PROGRAM'S CONSTANTS                                       *
      ****************************************************************

       77  LENG                     PIC 9(4)  COMP  VALUE 0.
       77  RESPONSE                 PIC 9(9)  COMP.
       77  TSTAMP                   PIC 9(8).
       77  TOEBCDIC-TOKEN           PIC X(16) VALUE 'TCPIPTOEBCDICXLT'.
       77  TOASCII-TOKEN            PIC X(16) VALUE 'TCPIPTOASCIIXLAT'.
       77  SOCKET-FUNCTION          PIC X(16) VALUE 'SOCKET'.           
       77  CONN-FUNCTION            PIC X(16) VALUE 'CONNECT'.          
       77  WRITE-FUNCTION           PIC X(16) VALUE 'WRITE'.            
       77  RECVFROM-FUNCTION        PIC X(16) VALUE 'RECVFROM'.         
       77  BLOCK-FUNCTION           PIC X(16) VALUE 'FCNTL'.
       77  CLOSE-FUNCTION           PIC X(16) VALUE 'CLOSE'.

       77  START-MSG                PIC X(30)
            VALUE IS 'SERVER PROGRAM IS STARTING    '.
       77  TS-INVREQ-ERR            PIC X(30)
            VALUE IS 'WRITE TS FAILED  - INVREQ     '.
       77  TS-NOTAUTH-ERR           PIC X(30)
            VALUE IS 'WRITE TS FAILED  - NOTAUTH    '.
       77  TS-IOERR-ERR             PIC X(30)
            VALUE IS 'WRITE TS FAILED  - IOERR      '.
       77  WRITETS-ERR              PIC X(30)
            VALUE IS 'WRITE TS FAILED               '.

       01  CONV-DATA.
           05  CONV-BUFFER          PIC X(100)       VALUE SPACE.
           05  CONV-LENGTH          PIC 9(08) COMP  VALUE 0.

       01  COMMON-FUNCTION.
           05  ERRNO                PIC 9(08) COMP  VALUE 0.            
           05  RETCODE              PIC S9(8) COMP  VALUE 0.            
           05  SOC-BUF              PIC X(4096).
           05  SOC-NBYTE            PIC 9(08) COMP  VALUE 0.

      *--//TAKESOCKET
       01  SOCKET.
           05  SOCKET-AF            PIC 9(08) COMP  VALUE 2.
      *--    ( SOCKET-SOCTYPE => 1:STREAM, 2:DATAGRAM, 3:RAW )
           05  SOCKET-SOCTYPE       PIC 9(08) COMP  VALUE 1.
           05  SOCKET-PROTO         PIC 9(08) COMP  VALUE 0.

      *--//CONNECT
       01  CONN-SOCKET.
           05  CONN-S               PIC 9(04) COMP VALUE 0.
           05  CONN-CLIENT.
               10  CONN-FAMILY      PIC 9(04) COMP VALUE 2.
      *--      CONN-PORT: 32772 (REMOTE PORT NUMBER)
               10  CONN-PORT        PIC X(02)      VALUE X'8004'.
               10  CONN-PORT-R  REDEFINES  CONN-PORT
                                    PIC 9(04) COMP.
IMAGES*--      CONN-IP-ADDRESS: 191.227.17.1 (REMOTE IP ADDRESS)
               10  CONN-IP-ADDRESS  PIC X(04)      VALUE X'BFE31101'.
               10  CONN-IP-ADDRESSR REDEFINES  CONN-IP-ADDRESS
                                    PIC 9(08) COMP.
               10  CONN-RESERVED    PIC X(08)      VALUE '00000000'.

      *--//WRITE
       01  WRITE-SOCKET.
           05  WRITE-S              PIC 9(04) COMP VALUE 0.

      *--//RECVFROM
       01  RECVFROM-SOCKET.
           05  RECVFROM-S           PIC 9(04) COMP VALUE 0.
           05  RECVFROM-FLAGS       PIC 9(08) COMP.
               88  NO-GLAG                    VALUE 0.
               88  OOB                        VALUE 1.
               88  PEEK                       VALUE 2.

           05  RECVFROM-NAME.
               10  RECVFROM-FAMILY  PIC 9(04) COMP VALUE 2.
      *--      RECVFROM-PORT:  9000 (REMOTE PORT NUMBER)
               10  RECVFROM-PORT    PIC X(02) VALUE X'2328'.
               10  RECVFROM-PORT-R  REDEFINES  RECVFROM-PORT
                                    PIC 9(04) COMP.
      *--      RECVFROM-IP-ADDRESS: 191.227.17.1 (REMOTE IP ADDRESS)
BANCS *--      10  RECVFROM-IP-ADDRESS  PIC   X(04)  VALUE X'D3E92B16'.
TEST  *--      RECVFROM-IP-ADDRESS: 191.230.21.14(REMOTE IP ADDRESS)
PROD  *--      RECVFROM-IP-ADDRESS: 191.230.21.20(REMOTE IP ADDRESS)
      *--      RECVFROM-IP-ADDRESS: 191.1.60.1   (REMOTE IP ADDRESS)
               10  RECVFROM-IP-ADDRESS  PIC   X(04)  VALUE X'BF013C01'.
               10  RECVFROM-IP-ADDRESSR REDEFINES  RECVFROM-IP-ADDRESS
                                    PIC 9(08) COMP.
               10  RECVFROM-RESERVED
                                    PIC X(08) VALUE '00000000'.

      *--//NONBLOCK
       01  BLOCK-SOCKET.
           05  BLOCK-S              PIC 9(04) COMP  VALUE 4.
           05  BLOCK-COMMAND        PIC 9(08) COMP  VALUE 4.
           05  BLOCK-REQARG         PIC 9(08) COMP  VALUE 4.

      *--//CLOSE
       01  CLOSE-SOCKET.
           05  CLOSE-S              PIC 9(04) COMP  VALUE 0.

       01  TCPCICS-MSG-AREA.
           02  TCPCICS-MSG-1.
               05  MSGDATE          PIC 9(8).
               05  FILLER           PIC X(2)  VALUE SPACES.
               05  MSGTIME          PIC 9(8).
               05  FILLER           PIC X(2)  VALUE SPACES.
               05  MODULE           PIC X(10) VALUE 'LCHSINIT: '.
           02  TCPCICS-MSG-2.
               05  MSG-AREA         PIC X(90) VALUE SPACES.

       01  TCP-INPUT-DATA           PIC X(4148) VALUE LOW-VALUES.
       01  TCPSOCKET-PARM REDEFINES TCP-INPUT-DATA.
           05  GIVE-TAKE-SOCKET     PIC 9(8)  COMP.
           05  CLIENTID-PARM.
               10  LSTN-NAME        PIC X(8).
               10  LSTN-SUBTASKNAME PIC X(8).
           05  CLIENT-DATA-FLD.
               10  CLIENT-IN-DATA   PIC X(4096).
           05  COMM-SOCKID          PIC S9(8) COMP.
           05  COMM-RCV-LENG        PIC S9(8) COMP.
           05  COMM-SND-LENG        PIC S9(8) COMP.
           05  SOCKADDR-IN-PARM.
               10  SIN-FAMILY-PARM  PIC 9(4).
               10  SIN-PORT-PARM    PIC 9(4).
               10  SIN-ADDR-PARM    PIC 9(8)  COMP.
               10  SIN-ZERO-PARM    PIC X(8).

      ****************************************************************
      *    LG-CNS SYSTEM-SUPPLIED EIBRESP CONDITION VALUE CONSTANTS  *
      ****************************************************************

           COPY LCBYBRSP.

      ****************************************************************
      *    C O N S T A N T S                                         *
      ****************************************************************

       01  CONSTANTS.

           05  C-SOCKET-ERR-M                PIC X(26) VALUE
               'SOCKET CALL FAILED        '.
           05  C-CONNECT-ERR-M               PIC X(26) VALUE
               'CONNECT SOCKET CALL FAILED'.
           05  C-WRITE-ERR-M                 PIC X(26) VALUE
               'WRITE SOCKET FAILED       '.
           05  C-NONBLOCK-ERR-M              PIC X(26) VALUE
               'NONBLOCK SOCKET FAILED    '.
           05  C-RECVFROM-ERR-M              PIC X(26) VALUE
               'RECEIVE SOCKET FAIL       '.
           05  C-CLOSE-ERR-M                 PIC X(26) VALUE
               'CLOSE SOCKET FAILED       '.
           05  C-RECVFROM-SUC-M              PIC X(26) VALUE
               'RECEIVE SUCCESSFUL        '.
           05  C-WRITE-SUC-M                 PIC X(26) VALUE
               'WRITE   SUCCESSFUL        '.
           05  C-CLOSE-SUC-M                 PIC X(26) VALUE
               'CLOSE   SUCCESSFUL        '.

      ****************************************************************
      *                L I N K A G E     S E C T I O N               *
      ****************************************************************

       LINKAGE SECTION.

       01  DFHCOMMAREA                  PIC X(4148).

      ****************************************************************
      *                                                              *
      *        P R O C E D U R E    D I V I S I O N                  *
      *                                                              *
      ****************************************************************

       PROCEDURE        DIVISION.

           MOVE   DFHCOMMAREA               TO  TCP-INPUT-DATA.

      ****************************************************************
      *                                                              *  
      *                 I N I T I A L I Z A T I O N                  *
      *                                                              *  
      ****************************************************************
       INITIALIZATION SECTION.

           MOVE START-MSG                   TO MSG-AREA.

      *--<< SEND DATA_KEY(QUEUE CHECK) >>
           MOVE CLIENT-DATA-FLD(1:30)       TO SOC-ERR-KEY.

      *****************************************************************
      *                     M A I N L I N E                           *
      *---------------------------------------------------------------*
      *  AT START UP THE SERVER REQUIRES THE PORT NUMBER FOR TCP/IP   *
      *  IT WILL USE.  THE PORT NUMBER SUPPORTED BY THIS SAMPLE IS    *
      *  4 DIGITS IN LENGTH.                                          *
      *****************************************************************
       MAINLINE SECTION.

      *--//SOCKET
           PERFORM  S0000-SOCKET-PROC.

      *--//CONNECT
           PERFORM  S0000-CONNECT-SOCKET.

      *--//SEND DATA CONVERSION(EBCDIC => ASCII)
           PERFORM  S0000-CONV-DATA.

      *--//WRITE
           PERFORM  S0000-WRITE-SOCKET.

      *--//NONBLOCK
           PERFORM  S0000-NONBLOCK-PROC.

      *--//RECEIVEFROM & RECEIVE DATA CONVERSION(ASCII=>EBCDIC)
      *--<<RECEIVE ERROR~  3Kuvs  a}p>>
           MOVE  ZERO                         TO  W-RCV-CNT.
           PERFORM  S0000-RECEIVE-SOCKET-PROC.

      *--//CLOSE
           PERFORM  S0000-CLOSE-SOCKET.

      ****************************************************************
      *                                                              *  
      *                    F I N A L I Z A T I O N                   *
      *                                                              *  
      ****************************************************************
       FINALIZATION SECTION.

           MOVE   TCP-INPUT-DATA            TO  DFHCOMMAREA.

           EXEC  CICS   RETURN                                          
           END-EXEC.                                                    
                                                                        
           GOBACK.

      ****************************************************************
      *                                                              *  
      *                   S U B R O U T I N E S                      *
      *                                                              *  
      ****************************************************************
      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - S O C K E T - P R O C                  *
      *                                                              *  
      ****************************************************************

       S0000-SOCKET-PROC    SECTION.

           CALL 'EZASOKET' USING SOCKET-FUNCTION  SOCKET-AF
                                 SOCKET-SOCTYPE   SOCKET-PROTO
                                 ERRNO            RETCODE.

      *--//SUCESS:RETCODE >= 0 ->> LOCAL SOCKET DESCRIPTOR(CONN-S)
      *--//FAIL  :RETCODE <  0 ->> ERRNO CHECK

           IF RETCODE < 0
                MOVE '99'                   TO SOC-BUF(28:02)
                                               CLIENT-DATA-FLD(28:02)
                MOVE RETCODE                TO SOC-RETCODE
                MOVE ERRNO                  TO SOC-ERRNO
                MOVE C-SOCKET-ERR-M         TO SOC-ERR-MSG
                MOVE SOC-ERR                TO MSG-AREA
                PERFORM S0000-WRITEQ-TD
                GO  TO  FINALIZATION
           ELSE
                MOVE RETCODE                TO CONN-S
                MOVE SPACE                  TO MSG-AREA
           END-IF.

       S0000-SOCKET-PROC-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - C O N N E C T - S O C K E T            *
      *                                                              *  
      ****************************************************************
       S0000-CONNECT-SOCKET SECTION.

      *-// SOCKET-DESCRIPTOR: CONN-S

           CALL 'EZASOKET' USING CONN-FUNCTION  CONN-S
                                 CONN-CLIENT
                                 ERRNO      RETCODE.

      *-<< RETCODE: SUCESS=0, FAIL=-1 >>

           IF RETCODE < 0
                MOVE '99'                   TO SOC-BUF(28:02)
                                               CLIENT-DATA-FLD(28:02)
                MOVE RETCODE                TO SOC-RETCODE
                MOVE ERRNO                  TO SOC-ERRNO
                MOVE C-CONNECT-ERR-M        TO SOC-ERR-MSG
                MOVE SOC-ERR                TO MSG-AREA
                PERFORM S0000-WRITEQ-TD
                GO  TO  FINALIZATION
           ELSE
                MOVE SPACE                  TO MSG-AREA
           END-IF.

       S0000-CONNECT-SOCKET-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - C O N V - D A T A                      *
      *  EBCDIC => ASCII                                             *  
      ****************************************************************
       S0000-CONV-DATA SECTION.

      *-<< CONVERSION ma DATA MOVE
           MOVE CLIENT-DATA-FLD(1:100)      TO CONV-BUFFER.

      *-// MAX LENGTH: 100 BYTE (A~iA~ 100BYTE m~  uvsvJE)
           MOVE 100                         TO CONV-LENGTH.

      *-// EZACIC04: EBCDIC => ASCII
           CALL 'EZACIC04' USING TOASCII-TOKEN
                                 CONV-BUFFER
                                 CONV-LENGTH.

           MOVE CONV-BUFFER                 TO CLIENT-DATA-FLD.

       S0000-CONV-DATA-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - W R I T E - S O C K E T                *
      *                                                              *  
      ****************************************************************
       S0000-WRITE-SOCKET SECTION.

           MOVE LOW-VALUES                  TO SOC-BUF.

      *-<< SOCKET-DESCRIPTOR
           MOVE CONN-S                      TO WRITE-S.

      *-<< SEND}  RECORDa  LENGTH
           MOVE COMM-SND-LENG               TO SOC-NBYTE.

      *-<< SEND}  RECORDa  DATA
           MOVE CLIENT-DATA-FLD             TO SOC-BUF.

           CALL 'EZASOKET'  USING WRITE-FUNCTION  WRITE-S
                                  SOC-NBYTE       SOC-BUF
                                  ERRNO           RETCODE.

      *-<< RETCODE: SUCESS=0, FAIL=-1 >>

           IF RETCODE < 0
               MOVE '99'                    TO SOC-BUF(28:02)
                                               CLIENT-DATA-FLD(28:02)
               MOVE RETCODE                 TO SOC-RETCODE
               MOVE ERRNO                   TO SOC-ERRNO
               MOVE C-WRITE-ERR-M           TO SOC-ERR-MSG
               MOVE SOC-ERR                 TO MSG-AREA
               PERFORM S0000-WRITEQ-TD
               GO  TO  FINALIZATION
           ELSE
               MOVE RETCODE                 TO SOC-RETCODE
               MOVE ERRNO                   TO SOC-ERRNO
               MOVE C-WRITE-SUC-M           TO SOC-ERR-MSG
               MOVE SOC-ERR                 TO MSG-AREA
           END-IF.

      *--<< QUEUE/DELETE >>
           PERFORM S0000-DELETEQ.

      *--<< QUEUE/CHECK >>
           PERFORM S0000-WRITEQ-TD.

           MOVE LOW-VALUES                  TO SOC-BUF.

       S0000-WRITE-SOCKET-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - N O N B L O C K - P R O C              *
      *                                                              *  
      ****************************************************************
       S0000-NONBLOCK-PROC SECTION.

      *-// SOCKET-DESCRIPTOR
           MOVE CONN-S                      TO BLOCK-S.

      *-// BLOCK-REQARG: 4(NONBLOCKING),0(BLOCKING)

           CALL 'EZASOKET' USING BLOCK-FUNCTION BLOCK-S
                                 BLOCK-COMMAND  BLOCK-REQARG
                                 ERRNO          RETCODE.

      *-<< RETCODE: SUCESS=0, FAIL=-1 >>

           IF RETCODE < 0 THEN
               MOVE '99'                    TO SOC-BUF(28:02)
                                               CLIENT-DATA-FLD(28:02)
               MOVE RETCODE                 TO SOC-RETCODE
               MOVE ERRNO                   TO SOC-ERRNO
               MOVE C-NONBLOCK-ERR-M        TO SOC-ERR-MSG
               MOVE SOC-ERR                 TO MSG-AREA
               PERFORM S0000-WRITEQ-TD
               GO  TO  FINALIZATION
           ELSE
               CONTINUE
           END-IF.

       S0000-NONBLOCK-PROC-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - D E L A Y - P R O C                    *
      *                                                              *  
      ****************************************************************
       S0000-DELAY-PROC     SECTION.

      *--//1A~h  ma~: INTERVAL(HHMMSS)
           EXEC  CICS  DELAY
                       INTERVAL(000001)
           END-EXEC.

       S0000-DELAY-PROC-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *        S 0 0 0 0 - R E C E I V E - S O C K E T - P R O C     *
      *                                                              *  
      ****************************************************************
       S0000-RECEIVE-SOCKET-PROC SECTION.

      *--//RECEIVE TRIAL COUNT
           ADD   1                            TO  W-RCV-CNT.

      *--//1A~h DELAY
           PERFORM S0000-DELAY-PROC.

      *--// DATA RECEIVE & CONVERSION
           PERFORM S0000-RECEIVE-SOCKET.

      *-<< SOCKET/~waH  SOC-BUF  RECEIVE}  DATA  
      *-<< MAIN PGM  1~~  }a COMMAREAa DATAwa MOVE
           MOVE  SOC-BUF                  TO  CLIENT-DATA-FLD.

       S0000-RECEIVE-SOCKET-PROC-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - R E C E I V E - S O C K E T            *
      *                                                              *  
      ****************************************************************
       S0000-RECEIVE-SOCKET  SECTION.

      *-<< M/F=>IMAGE SERVER~  VKa  mav >>

      *-<< SOCKET-DESCRIPTOR
           MOVE CONN-S                      TO RECVFROM-S.

           MOVE COMM-RCV-LENG               TO SOC-NBYTE.
           MOVE LOW-VALUES                  TO SOC-BUF.

           CALL 'EZASOKET' USING RECVFROM-FUNCTION  RECVFROM-S
                                 RECVFROM-FLAGS     SOC-NBYTE
                                 SOC-BUF            RECVFROM-NAME
                                 ERRNO              RETCODE.

      *--//SUCESS:RETCODE > 0 ->> RECEIVE DATA BYTE
      *--//SUCESS:RETCODE = 0 ->> SOCKET CLOSE
      *--//FAIL  :RETCODE =-1 ->> ERRNO  CHECK

           IF  RETCODE < 0
               MOVE '99'                    TO SOC-BUF(28:2)
                                               CLIENT-DATA-FLD(28:2)
               MOVE RETCODE                 TO SOC-RETCODE
               MOVE ERRNO                   TO SOC-ERRNO
               MOVE C-RECVFROM-ERR-M        TO SOC-ERR-MSG
               MOVE '(    )'                TO SOC-ERR-MSG(21:06)
               MOVE W-RCV-CNT               TO SOC-ERR-MSG(22:04)
               MOVE SOC-ERR                 TO MSG-AREA
               PERFORM S0000-WRITEQ-TD
           ELSE
      *--//RECEIVE DATA CONVERSION (ASCII => EBCDIC)
      *        PERFORM  S0000-RECEIVE-CONV-DATA

      *-<< V  7i >>
               MOVE '00'                TO SOC-BUF(28:2)
                                           CLIENT-DATA-FLD(28:2)
               MOVE RETCODE             TO SOC-RETCODE
               MOVE ERRNO               TO SOC-ERRNO
               MOVE C-RECVFROM-SUC-M    TO SOC-ERR-MSG
               MOVE SOC-ERR                 TO MSG-AREA
               MOVE SOC-BUF(1:20)       TO MSG-AREA(27:20)
               PERFORM S0000-WRITEQ-TD
           END-IF.

       S0000-RECEIVE-SOCKET-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - C L O S E - S O C K E T                *
      *                                                              *  
      *   CLOSE ORIGINAL SOCKET DESCRIPTOR                           *
      ****************************************************************
       S0000-CLOSE-SOCKET  SECTION.

      *-<< SOCKET-DESCRIPTOR
           MOVE CONN-S                      TO CLOSE-S.

           CALL 'EZASOKET' USING CLOSE-FUNCTION  CLOSE-S
                                 ERRNO           RETCODE.

      *-<< RETCODE: SUCESS=0, FAIL=-1 >>

           IF RETCODE < 0 THEN
               MOVE RETCODE                 TO SOC-RETCODE
               MOVE ERRNO                   TO SOC-ERRNO
               MOVE C-CLOSE-ERR-M           TO SOC-ERR-MSG
               MOVE SOC-ERR                 TO MSG-AREA
               PERFORM S0000-WRITEQ-TD
           ELSE
               CONTINUE
           END-IF.

       S0000-CLOSE-SOCKET-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - R E C E I V E - C O N V - D A T A      *
      *  ASCII => EBCDIC                                             *  
      ****************************************************************
       S0000-RECEIVE-CONV-DATA   SECTION.

      *-<< CONVERSION ma DATA MOVE
           MOVE SOC-BUF(1:100)              TO CONV-BUFFER.
      *-<< MAX LENGTH: 100 BYTE (A~iA~ 100BYTE m~  uvsvJE)
           MOVE 100                         TO CONV-LENGTH.

      *-<< EZACIC05: ASCII  => EBCDIC
           CALL 'EZACIC05' USING TOEBCDIC-TOKEN
                                 CONV-BUFFER
                                 CONV-LENGTH.

           MOVE CONV-BUFFER                 TO SOC-BUF(1:100).

       S0000-RECEIVE-CONV-DATA-EXIT.
           EXIT.

      ****************************************************************
      *                                                              *  
      *           S 0 0 0 0 - W R I T E - T D                        *
      *                                                              *  
      ****************************************************************
       S0000-WRITEQ-TD SECTION.

           MOVE LENGTH OF TCPCICS-MSG-AREA TO LENG.

           EXEC CICS ASKTIME
                ABSTIME (TSTAMP)
                NOHANDLE
           END-EXEC.

           EXEC CICS FORMATTIME
                ABSTIME (TSTAMP)
                MMDDYY  (MSGDATE)
                TIME    (MSGTIME)
                DATESEP ('/')
                TIMESEP (':')
                NOHANDLE
           END-EXEC.

           EXEC CICS WRITEQ TS
                QUEUE  ('INIT')
                FROM   (TCPCICS-MSG-AREA)
                RESP   (RESPONSE)
                LENGTH (LENG)
           END-EXEC.

           IF RESPONSE = DFHRESP(NORMAL)
              THEN CONTINUE
              ELSE
                IF RESPONSE = DFHRESP(INVREQ)
                   THEN MOVE TS-INVREQ-ERR          TO MSG-AREA
                   ELSE
                     IF RESPONSE = DFHRESP(NOTAUTH)
                        THEN MOVE TS-NOTAUTH-ERR    TO MSG-AREA
                        ELSE
                          IF RESPONSE = DFHRESP(IOERR)
                             THEN MOVE TS-IOERR-ERR TO MSG-AREA
                             ELSE MOVE WRITETS-ERR  TO MSG-AREA
                          END-IF
                     END-IF
                END-IF
           END-IF.

       S0000-WRITEQ-TD-EXIT.
           EXIT.

      ****************************************************************  
      *                                                              *  
      *           S 0 0 0 0 - D E L E T E Q                          *
      *                                                              *  
      ****************************************************************  
       S0000-DELETEQ  SECTION.

           EXEC CICS READQ  TS
                QUEUE('INIT')
                INTO(W-DBUG-IN)
                ITEM(W-QUEUE-ITEM-ONE)
                NUMITEMS(W-NUM-ITEMS)
                RESP(RESPONSE)
           END-EXEC.

           IF RESPONSE = DFHRESP(NORMAL)
               IF  W-NUM-ITEMS > +150
                   EXEC  CICS  DELETEQ  TS
                               QUEUE('INIT')
                               RESP(RESPONSE)
                   END-EXEC
               ELSE
                   CONTINUE
               END-IF
           ELSE
               CONTINUE
           END-IF.

       S0000-DELETEQ-EXIT.
           EXIT.

      ******************************************************************
      *                  END  OF  LCHSINIT                             *
      ******************************************************************
