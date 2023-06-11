void shell_sqlean_init() {
    sqlite3_snprintf(sizeof(mainPrompt), mainPrompt, "sqlean> ");
}
