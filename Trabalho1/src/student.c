#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int main(int argc, char *argv[])
{
    //Verefica o argumento
    if(argc != 3){
        printf("Student: O numero de argumentos dados é o errado\n");
        return 1;
    }


    // Abre o named pipe para leitura e escrita
    int fd = open(argv[1], O_WRONLY);
    if(fd == -1){
        perror("Student: Erro ao abrir o pipe");
        return 1;
    }


    //Escrever no named pipe
    char *mensagem = argv[2];

    if (write(fd, mensagem, strlen(mensagem) + 1) == -1) {
        perror("Student: Erro ao escrever no pipe");
        close(fd);
        return 1;
    }

    close(fd);
    return 0;
}