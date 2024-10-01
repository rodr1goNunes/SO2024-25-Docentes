#!/bin/bash

#Verficar se o named pipe existe
if [ -z $1 ]; then
    echo "Nao existe argumento"
    exit 1
fi


if [ -p $1 ]; then
    echo "Pipe existe"
else
    while [ ! -p $1 ]; do
        echo "Pipe ainda nao existe"
        sleep $((RANDOM % 5 + 1))
    done
fi




#Verficar a mensagem do named pipe
while true; do
    if read mensagem < "$1"; then
        if [ "$mensagem" = "quit" ]; then
            echo "Encerrar"
            exit 0
        fi
        echo "A mensagem recebida foi: $mensagem"
        sleep 1
    fi
done
