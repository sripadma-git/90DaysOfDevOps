### Day-32: Docker volumes and Networking  

Task1: Task 1: The Problem Run a Postgres or MySQL container Create some data inside it (a table, a few rows — anything) Stop and remove the container Run a new one — is your data still there? Write what happened and why. 

1.Step 1 — Run PostgreSQL container 
```bash
docker run -d \ 

--name postgres-test \ 

-e POSTGRES_PASSWORD=pass123 \ 

-p 5432:5432 \ 

postgres  , check container : docker ps  
```


2. Step 2 — Enter the container  : docker exec -it postgres-test psql -U postgres 

Step 3 — Create table + insert data :  
```bash
CREATE TABLE students ( 

id SERIAL PRIMARY KEY, 

name TEXT 

); 

INSERT INTO students (name) VALUES ('Padma'); 

INSERT INTO students (name) VALUES ('DevOps'); 

SELECT * FROM students; 

Expected output: 

id |  name 
----+-------- 
1  | Padma 
2  | DevOps 
```
Step 4: Stop container and remove container : docker stop id && docker rm id 

Step 6 — Run NEW container again  

Step 7 : Check if data exists Enter container again: 

docker exec -it postgres-test psql -U postgres 

Run:SELECT * FROM students; 

You will see: ERROR: relation "students" does not exist 

Postgres stored data inside the container filesystem:/var/lib/postgresql/data 

When the container was deleted:container filesystem = deleted 
data = deleted ,This is why containers are ephemeral.This problem is exactly why Docker volumes exist. 

 ---

Task 2: Named Volumes Create a named volume Run the same database container, but this time attach the volume to it Add some data, stop and remove the container Run a brand new container with the same volume Is the data still there? Verify: docker volume ls, docker volume inspect. 

1.create a volume : docker volume create postgres-data and verify it : docker volumes ls 

2.Run Container with mount path :  
```bash
docker run -d \ 

--name postgres-vol \ 

-e POSTGRES_PASSWORD=pass123 \ 

-v postgres-data:/var/lib/postgresql \ 

-p 5432:5432 \ 

Postgres 
```

3.verify the container is running : docker ps  

4. Connect to database : docker exec -it postgres-vol psql -U postgres you can see Prompt: 

postgres=# 

5.create data again : take same we used in task 1 

6.stop container and delete : docker stop postgres-vol && docker rm postgres-vol 

7. Start new container using same volume: take the same container used in step 2. 

8. check data : docker exec -it postgres-vol2 psql -U postgres and Run : SELECT * FROM devops; 

You can still see the Padma and Devops.  

That proves volume persistence works. Data remained after container deletion. 

Reason : Docker volume stores data outside container filesystem. 

Container deleted → Data safe. 

Volume persists → Data persists. 

---

Task 3: Bind Mounts Create a folder on your host machine with an index.html file Run an Nginx container and bind mount your folder to the Nginx web directory Access the page in your browser Edit the index.html on your host — refresh the browser Write in your notes: What is the difference between a named volume and a bind mount? 

1.create a folder : mkdir mywebsite, cd mywebsite, vim index.html: <h1>Hello from Docker Bind Mount</h1> 

2. Run Nginx container with bind mount 
```bash
docker run -d \ 
--name nginx-bind \ 
-p 8080:80 \ 
-v $(pwd):/usr/share/nginx/html \ 
nginx 
```
3.Access in browser: http://EC2_PUBLIC_IP:8080 

Changes made on the host machine were immediately reflected in the container.  

Explanation :  

Bind mounts directly connect a host directory to a container directory, allowing real-time file updates. 

 ---

Task 4: Docker Networking Basics List all Docker networks on your machine Inspect the default bridge network Run two containers on the default bridge — can they ping each other by name? Run two containers on the default bridge — can they ping each other by IP? 

1. List all Docker networks on your machine :docker network ls  

2. Inspect the default bridge network : docker network inspect bridge 

You will see a large JSON output, Important section looks like: 

"Subnet": "172.17.0.0/16" 
"Gateway": "172.17.0.1" 

This means Docker automatically creates a private network. 

3. Run two containers on the default bridge — can they ping each other by name: NO 

4. Run two containers on the default bridge — can they ping each other by IP: YES 

The default bridge network does not provide automatic DNS-based name resolution. 

Containers can communicate only using IP addresses unless a custom network is used. 

---

Task 5: Custom Networks Create a custom bridge network called my-app-net Run two containers on my-app-net Can they ping each other by name now? Write in your notes: Why does custom networking allow name-based communication but the default bridge doesn't? 

1. Custom Networks Create a custom bridge network called my-app-net: docker network create my-app-net and verify it : docker network ls 

2. Run first container on this network :  docker run -dit \ 

--name app1 \ 

--network my-app-net \ 

Ubuntu 

3. Run second container on same network : docker run -dit \ 

--name app2 \ 

--network my-app-net \ 

Ubuntu 

4. Check containers: docker ps  

5. Install ping tool: Enter container app1 :docker exec -it app1 bash 

Install ping:apt update , apt install iputils-ping -y 

6. Ping using container name: ping app2 

Docker custom networks include an internal DNS server that automatically resolves container names to their IP addresses. 

Why does custom networking allow name-based communication but the default bridge doesn't? 

-> Custom Docker bridge networks provide built-in DNS-based service discovery, allowing containers to communicate using container names. The default bridge network does not support automatic DNS name resolution between containers. 

Task 6: Task 6: Put It Together Create a custom network Run a database container (MySQL/Postgres) on that network with a volume for data Run an app container (use any image) on the same network Verify the app container can reach the database by container name. 

1.Create network: docker network create my-app-net
2. Create a volume for database: docker volume create mysql-data 
3.Run MySQL container: 
```bash 
docker run -d \
--name mysql-db \
--network my-app-net \
-e MYSQL_ROOT_PASSWORD=root123 \
-v mysql-data:/var/lib/mysql \
mysql
```
4. Run application container : 
```bash
docker run -dit \
--name app-container \
--network my-app-net \
ubuntu
```
5.Install mysql client inside app container:
- Enter container:docker exec -it app-container bash
- Install mysql client:apt update ,apt install mysql-client -y
6. Connect to database using container name 
- Inside container run:mysql -h mysql-db -u root -pPassword:root123

7.If connection succeeds you will see:

mysql>