#!/bin/bash

# Verficar se o named pipe existe
if [ -z $1 ]; then
    echo "Suporte_agente: Nao existe argumento"
    exit 1
fi


if [ -p $1 ]; then
    echo "Suporte_agente: Pipe existe"
else
    while [ ! -p $1 ]; do
        echo "Suporte_agente: Pipe ainda nao existe"
        sleep $((RANDOM % 5 + 1))
    done
fi




# Verficar a mensagem do named pipe
echo "Suporte_agente: A ler mensagens"
while true; do
    read mensagem < $1
    if [ "$mensagem" = "quit" ]; then
        echo "Suporte_agente: A encerrar"
        exit 0
    fi
    echo "Suporte_agente: Mensagem recebida $mensagem"
    sleep 1
done