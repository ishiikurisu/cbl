      ******************************************************************
      * Author: cristiano.junior@mbra.com.br
      * Date: 2018-10-16
      * Purpose: Solve the problem 2 on Stern & Stern, PDF page 462
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAGE-462.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT TAB-IMPOSTOS
           ASSIGN TO '.\TAB-IMPOSTOS.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT ARQ-SALARIO
           ASSIGN TO '.\ARQ-SALARIO.CBDB'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT RELATORIO-SALARIO
           ASSIGN TO '.\RELATORIO-SALARIO.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD TAB-IMPOSTOS LABEL RECORDS ARE STANDARD.
       01 REG-IMPOSTOS-IN.
           05 RENDIMENTO PIC 9(5).
           05 IMPOSTO-FEDERAL PIC V999.
           05 IMPOSTO-ESTADUAL PIC V999.

       FD ARQ-SALARIO LABEL RECORDS ARE STANDARD.
       01 REG-SALARIO-IN.
           05 NR-EMPREGADO-IN PIC 9(5).
           05 NOME-EMPREGADO-IN PIC X(20).
           05 PIC XX.
           05 SALARIO-ANUAL-IN PIC 9(5).
           05 PIC X(8).
           05 NR-DEPENDENTES-IN PIC 99.

       FD RELATORIO-SALARIO LABEL RECORDS ARE OMITTED.
       01 REG-RELAT-OUT PIC X(80).

       WORKING-STORAGE SECTION.
       01 CABECALHO-RELATORIO-1.
           05 PIC X(35) VALUE '# RELATORIO MENSAL DE SALARIOS -- p'.
           05 NR-PAG        PIC 999.
           05 PIC X(5) VALUE ' DIA '.
           05 DATA-ATUAL.
               10 DIA-ATUAL PIC 99.
               10           PIC X VALUE '/'.
               10 MES-ATUAL PIC 99.
               10           PIC X VALUE '/'.
               10 ANO-ATUAL PIC 9999.
       01 CABECALHO-RELATORIO-2.
           05 PIC X(50) VALUE ' NOME EMPREGADO      | SALARIO LIQUIDO |
      -''.
       01 CABECALHO-RELATORIO-3.
           05 PIC X(50) VALUE '---------------------|-----------------|-
      -'---'.
       01 REG-SALARIO-OUT.
           05 NOME-EMPREGADO-OUT PIC X(20).
           05 PIC X(3) VALUE ' | '.
           05 SALARIO-LIQUIDO-OUT PIC $ZZ,ZZZ.99.
           05 PIC X(10) VALUE '      | '.
       01 FOOTER-RELATORIO.
           05 PIC X(50) VALUE '----'.

       01 WS-TAB-IMPOSTOS OCCURS 5 TIMES.
           05 RENDIMENTO-MAXIMO PIC 9(5).
           05 IMPOSTO-FEDERAL PIC V999.
           05 IMPOSTO-ESTADUAL PIC V999.
       01 WS-DATA.
           05 WS-ANO PIC 9(4).
           05 WS-MES PIC 99.
           05 WS-DIA PIC 99.
       01 WS-ULTIMO-REGISTRO PIC X VALUE 'N'.
       01 WS-REGISTROS-POR-PAGINA PIC 99.
       01 WS-NR-PAG PIC 999.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT TAB-IMPOSTOS ARQ-SALARIO
           OPEN OUTPUT RELATORIO-SALARIO
      * TODO Ler tabela de impostos
           PERFORM LOOP-SETUP
           PERFORM UNTIL WS-ULTIMO-REGISTRO = 'S'
               READ ARQ-SALARIO
                   AT END
                       MOVE 'S' TO WS-ULTIMO-REGISTRO
                   NOT AT END
                       PERFORM CALCULAR-IMPOSTO
           END-PERFORM
           CLOSE TAB-IMPOSTOS ARQ-SALARIO RELATORIO-SALARIO
           STOP RUN.

      ******************************************************************
      * escreve o cabecalho do arquivo de saida.
      ******************************************************************
       ESCREVER-CABECALHO.
           MOVE FUNCTION CURRENT-DATE TO WS-DATA
           MOVE WS-NR-PAG TO NR-PAG
           MOVE WS-DIA TO DIA-ATUAL
           MOVE WS-MES TO MES-ATUAL
           MOVE WS-ANO TO ANO-ATUAL
           WRITE REG-RELAT-OUT
               FROM CABECALHO-RELATORIO-1
               AFTER ADVANCING 2 LINES
           WRITE REG-RELAT-OUT
               FROM CABECALHO-RELATORIO-2
               AFTER ADVANCING 2 LINES
           WRITE REG-RELAT-OUT
               FROM CABECALHO-RELATORIO-3
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * calcula os impostos por cada funcionario e escreve o resultado
      * na tabela de saida chamando o procedimento ADICIONA-SALARIO
      ******************************************************************
       CALCULAR-IMPOSTO.
           MOVE NOME-EMPREGADO-IN TO NOME-EMPREGADO-OUT
      * TODO Calcular impostos de verdade
           MOVE SALARIO-ANUAL-IN TO SALARIO-LIQUIDO-OUT
           PERFORM ADICIONA-SALARIO.

      ******************************************************************
      * Adiciona um salario na tabela de saida
      ******************************************************************
       ADICIONA-SALARIO.
           WRITE REG-RELAT-OUT
               FROM REG-SALARIO-OUT
               AFTER ADVANCING 1 LINE
           ADD 1 TO WS-REGISTROS-POR-PAGINA
           IF WS-REGISTROS-POR-PAGINA = 20
               ADD 1 TO WS-NR-PAG
               WRITE REG-RELAT-OUT
                   FROM FOOTER-RELATORIO
                   AFTER ADVANCING 2 LINES
               PERFORM ESCREVER-CABECALHO
               MOVE 0 TO WS-REGISTROS-POR-PAGINA
           END-IF.

      ******************************************************************
      * Adiciona um salario na tabela de saida
      ******************************************************************
       LOOP-SETUP.
           MOVE 0 TO WS-REGISTROS-POR-PAGINA
           MOVE 1 TO WS-NR-PAG
           PERFORM ESCREVER-CABECALHO.

       END PROGRAM PAGE-462.
