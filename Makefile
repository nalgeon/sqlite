# Copyright (c) 2023 Anton Zhiyanov, MIT License
# https://github.com/nalgeon/sqlite

SQLITE_RELEASE_YEAR := 2024
SQLITE_VERSION := 3450000
SQLEAN_VERSION := 0.21.8

SQLITE_OPT_WIN := -DSQLITE_ENABLE_DBPAGE_VTAB -DSQLITE_ENABLE_DBSTAT_VTAB -DSQLITE_ENABLE_EXPLAIN_COMMENTS -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_FTS5 -DSQLITE_ENABLE_GEOPOLY -DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_MATH_FUNCTIONS -DSQLITE_ENABLE_OFFSET_SQL_FUNC -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_STAT4 -DSQLITE_ENABLE_STMTVTAB -DSQLITE_ENABLE_UNKNOWN_SQL_FUNCTION -DSQLITE_LIKE_DOESNT_MATCH_BLOBS -DSQLITE_THREADSAFE=0 -DSQLITE_USE_URI

SQLITE_OPT := $(SQLITE_OPT_WIN) -DHAVE_READLINE -DSQLITE_HAVE_ZLIB

SQLITE_SRC := src/shell.c src/sqlite3.c

SQLEAN_INC := -include src/regexp/constants.h

SQLEAN_OPT := -DSQLITE_EXTRA_INIT=core_init -DSQLEAN_VERSION='"$(SQLEAN_VERSION)"'

SQLEAN_SRC_WIN := src/sqleanshell.c src/sqlean.c src/sqlite3-sqlean.c src/crypto/*.c src/define/*.c src/fileio/*.c src/fuzzy/*.c src/math/*.c src/regexp/*.c src/regexp/pcre2/*.c src/stats/*.c src/text/*.c src/unicode/*.c src/uuid/*.c src/vsv/*.c

SQLEAN_SRC := $(SQLEAN_SRC_WIN) src/ipaddr/*.c

LINK_LIB := -ldl -lz -lm -lreadline -lncurses

prepare-src:
	mkdir -p src
	rm -rf src/*

download-sqlite:
	curl -L https://github.com/sqlite/sqlite/raw/master/src/test_windirent.h --output src/test_windirent.h
	curl -L http://sqlite.org/$(SQLITE_RELEASE_YEAR)/sqlite-amalgamation-$(SQLITE_VERSION).zip --output sqlite.zip
	unzip sqlite.zip
	mv sqlite-amalgamation-$(SQLITE_VERSION)/* src
	rmdir sqlite-amalgamation-$(SQLITE_VERSION)

download-sqlean:
	curl -L https://github.com/nalgeon/sqlean/archive/refs/tags/$(SQLEAN_VERSION).zip --output sqlean.zip
	unzip sqlean.zip
	mv sqlean-$(SQLEAN_VERSION)/src/* src
	cat src/sqlite3.c init/initsqlite.c > src/sqlean.c
	cat src/shell.c init/initshell.c > src/sqleanshell.c
	cp init/init.h src
	rm -rf sqlean-$(SQLEAN_VERSION)

prepare-dist:
	mkdir -p dist
	rm -f dist/*

compile-sqlite-linux:
	gcc -Os $(SQLITE_OPT) $(SQLITE_SRC) -o dist/sqlite3-ubuntu $(LINK_LIB)
	chmod +x dist/sqlite3-ubuntu

compile-sqlite-windows:
	gcc -Os -Isrc $(SQLITE_OPT_WIN) $(SQLITE_SRC) -o dist/sqlite3.exe

compile-sqlite-macos:
	gcc -Os $(SQLITE_OPT) $(SQLITE_SRC) -o dist/sqlite3-macos-x86 -target x86_64-apple-macos10.12 $(LINK_LIB)
	gcc -Os $(SQLITE_OPT) $(SQLITE_SRC) -o dist/sqlite3-macos-arm -target arm64-apple-macos11 $(LINK_LIB)
	lipo -create -output dist/sqlite3-macos dist/sqlite3-macos-x86 dist/sqlite3-macos-arm
	chmod +x dist/sqlite3-macos

compile-sqlean-linux:
	gcc -O1 -Isrc $(SQLITE_OPT) $(SQLEAN_OPT) $(SQLEAN_INC) $(SQLEAN_SRC) -o dist/sqlean-ubuntu $(LINK_LIB)
	chmod +x dist/sqlean-ubuntu

compile-sqlean-windows:
	gcc -O1 -Isrc $(SQLITE_OPT_WIN) $(SQLEAN_OPT) $(SQLEAN_INC) $(SQLEAN_SRC_WIN) -o dist/sqlean.exe

compile-sqlean-macos:
	gcc -O1 -Isrc $(SQLITE_OPT) $(SQLEAN_OPT) $(SQLEAN_INC) $(SQLEAN_SRC) -o dist/sqlean-macos-x86 -target x86_64-apple-macos10.12 $(LINK_LIB)
	gcc -O1 -Isrc $(SQLITE_OPT) $(SQLEAN_OPT) $(SQLEAN_INC) $(SQLEAN_SRC) -o dist/sqlean-macos-arm -target arm64-apple-macos11 $(LINK_LIB)
	lipo -create -output dist/sqlean-macos dist/sqlean-macos-x86 dist/sqlean-macos-arm
	chmod +x dist/sqlean-macos
