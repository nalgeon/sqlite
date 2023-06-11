// Copyright (c) 2023 Anton Zhiyanov, MIT License
// https://github.com/nalgeon/sqlite

void shell_sqlean_init() {
    sqlite3_snprintf(sizeof(mainPrompt), mainPrompt, "sqlean> ");
}
