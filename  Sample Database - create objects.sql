/*
--------------------------------------------------------------------
sample data

--------------------------------------------------------------------
*/
-- create schemas

CREATE SCHEMA store;
go

-- create tables


CREATE TABLE store.products (
	productId INT IDENTITY (1, 1) PRIMARY KEY,
	productName VARCHAR (255) NOT NULL,
	brandId INT NOT NULL,
	categoryId INT NOT NULL,
	year SMALLINT NOT NULL,
	price DECIMAL (10, 2) NOT NULL)
;

EXEC sys.sp_cdc_enable_table @source_schema = 'store', @source_name = 'products', @role_name = NULL, @supports_net_changes = 0;
GO

CREATE TABLE store.customers (
	customerId INT IDENTITY (1, 1) PRIMARY KEY,
	firstName VARCHAR (255) NOT NULL,
	lastName VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip VARCHAR (5)
);

EXEC sys.sp_cdc_enable_table @source_schema = 'store', @source_name = 'customers', @role_name = NULL, @supports_net_changes = 0;
GO


CREATE TABLE store.orders (
	orderId INT IDENTITY (1, 1) PRIMARY KEY,
	customerId INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	orderDate DATE NOT NULL,
	shippingDate DATE,
	FOREIGN KEY (customerId) REFERENCES store.customers (customerId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE store.order_items (
	orderId INT,
	itemId INT,
	productId INT NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL (10, 2) NOT NULL,
	PRIMARY KEY (orderId, itemId),
	FOREIGN KEY (orderId) REFERENCES store.orders (orderId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (productId) REFERENCES store.products (productId) ON DELETE CASCADE ON UPDATE CASCADE
);

GO
