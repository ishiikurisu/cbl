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
      * TODO preencher esta parte

       WORKING-STORAGE SECTION.
      * TODO preencher esta parte

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT TRANS-VENDAS
           OPEN OUTPUT RELATORIO-VENDAS
      * TODO what to do now?
           CLOSE TRANS-VENDAS RELATORIO-VENDAS
           STOP RUN.


       END PROGRAM PAGE-461.
