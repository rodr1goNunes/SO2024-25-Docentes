#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{
    //Verefica o argumento
    if(argc != 3){
        printf("O numero de argumentos dados é o errado\n");
        return 1;
    }


    //Abre o named pipe para leitura e escrita
    int operacaoAbrir = open(argv[1], O_WRONLY);
    if(operacaoAbrir == -1){
        perror("Erro ao abrir o pipe");
        return 1;
    }


    //Escrever no named pipe
    const char *mensagem = argv[2];

    if (write(operacaoAbrir, mensagem, sizeof(mensagem)) == -1) {
        perror("Erro ao escrever no pipe");
        close(operacaoAbrir);
        return 1;
    }
    printf("Mensagem enviada: %s\n", mensagem);

    close(operacaoAbrir);
    return 0;
}