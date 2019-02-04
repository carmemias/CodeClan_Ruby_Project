-- database name: spending_tracker_db --

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS user_settings;

CREATE TABLE tags (
	id serial8 PRIMARY KEY,
	name VARCHAR(255)
);

CREATE TABLE merchants (
	id serial8 PRIMARY KEY,
	name VARCHAR(255)
);

CREATE TABLE transactions (
	id serial8 PRIMARY KEY,
	amount INT4,
	transaction_time TIMESTAMP,
	tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE,
	merchant_id INT8 REFERENCES merchants(id)
);

CREATE TABLE user_settings (
	id serial8 PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	budget INT4
)
