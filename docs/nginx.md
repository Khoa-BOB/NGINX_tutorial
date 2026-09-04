# What is NGINX?

- A web server refers to both the physical machine and software running on the machine
- Primary function is to serve web pages to client browser's

NGINX is a **high performance we server**

- NGINX as Load Balancer
    + Distributes incoming traffic across multiple backend servers
    + To balance the load, improve performance and provide redundancy

"Proxy" = General term meaning acting on the behalf of another
"Proxy server" = intermediary server that forwards client requests to other servers

Some Load Balancing Mehthods include:
- Least Connections: Routes traffic to the server with the fewest active connections
- Round Robin: Distributes client requests in a sequqential, cyclical manner to each server in the group

Caching:
- Cach response from backend server for frequently accessed resources
- Copies are stored temporarily to improve the performance

One entrypoint:
- problem: exposing all servers to the public internet
- Solve: Only one server that is publicly available:
    + Consolidate security
    + centralize access control
    + Minimized exposure
    + Centralized logging and monitoring

Security:
- NGINX can handle SSL/TLS encryption and decryption
- Attacker cannot intercept
- NGINX forwards the encrypted message, Webserver decrypted itself
- Enforce HTTPS

NGINX Proxy can:
- Compress: reduce the bandwidth usage and improve load time
- Segmentation: Breaks the file into smaller chunks (video streaming)

nginx.config