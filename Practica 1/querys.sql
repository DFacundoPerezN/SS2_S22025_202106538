-- Total de Ventas por año
SELECT 
    f.year,
    SUM(v.unidades * v.price) AS total_ventas
FROM Venta_hecho v
JOIN Fecha_dim f ON v.fecha_id = f.id
GROUP BY f.year
ORDER BY f.year;
-- Total de Compras por año
SELECT 
    f.year,
    SUM(c.unidades * c.price) AS total_compras
FROM Compra_hecho c
JOIN Fecha_dim f ON c.fecha_id = f.id
GROUP BY f.year
ORDER BY f.year;

-- Productos con perdida
SELECT 
    p.name AS producto,
    SUM(v.unidades * v.price) AS total_perdida
FROM Venta_hecho v
JOIN Product_dim p ON v.product_id = p.id
WHERE v.unidades < 0    
GROUP BY p.name
-- p2
SELECT 
    f.year,
    p.nombre AS producto,
    SUM(v.unidades * (v.price - p.costo)) AS perdida_total
FROM Venta_hecho v
JOIN Producto_dim p ON v.producto_id = p.id
JOIN Fecha_dim f ON v.fecha_id = f.id
WHERE v.price < p.costo
GROUP BY f.year, p.nombre
HAVING SUM(v.unidades * (v.price - p.costo)) < 0
ORDER BY f.year, perdida_total;
-- Los 5 productos más vendidos 
SELECT 
    p.nombre AS producto,
    SUM(v.unidades) AS total_unidades
FROM Venta_hecho v
JOIN Producto_dim p ON v.producto_id = p.id
GROUP BY p.nombre
ORDER BY total_unidades DESC
LIMIT 5;
-- Ingresos por region
SELECT 
    s.region,
    SUM(v.unidades * v.price) AS total_ingresos
    FROM Venta_hecho v
    JOIN Sucursal_dim s ON v.sucursal_id = s.id
GROUP BY s.region
ORDER BY total_ingresos DESC;  
-- Ingresos por año
SELECT 
    f.year,
    SUM(v.unidades * v.price) AS total_ingresos
    FROM Venta_hecho v
    JOIN Fecha_dim f ON v.fecha_id = f.id
GROUP BY f.year
ORDER BY total_ingresos;
-- Provedores con más compras
SELECT 
    pr.name AS proveedor,
    SUM(c.unidades * c.price) AS total_compras
FROM Compra_hecho c
JOIN Provider_dim pr ON c.provider_id = pr.id
GROUP BY pr.name
ORDER BY total_compras DESC
LIMIT 10;