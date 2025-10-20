Para executar o código, primeiramente é necessário executar o arquivo gerar_dados.c

para editar a o tamanho da base de dados, o número de centróides e outras informações relacionadas aos dados é necessário modificar o código:

    int n_dados = 1000000;      // quantidade de pontos
    int n_centroides = 18;    // quantidade de centróides
    double min = 0.0, max = 1000000000;

em seguida é só executar o scrip run_tests.sh

      chmod +x run_tests.sh
      ./run_tests.sh
executando esses comandos no terminal

como no arquivo há 3 versões distintas do código, nomeadas de acordo com atributo sequencial {x}: kmeans_1d_naive_x.c

para executar as demais versões, é necessário modificar o trecho abaixo do script:

    SRC_FILE="kmeans_1d_naive_3.c"
    EXEC_FILE="kmeans_1d_naive_3"
    ARGS="dados.csv centroides_iniciais.csv 50 0.000001 assign.csv centroids.csv"
    THREADS_TO_TEST="2 4 8 16 32"
no caso é só substituir o 3 por 2 ou apagar o 3 e o _ pra rodar a versão original



