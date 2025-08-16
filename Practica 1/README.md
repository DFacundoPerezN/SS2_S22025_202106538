# Proceso ETL de la empresa SG-FOOD: 

## Pasos ETL
### Compras
```mermaid
flowchart TB
  F["Flat File Source<br/>Compras CSV"]
  DC1["Data Conversion<br/>Compras DC"]
  DF["Derived Column<br/>Fecha Fix (corrige 'Z'->'2' & '-' -> '' en enteros)"]
  DC2["Data Conversion<br/>Compras DC Fix"]
  UA1["Union All<br/>Compras Union All"]
  CS["Conditional Split<br/>Errores: negativos, nulos y espacios vacíos"]
  FIX["Script <br/>Corrección de negativos, nulos y espacios vacíos"]
  TRIM["Trimed Unicode strings"]
  UA2["Union All<br/>Compras Union"]
  MC["Multicast<br/>Compras Multicast"]
  SORT["Sort<br/>Fecha Sort (distinct)"]
  DCF["Derived Column<br/>Year/Month/MonthName/DayName"]
  LK["Lookup<br/>DimFecha existente?"]
  OLE["OLE DB Destination<br/>Fecha Insert"]
  VAR["Varchar<br/>Convertir a vadena aceptable para la DB"]
  MC1["Multicast<br/>Compras Multicast 1"]
  SORT2["Sort<br/>Sort (key)"]
  DCF2["Derived Column<br/>Year/Month/MonthName/DayName"]
  LK2["Lookup<br/>Otros atributos existente?"]
  OLE2["OLE DB Destination<br/> Insert"]

  F --> DC1
  DC1 -- Error Output --> DF --> DC2 --> UA1
  DC1 --> UA1
  UA1 --> TRIM
  TRIM --> CS
  CS -- Registros con error --> FIX --> UA2
  CS -- Registros sin error --> UA2
  UA2 --> MC
  MC --> SORT --> DCF --> LK
  LK -- No Match --> OLE
  MC --> VAR 
  VAR --> MC1--> SORT2 --> DCF2 --> LK2 --> OLE2
```
### Ventas
```mermaid
flowchart TB
  F["Flat File Source<br/>Ventas CSV"]
  DC1["Data Conversion<br/>Ventas DC"]
  DF["Derived Column<br/>Fecha Fix (corrige 'Z'->'2' & '-' -> '' en enteros)"]
  DC2["Data Conversion<br/>Ventas DC Fix"]
  UA1["Union All<br/>Ventas Union "]
  TRIM["Trimed Unicode strings"]
  FIX["Script <br/>Corrección de negativos, nulos y espacios vacíos"]
  MC["Multicast<br/>Ventas Multicast"]
  SORT["Sort<br/>Fecha Sort (distinct)"]
  DCF["Derived Column<br/>Year/Month/MonthName/DayName"]
  LK["Lookup<br/>DimFecha existente?"]
  OLE["OLE DB Destination<br/>Fecha Insert"]
  VAR["Varchar<br/>Convertir a vadena aceptable para la DB"]
  MC1["Multicast<br/>Compras Multicast 1"]
  SORT2["Sort<br/>Sort (key)"]
  DCF2["Derived Column<br/>Year/Month/MonthName/DayName"]
  LK2["Lookup<br/>Otros atributos existente?"]
  OLE2["OLE DB Destination<br/> Insert"]

  F --> DC1
  DC1 -- Error Output --> DF --> DC2 --> UA1
  DC1 --> UA1
  UA1 --> TRIM
  TRIM --> FIX --> MC
  MC --> SORT --> DCF --> LK
  LK -- No Match --> OLE
  MC --> VAR 
  VAR --> MC1 --> SORT2 --> DCF2 --> LK2 --> OLE2
```

## ¿Por qué se eligio el modelo constelación?
Debido a el cambio que esta teniendo la organización, debido a el aumento en la complejidad de sus datos a analizar. Este modelo es adaptable a trabajar con normalización o con desnormalización, entonces gracias al cambio que puede tener el negocio es bueno usar un modelo adaptable como el de constelación de hechos.

## Analisis
### Hechos
1. **Venta**
    - Sucursal (FK)
    - Producto (FK)
    - Fecha

2. **Compra**
    - Producto (FK)
    - Proveedor 
    - Fecha

### Dimensiones
3. **Producto**
    - Precio venta
    - Precio compra
    - Tipo

4. **Sucursal**
    - Región

5. Fechas en:
    - Año 
    - Mes
    - Semana (del mes)
    - Dia

6. **Proveedor**
    - nombre

## SQL del DDL
``` SQL 
Table Venta_hecho {
  id integer [primary key]
  fecha_id int [foreign key]
  sucursal_id varchar(10)   [foreign key]
  cliente_id varchar(8)   [foreign key]
  vendedor_id varchar(8)   [foreign key]
  product_id varchar(8)   [foreign key]
  unidades  integer
  price  decimal (10,2)
}
Table Compra_hecho{
  id integer [primary key] 
  fecha_id int [foreign key]
  sucursal_id varchar(10)   [foreign key]
  product_id varchar(8)  [foreign key]
  provider_id varchar(8) [foreign key]
  unidades integer
  price decimal (10,2)
}
Table Fecha_dim {
  id int [primary key]
  fecha date
  year smallint
  month tinyint
  week_of_month tinyint
  day_of_week tinyint
}

Table Product_dim {
  id varchar(8) [primary key]
  name varchar(32) [not null]
  category_id integer [foreign key]
  branch_id integer [foreign key]
}
Table Category_dim {
  id integer [primary key]
  name varchar (16) [not null]
}
Table Branch_dim {
  id integer [primary key]
  name varchar (16) [not null]
}
Table Provider_dim {
  id varchar (8) [primary key]
  name varchar (24) [not null]
}
Table Client_dim {
  id varchar(8) [primary key]
  name varchar (24) [not null]
  type varchar (24) 
}
Table Vendedor_dim {
  id varchar(8) [primary key]
  name varchar (24) [not null]
}
Table Sucursal_dim {
  id varchar (10) [primary key]
  name varchar(32)
  region varchar(16) [not null]
  department varchar(16) [not null]
}

```
<img width="1188" height="761" alt="imagen" src="Diagram/ER.png" />
