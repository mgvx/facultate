#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
 
#define PORT 12345

int main() {
	int c;
	struct sockaddr_in server;
	
	c = socket(AF_INET, SOCK_STREAM, 0);
	if (c < 0) {
		printf("ERR Client Socket Creation\n");
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
	
	int x, dx;
	printf("x = ");
	scanf("%d", &x);
	x = htons(x);
	send(c, &x, sizeof(x), 0);
	
	recv(c, &dx, sizeof(dx), 0);
	dx = ntohs(dx);
	printf("Received: %d\n", dx);
	
	close(c);
}
 
 