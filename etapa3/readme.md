/* kmeans_mpi.c
   Compilar: mpicc -O2 kmeans_mpi.c -o kmeans_mpi -lm
   Rodar:    mpirun -np 4 ./kmeans_mpi dados.csv centroides_iniciais.csv
*/

Primeiramente é necessário rodar o código que gera os dados de teste

gerar_dados.c

gcc gerar_dados.c -o gerar_dados
./gerar_dados
