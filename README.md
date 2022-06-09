# From SQL to NoSQL streaming

Prerequisite:
Run sh cleanup.sh to clean up previous containers

Steps:
1) To start Confluent Platform, Couchbase server and SQL Server inside the same network run: docker compose up -d. This will start SQL server with pre populated tables and Couchbase server with all the scopes and collection already created.
2) Create the SQL Server Source and Sink Connectors:
*  curl -X POST -H "Content-Type: application/json" -d @SqlServerConnector.json http://localhost:8083/connectors  
 *  curl -X POST -H "Content-Type: application/json" -d @CouchbaseSinkConnector.json http://localhost:8083/connectors
3) Access to Control Center on localhost:9021 and verify that the connectors are OK
4) Create proper KSQLDB streams to transform the data and load them in Couchbase (see file ksqldb). To do this simply run:
  - source deployksql.sh
  - deploy_ksql ksqldb.sql
5) Verify that all data have been streamed and inserted in target Couchbase collections :)
 
