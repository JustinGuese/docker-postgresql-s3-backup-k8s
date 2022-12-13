#!/bin/bash
export PGPASSWORD=$PSQL_PASSWORD
pg_dumpall -U $PSQL_USER -h $PSQL_HOST -p $PSQL_PORT > psqlbackup-$(date +%Y-%m-%d).sql
gzip psqlbackup-$(date +%Y-%m-%d).sql 
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY aws s3 cp psqlbackup-$(date +%Y-%m-%d).sql.gz s3://$S3_BUCKET/$S3_PATH --endpoint-url=$S3_ENDPOINT