# docker-postgresql-s3-backup-k8s
simple docker image to backup current psql database to s3

the core script excutes this:

```
#!/bin/bash
pg_dumpall -U $PSQL_USER -h $PSQL_HOST -p $PSQL_PORT -W$PSQL_PASSWORD > psqlbackup-$(date +%Y-%m-%d).sql
gzip psqlbackup-$(date +%Y-%m-%d).sql 
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY aws s3 cp psqlbackup-$(date +%Y-%m-%d).sql.gz s3://$S3_BUCKET/$S3_PATH --endpoint-url=$S3_ENDPOINT
```
## usage

If you want to run it manually, swap out the env variables with your values, and run the following:

`docker run --rm -e PSQGL_HOST=postgres -e PSQL_PORT=5432 -e PSQL_USER=postgres -e PSQL_PASSWORD=postgres -e AWS_ACCESS_KEY_ID=secret -e AWS_SECRET_ACCESS_KEY=secret -e S3_BUCKET=mongodb-backup-bucket -e S3_ENDPOINT=https://s3.amazonaws.com guestros/postgres-s3-backup:latest`


## kubernetes

1. first create a secret after filling in the .env file
`kubectl create secret generic s3backuptarget --from-env-file=.env`
2. fill in the remaining settings in [kubernetes/postgresql-backup-cronjob.yaml](kubernetes/postgresql-backup-cronjob.yaml)
3. `kubernetes/postgresql-backup-cronjob.yaml`
