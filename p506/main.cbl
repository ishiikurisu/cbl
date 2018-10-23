      ******************************************************************
      * Author: cristiano.junior@mbra.com.br
      * Date: 2018-10-22
      * Purpose: Solve the problem 1 on Stern & Stern, PDF page 506
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAGE-506.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT MESTRE-VENDAS
           ASSIGN TO 'E:\p506\bin\MESTRE-VENDAS.CBDB'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT TRANS-VENDAS
           ASSIGN TO 'E:\p506\bin\TRANS-VENDAS.CBDB'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT LISTAGEM-CONTROLE
           ASSIGN TO 'E:\p506\bin\LISTAGEM-CONTROLE.MD'
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT MESTRE-VENDAS-ATUAL
           ASSIGN TO 'E:\p506\bin\MESTRE-VENDAS-ATUAL.CBDB'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD MESTRE-VENDAS LABEL RECORDS ARE STANDARD.
       01 REG-MESTRE-VENDAS.
           05 NR-VENDEDOR PIC X(5).
           05 PIC X(32).
           05 VALORES-ANO-ANT.
               10 VENDAS PIC 9999V99.
               10 COMISSAO PIC 9999V99.
           05 PIC X(6).
           05 VALORES-PER-ATUAL.
              10 VENDAS PIC 9999V99.
              10 COMISSAO PIC 9999V99.
           05 PIC X(3).

       FD TRANS-VENDAS LABEL RECORDS ARE STANDARD.
       01 REG-TRANS-VENDAS.
           05 NR-VENDEDOR-IN PIC X(5).
           05 VENDAS-IN PIC 9999V99.
           05 COMISSAO-IN PIC 9999V99.

       FD LISTAGEM-CONTROLE LABEL RECORDS ARE OMITTED.
       01 REG-LISTAGEM-CONTROLE PIC X(90).

       FD MESTRE-VENDAS-ATUAL LABEL RECORDS ARE OMITTED.
       01 REG-MESTRE-VENDAS-ATUAL PIC X(70).



       WORKING-STORAGE SECTION.
      * tela
       01 CABECALHO-RELATORIO-1.
           05 PIC X(54) VALUE '# LISTAGEM DE CONTROLE PARA ATUALIZACAO D
      -'E VENDAS -- p'.
           05 NR-PAG        PIC 999.
           05 PIC X(5) VALUE ' DIA '.
           05 DATA-ATUAL.
               10 DIA-ATUAL PIC 99.
               10           PIC X VALUE '/'.
               10 MES-ATUAL PIC 99.
               10           PIC X VALUE '/'.
               10 ANO-ATUAL PIC 9999.
       01 CABECALHO-RELATORIO-2.
           05 PIC X(90) VALUE '| NR. VENDEDOR | ANO ANTERIOR          |
      -'VALORES ATUAIS        | PROCESSO REALIZADO |'.
       01 CABECALHO-RELATORIO-3.
           05 PIC X(90) VALUE '|              | VENDAS    | COMISSAO  |
      -'VENDAS    | COMISSAO  |                    |'.
       01 CABECALHO-RELATORIO-4.
           05 PIC X(90) VALUE '|--------------|-----------|-----------|
      -'----------|-----------|--------------------|'.
       01 REG-MESTRE-OUT.
           05 PIC XXX VALUE '|  '.
           05 NR-VENDEDOR-OUT PIC X(5).
           05 PIC X(9) VALUE '       | '.
           05 VALORES-ANO-ANT-OUT.
               10 VENDAS-OUT PIC $Z,ZZZ.99.
               10 PIC XXX VALUE ' | '.
               10 COMISSAO-OUT PIC $Z,ZZZ.99.
               10 PIC XXX VALUE ' | '.
           05 VALORES-PER-ATUAL-OUT.
               10 VENDAS-OUT PIC $Z,ZZZ.99.
               10 PIC XXX VALUE ' | '.
               10 COMISSAO-OUT PIC $Z,ZZZ.99.
               10 PIC XXX VALUE ' | '.
           05 SITUACAO-PROCESSO-OUT PIC X(18).
           05 PIC XXX VALUE ' | '.

      * variaveis
       01 WS-DATA.
           05 WS-ANO PIC 9(4).
           05 WS-MES PIC 99.
           05 WS-DIA PIC 99.
       01 WS-ULTIMO-REGISTRO-MESTRE PIC X.
       01 WS-ULTIMO-REGISTRO-TRANS PIC X.
       01 WS-REGISTROS-POR-PAGINA PIC 99.
       01 WS-NR-PAG PIC 999 VALUE 1.
       01 WS-MUDOU-REGISTRO-ATUAL PIC X.

       PROCEDURE DIVISION.
      ******************************************************************
      * procedimento principal: atualizar o arquivo mestre baseado nas
      * transacoes no arquivo de vendas.
      ******************************************************************
       MAIN-PROCEDURE.
           OPEN INPUT MESTRE-VENDAS
           OPEN INPUT TRANS-VENDAS
           OPEN OUTPUT LISTAGEM-CONTROLE
           OPEN OUTPUT MESTRE-VENDAS-ATUAL
           PERFORM ESCREVER-CABECALHO
           PERFORM SETUP-LOOP-REGISTROS-MESTRE
           MOVE 'N' TO WS-ULTIMO-REGISTRO-MESTRE
           MOVE 'N' TO WS-ULTIMO-REGISTRO-TRANS
           PERFORM UNTIL WS-ULTIMO-REGISTRO-MESTRE = 'S'
               READ MESTRE-VENDAS
                   AT END
                       MOVE 'S' TO WS-ULTIMO-REGISTRO-MESTRE
                   NOT AT END
                       PERFORM ATUALIZAR-REGISTROS-MESTRE
           END-PERFORM
      * TODO write remaining master file
           CLOSE MESTRE-VENDAS
                 TRANS-VENDAS
                 LISTAGEM-CONTROLE
                 MESTRE-VENDAS-ATUAL
           STOP RUN.

      ******************************************************************
      * escreve o cabecalho do arquivo de saida
      ******************************************************************
       ESCREVER-CABECALHO.
           MOVE FUNCTION CURRENT-DATE TO WS-DATA
           MOVE WS-DIA TO DIA-ATUAL
           MOVE WS-MES TO MES-ATUAL
           MOVE WS-ANO TO ANO-ATUAL
           MOVE WS-NR-PAG TO NR-PAG
           WRITE REG-LISTAGEM-CONTROLE
               FROM CABECALHO-RELATORIO-1
               AFTER ADVANCING 2 LINES
           WRITE REG-LISTAGEM-CONTROLE
               FROM CABECALHO-RELATORIO-2
               AFTER ADVANCING 2 LINES
           WRITE REG-LISTAGEM-CONTROLE
               FROM CABECALHO-RELATORIO-3
               AFTER ADVANCING 1 LINE.
           WRITE REG-LISTAGEM-CONTROLE
               FROM CABECALHO-RELATORIO-4
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * escreve atualizacoes no arquivo mestre
      ******************************************************************
       ESCREVER-ARQUIVO-MESTRE.
           WRITE REG-MESTRE-VENDAS-ATUAL
               FROM REG-MESTRE-VENDAS
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * escreve atualizacoes no arquivo mestre
      ******************************************************************
       ESCREVER-LISTAGEM-CONTROLE.
           MOVE NR-VENDEDOR TO NR-VENDEDOR-OUT
           MOVE 0 TO VENDAS-OUT OF VALORES-ANO-ANT-OUT
           MOVE 0 TO COMISSAO-OUT OF VALORES-ANO-ANT-OUT
           MOVE VENDAS OF VALORES-PER-ATUAL
                TO VENDAS-OUT OF VALORES-PER-ATUAL-OUT
           MOVE COMISSAO OF VALORES-PER-ATUAL
                TO COMISSAO-OUT OF VALORES-PER-ATUAL-OUT
           WRITE REG-LISTAGEM-CONTROLE
               FROM REG-MESTRE-OUT
               AFTER ADVANCING 1 LINE.

      ******************************************************************
      * atualiza um registro do arquivo mestre por meio da análise das
      * transacoes relacionadas a um vendedor
      ******************************************************************
       SETUP-LOOP-REGISTROS-MESTRE.
           READ TRANS-VENDAS
               AT END
                   MOVE 'S' TO WS-ULTIMO-REGISTRO-TRANS.

      ******************************************************************
      * atualiza um registro do arquivo mestre por meio da análise das
      * transacoes relacionadas a um vendedor
      ******************************************************************
       ATUALIZAR-REGISTROS-MESTRE.
      * setup
           MOVE 'SEM REGISTRO' TO SITUACAO-PROCESSO-OUT
           PERFORM UNTIL (NR-VENDEDOR IS NOT EQUAL NR-VENDEDOR-IN) OR
                         (WS-ULTIMO-REGISTRO-TRANS IS EQUAL TO 'S')
      * updating current master register
               MOVE 'ATUALIZACAO' TO SITUACAO-PROCESSO-OUT
               ADD VENDAS-IN TO VENDAS OF VALORES-PER-ATUAL
               ADD COMISSAO-IN TO COMISSAO OF VALORES-PER-ATUAL

      * reading new transaction
               READ TRANS-VENDAS
                   AT END MOVE 'S' TO WS-ULTIMO-REGISTRO-TRANS
           END-PERFORM
           PERFORM ESCREVER-ARQUIVO-MESTRE
           PERFORM ESCREVER-LISTAGEM-CONTROLE.

       END PROGRAM PAGE-506.
