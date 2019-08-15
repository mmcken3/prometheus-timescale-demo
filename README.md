# Prometheus With TimescaleDB Demo

*This is a work in progress an is essentially on a timescale db set up for the time being*

Goal for this is to be an easy starter kit to run prometheus with timescale db as a read/write semi-persistent data store in docker. I say semi-persistent because it will persist as you schedule backups, and if the docker container shuts down between backups you would loose the data since the last backup.

## Timescale Setup

This timescale set up that is in the [compose file](docker-compose.yml) is configured to have the WAL-E sidecar running along side it. There is some good documentation around this sidecar located on the timescale db site [here](https://docs.timescale.com/latest/using-timescaledb/backup#docker-wale). However, in these docs they discuss running standard docker cli commands to start the db and the sidecar up, but here we have configured it all with docker compose.

Start up the timescale db and sidecar with this command:

```
docker-compose up
```

Or using our [Makefile](Makefile):

```
make timescaledb
```

[Here](https://docs.timescale.com/v0.9/getting-started/installation/windows/installation-docker#prometheus-docker) is some information on the timescale database set up that we are using which is the docker image pre built with the prometheus adapter. Find is [here](https://hub.docker.com/r/timescale/pg_prometheus) on Docker Hub.

### Creating the WAL-E Backups

You can use the sidecar to help you create backups of your timescale database. In production you can even set up the sidecar to send backups into things like AWS S3. It is recomended to set up those backups using a cron or a similar tatic. There are a couple of different ways to create these backups laid out in the docs from above.

The most simple is a docker command which our `make backup` uses:

```
docker exec wale wal-e backup-push /var/lib/postgresql/data/pg_data
```

There is also another way to create the backup, which is by exposing port 80 of the sidecar and making an http request:

```
curl http://localhost:8080/backup-push
```

### Restoring From WAL-E Backups

*More to come here*

But for now, [here](https://docs.timescale.com/latest/using-timescaledb/backup#docker-wale-restore) are the main docs on this topic.

## Using WAL-E With S3

*More to come here*

## Cleanup

You can cleanup everything we set up in the docker compose file with the simple make command:

```
make clean
```

It will shutdown the items in docker compose and prune your docker system for you.

## Tools

[Timescale](https://www.timescale.com/)

[Prometheus](https://prometheus.io/)

[Docker](https://www.docker.com/)
