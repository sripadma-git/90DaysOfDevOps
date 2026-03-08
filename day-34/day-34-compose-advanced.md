Task 33: Docker Compose:Real-world mutli-container App 

Task 1: Build Your Own App Stack 

1.Create a docker-compose.yml for a 3-service stack: A web app (use Python Flask, Node.js, or any language you know) A database (Postgres or MySQL) A cache (Redis) Write a simple Dockerfile for the web app. The app doesn't need to be complex — even a "Hello World" that connects to the database is enough. 

1. create Folder: mkdir compose-app-stack , cd compose-app-stack 

Create directories: 

mkdir docker-compose-app 
cd docker-compose-app 
mkdir app 
touch docker-compose.yml  
cd app 
touch app.py requirements.txt Dockerfile 

Edit the file:app/app.py 

from flask import Flask import psycopg2 

app = Flask(name) 

def check_db(): try: conn = psycopg2.connect( host="db", database="mydb", user="postgres", password="postgres" ) conn.close() return "Database Connected!" except: return "Database Not Ready" 

@app.route("/") def home(): return check_db() 

if name == "main": app.run(host="0.0.0.0", port=5000) 

File: 

app/requirements.txt 

flask 
psycopg2-binary 
redis 

Dockerfile for Web Application 

app/Dockerfile 

FROM python:3.10 
WORKDIR /app 
COPY requirements.txt . 
RUN pip install -r requirements.txt 
COPY . . 
EXPOSE 5000 
CMD ["python", "app.py"] 
 
docker-compose.yml : 

version: "3.9" 
services: 
 web: 
   build: ./app 
   ports: 
     - "5000:5000" 
   depends_on: 
     db: 
       condition: service_healthy 
   networks: 
     - mynetwork 
   labels: 
     project: "compose-demo" 
 db: 
   image: postgres:15 
   environment: 
     POSTGRES_DB: mydb 
     POSTGRES_USER: postgres 
     POSTGRES_PASSWORD: postgres 
   volumes: 
     - postgres_data:/var/lib/postgresql/data 
   restart: always 
   networks: 
     - mynetwork 
   healthcheck: 
     test: ["CMD-SHELL", "pg_isready -U postgres"] 
     interval: 5s 
     retries: 5 
     timeout: 3s 
 
 redis: 
   image: redis:7 
   networks: 
     - mynetwork 
   labels: 
     project: "compose-demo" 
 
volumes: 
 postgres_data: 
 
networks: 
 mynetwork: 

Running the Application 

Start the entire stack: 

docker compose up -d 

Check running containers: 

docker ps 

Expected containers: 

web 
db 
redis 

Access the application: 

http://EC2_PUBLIC_IP:5000 

---

Task 2: depends_on & Healthchecks Add depends_on to your compose file so the app starts after the database Add a healthcheck on the database service Use depends_on with condition: service_healthy so the app waits for the database to be truly ready, not just started Test: Bring everything down and up — does the app wait for the DB?  

Service Dependency with Health Checks 

The web service waits for the database to become healthy. 

depends_on: 
 db: 
   condition: service_healthy 

Database healthcheck: 

healthcheck: 
 test: ["CMD-SHELL", "pg_isready -U postgres"] 
 interval: 5s 
 retries: 5  

This ensures the web service starts only after PostgreSQL is ready. 

---

Task 3: Restart Policies Add restart: always to your database service Manually kill the database container — does it come back? Try restart: on-failure — how is it different? Write in your notes: When would you use each restart policy?  

Restart Policies : Database service includes: 

restart: always 

Testing Restart Policy 

Find container ID: 

docker ps 

Kill database container: 

docker kill <container-id> 

Check again: 

docker ps 

The container automatically restarts. 

---

Task 4: Custom Dockerfiles in Compose Instead of using a pre-built image for your app, use build: in your compose file to build from a Dockerfile Make a code change in your app Rebuild and restart with one command  

=> Rebuilding After code chnages 

If application code changes, rebuild the image. 

Docker compose up –build -d 

---

Task 5: Named Networks & Volumes Define explicit networks in your compose file instead of relying on the default Define named volumes for database data Add labels to your services for better organization  

=> Named volume used for database persistence:postgres_data 

Check volumes:docker volume ls 

Custom network:mynetwork 

Check networks:docker network l 

---

Task 6: Scaling (Bonus) Try scaling your web app to 3 replicas using docker compose up --scale What happens? What breaks? Write in your notes: Why doesn't simple scaling work with port mapping? 

=> Scale web application:docker compose up --scale web=3 -d 

Check containers:docker ps 

 

 

 

 

 

 

 

 