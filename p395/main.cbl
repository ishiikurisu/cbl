       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXERCICIO-DE-DEPURACAO.

       DATA DIVISION.
       FILE SECTION.
       01 REG-IN.
           05 NR-CONTA     PIC X(5).
           05 SALARIO      PIC 9(4).
           05 VLR2         PIC 9(3).
           05 COD-STATUS   PIC 9.

       PROCEDURE DIVISION.
       100-MODULO-PRINCIPAL.
           OPEN INPUT  ARQ-TRANS
                OUTPUT ARQ-IMP
           PERFORM UNTIL EXISTEM-MAIS-REGISTROS = 'NAO'
               READ ARQ-TRANS
                   AT END
                       MOVE 'NAO' TO EXISTEM-MAIS-REGISTROS
                   NOT AT END
                       PERFORM 200-TESTA-EDICAO
           END-PERFORM
           PERFORM 600-IMPRIME-TOTAIS
           CLOSE ARQ-TRANS ARQ-IMP
           STOP RUN.

       200-TESTA-EDICAO.
           IF SALARIO IS NOT > 5000 OR < 98000
               PERFORM 300-ERRO-SALARIO
           END-IF
           IF VLR2 IS NEGATIVE
               PERFORM 400-ERRO-VLR2
           END-IF
           IF COD-STATUS > 5 AND SALARIO NOT < 86000
               PERFORM 500-ERRO-STATUS
           END-IF

           IF CHAVE-ERROS = 0
               WRITE REG-IMP FROM REG-OK
           ELSE
               WRITE REG-IMP FROM REG-ERRO
           END-IF

           ADD 1 TO CONTAGEM-REGISTROS.

       END PROGRAM EXERCICIO-DE-DEPURACAO.
