## Goal

Create an postgres with some data load in there, and also modify the data with DBT. Here is an [article](https://dev.to/obrotoks/create-a-dbt-wpostgres-19bi) with step by step of the construction.

## Data

For this purpouse it's going to be use [this dataset](https://www.kaggle.com/datasets/sellingstories/travel-company-insurance-prediction?resource=download). In there we could find two csv:

- 2nd File: Travel Company New Clients; Number of observations: 1303

We are going to use only Travel Company New Clients.


## Prequistes

- Docker version 23.0.5
- Postgres version 15
- Python 3.8


## Install 

Clone it in your own directory and run:


```shell
docker compose up
```

## Uninstall

```shell
docker compose down --rmi all -v --remove-orphans
```

