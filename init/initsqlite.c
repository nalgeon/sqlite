// Copyright (c) 2023 Anton Zhiyanov, MIT License
// https://github.com/nalgeon/sqlite

#include "init.h"

int core_init(const char* dummy) {
    shell_sqlean_init();
    return sqlite3_auto_extension((void*)sqlite3_sqlean_init);
}
