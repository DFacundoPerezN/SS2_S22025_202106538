CREATE TABLE Fecha_dim (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    year SMALLINT,
    month TINYINT,
    week_of_month TINYINT,
    day_of_week TINYINT
);

CREATE TABLE Category_dim (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(16) NOT NULL
);

CREATE TABLE Branch_dim (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(16) NOT NULL
);

CREATE TABLE Product_dim (
    id VARCHAR(8) PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    category_id INT,
    branch_id INT,
    FOREIGN KEY (category_id) REFERENCES Category_dim(id),
    FOREIGN KEY (branch_id) REFERENCES Branch_dim(id)
);

CREATE TABLE Provider_dim (
    id VARCHAR(8) PRIMARY KEY,
    name VARCHAR(24) NOT NULL
);

CREATE TABLE Client_dim (
    id VARCHAR(8) PRIMARY KEY,
    name VARCHAR(24) NOT NULL,
    type VARCHAR(24)
);

CREATE TABLE Vendedor_dim (
    id VARCHAR(8) PRIMARY KEY,
    name VARCHAR(24) NOT NULL
);

CREATE TABLE Sucursal_dim (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(32),
    region VARCHAR(16) NOT NULL,
    department VARCHAR(16) NOT NULL
);

CREATE TABLE Venta_hecho (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fecha_id INT,
    sucursal_id VARCHAR(10),
    cliente_id VARCHAR(8),
    vendedor_id VARCHAR(8),
    product_id VARCHAR(8),
    unidades INT,
    price DECIMAL(10,2),
    FOREIGN KEY (fecha_id) REFERENCES Fecha_dim(id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal_dim(id),
    FOREIGN KEY (cliente_id) REFERENCES Client_dim(id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedor_dim(id),
    FOREIGN KEY (product_id) REFERENCES Product_dim(id)
);

CREATE TABLE Compra_hecho (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fecha_id INT,
    sucursal_id VARCHAR(10),
    product_id VARCHAR(8),
    provider_id VARCHAR(8),
    unidades INT,
    price DECIMAL(10,2),
    FOREIGN KEY (fecha_id) REFERENCES Fecha_dim(id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal_dim(id),
    FOREIGN KEY (product_id) REFERENCES Product_dim(id),
    FOREIGN KEY (provider_id) REFERENCES Provider_dim(id)
);
