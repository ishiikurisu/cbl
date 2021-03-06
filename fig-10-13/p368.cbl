      ******************************************************************
      * Author: cristiano.junior@mbra.com.br
      * Date: 2018-10-11
      * Purpose: Solve the problem 1 on Stern & Stern, PDF page 367
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAGE-367.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT TRANS-VENDAS
           ASSIGN TO '.\TRANS-VENDAS.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT RELAT-VENDAS
           ASSIGN TO '.\RELAT-VENDAS.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD TRANS-VENDAS  LABEL RECORDS ARE STANDARD.
       01 REG-VENDAS-IN.
           05 NR-DIA       PIC 9.
           05 NR-VENDEDOR  PIC XXX.
           05 VALOR-VENDAS PIC 9(3)V99.

       FD RELAT-VENDAS LABEL RECORDS ARE OMITTED.
       01 REG-RELAT-OUT PIC X(80).

       WORKING-STORAGE SECTION.
       01 CABECALHO-RELATORIO-1.
           05 PIC X(26) VALUE '# RELATORIO DE VENDAS -- p'.
           05 NR-PAG        PIC 99.
           05 PIC X(5) VALUE ' DIA '.
           05 DATA-ATUAL.
               10 DIA-ATUAL PIC 99.
               10           PIC X VALUE '/'.
               10 MES-ATUAL PIC 99.
               10           PIC X VALUE '/'.
               10 ANO-ATUAL PIC 9999.
       01 CABECALHO-RELATORIO-2.
           05 PIC X(18) VALUE 'DIA | VALOR TOTAL '.
       01 CABECALHO-RELATORIO-3.
           05 PIC X(18) VALUE '------------------'.
       01 REG-VENDAS-OUT.
           05 DIA-SEMANA-OUT PIC XXX.
           05 PIC X(3) VALUE ' | '.
           05 VENDAS-TOTAIS-OUT PIC $ZZ,ZZZ.99.
       01 FOOTER-RELATORIO.
           05 PIC X(25) VALUE '          TOTAL SEMANAL: '.
           05 TOTAL-SEMANAL-OUT PIC $ZZZ,ZZZ.99.

       01 WS-DATA.
           05 WS-ANO PIC 9(4).
           05 WS-MES PIC 99.
           05 WS-DIA PIC 99.
       01 SEGUNDA PIC XXX VALUE 'SEG'.
       01 TERCA   PIC XXX VALUE 'TER'.
       01 QUARTA  PIC XXX VALUE 'QUA'.
       01 QUINTA  PIC XXX VALUE 'QUI'.
       01 SEXTA   PIC XXX VALUE 'SEX'.
       01 DIA-CORRENTE PIC X.
       01 ULTIMO-REGISTRO PIC X VALUE 'N'.
       01 VENDAS-TOTAIS PIC 99999v99.
       01 TOTAL-SEMANAL PIC 999999v99.


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT TRANS-VENDAS
           OPEN OUTPUT RELAT-VENDAS
           PERFORM ESCREVER-CABECALHO-1
           PERFORM ESCREVER-CABECALHO-2
           PERFORM ESCREVER-CABECALHO-3
           PERFORM COMECAR-INTERRUPCAO
           PERFORM UNTIL ULTIMO-REGISTRO = 'S'
               READ TRANS-VENDAS
                   AT END
                       MOVE 'S' TO ULTIMO-REGISTRO
                   NOT AT END
                       PERFORM INTERRUPCAO
           END-PERFORM.
           PERFORM ESCREVER-LINHA-DO-RELATORIO
           PERFORM ESCREVER-FOOTER
           CLOSE TRANS-VENDAS RELAT-VENDAS
           STOP RUN.

      ******************************************************************
      * escreve o cabecalho do arquivo de saida.
      ******************************************************************
       ESCREVER-CABECALHO-1.
           MOVE 1 TO NR-PAG
           MOVE FUNCTION CURRENT-DATE TO WS-DATA
           MOVE WS-DIA TO DIA-ATUAL
           MOVE WS-MES TO MES-ATUAL
           MOVE WS-ANO TO ANO-ATUAL
           WRITE REG-RELAT-OUT FROM CABECALHO-RELATORIO-1.

      ******************************************************************
      * escreve o cabecalho da tabela de saida
      ******************************************************************
       ESCREVER-CABECALHO-2.
           WRITE REG-RELAT-OUT
               FROM CABECALHO-RELATORIO-2
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * escreve a quebra de linha da tabela saida
      ******************************************************************
       ESCREVER-CABECALHO-3.
           WRITE REG-RELAT-OUT FROM CABECALHO-RELATORIO-3
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * prepara as variaveis de estado para processar o arquivo.
      ******************************************************************
       COMECAR-INTERRUPCAO.
           READ TRANS-VENDAS.
           MOVE NR-DIA TO DIA-CORRENTE
           MOVE VALOR-VENDAS TO TOTAL-SEMANAL VENDAS-TOTAIS.

      ******************************************************************
      * loop principal do programa
      ******************************************************************
       INTERRUPCAO.
           IF NR-DIA NOT EQUAL TO DIA-CORRENTE
               PERFORM ESCREVER-LINHA-DO-RELATORIO
               MOVE NR-DIA TO DIA-CORRENTE
               MOVE 0 TO VENDAS-TOTAIS
           END-IF.
           ADD VALOR-VENDAS TO TOTAL-SEMANAL
           ADD VALOR-VENDAS TO VENDAS-TOTAIS.

      ******************************************************************
      * escreve uma linha do relatorio
      ******************************************************************
       ESCREVER-LINHA-DO-RELATORIO.
           EVALUATE DIA-CORRENTE
           WHEN 1
               MOVE SEGUNDA TO DIA-SEMANA-OUT
           WHEN 2
               MOVE TERCA TO DIA-SEMANA-OUT
           WHEN 3
               MOVE QUARTA TO DIA-SEMANA-OUT
           WHEN 4
               MOVE QUINTA TO DIA-SEMANA-OUT
           WHEN 5
               MOVE SEXTA TO DIA-SEMANA-OUT
           END-EVALUATE
           MOVE VENDAS-TOTAIS TO VENDAS-TOTAIS-OUT
           WRITE REG-RELAT-OUT
               FROM REG-VENDAS-OUT
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * escreve footer do relatorio
      ******************************************************************
       ESCREVER-FOOTER.
           MOVE TOTAL-SEMANAL TO TOTAL-SEMANAL-OUT
           WRITE REG-RELAT-OUT
               FROM FOOTER-RELATORIO
               AFTER ADVANCING 2 LINES.

       END PROGRAM PAGE-367.
