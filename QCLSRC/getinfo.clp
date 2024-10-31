             PGM

             DCL        VAR(&LOC) TYPE(*CHAR) LEN(10)
             DCL        VAR(&DTAARA) TYPE(*CHAR) LEN(10)
             DCLF       FILE(BCOMMAP)

 LOOP:       RCVF
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ENDPGM))

             RCLDDMCNV
             MONMSG     MSGID(CPF0000)

             CHGVAR     VAR(&DTAARA) VALUE('FX' || &F3EDNV)

             CRTDTAARA  DTAARA(JSANGUIN/&DTAARA) TYPE(*CHAR) LEN(10) +
                          TEXT(TRYYYY)
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(LOOP))

             DLTOBJ     OBJ(JSANGUIN/BARCODS) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF0000)


             CRTDDMF    FILE(JSANGUIN/BARCODS) +
                          RMTFILE(DTAPDBRC/BARCODP) RMTLOCNAME(&F3EDNV)
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(LOOP))


             SBMRMTCMD  CMD('DSPFD FILE(DTAPDBRC/BARCODP)  +
                          TYPE(*MBR) OUTPUT(*OUTFILE) +
                          OUTFILE(QPGMR/JORGE) OUTMBR(*FIRST +
                          *ADD)') DDMFILE(JSANGUIN/BARCODS)
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(LOOP))

             SBMRMTCMD  CMD('SNDNETF FILE(qpgmr/jorge) TOUSRID(( +
                          JSANGUIN YODA))') DDMFILE(JSANGUIN/BARCODS)
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(LOOP))

             CHGOBJD    OBJ(JSANGUIN/&DTAARA) OBJTYPE(*DTAARA) +
                          TEXT('+++ GOOD +++')

             GOTO       CMDLBL(LOOP)

 ENDPGM:     ENDPGM 