package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable"
)

// testQueries as return instance all function from object Queries
var testQueries *Queries

func TestMain(m *testing.M) {
	// Open connection to db
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	// Inject connection into func New
	testQueries = New(conn)

	// Run test
	os.Exit(m.Run())
}
