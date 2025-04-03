#include<stdio.h>
#include<stdlib.h>
#include <sys/stat.h>
#include <errno.h>

int main(int argc,char* args[]){
    char buffer[255];
    struct stat statStruct;
    if(argc!=2){
        fprintf(stderr,"Wrong argument!\nUsage: sendPubKey <path-to-pub-key>\n");
        return 1;
    }
    if (stat(args[1], &statStruct) != 0){
        fprintf(stderr,"Public key file does not exist!\n");
        return 1;
    }
    sprintf(buffer,"echo -n \"Raphael is a spy! \" | openssl pkeyutl -encrypt -inkey %s -pubin -out \"$GSH_HOME/Castle/Main_building/Mail_box/top_secret.enc\"",args[1]);
    if(system(buffer)!=0){
        fprintf(stderr,"Decryption failed!\n");
        return 1;
    }
    printf("A new letter is received in the Mail_Box!\n");
    return 0;
}