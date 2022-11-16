postgres:
	docker run --name db_simple_bank -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

# Create database on container
createdb:
	docker exec -it db_simple_bank createdb --username=root --owner=root simple_bank

# Drop database
dropdb:
	docker exec -it db_simple_bank dropdb simple_bank

# Migrate up
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose up

# Migrate down
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose down

# Run SQLC for generate to query to golang code
sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc