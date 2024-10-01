#!/bin/bash

# Verficar argumentos
if [ -z "$1" ]; then
    echo "Suporte_desk: 1 argumento vazio, a criar pipe com o nome /tmp/suporte"
    nomeDoPipe="/tmp/suporte"
else
    nomeDoPipe=$1
fi

if [ -z "$2" ]; then
    echo "Suporte_desk: 2 argumento vazio, a ser posto em backGround 3 students.c"
    numeroStudents=3
else
    numeroStudents=$2
fi




# Criar um named piped
if [ -p $nomeDoPipe ]; then
    echo "Suporte_desk: Ja existe o named pipe"
else
    echo "Suporte_desk: Criar named pipe"
    mkfifo $nomeDoPipe
    codigoDeSaida=$?;

    if [ $codigoDeSaida -eq 0 ]; then
        echo "Suporte_desk: Pipe criado com sucesso"
    else
        echo "Suporte_desk: Erro a criar o pipe"
        exit 1
    fi
fi




# Por students em backGround
echo "Suporte_desk: A por o programa student em background"
gcc student.c
for c in $(seq 1 $numeroStudents); do
    ./a.out $nomeDoPipe "Estudante $c"$'\n' &
done




# Por suporte_agente em backGround
echo "Suporte_desk: A por o script suporte_agente em background"
chmod +x suporte_agente.sh
./suporte_agente.sh $nomeDoPipe &




# Mandar texto para o named pipe
echo "Suporte_desk: A encerrar suporte_agente"
sleep 1
echo "quit" > $nomeDoPipe




# Esperar que os processos em Back ground acabem
echo "Suporte_desk: A espera que os processos em backGround terminem"
wait




# Remover o namedPipe
rm $nomeDoPipe
exit 0