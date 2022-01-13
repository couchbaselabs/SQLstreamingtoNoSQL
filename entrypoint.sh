#!/usr/bin/env bash
set -m
./opt/mssql/bin/sqlservr & ./startup.sh
fg