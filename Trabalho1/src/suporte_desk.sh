#!/bin/bash

# Criar um named piped
if [ -z "$1" ]; then
    echo "1 argumento vazio, a criar pipe com o nome /tmp/suporte"
    nomeDoPipe="/tmp/suporte"
else
    nomeDoPipe=$1
fi

if [ -p $nomeDoPipe ]; then
    echo "Ja existe o named pipe"
else
    echo "Criar named pipe"
    mkfifo $nomeDoPipe
    codigoDeSaida=$?;

    if [ $codigoDeSaida -eq 0 ]; then
        echo "Pipe criado com sucesso"
    else
        echo "Erro a criar o pipe"
        exit 1
    fi
fi




# Por suporte_agente em backGround
echo "A por o script suporte_agente em background"
chmod +x suporte_agente.sh
./suporte_agente.sh $nomeDoPipe &




# Por students em backGround
if [ -z "$2" ]; then
    echo "2 argumento vazio, a ser posto em backGround 3 students.c"
    numeroStudents=3
else
    numeroStudents=$2
fi

echo "A por o programa student em background"
gcc student.c
for c in $(seq 1 $numeroStudents); do
    ./a.out $nomeDoPipe "estudante $c" &
    echo "$c processo criado em back ground" 
    sleep 1
done




# Mandar texto para o named pipe
echo "A enviar texto para o named pipe"
sleep 1
echo "quit" > $nomeDoPipe




# Esperar que os processos em Back ground acabem
echo "A espera que os processos em backGround terminem"
wait




# Remover o namedPipe
rm $nomeDoPipe
echo "Encerrar suporte_desk"
exit 0