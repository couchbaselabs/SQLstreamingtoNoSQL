#!/usr/bin/env bash
# Wait for database to startup 
for i in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password! -i DBSampleObjects.sql
    if [ $? -eq 0 ]
    then
        echo "DBSampleObjects.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done
for j in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password! -i loaddata.sql
    if [ $? -eq 0 ]
    then
        echo "loaddata.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done
