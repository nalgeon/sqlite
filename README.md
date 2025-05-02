# SQLite / Sqlean builds

This repo provides customized builds for [`sqlite`](https://sqlite.org) and [`sqlean`](https://github.com/nalgeon/sqlean) shells.

## SQLite

Builds and publishes SQLite shell (aka command-line interface or CLI) for different Linux, Windows and macOS.

The list of enabled features:

-   `SQLITE_ENABLE_DBPAGE_VTAB`. Enables the [sqlite_dbpage](https://sqlite.org/dbpage.html) virtual table.
-   `SQLITE_ENABLE_DBSTAT_VTAB`. Enables the [dbstat](https://sqlite.org/dbstat.html) virtual table.
-   `SQLITE_ENABLE_EXPLAIN_COMMENTS`. Makes [EXPLAIN](https://sqlite.org/lang_explain.html) output more readable.
-   `SQLITE_ENABLE_FTS4`. Enables [FTS3 and FTS4](https://sqlite.org/fts3.html) extensions.
-   `SQLITE_ENABLE_FTS5`. Enables the [FTS5](https://sqlite.org/fts5.html) extension.
-   `SQLITE_ENABLE_GEOPOLY`. Enables the [Geopoly](https://sqlite.org/geopoly.html) extension.
-   `SQLITE_ENABLE_JSON1`. Enables the [JSON1](https://sqlite.org/json1.html) extension.
-   `SQLITE_ENABLE_MATH_FUNCTIONS`. Enables [math functions](https://sqlite.org/lang_mathfunc.html).
-   `SQLITE_ENABLE_OFFSET_SQL_FUNC`. Enables the [sqlite_offset(x)](https://sqlite.org/lang_corefunc.html#sqlite_offset) function.
-   `SQLITE_ENABLE_RTREE`. Enables the [R\*Tree](https://sqlite.org/rtree.html) extension.
-   `SQLITE_ENABLE_STAT4`. Helps query planner to make better index choices.
-   `SQLITE_ENABLE_STMTVTAB`. Enables the [sqlite_stmt](https://sqlite.org/stmt.html) virtual table.
-   `SQLITE_ENABLE_UNKNOWN_SQL_FUNCTION`. Ignores unknown functions in EXPLAIN, useful for debugging.
-   `SQLITE_HAVE_ZLIB`. Required for [SQL Archive](https://sqlite.org/sqlar.html) support. Not available on Windows.
-   `SQLITE_LIKE_DOESNT_MATCH_BLOBS`. Forces LIKE and GLOB to return FALSE for BLOBs.
-   `SQLITE_THREADSAFE=0`. Turns off support for multithreaded environment.
-   `SQLITE_USE_URI`. Enables [URI](https://sqlite.org/uri.html) connection strings.

Latest release: [3.49.1](https://github.com/nalgeon/sqlite/releases/latest)

## Sqlean

`sqlean` shell is SQLite shell bundled with a collection of [essential extensions](https://github.com/nalgeon/sqlean) ranging from regular expressions and math statistics to file I/O and dynamic SQL.

```
  sqlean shell =
┌───────────────────────────┐
│ sqlite shell              │
├ + ────────────────────────┤
│ crypto   ipaddr   text    │
│ define   math     time    │
│ fileio   regexp   uuid    │
│ fuzzy    stats    vsv     │
└───────────────────────────┘
```

Builds are available for every OS:

-   `sqlean.exe` - for Windows
-   `sqlean-ubuntu` - for Ubuntu (and other Debian-based distributions)
-   `sqlean-macos` - for macOS (supports both Intel and Apple processors)

Latest release: [3.49.1](https://github.com/nalgeon/sqlite/releases/latest) (using Sqlean 0.27.2).

**Note for macOS users**. macOS disables unsigned binaries and prevents the `sqlean` shell from running. To resolve this issue, remove the build from quarantine by running the following command in Terminal (replace `/path/to/folder` with an actual path to the folder containing the `sqlean-macos` binary):

```
chmod +x /path/to/folder/sqlean-macos
xattr -d com.apple.quarantine /path/to/folder/sqlean-macos
```

And then run the shell:

```
$ /path/to/folder/sqlean-macos
SQLite version 3.42.0 2023-05-16 12:36:15
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlean> █
```
