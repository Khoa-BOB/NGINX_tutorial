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


worker_process: 
- controls how many parallel process Nginx spawns to handle client requests
- instead of using a new process for every incoming connection, Nginx uses worker processes that handle many connections using a single-threaded event loop

What does the number represent?
- The value is the number of worker processes Nginx should create
- Each worker process run independently and can hanle its own set of connections

This configuration directly influeneces how well it can handle traffic (perf)
- should be tuned according to the server's hardware (CPU cores) and expected traffic load 


```nginx
worker_processes 1;

events {
    worker_connections 1024; #The higher number the more memory usage
                             # The actual simultaneous connections cannot exceed
                             # the current limit on the max number of open files
    
    http { # Configuration specific to HTTP and affecting all virtual servers

        upstream nodejs_cluster{ # define the upstram
            server 127.0.0.1:3000;
            server 127.0.0.1:3001;
            server 127.0.0.1:3002;
        }

        server{
            listen 8080;
            server_name localhost;

            location / {
                proxy_pass http://nodejs_cluster;
            }


        }

    }
}
```

server block: defines how Nginx should handle requests for a particular domain or IP address

server_name: which domain or IP address this server block should response to

location: the root (/) URL, will apply to all requests unless more specific location blocks are defined

proxy_pass: tells Nginx to "pass" the request to another server, making it act as a reverse proxy

upstream block:
+ Refers to servers that Nginx forward requests to
+ "upstream" name is based on the flow of data
+ Upstream servers = Refers to traffic going from a client toward the source or higer-level infra, in this case application server
+ Downstream servers = traffic going to the client is "downstream"

We want to forward into from the original client requests to the backend servers. They provide useful information, which backend servers can use for logging or processing etc.
+ Original IP address
+ Original Host
+ Referrer Information
+ Custom Headers

When Nginx acts as a reverse proxy, the requests coming to the backend servers originate from Nginx, not directly from the client. As a result, backend servers would see the IP address of the Nginx server as the source of the request.

We need to tell Nginx to include the correspongind MIME types in the "content-type" response header, when sending a file. This helps the client understand how to process or render the file.


How does Nginx decide to which server to forward the request to?


Directives: the actual instructions or commands that tell Nginx what to do
Contexts: groups of related directives that apply to a certain type of configuration

You will ONLY open port 8080 or which ever port Nginx listens to
All other ports will NOT be publicly accessible

Configure HTTPS - Encrypted Commnucation
- HTTPS uses SSL to encrypt the data transmitted over the web
- All communication between the client and server is encrypted
- Malcious cannt interrupt the transmission

1. Obtain an SSL/TLS Certificate
+ SSL cert. enable encryption by using public-key cruptography
+ When a user connects to a website via HTTPs, the web server provides its SSL certificate, which contains a public key
+ The client (browser) uses this key to establish a secure, encrypted session with the server
+ Generate and signed by the server itself or Production: CA-Signed Certificate, issued and authenticated by a trusted certificate authority, CA verifies identity of the organization requesting the cert

Configure the server to listen on port 443, which is the standard port for the HTTPS traffic enabling SSL for secure connection