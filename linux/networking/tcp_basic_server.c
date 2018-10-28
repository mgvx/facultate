#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
 
#define PORT 12345

int main() {
	int s;
	struct sockaddr_in server, client;
	int c, l = sizeof(client);

	s = socket(AF_INET, SOCK_STREAM, 0);
	if (s < 0) {
		printf("ERR Server Socket Creation\n");
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
	memset(&client, 0, sizeof(client));

	while (1) {
		int x, dx;
		c = accept(s, (struct sockaddr *) &client, &l);
		if(c == -1) {
			printf("ERR Accept Connection\n");
			continue;
		}
		
		printf("Client Connected\n");

		recv(c, &x, sizeof(x), MSG_WAITALL);
		x = ntohs(x);
		dx = x*x;
		dx = htons(dx);
		send(c, &dx, sizeof(dx), 0);
		
		printf("Done\n");
		close(c);
	}
}
