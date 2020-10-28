CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    firstname varchar(255),
    lastname varchar(255),
    age varchar(255),
    password varchar(255),
    email varchar(255)
);