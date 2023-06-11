// Copyright (c) 2023 Anton Zhiyanov, MIT License
// https://github.com/nalgeon/sqlite

#ifndef INIT_H
#define INIT_H

#include <stdlib.h>

#include "sqlite3ext.h"

int sqlite3_sqlean_init(sqlite3* db, char** errmsg_ptr, const sqlite3_api_routines* api);
void shell_sqlean_init();

#endif /* INIT_H */
