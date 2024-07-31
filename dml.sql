-- Categoria
INSERT INTO categorias (nombre_categoria, estado) VALUES
    ('Electrónica', 1),
    ('Ropa', 1),
    ('Alimentos', 1);

-- Producto
INSERT INTO productos (nombre_producto, codigo_barras, precio_venta, stock, estado, id_categoria) 
VALUES 
('Smartphone', '110203352', 700000.00, 70, 1, 1),
('Camiseta', '12344567890', 40000.00, 80, 1, 2),
('Radio', '45961785', 60000.00, 8, 1, 1),
('Pasta', '45879321330', 20000.00, 300, 1, 3);

-- Clientes
INSERT INTO clientes (nombre_cliente, apellidos, celular, direccion, correo_electronico) 
VALUES 
('Juan', 'Pérez', '1234567890', 'Calle 1', 'juan.perez@example.com'),
('María', 'García', '2345678901', 'Calle 2', 'maria.garcia@example.com'),
('Pedro', 'López', '3456789012', 'Calle 3', 'pedro.lopez@example.com');

-- Compras
INSERT INTO compras (fecha_compra, medio_pago, comentario, estado, id_cliente) 
VALUES
('2024-07-25', 'C', 'buen producto', 'A', 1),
('2024-07-26', 'D', 'buena compra', 'A', 2),
('2024-07-27', 'T', 'puede mejorar el producto', 'A', 3);

-- Compras_productos
INSERT INTO compras_productos (cantidad, total, estado, id_compra, id_producto) 
VALUES 
(2,1400000,1, 1, 1),
(3,120000, 3, 2, 2),
(4,80000, 5, 3, 3);
