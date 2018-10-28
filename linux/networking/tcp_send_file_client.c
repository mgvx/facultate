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
	int c;
	struct sockaddr_in server;

	c = socket(AF_INET, SOCK_STREAM, 0);
	if (c < 0) {
		printf("ERR Socket Creation\n");
		return 1;
	}

	memset(&server, 0, sizeof(server));
	server.sin_port = htons(PORT);
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = inet_addr("127.0.0.1");

	if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
		printf("ERR Server Connection\n");
		return 1;
	}
 	
 	FILE *pf;
	pf = fopen("send", "rb"); // binary read 
	if (pf == NULL) {
		printf("ERR File Not Found\n");
		return 1;
	}

	char buffer[NBUFF];
    memset(&buffer, 0, sizeof(buffer));
	int bytes_read = 0;
	
	// while read from file
	while((bytes_read = fread(buffer,sizeof(char),sizeof(buffer),pf)) > 0) {
		void *buff = buffer;
		
		while (bytes_read > 0) {
			// send bytes
			int bytes_write = write(c, buff, bytes_read);
			printf("bytes sent: %d\n",bytes_read);
			if (bytes_write <= 0) {
				error("ERR Writing to Socket\n");
			}
			bytes_read -= bytes_write;
			buff += bytes_write;
		}
	}
	if (bytes_read < 0) {
		error("ERR Reading File"); 
	}
	fclose(pf);
	close(c);
}
