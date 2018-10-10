       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALC4.
       AUTHOR. NANCY STERN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-QUANTIDADE   PIC 99999.
       01 WS-PRECO        PIC S99V99.
       01 WS-TOTAL        PIC S9(7)V99.
       01 WS-VALOR-TAXA   PIC S9(7)V99.
       01 WS-TOTAL-GERAL  PIC S9(8)V99.
       01 WS-RESPOSTA     PIC X(4) VALUE SPACES.

       SCREEN SECTION.
       01 CALC4-TELA-ETIQUETA BACKGROUND-COLOR IS 1
                              FOREGROUND-COLOR IS 7.
           05 BLANK SCREEN.
           05 'QUANTIDADE   PRECO             TOTAL'
              LINE 5  COLUMN 20 HIGHLIGHT.
           05 'TAXA 8%'
              LINE 10 COLUMN 35 HIGHLIGHT.
           05 '=============='
              LINE 12 COLUMN 43 HIGHLIGHT.
           05 'TOTAL GERAL: '
              LINE 14 COLUMN 30 HIGHLIGHT.
       01 CALC4-LIMPA-TELA.
           05 LINE 7  COLUMN 21 VALUE '       '
                                REVERSE-VIDEO.
           05 LINE 7  COLUMN 33 VALUE '       '
                                REVERSE-VIDEO.
           05 LINE 7  COLUMN 43 VALUE '                    '
                                REVERSE-VIDEO.
           05 LINE 10 COLUMN 43 VALUE '                    '
                                REVERSE-VIDEO.
           05 LINE 14 COLUMN 43 VALUE '                    '
                                REVERSE-VIDEO.
           05 LINE 24 COLUMN 1  VALUE
               'Digite os dados e aperte <Tab> ou <Enter>'BLANK LINE.
       01 CALC4-TELA-ENTRADA.
           05 LINE 7 COLUMN 21 PIC ZZ,ZZ9 TO WS-QUANTIDADE
               REVERSE-VIDEO REQUIRED AUTO.
           05 LINE 7 COLUMN 33 PIC Z9.99- TO WS-PRECO
               REVERSE-VIDEO REQUIRED.
       01 CALC4-TELA-SAIDA.
           05 LINE 7  COLUMN 21 PIC ZZ,ZZ9 FROM WS-QUANTIDADE
               REVERSE-VIDEO.
           05 LINE 7  COLUMN 35 PIC ZZ.99- FROM WS-PRECO
               REVERSE-VIDEO.
           05 LINE 7  COLUMN 43 PIC Z,ZZZ,ZZ9.99- FROM WS-TOTAL
               REVERSE-VIDEO.
           05 LINE 10 COLUMN 43 PIC Z,ZZZ,ZZ9.99- FROM WS-VALOR-TAXA
               REVERSE-VIDEO.
           05 LINE 14 COLUMN 43 PIC ZZ,ZZZ,ZZ9.99- FROM WS-TOTAL-GERAL
               REVERSE-VIDEO.
           05 LINE 24 COLUMN 1 VALUE
               'Aperte <Enter> para continuar our "sair" para encerrar'
      -BLANK LINE.
       01 CALC4-TELA-ENCERRAMENTO BACKGROUND-COLOR IS 0
                                  FOREGROUND-COLOR IS 1.
           05 BLANK SCREEN.
           05 LINE 7  COLUMN 10
              VALUE '********************************'.
           05 LINE 8  COLUMN 10
              VALUE '*                              *'.
           05 LINE 9  COLUMN 10
              VALUE '*                              *'.
           05 LINE 10 COLUMN 10
              VALUE '*                              *'.
           05 LINE 11 COLUMN 10
              VALUE '********************************'.
      *****************************************************************

       PROCEDURE DIVISION.
       100-COMECA-PROGRAMA.
           DISPLAY CALC4-TELA-ETIQUETA
           PERFORM 200-INICIA-TRANSACAO
                   UNTIL WS-RESPOSTA = 'SAIR' OR 'sair'
           PERFORM 300-FIM-PROGRAMA
           STOP RUN.

      *****************************************************************
      * Aceita os dados , faz calculos, apresenta resultados;
      * pergunta se o usuario deseja continuar ou sair
      *****************************************************************
       200-INICIA-TRANSACAO.
           DISPLAY CALC4-LIMPA-TELA
           ACCEPT CALC4-TELA-ENTRADA
           COMPUTE WS-TOTAL = WS-QUANTIDADE * WS-PRECO
           COMPUTE WS-VALOR-TAXA = WS-TOTAL * .08
           COMPUTE WS-TOTAL-GERAL = WS-TOTAL + WS-VALOR-TAXA
           DISPLAY CALC4-TELA-SAIDA
           ACCEPT WS-RESPOSTA
               LINE 24 COLUMN 60.
      *        PROMPT '_' REVERSE-VIDEO NO BEEP.

      *****************************************************************
      * Limpa a tela e exibe mensagem de saida
      *****************************************************************
       300-FIM-PROGRAMA.
           DISPLAY CALC4-TELA-ENCERRAMENTO
           DISPLAY 'CALC4 ENCERRADO CONFORME SOLICITADO'
               LINE 9 COLUMN 14
               BLINK
           DISPLAY ' '
               LINE 1 COLUMN 1.

       END PROGRAM CALC4.
