#!/bin/bash

# --- Configurações ---
SRC_FILE="kmeans_1d_naive.c"
EXEC_FILE="kmeans_1d_naive"
ARGS="dados.csv centroides_iniciais.csv 50 0.000001 assign.csv centroids.csv"
THREADS_TO_TEST="2 4 8 16 32"

# --- Compilação ---
echo "⚙️  Compilando o código..."
gcc -O2 -std=c99 -fopenmp "$SRC_FILE" -o "$EXEC_FILE" -lm

if [ $? -ne 0 ]; then
    echo "❌ Erro na compilação. Abortando."
    exit 1
fi
echo "✅ Compilação concluída com sucesso."
echo ""

# --- Medição do Tempo Base (Serial) ---
echo "⏳ Medindo o tempo base com 1 thread..."
# CORREÇÃO AQUI: Trocado $8 por $9 para pegar o número correto
TIME_SERIAL=$(OMP_NUM_THREADS=1 ./"$EXEC_FILE" $ARGS | grep 'Tempo:' | awk '{print $9}')

if [ -z "$TIME_SERIAL" ]; then
    echo "❌ Não foi possível extrair o tempo de execução serial."
    exit 1
fi
echo "✅ Tempo base (serial): ${TIME_SERIAL} ms"
echo "----------------------------------------"

# --- Laço de Testes Paralelos ---
for T in $THREADS_TO_TEST; do
    echo "🚀 Executando com ${T} threads..."
    # CORREÇÃO AQUI: Trocado $8 por $9 para pegar o número correto
    TIME_PARALLEL=$(OMP_NUM_THREADS=$T ./"$EXEC_FILE" $ARGS | grep 'Tempo:' | awk '{print $9}')
    
    if [ -z "$TIME_PARALLEL" ]; then
        echo "⚠️  Não foi possível extrair o tempo para ${T} threads."
        continue
    fi

    SPEEDUP=$(echo "scale=4; $TIME_SERIAL / $TIME_PARALLEL" | bc)
    
    echo "   -> Tempo Paralelo: ${TIME_PARALLEL} ms"
    echo "   -> Speedup: ${SPEEDUP}x"
    echo "----------------------------------------"
done

echo "🏁 Testes finalizados."
