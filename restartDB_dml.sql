-- Deshabilitar restricción de claves foráneas temporalmente
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT ALL"

-- Vaciar las tablas
EXEC sp_MSforeachtable "DELETE FROM ?"

-- Rehabilitar las claves foráneas
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL"

-- (Opcional) Reiniciar los IDs autoincrementales
EXEC sp_MSforeachtable "DBCC CHECKIDENT ('?', RESEED, 0)"
