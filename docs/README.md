# COBOL

# Capítulo 1

- Todo programa deve ser feito seguindo uma ordem:
    - Determinar especificações: Qual o problema? Qual a entrada? Qual a saída?
    - Projetar o programa: fluxograma; pseudocódigo; diagramas hierárquicos;
    - Codificação
    - Compilação: programas-fonte -> programa-objeto
    - Teste: depuração; erros de compilação; erros de execução;
    - Documentação
- Programas COBOL são bons para serem realizar tarefas em lote (batch processing) em estruturas de dados simples próprias para problemas comerciais. A linguagem é bastante usada em sistemas legados e, por isso, ainda requer especialistas na área.
- Programas em COBOL são divididos em 4 divisões:
    - `IDENTIFICATION DIVISION` → identifica o programa para o sistema operacional;
    - `ENVIRONMENT DIVISION` → define os nomes dos arquivos e descreve o equipamento computacional específico que será usado com o programa;
    - `DATA DIVISION` → descreve os formatos de entrada e saída a serem utilizados pelo
    programa. Ela define ainda quaisquer constantes e áreas de trabalho
    necessárias para o processamento dos dados;
    - `PROCEDURE DIVISION` → contém as instruções necessárias para a leitura e processamento dos dados de entrada e criação da saída;
- Variáveis no COBOL são declaradas da seguinte forma:

    <nível = 01> <nome da variável> PICTURE <formato>

por exemplo:

    05 NOME-EMPREGADO PICTURE X(20)
    05 HORAS-TRABALHADAS PICTURE 9(2)
    05 VALOR-HORA PICTURE 9V99

## Teste de final de capítulo

1. Todos os programas em COBOL consistem de 4 divisões chamadas `IDENTIFICATION`, `ENVIRONMENT`, `DATA` e `PROCEDURE DIVISION`. Elas devem aparecer nesta ordem.
2. A função da `IDENTIFICATION DIVISION` é informar o computador sobre o programa.
3. A função da `ENVIRONMENT DIVISION` é informar o programa sobre o computador. Deve conter quais os dispositivos de entrada e saída serão usados.
4. A função da `DATA DIVISION` é declarar todas as variáveis que serão utilizadas pelo programa.
5. A função da `PROCEDURE DIVISION` é descrever o algoritmo que manipulará os dados do problema.
6. Outro termo para os dados que são fornecidos ao computador é entrada e outro termo para as informações geradas pelo programa é saída.
7. HD e teclado são exemplos de mídias para fornecimento de dados de entrada ao computador.
8. Duas técnicas para simplificar o projeto de um programa COBOL e facilitar a depuração são chamadas pseudocódigo e teste de mesa.
9. Uma instrução `OPEN` indica quais arquivos são de entrada e quais são de saída.
10. Uma instrução `PERFORM ... UNTIL` execute de passos repetidamente até que uma determinada condição seja satisfeita.

# Capítulo 2

| Colunas | Uso | Explicação |
|---|---|---|
| 1-6 | Números em sequência ou números de páginas ou linhas | opcional |
| 7 | Continuação, comentário ou início de nova página | usado para indicar uma linha como comentário por meio de asterisco ou uma continuação por meio de um hífen |
| 8-11 | Área A | ... |
| 12-72 | Área B | ... |
| 73-80 | Identificação do programa | opcional |

- Existem dois tipos de entrada no COBOL. Divisões, seções e parágrafos devem começar na área A enquanto sentenças e instruções devem começar na área B. Sentenças terminam com um ponto, que deve sempre ser seguido de pelo menos um espaço; podem aparecer em linhas com ou sem outras entradas; e consiste de uma instrução ou em uma série de instruções.
- A `IDENTIFICATION DIVISION` é dividida em parágrafos e não em seções e serve para identificar o programa. Deve conter pelo menos o `PROGRAM-ID.` As duas primeiras entradas de um programa COBOL devem ser sempre como segue:

    IDENTIFICATION DIVISION.
    PROGRAM-ID. <nome-do-programa>.

- A `ENVIRONMENT DIVISION` é composta por duas seções: `CONFIGURATION` e `INPUT-OUTPUT SECTION`. A `CONFIGURATION SECTION` indica os `SOURCE-COMPUTER` e `OBJECT-COMPUTER`. Esta seção pode ser omitida em compiladores COBOL 85 e há formas de fazer o mesmo para o COBOL 74. A `INPUT-OUTPUT SECTION` pode conter um parágrafo chamado `FILE-CONTROL`, que consiste de instruções `SELECT` na área B seguindo o formato: `SELECT nome-do-arquivo ASSIGN TO <especificacao-do-dispositivo> [ORGANIZATION IS LINE-SEQUENTIAL].` Desta forma, pode-se ter acesso a arquivos e dispositivos externos. A especificação do dispositivo depende do equipamento e é responsabilidade dos técnicos de TI da empresa.

    ENVIRONMENT DIVISION.
    INPUT-OUTPUT SECTION.
    FILE-CONTROL.
    SELECT ARQUIVO-TRANSACOES ASSIGN TO DISK 'DADOS1.DAT'
    SELECT ARQUIVO-RELATORIO ASSIGN TO PRINTER.

# Capítulo 3

- Normalmente os programas não são escritos como entidades independentes. Em vez disso, eles são parte de um conjunto global de procedimentos chamado sistema comercial computadorizado de informações. Cada programa, então, é na realidade uma parte de um sistema de informações. Neste sentido, programas podem ser interativos (processam os dados assim que entram) ou para lotes (processam os dados de uma vez quando eles já estiverem prontos). O COBOL foi feito, a princípio, para processamento em lotes, mas pode aceitar interações. Isso implica que programas COBOL, em geral, leem uma linha de um arquivo de entrada e escrevem uma linha de um arquivo de saída por vez.
- A `DATA DIVISION` de um programa COBOL define e descreve o armazenamento de campos, registros e arquivos. Ela possui duas seções: `FILE` (define e descreve todos os arquivos de entrada e de saída, podendo guardar campos de registros em variáveis específicas); e `WORKING-STORAGE` (declaração de variáveis que não estarão presentes em nenhum dos arquivos) `SECTION`. Cada arquivo declarado na `INPUT-OUTPUT SECTION` da `ENVIRONMENT DIVISION` deve ter uma cláusula `FD` na `FILE SECTION` descrevendo a estrutura do arquivo. Podemos ter um `LABEL` para cada registro; a especificação do uso de blocos por meio de `BLOCK CONTAINS <n> RECORDS`; e a especificação do tamanho de cada registro por meio de `RECORD CONTAINS <inteiro> CHARACTERS.`
- Um registro é uma unidade de informação que consiste em itens de dados relacionados entre si dentro de um arquivo. Muito frequentemente, um arquivo é composto de registros que possuem o mesmo comprimento e formato (os chamados *fixed-length records*). A definição de um registro em COBOL permite o uso de vários níveis numerados (começando pelo 01 e geralmente incrementando de 5 em 5 para para níveis para específicos) a partir do `FD`. Cada campo em um registro pode ser descrito por uma `PICTURE` com o tipo dos dados.
- As variáveis em COBOL podem ser de 3 tipos: alfabéticos (`A`), alfanuméricos (`X`) ou numéricos (`9`). Números podem ser lidos com um separador decimal implícito (`v`) e podem ser negativos (`S`).

    DATA DIVISION.
    FILE SECTION.
    FD ARQ-VENDAS LABEL RECORDS ARE STANDARD.
    01 REG-VENDAS.
        05 NOME-IN          PICTURE X(15).
        05 QUANT-VENDAS-IN  PICTURE 999V99.
    FD ARQ-IMP LABEL RECORDS ARE OMITTED.
    01 REG-PRINT.
        05                    PICTURE X(20).
        05 NOME-OUT           PICTURE X(15).
        05                    PICTURE X(20).
        05 VALOR-COMISSAO-OUT PICTURE 99.99.
        05                    PICTURE X(72).
    WORKING-STORAGE SECTION.
    01 EXISTEM-MAIS-REGISTROS PICTURE XXX VALUE 'SIM'.

# Capítulo 4

- A `PROCEDURE DIVISION` é a parte do nosso código que conterá todas as instruções para o nosso programa manipular os dados declarados na `DATA DIVISION`, e é composta por parágrafos (na área A) com instruções (na área B). Dois parágrafos não podem ter o mesmo nome. Todas as instruções começam com algum verbo ou com um condicional. O primeiro parágrafo é o primeiro a ser executado e o programa só para ao executar uma instrução `STOP RUN.`. Por este motivo, o COBOL promove uma estruturação Top-Down para o código.
- O módulo principal quase sempre consiste de um loop para ler todas as linhas de um arquivo e gerar uma saída:

    PROCEDURE-DIVISION.
    100-MODULO-PRINCIPAL.
        OPEN INPUT ARQUIVO-INVENTARIO
             OUTPUT ARQUIVO-PAGAMENTO
        PERFORM UNTIL EXISTEM-MAIS-REGISTROS = 'NAO'
            READ ARQUIVO-INVENTARIO
                AT END
                    MOVE 'NAO' TO EXISTEM-MAIS-REGISTROS
                NOT AT END
                    PERFORM 200-ROTINA-PROCESSAMENTO
        END-PERFORM
        CLOSE ARQUIVO-INVENTARIO
              ARQUIVO-PAGAMENTO
        STOP RUN.
    200-ROTINA-PROCESSAMENTO.
        ...

- No caso do COBOL 74, o mesmo trecho de código precisa ser estruturado de uma forma ligeiramente diferente, já que ele não dá suporte para programação estruturada:

    PROCEDURE-DIVISION.
    100-MODULO-PRINCIPAL.
        OPEN INPUT ARQUIVO-INVENTARIO.
        OPEN OUTPUT ARQUIVO-PAGAMENTO.
        READ ARQUIVO-INVENTARIO
            AT END MOVE 'NAO' TO EXISTEM-MAIS-REGISTROS.
        PERFORM 200-ROTINA-PROCESSAMENTO 
            UNTIL EXISTEM-REGISTROS = 'NAO'.
        CLOSE ARQUIVO-INVENTARIO.
        CLOSE ARQUIVO-PAGAMENTO.
        STOP RUN.
    200-ROTINA-PROCESSAMENTO.
        ...
        READ ARQUIVO-INVENTARIO
            AT END MOVE 'NAO' TO EXISTEM-MAIS-REGISTROS.

- O COBOL conta com alguns comandos lógico-aritméticos:

    ADD x TO y [GIVING z]
    SUBTRACT x TO y [GIVING z]
    MULTIPLY x TO y [GIVING z]
    DIVIDE x TO y [GIVING z]
    
    IF x = y [ou x > y ou x < y] 
        ...
    ELSE
        ...
    END-IF

# Capítulo 6

- Quando definimos o tipo de uma variável por meio de uma PICTURE no COBOL, podemos ver duas situações ao tentar tirar ou colocar um valor lá dentro. Vamos pensar que vamos atribuir um valor a um variável qualquer: se as PIC forem iguais, então a atribuição direta. Caso contrário, haverá conversão de valores. Campos alfanuméricos podem ser truncados ou preenchidos com espaços dependendo da necessidade, sendo sempre lidos da esquerda para a direita. Campos numéricos são tratados em duas partes. A parte inteira será truncada ou preenchida com 0 (lidos da direita para a esquerda), assim como a parte decimal (da esquerda para a direita).
- Propriedades internas de registros podem ser acessadas por meio da palavra OF:

     01 SOBRE-PAI
         05 ESTADO-CIVIL
         05 SEXO
     01 SOBRE-FILHO
        05 SEXO
    * possível atribuição para campos de mesmo nome
     MOVE SEXO OF SOBRE-PAI TO SEXO OF SOBRE-FILHO

- Alguns símbolos podem ser usados para formatar campos de saída: `Z` para preencher zeros à esquerda em números ou `*` para proteções de cheque; `B` para espaços em números e alfanuméricos. Formatações podem conter `/`, `$`, e outros alfanuméricos para complementar o embelezamento de uma saída. Algumas saídas podem ser suprimidas dizendo que uma `PICTURE` é `BLANK WHEN ZERO`. Podemos justificar partes do texto com `JUSTIFIED RIGHT` que serão escritas com a borda direita no canto direito.
- Podemos utilizar a tela do computador para interagir com o usuário por meio de entradas e saídas. Podemos escrever texto na tela com `DISPLAY` e pedir entradas por meio de `ACCEPT`, que aceita inclusive entradas diversas como `DATE` para poder receber uma *string* com o dia atual no formato "YYMMDD". Podemos utilizar também uma seção chamada `SCREEN SECTION` na `DATA DIVISION` para poder descrever interações na tela com o usuário.

# Capítulo 7

- Para calcular equações em uma única linha, podemos usar o comando `COMPUTE` e usar as operações aritméticas `+ - * / **` . Desta forma, o código fica mais simples para operações complexas.
- Podemos tornar variáveis numéricas mais esficientes especificando o fim que queremos dá-las por meio do comando `USAGE`, que permite dizer se é para cáculo ou para display
- Algumas operações mais comuns podem ser invocadas implicitamente utilizando a *keyword* `FUNCTION` seguida de alguma das funções implícitas do COBOL e o seu argumento. A página 245 do PDF contém algumas destas funções e incluem `SORT`; `CURRENT-DATE`; `MIN`; `MAX`; `MEAN;` algumas funções trigonométricas e  financeiras; e operações com *strings*.

# Capítulo 8

     IF A > B 
    * or < > = <= >= AND OR
     THEN
         DISPLAY 'A IS GREATER THAN B'
     ELSE
         DISPLAY 'B IS AT LEAST A'
    * NEXT SENTENCE se o else for vazio.
    * não existe ELSE-IF ou algo assim
     END-IF
    * este END-IF pode ser substituido por um ponto final.

    * testes de sinal e de classe
     X IS [NOT] POSITIVE
     X IS NUMERIC
     X IS ALFABETIC
     X IS ALFABETIC-UPPER
     X IS ALFABETIC-LOWER

- O nível 88 é reservado a constantes que podem ser utilizadas em um determinado registro e não possuem `PICTURE`, somente `VALUE`.

    EVALUATE ANOS-FACULDADE-IN
        WHEN 1
            PERFORM RTN-CALOURO
        WHEN 2
            PERFORM RTN-SEG-ANO
        WHEN 3
            PERFORM RTN-TER-ANO
        WHEN 4
            PERFORM RTN-VETERANO
        WHEN OTHER
            PERFORM RTN-ERROR
    END-EVALUATE

# Capítulo 9

- `EXIT` no COBOL = `pass` no Python.
- Um loop `PERFORM` pode ser utilizado um número específico de vezes também utilizando `PERFORM [nome-do-paragrafo] [int-1|id1] TIMES`. Mais compacto do que utilizar um contador (que é utilizado com `PERFORM [para] VARYING [i] FROM [start] BY [inc]`)! Podemos ter vários loops `PERFORM` dentro de outros loops. Para indicar quando o teste da condição de parada de um loop , use `PERFORM [para] [WITH TEST (BEFORE|AFTER)] UNTIL [cond]`.

# Capítulo 10

    * Exemplo de rotina de interrupção de controle.
    * Funciona somente se o arquivo estiver coms os grupos
    * internos ordenados.
    NO-MORE-LINES := 'N'
    FIRST-REGISTER := 'Y'
    
    PERFORM UNTIL NO-MORE-LINES = 'Y'
        READ REGISTER
        IF FIRST-REGISTER = 'Y'
            * setup for first situation
            MOVE 'N' TO FIRST-REGISTER
        END-IF
        IF *situation changed*
            PERFORM CONTROL-INTERRUPTION
        END-IF
    END-PERFORM

- Bonus search: COBOL tables:

    IDENTIFICATION DIVISION.
    PROGRAM-ID. HELLO.
    
    DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TABLE.
          05 WS-A OCCURS 3 TIMES.
             10 WS-B PIC A(2).
             10 WS-C OCCURS 2 TIMES.
                15 WS-D PIC X(3).
    
    PROCEDURE DIVISION.
       MOVE '12ABCDEF34GHIJKL56MNOPQR' TO WS-TABLE.
       DISPLAY 'WS-TABLE  : ' WS-TABLE.
       DISPLAY 'WS-A(1)   : ' WS-A(1).
       DISPLAY 'WS-C(1,1) : ' WS-C(1,1).
       DISPLAY 'WS-C(1,2) : ' WS-C(1,2).
       DISPLAY 'WS-A(2)   : ' WS-A(2).
       DISPLAY 'WS-C(2,1) : ' WS-C(2,1).
       DISPLAY 'WS-C(2,2) : ' WS-C(2,2).
       DISPLAY 'WS-A(3)   : ' WS-A(3).
       DISPLAY 'WS-C(3,1) : ' WS-C(3,1).
       DISPLAY 'WS-C(3,2) : ' WS-C(3,2).
       STOP RUN.
    
    END-PROGRAM HELLO.

# Capítulo 11

> Se é possível algo sair errado, *sairá*.

- A instrução `INSPECT` pode ser usada para validar strings. Em seu primeiro formato, ela pode ser usada para contar quantas vezes um determinado caractere aparece, como indicado a seguir:

    INSPECT item TALLYING ctr FOR ALL SPACES
    INSPECT item TALLYING ctr
    						 FOR CHARACTERS 
                 BEFORE INITIAL SPACE
    INSPECT item TALLYING ctr FOR LEADING ZEROS
    ***************************************************
    INSPECT DATA-IN REPLACING ALL '-' BY '/'
    INSPECT NRSS REPLACING ALL SPACES BY '-'
    INSPECT ITEM REPLACING CHARACTERS BY '3' 
                 BEFORE INITIAL '2'
    ***************************************************
    01 ALFA-MINUS PIC X(26)
        VALUE 'abcdefghijlkmnopqrstuvwyz'
    01 ALFA-MAIUS PIC X(26)
        VALUE 'ABCDEFGHIJLKMNOPQRSTUVWYZ'
    INSPECT CAMPO CONVERTING ALFA-MINUS TO ALFA-MAIUS
    

# Capítulo 12

A cláusula `OCCURS` é usada no COBOL para declarar *arrays*, isto é, campos do mesmo formato com **ocorrência** repetida. `05 TEMPERATURA OCCURS 24 TIMES PIC S9(3)` é um exemplo de declaração de array. Para acessar dados de um array, usamos um subscrito iniciando em 1: `MOVE TEMPERATURA(2) TO TEMP-OUT` ou `DISPLAY TEMPERATURA(23)` , por exemplo. Não há alocação dinâmica de memória em COBOL, então todos os arrays devem ser declaradas de tal forma a conter toda a informação que o programador considerar necessária.

    * em COBOL, uma tabela é um array de registros
    01 TABELA-IMPOSTOS-VENDAS
    		05 ENTRADAS-TABELA OCCURS 1000 TIMES INDEXED BY X1.
    				10 WS-CODPOSTAL PIC 9(5).
    				10 WS-TAXA-IMP PIC X999.
    *******************************************************
    SET X1 TO 1
    SEARCH ENTRADAS-TABELA
    		AT END MOVE 0 TO WS-IMP-VENDAS
    		WHEN CEP-IN = WS-CODPOSTAL(X1)
    				COMPUTE WS-IMP-VENDAS ROUNDED = WS-TAXA-IMP(X1) * PRECO-UNIT-IN * QTD-IN
    END-SEARCH

    * a instrucao SEARCH pode ser usada para procurar dados em uma tabela de forma serial
    SEARCH id-1 
    	[AT END [instrucao-2]]
    	WHEN cond-1 (instrucao-2|NEXT SENTENCE|CONTINUE)...
    END-SEARCH
    * Se for usado o END-SEARCH, NEXT SENTENCE deve ser substituido por CONTINUE.

    * a instrucao SEARCH ALL realiza uma busca binária na tabela
    SEARCH ALL id-1
    		[AT END instrucao-1]
      	WHEN cond-1
    	 		   [AND cond-2]...
    		(instrucao|NEXT SENTENCE|CONTINUE)
    END-SEARCH
    
    * Pode ser usada com um campo chave para indicar qual 
    01 TABELA-1.
    		05 TABELA-DESCONTO OCCURS 50 TIMES
    											 ASCENDING KEY T-NR-CLIENTE
    											 INDEXED BY X1.
    				10 T-NR-CLIENTE PIC 9(4).
    				10 T-PERCENT-DESCONTO PIC v999.

    01 ARRAY-TEMPERATURA
    		05 DIA-SEMANA OCCURS 7 TIMES
    				10 HORA   OCCURS 24 TIMES
    						15 TEMP PIC S9(3).
    *****************************************************************
    PERFORM 700-LOOP-1
    		VARYING SUB-DIA FROM 1 BY 1 UNTIL SUB-DIA > 7
    		AFTER SUB-HORA FROM 1 BY 1 UNTIL SUB-HORA > 24
    
    ...
    
    700-LOOP-1.
    		DISPLAY 'TEMPERATURA DE QUARTA-FEIRA AO MEIO DIA: ', TEMP(SUB-DIA,SUB-HORA)

# Capítulo 13

- Rotina de processamento de arquivos sequenciais:
    - Criação do arquivo-mestre (realiza-se uma única vez)
    - Criação do arquivo de transações
    - Atualização do arquivo-mestre
    - Geração de relatórios
- O algoritmo de linha balanceada é uma técnica que permite atualizar um arquivo-mestre com registros sequenciais com qualquer número de transações e ainda verifica várias condições de erro. Este algoritmo é muito útil para comparar dois arquivos também.
- Arquivos no COBOL podem ser reescritos se o abrirmos como `I-O` em vez de `INPUT` e utilizar as instruções `REWRITE` para reescrever o registro lido da memória; `EXTEND` para adicionar; 