# From SQL to NoSQL streaming

## Stream to standard Couchbase server
Prerequisite:
Run sh cleanup.sh to clean up previous containers

Steps:
1) To start Confluent Platform, Couchbase server and SQL Server inside the same network run: docker compose up -d. This will start SQL server with pre populated tables and Couchbase server with all the scopes and collection already created.
2) Create the SQL Server Source and Sink Connectors:
*  curl -X POST -H "Content-Type: application/json" -d @SQLServerConnector.json http://localhost:8083/connectors  
 *  curl -X POST -H "Content-Type: application/json" -d @CouchbaseSinkConnector.json http://localhost:8083/connectors
3) Access to Control Center on localhost:9021 and verify that the connectors are OK
4) Create proper KSQLDB streams to transform the data and load them in Couchbase (see file ksqldb). To do this simply run:
  - source deployksql.sh
  - deploy_ksql ksqldb.sql
5) Verify that all data have been streamed and inserted in target Couchbase collections :)

## Stream to Couchbase Capella

### Set up your Couchbase cluster on Capella
01) Select Cloud Provider, region and CIDR config
02) Select a 3 data/query/index nodes 4vCPU,16GB RAM, 50GB Disk
03) Choose basic plan with one AZ
04) Create cluster
05) Create a bucket named "raw" without backup policies
06) Create a scope named "store"
07) Create 4 collections named "products", "customers", "orders", "order_items"
08) Create a user named "application", choose a password, and give read/write access to the "store" scope
09) Configure your IP in the allowed IPs
10) Copy the root certificate into a capella.pem file
11) To start Confluent Platform, Couchbase server and SQL Server inside the same network run: docker compose up -d. 
12) Copy capella.pem file into kafka connect container : docker cp capella.pem connect:/home/appuser
13) Edit CouchbaseTLSSinkConnector.json and provide :
 * "couchbase.seed.nodes": "*paste url from capella cluster connect*",
 * "couchbase.username": "application"
 * "couchbase.password": "*paste application user password*"
14) Create the SQL Server Source and Sink Connectors:
 * curl -X POST -H "Content-Type: application/json" -d @SQLServerConnector.json http://localhost:8083/connectors  
 * curl -X POST -H "Content-Type: application/json" -d @CouchbaseTLSSinkConnector.json http://localhost:8083/connectors
15) Access to Control Center on localhost:9021 and verify that the connectors are OK
16) Create proper KSQLDB streams to transform the data and load them in Couchbase (see file ksqldb). To do this simply run:
  - source deployksql.sh
  - deploy_ksql ksqldb.sql
17) Verify that all data have been streamed and inserted in target Couchbase collections :)

