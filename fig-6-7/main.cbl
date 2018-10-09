       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALC4.
       AUTHOR. NANCY STERN.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-QUANTIDADE PIC 9(5).
       01 WS-PRECO PIC S99V99.
       01 WS-TOTAL PIC S9(7)V99.
       01 WS-VALOR-TAVA PIC S9(7)V99.
       01 WS-TOTAL-GERAL PIC S9(8)V99.
       01 WS-RESPOSTA PIC X(4) VALUE SPACES.

       SCREEN SECTION.
       01 CALC4-TELA-ETIQUETA BACKGROUND-COLOR IS BLUE
                              FOREGROUND-COLOR IS WHITE.
           05 BLANK SCREEN.
           05 'QUANTIDADE   PRECO             TOTAL'
              LINE 5 COLUMN 20 HIGHLIGHT.
           05 'TAVA 8%'
              LINE 10 COLUMN 55 HIGHLIGHT.
           05 '--------------'
              LINE 12 COLUMN 43 HIGHLIGHT.
           05 'TOTAL GERAL'
              LINE 14 COLUMN 30.

       01 CALC4-LIMPA-TELA.
           05 LINE 7 COLUMN 21 VALUE '        '
                               REVERSE-VIDEO.
           05 LINE 7 COLUMN 21 VALUE '        '
                               REVERSE-VIDEO.
           05 LINE 7 COLUMN 21 VALUE '        '
                               REVERSE-VIDEO.
           05 LINE 7 COLUMN 21 VALUE '        '
                               REVERSE-VIDEO.
