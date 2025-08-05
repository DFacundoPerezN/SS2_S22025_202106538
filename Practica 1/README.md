# Proceso ETL de la empresa SG-FOOD: 

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
Table sale {
  id integer [primary key]
  created_at integer
  branch integer   
  product integer   
}
Table buy {
  id integer [primary key]
  created_at integer
  product integer  
  provider integer 
}
Table time {
  id integer [primary key]
  year integer
  month integer
  week_of_month integer
  day_of_week_ int2
}


Table product {
  id integer [primary key]
  name varchar [not null]
  sale_price float [not null]
  buy_price float [not null]
}
Table provider {
  id integer [primary key]
  name varchar [not null]
}
Table branch {
  id integer [primary key]
  name varchar
  region varchar [not null]
}

```