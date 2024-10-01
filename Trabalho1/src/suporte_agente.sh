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
        sleep 1
    done
fi




# Ler mensagens
echo "Suporte_agente: A ler mensagens"
while read message; do

    if [ "$message" = "quit" ]; then
        echo "Suporte_agente: Encerrar"
        break
    fi

    echo "Suporte_agente: Mensagem recebida $message"

    echo "Suporte_agente: Espera aleatoria"
    sleep $((RANDOM % 5 + 1))

done < "$1"