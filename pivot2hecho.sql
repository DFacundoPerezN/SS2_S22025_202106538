INSERT INTO Product_dim (id, name, category_id, branch_id)
SELECT 
    p.id,
    p.name,
    c.id AS category_id,
    b.id AS branch_id
FROM Pivot_Product p
LEFT JOIN Category_dim c
    ON p.category = c.name
LEFT JOIN Branch_dim b
    ON p.branch = b.name
WHERE NOT EXISTS (
    SELECT 1
    FROM Product_dim pd
    WHERE pd.id = p.id
);
TRUNCATE TABLE Pivot_Product;

----Venta
INSERT INTO Venta_hecho (fecha_id, sucursal_id, cliente_id, vendedor_id, product_id, unidades, price)
SELECT 
    f.id AS fecha_id,
    s.id AS sucursal_id,
    c.id AS cliente_id,
    vd.id AS vendedor_id,
    p.id AS product_id,
    v.unidades,
    v.price
FROM Pivot_Venta v
LEFT JOIN Product_dim p
    ON v.product_id = p.id
LEFT JOIN Client_dim c
    ON v.cliente_id = c.id
LEFT JOIN Vendedor_dim vd
    ON v.vendedor_id = vd.id
LEFT JOIN Sucursal_dim s
    ON v.sucursal_id = s.id
LEFT JOIN Fecha_dim f
    ON v.fecha = f.fecha
WHERE NOT EXISTS (
    SELECT 1
    FROM Venta_hecho vh
    WHERE vh.fecha_id = f.id
      AND vh.sucursal_id = s.id
      AND vh.cliente_id = c.id
      AND vh.vendedor_id = vd.id
      AND vh.product_id = p.id
);
TRUNCATE TABLE Pivot_Venta;

---Compra 
INSERT INTO Compra_hecho (fecha_id, sucursal_id, product_id, provider_id, unidades, price)
SELECT
    f.id AS fecha_id,
    s.id AS sucursal_id,
    p.id AS product_id,
    pr.id AS provider_id,
    c.unidades,
    c.price
FROM Pivot_Compras c
LEFT JOIN Product_dim p
    ON c.product_id = p.id
LEFT JOIN Provider_dim pr
    ON c.provider_id = pr.id
LEFT JOIN Sucursal_dim s
    ON c.sucursal_id = s.id
LEFT JOIN Fecha_dim f
    ON c.fecha = f.fecha
WHERE NOT EXISTS (
    SELECT 1
    FROM Compra_hecho ch
    WHERE ch.fecha_id = f.id
      AND ch.sucursal_id = s.id
      AND ch.product_id = p.id
      AND ch.provider_id = pr.id
);
TRUNCATE TABLE Pivot_Compras;
