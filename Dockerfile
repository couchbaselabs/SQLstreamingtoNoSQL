FROM confluentinc/cp-kafka-connect-base:6.2.1

RUN   confluent-hub install --no-prompt  debezium/debezium-connector-sqlserver:1.7.0  \
   && confluent-hub install --no-prompt  couchbase/kafka-connect-couchbase:4.1.3
  