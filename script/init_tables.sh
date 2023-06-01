#!/bin/bash

set -e


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    
ALTER ROLE ps with password 'ps_2023';
EOSQL
