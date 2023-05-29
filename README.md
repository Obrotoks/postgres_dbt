## Goal

Create an postgres with some data load in there.

## Data

For this purpouse it's going to be use [this dataset](https://www.kaggle.com/datasets/sellingstories/travel-company-insurance-prediction?resource=download). In there we could find two csv:

- 1st File: Travel Company Old Clients; Number of observations: 682
- 2nd File: Travel Company New Clients; Number of observations: 1303

We are going to use only Travel Company New Clients.


## Prequistes

- Docker version 23.0.5
- Postgres version 15

## 1- Create a docker-compose

For this objective we are going to create an image based on [actual image](https://hub.docker.com/_/postgres)

```yaml
version: '3.9'
services:
  post_db:
    build: . 
    image: postgres/test:v1
    user: postgres
    environment:
      - POSTGRES_USER=${PS_USER}
      - POSTGRES_PASSWORD=${PS_PASSWORD}
      - PG_DATA:/var/lib/postgresql/data/pgdata
      - POSTGRES_DB=${PS_DB}
    healthcheck:
      test: ["CMD-SHELL","pg_isready -U ${PS_USER} ${PS_PASSWORD}"]
      interval: 10s
      timeout: 5s
      retries: 5
    ports:
      - "8080:8080"
    volumes:
      - db-data:/var/lib/postgresql/data
    restart: unless-stopped
volumes:
  db-data: 

```

There are a healthcheck to view if there are something wrong with the connection.


## 2 - Create table(s) 

If we want to create a table as init configuration. The scrips shouldbe place in [docker-entrypoint-initdb.d](https://hub.docker.com/_/postgres).

There is an example of script in bash: 


```bash 
!/bin/bash

set -e


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    
CREATE TABLE 
    newClients (
         Num_Age INT
        ,Des_EmployeType VARCHAR(50)
        ,Is_Graduate VARCHAR(3)
        ,Imp_AnnualIncome INT
        ,Num_FamilyMembers INT
        ,Num_ChronicDisease INT
        ,Is_FrequentFlyer VARCHAR(3)
        ,Is_EverTravelledAbroad VARCHAR(3)
    );
EOSQL
```
Also, it should be place in the Dockerfile. 

```Dockerfile

FROM postgres${PS_VERSION}

# make directory to Docker
RUN mkdir -p /home/raw

# copy scripts
COPY ./raw/* /docker-entrypoint-initdb.d

# run all the scripts in initdb
RUN chmod a+r /docker-entrypoint-initdb.d/*

``` 

## 3- Load data 

Now, with the folder of docker-entrypoint-initdb it could be use to load the data adding in the last script: 

```shell

#!/bin/bash

set -e


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    
CREATE TABLE 
    newClients (
         Num_Age INT
        ,Des_EmployeType VARCHAR(100)
        ,Is_Graduate VARCHAR(3)
        ,Imp_AnnualIncome INT
        ,Num_FamilyMembers INT
        ,Num_ChronicDisease INT
        ,Is_FrequentFlyer VARCHAR(3)
        ,Is_EverTravelledAbroad VARCHAR(3)
    );

COPY newClients FROM '/home/src/Travel Company New Clients.csv' DELIMITER ';' CSV HEADER;
EOSQL

```

And it's looks like it works.
