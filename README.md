# confluentdemo

1) To build kafka connect container with proper connectors run: docker build . -t connect:1.0.0. with the provided DockerFile
2) To start Confluent Platform, Couchbase server and SQL Server inside the same network run: docker compose up -d
3) Access to SQL server and create a Schema and the sample tables, enabling CDC (https://docs.microsoft.com/en-us/sql/relational-databases/track-changes/enable-and-disable-change-data-capture-sql-server?view=sql-server-ver15). You can also use Azure Data studio to connect to it (https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15).  TODO: enanche demo data
4) Access Couchbase Cluster on localhost:9021 and setup a cluster with a Bucket Called test
5) Create the SQL Server Source and Sink Connectors:
*  curl -X POST -H "Content-Type: application/json" -d @SQLServerConnector.json http://localhost:8083/connectors  
 *  curl -X POST -H "Content-Type: application/json" -d @CouchbaseSinkConnector.json http://localhost:8083/connectors
6) Access to Control Center on localhost:9021 and verify that the connectors are OK
7) Create proper KSQLDB streams to transform the data and load them in Couchbase with the proper key, e.g.:
* CREATE STREAM PRODUCTS WITH (KAFKA_TOPIC='test.store.products', VALUE_FORMAT='AVRO');
* CREATE STREAM TARGET_PRODUCTS WITH (KAFKA_TOPIC='target_products', VALUE_FORMAT='AVRO') AS SELECT 'product::'+ CAST(AFTER->PRODUCTID AS VARCHAR)  KEY,AFTER->PRODUCTID AS "productId", AFTER->PRODUCTNAME AS "productName", AFTER->BRANDID AS "brandId", AFTER->CATEGORYID AS "categoryId", AFTER->YEAR AS "year", ROUND(AFTER->PRICE,2) AS "price" FROM PRODUCTS;  
 
