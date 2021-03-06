      ******************************************************************
      * Author: cristiano.junior@mbra.com.br
      * Date: 2018-10-15
      * Purpose: Solve the problem 1 on Stern & Stern, PDF page 461
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAGE-461.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT TRANS-VENDAS
           ASSIGN TO '.\TRANS-VENDAS.CBDB'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT RELATORIO-VENDAS
           ASSIGN TO '.\RELATORIO-VENDAS.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD TRANS-VENDAS LABEL RECORDS ARE STANDARD.
       01 REG-VENDAS-IN.
           05 NR-VENDEDOR-IN PIC 99.
           05 NOME-VENDEDOR-IN PIC X(20).
           05 VLR-VENDAS-IN PIC 999V99.

       FD RELATORIO-VENDAS LABEL RECORDS ARE OMITTED.
       01 REG-VENDAS-OUT PIC X(80).

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
           05 PIC X(43) VALUE 'NR | NOME VENDEDOR        | VENDAS TOTAIS
      -''.
       01 CABECALHO-RELATORIO-3.
           05 PIC X(50) VALUE '---|----------------------|--------------
      -'---'.
       01 REG-VENDEDOR-OUT.
           05 NR-VENDEDOR-OUT PIC 99.
           05 PIC X(3) VALUE ' | '.
           05 NOME-VENDEDOR-OUT PIC X(20).
           05 PIC X(3) VALUE ' | '.
           05 VENDAS-TOTAIS-OUT PIC $ZZZ,ZZZ.99.
      * TODO add a footer to the report

       01 TABELA-VENDAS OCCURS 20 TIMES INDEXED BY NR-V.
           05 NOME-VENDEDOR PIC X(20).
           05 VENDAS-TOTAIS PIC 9(6)V99.

       01 WS-DATA.
           05 WS-ANO PIC 9(4).
           05 WS-MES PIC 99.
           05 WS-DIA PIC 99.
       01 ULTIMO-REGISTRO PIC X VALUE 'N'.
       01 VENDAS-COMPANHIA PIC 99999v99.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT TRANS-VENDAS
           OPEN OUTPUT RELATORIO-VENDAS
           PERFORM ESCREVER-CABECALHO
           PERFORM UNTIL ULTIMO-REGISTRO = 'S'
               READ TRANS-VENDAS
                   AT END
                       MOVE 'S' TO ULTIMO-REGISTRO
                   NOT AT END
                       PERFORM CONTABILIZAR-VENDA
           END-PERFORM
           PERFORM ESCREVER-RELATORIO
           CLOSE TRANS-VENDAS RELATORIO-VENDAS
           STOP RUN.

      ******************************************************************
      * escreve o cabecalho do arquivo de saida.
      ******************************************************************
       ESCREVER-CABECALHO.
           MOVE 1 TO NR-PAG
           MOVE FUNCTION CURRENT-DATE TO WS-DATA
           MOVE WS-DIA TO DIA-ATUAL
           MOVE WS-MES TO MES-ATUAL
           MOVE WS-ANO TO ANO-ATUAL
           WRITE REG-VENDAS-OUT FROM CABECALHO-RELATORIO-1.
           WRITE REG-VENDAS-OUT
               FROM CABECALHO-RELATORIO-2
               AFTER ADVANCING 1 LINE.
           WRITE REG-VENDAS-OUT
               FROM CABECALHO-RELATORIO-3
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * Adiciona uma venda aa tabela de acumulacao
      ******************************************************************
       CONTABILIZAR-VENDA.
           MOVE NOME-VENDEDOR-IN TO NOME-VENDEDOR(NR-VENDEDOR-IN)
           ADD VLR-VENDAS-IN TO VENDAS-TOTAIS(NR-VENDEDOR-IN).

      ******************************************************************
      * Escreve a tabela de vendas de acordo com o calculado
      ******************************************************************
       ESCREVER-RELATORIO.
           PERFORM VARYING NR-V FROM 1 BY 1 UNTIL NR-V > 20
               MOVE NR-V TO NR-VENDEDOR-OUT
               MOVE NOME-VENDEDOR(NR-V) TO NOME-VENDEDOR-OUT
               MOVE VENDAS-TOTAIS(NR-V) TO VENDAS-TOTAIS-OUT

               WRITE REG-VENDAS-OUT
                   FROM REG-VENDEDOR-OUT
                   AFTER ADVANCING 1 LINE
           END-PERFORM.

       END PROGRAM PAGE-461.
