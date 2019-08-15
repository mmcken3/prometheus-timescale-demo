timescaledb:
	docker-compose up

clean:
	docker-compose down
	docker system prune -f

backup:
	docker exec wale wal-e backup-push /var/lib/postgresql/data/pg_data

clean-backups:
	rm -r backups/
