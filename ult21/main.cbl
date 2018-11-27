      ******************************************************************
      * Author: cristiano.junior@mbra.com.br
      * Date: 2018-11-27
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ULT-21.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT ENTRADA
           ASSIGN TO '.\input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT ARQ-SORT
           ASSIGN TO '.\ARQ-SORT.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT SAIDA
           ASSIGN TO '.\OUTPUT.TXT'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD ENTRADA LABEL RECORDS ARE STANDARD.
       01 REG-ENTRADA.
           05 IN-NOME PIC X(10).
           05 IN-CODIGO PIC XX.
           05 IN-FONE PIC 9(8).
           05 IN-SALARIO PIC 9(5)V99.

       SD ARQ-SORT LABEL RECORDS ARE STANDARD.
       01 REG-ARQ-SORT.
           05 E-NOME PIC X(10).
           05 E-SALARIO PIC 9(5)V99.

       FD SAIDA LABEL RECORDS ARE STANDARD.
       01 REG-SAIDA.
           05 OUT-NOME PIC X(10).
           05 OUT-SALARIO PIC 9(5)V99.

       WORKING-STORAGE SECTION.
       01 WS-ULTIMO-REGISTRO PIC X.


       PROCEDURE DIVISION.
      ******************************************************************
      * procedimento principal: ordenar o arquivo de entrada, mantendo
      * somente os registros dos funcionários com salario maior que 5000
      ******************************************************************
       MAIN-PROCEDURE.
           OPEN INPUT ENTRADA
           OPEN OUTPUT SAIDA
           PERFORM ORDENAR
           CLOSE ENTRADA
                 SAIDA
           STOP RUN.

      ******************************************************************
      * ordena o arquivo de entrada.
      ******************************************************************
       ORDENAR.
           SORT ARQ-SORT
               ON ASCENDING KEY E-SALARIO
               INPUT PROCEDURE IS LER-ENTRADA
               OUTPUT PROCEDURE IS ESCREVER-SAIDA.

       LER-ENTRADA.
           MOVE 'N' TO WS-ULTIMO-REGISTRO
           PERFORM LER-ENTRADA-LOOP UNTIL WS-ULTIMO-REGISTRO = 'S'
           EXIT.

       LER-ENTRADA-LOOP.
           READ ENTRADA
               AT END
                   MOVE 'S' TO WS-ULTIMO-REGISTRO
               NOT AT END
                   IF IN-SALARIO > 5000
                       MOVE IN-NOME TO E-NOME
                       MOVE IN-SALARIO TO E-SALARIO
                       RELEASE REG-ARQ-SORT
                   END-IF
           END-READ.

       ESCREVER-SAIDA.
           MOVE 'N' TO WS-ULTIMO-REGISTRO
           PERFORM ESCREVER-SAIDA-LOOP UNTIL WS-ULTIMO-REGISTRO = 'S'
           EXIT.

       ESCREVER-SAIDA-LOOP.
           RETURN ARQ-SORT
               AT END
                   MOVE 'S' TO WS-ULTIMO-REGISTRO
               NOT AT END
                   MOVE E-NOME TO OUT-NOME
                   MOVE E-SALARIO TO OUT-SALARIO
                   WRITE REG-SAIDA BEFORE ADVANCING 1 LINE
           END-RETURN.

       END PROGRAM ULT-21.
