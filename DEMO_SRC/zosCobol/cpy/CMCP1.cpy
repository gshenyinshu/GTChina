       01  MQ-OBJECT-DESCRIPTOR.
           COPY CMQODV.

       01  MQ-MESSAGE-DESCRIPTOR.
           COPY CMQMDV.
           COPY CMQODV.

       01  MQ-GET-MESSAGE-OPTIONS.
           COPY CMQGMOV.

      *01  MQ-PUT-MESSAGE-OPTIONS.
      *    COPY CMQPMOV.

       01  MQ-CONSTANTS.
           COPY CMQV.
