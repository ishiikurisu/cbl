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
       FD TRANS-VENDAS.
       01 REG-VENDAS-IN.
           05 NR-DIA       PIC X.
           05 NR-VENDEDOR  PIC XXX.
           05 VALOR-VENDAS PIC 9(3)V99.

       FD RELAT-VENDAS.
       01 REG-VENDAS-OUT.
           05 DIA-SEMANA PIC AAA.
           05 VENDAS-TOTAIS PIC $ZZ,ZZZ.99.
       01 TOTAL-SEMANAL PIC $ZZZ,ZZZ.99.

       WORKING-STORAGE SECTION.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            STOP RUN.
       END PROGRAM PAGE-367.
