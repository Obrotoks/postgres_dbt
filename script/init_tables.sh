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
