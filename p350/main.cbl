       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAGINA-350.
      ************************************************
      * este programa cria um relatorio mensal de    *
      * vendas usando interrupcao de controle de     *
      * nivel duplo.                                 *
      ************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-TRANS-IN
               ASSIGN TO 'G:\p350\bin\entrada.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ARQ-RELAT-OUT ASSIGN TO PRINTER.

       DATA DIVISION.
       FILE SECTION.
       FD ARQ-TRANS-IN LABEL RECORDS ARE STANDARD.
       01 REG-TRANS-IN.
           05 DEPT-IN PIC XX.
           05 NRVEND-IN PIC X(3).
           05 VLR-TRANS-IN PIC 9(3)V99.
       FD ARQ-RELAT-OUT LABEL RECORDS ARE OMITTED.
       01 REG-RELAT-OUT PIC X(132).

       WORKING-STORAGE SECTION.
       01 WS-AREAS-TRAB.
           05 WS-DEPT-ATUAL PIC XX VALUE ZEROS.
           05 WS-NRVEND-ATUAL PIC X(3) VALUE ZEROS.
           05 EXISTEM-MAIS-REGISTROS PIC XXX VALUE 'SIM'.
               88 MAIS-REGISTROS VALUE 'SIM'.
               88 NENHUM-REGISTRO VALUE 'NAO'.
           05 PRIMEIRO-REGISTRO PIC XXX VALUE 'SIM'.
           05 WS-TOTAL-VEND PIC 9(4)V99 VALUE ZEROS.
           05 WS-TOTAL-DEPT PIC 9(5)V99 VALUE ZEROS.
           05 WS-CONTA-PAG PIC 99 VALUE ZEROS.
       01 WS-DATA.
           05 WS-ANO PIC 9(4).
           05 WS-MES PIC 99.
           05 WS-DIA PIC 99.
       01 LC-CABECALHO1.
           05 PIC X(23) VALUE SPACES.
           05 PIC X(26)
               VALUE 'RELATORIO MENSAL DE VENDAS'.
           05 PIC X(7) VALUE SPACES.
           05 PIC X(5) VALUE 'PAG.'.
           05 LC-PAG PIC Z9.
           05 PIC X(3) VALUE SPACES.
           05 LC-DATA.
               10 LC-DIA PIC 99.
               10 PIC X VALUE  '/'.
               10 LC-MES PIC 99.
               10 PIC X VALUE '/'.
               10 LC-ANO PIC 9999.
           05 PIC X(56) VALUE SPACES.
       01 LC-CABECALHO2.
           05 PIC X(17) VALUE SPACES.
           05 PIC X(5) VALUE 'DEPT-'.
           05 LC-DEPT PIC XX.
           05 PIC X(108) VALUE SPACES.
       01 LC-CABECALHO3.
           05 PIC X(12) VALUE SPACES.
           05 PIC X(14) VALUE 'NR DO VENDEDOR'.
           05 PIC X(15) VALUE SPACES.
           05 PIC X(19) VALUE 'VLR TOTAL DE VENDAS'.
           05 PIC X(72) VALUE SPACES.
       01 LD-LINHA-VEND.
           05 PIC X(28) VALUE SPACES.
           05 LD-NRVEND PIC X(3).
           05 PIC X(21) VALUE SPACES.
           05 LD-TOTAL-VEND PIC $$,$$$.99.
           05 PIC X(71) VALUE SPACES.
       01 LD-LINHA-DEPT.
           05 PIC X(47) VALUE SPACES.
           05 PIC X(16) VALUE 'TOTAL DO DEPT - '.
           05 LD-TOTAL-DEPT PIC $$,$$$.99.
           05 PIC X(59) VALUE SPACES.

       PROCEDURE DIVISION.

      ************************************************
      * controle o rumo da logica do programa        *
      ************************************************
       100-MODULO-PRINCIPAL.
           PERFORM 600-RTN-INICIALIZACAO
           PERFORM UNTIL NENHUM-REGISTRO
               READ ARQ-TRANS-IN
                   AT END
                       MOVE 'NAO' TO
                           EXISTEM-MAIS-REGISTROS
                   NOT AT END
                       PERFORM 200-RTN-DETALHES
           END-PERFORM
           PERFORM 400-QUEBRA-DEPT
           PERFORM 700-RTN-FINALIZACAO
           STOP RUN.

      ************************************************
      * executada a partir do modulo principal. testa*
      * as quebras de dept e nrvend. soma o valor da *
      * transacao a WS-TOTAL-VEND.                   *
      ************************************************
       200-RTN-DETALHES.
           EVALUATE TRUE
               WHEN PRIMEIRO-REGISTRO = 'SIM'
                   MOVE NRVEND-IN TO WS-NRVEND-ATUAL
                   MOVE DEPT-IN TO WS-DEPT-ATUAL
                   PERFORM 500-RTN-CABECALHO
                   MOVE 'NAO' TO PRIMEIRO-REGISTRO
               WHEN DEPT-IN NOT EQUAL TO WS-DEPT-ATUAL
                   PERFORM 400-QUEBRA-DEPT
               WHEN NRVEND-IN NOT = WS-NRVEND-ATUAL
                   PERFORM 300-QUEBRA-VEND
           END-EVALUATE
           ADD VLR-TRANS-IN TO WS-TOTAL-VEND.

      ************************************************
      * executada a partir de 200-RTN-DETALHES e     *
      * 400-QUEBRA-DEPT. Execute quebra nrvend       *
      ************************************************
       300-QUEBRA-VEND.
           MOVE WS-TOTAL-VEND TO LD-TOTAL-VEND
           MOVE WS-NRVEND-ATUAL TO LD-NRVEND
           WRITE REG-RELAT-OUT FROM LD-LINHA-VEND
               AFTER ADVANCING 2 LINES
           ADD WS-TOTAL-VEND TO WS-TOTAL-DEPT
           IF MAIS-REGISTROS
               MOVE ZERO TO WS-TOTAL-VEND
               MOVE NRVEND-IN TO WS-NRVEND-ATUAL
           END-IF.

      ************************************************
      * executada a partir do modulo principal e     *
      * 200-RTN-DETALHES. Executa quebra de dpto     *
      ************************************************
       400-QUEBRA-DEPT.
           PERFORM 300-QUEBRA-VEND
           MOVE WS-TOTAL-DEPT TO LD-TOTAL-DEPT
           WRITE REG-RELAT-OUT FROM LD-LINHA-DEPT
               AFTER ADVANCING 2 LINES
           IF MAIS-REGISTROS
               MOVE ZEROS TO WS-TOTAL-DEPT
               MOVE DEPT-IN TO WS-DEPT-ATUAL
               PERFORM 500-RTN-CABECALHO
           END-IF.

      *******************************************************
      * executada a partir do modulo principal e            *
      * 400-QUEBRA-DEPT. Imprime cabecalhos de relatiorios  *
      * apos avancar para a nova pagina                     *
      *******************************************************
       500-RTN-CABECALHO.
           ADD 1 TO WS-CONTA-PAG
           MOVE WS-CONTA-PAG TO LC-PAG
           MOVE WS-DEPT-ATUAL TO LC-DEPT
           WRITE REG-RELAT-OUT FROM LC-CABECALHO1
               AFTER ADVANCING PAGE
           WRITE REG-RELAT-OUT FROM LC-CABECALHO2
               AFTER ADVANCING 2 LINES
           WRITE REG-RELAT-OUT FROM LC-CABECALHO3
               AFTER ADVANCING 2 LINES.

      *******************************************************
      * executada a partir do modulo principal.             *
      * abre os arquivos e obtem a data atual do sistema    *
      * operacional.                                        *
      *******************************************************
       600-RTN-INICIALIZACAO.
           OPEN INPUT  ARQ-TRANS-IN
                OUTPUT ARQ-RELAT-OUT
           MOVE FUNCTION CURRENT-DATE TO WS-DATA
           MOVE WS-ANO TO LC-ANO
           MOVE WS-MES TO LC-MES
           MOVE WS-DIA TO LC-DIA.

      *******************************************************
      * executada a partir do modulo principal.             *
      * fecha os arquivos.                                  *
      *******************************************************
       700-RTN-FINALIZACAO.
           CLOSE ARQ-TRANS-IN ARQ-RELAT-OUT.
