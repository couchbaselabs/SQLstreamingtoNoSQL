/*
--------------------------------------------------------------------
sample data

--------------------------------------------------------------------
*/
-- create schemas

create database test;
use test;
EXEC sys.sp_cdc_enable_db;
CREATE SCHEMA store;
go

-- create tables


CREATE TABLE store.products (
productId INT IDENTITY (1, 1) PRIMARY KEY,
productName VARCHAR (255) NOT NULL,
description VARCHAR (255) NOT NULL,
price REAL  NOT NULL)
;

EXEC sys.sp_cdc_enable_table @source_schema = 'store', @source_name = 'products', @role_name = NULL, @supports_net_changes = 0;
GO

CREATE TABLE store.customers (
	customerId INT IDENTITY (1, 1) PRIMARY KEY,
	firstName VARCHAR (255) NOT NULL,
	lastName VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	address VARCHAR (500) NOT NULL
);

EXEC sys.sp_cdc_enable_table @source_schema = 'store', @source_name = 'customers', @role_name = NULL, @supports_net_changes = 0;
GO


CREATE TABLE store.orders (
	orderId INT IDENTITY (1, 1) PRIMARY KEY,
	customerId INT,
	orderStatus tinyint NOT NULL,
	orderDate VARCHAR (15) NOT NULL,
	FOREIGN KEY (customerId) REFERENCES store.customers (customerId) ON DELETE CASCADE ON UPDATE CASCADE
);

EXEC sys.sp_cdc_enable_table @source_schema = 'store', @source_name = 'orders', @role_name = NULL, @supports_net_changes = 0;
GO


CREATE TABLE store.order_items (
	orderId INT,
	itemId INT,
	productId INT NOT NULL,
	quantity INT NOT NULL,
	price REAL NOT NULL,
	PRIMARY KEY (orderId, itemId),
	FOREIGN KEY (orderId) REFERENCES store.orders (orderId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (productId) REFERENCES store.products (productId) ON DELETE CASCADE ON UPDATE CASCADE
);

EXEC sys.sp_cdc_enable_table @source_schema = 'store', @source_name = 'order_items', @role_name = NULL, @supports_net_changes = 0;
GO


