#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <fcntl.h>

#define PORT 12345
#define NBUFF 100

int main() {
	int s;
	struct sockaddr_in server, client;
	int c, l = sizeof(client);

	s = socket(AF_INET, SOCK_STREAM, 0);
	if (s < 0) {
		printf("ERR Socket Creation\n");
		return 1;
	}

	memset(&server, 0, sizeof(server));
	server.sin_port = htons(PORT);
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;

	if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) {
		printf("ERR Socket Bind\n");
		return 1;
	}
	listen(s, 5);
	
	while(1) {
	   	c = accept(s, (struct sockaddr *) &client, &l);
		printf("Client Connected.\n");
	    
		FILE *fp;
		fp = fopen("recv", "ab+"); // binary append 
		if(NULL == fp) {
			printf("ERR Opening File");
			return 1;
		}

	    char buffer[NBUFF];
		memset(&buffer, 0, sizeof(buffer));   
		int bytes_recv = 0;
		
		// while receiva bytes
		while((bytes_recv = read(c, buffer, sizeof(buffer))) > 0) {
			printf("bytes received: %d\n",bytes_recv);
			// write to file
			int bytes_write = fwrite(buffer,sizeof(char),sizeof(buffer),fp);
		}
		if(bytes_recv < 0) {
			printf("ERR Read \n");
		}
		fclose(fp);
	}
	close(c);
}

