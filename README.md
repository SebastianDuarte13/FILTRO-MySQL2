# Consultas Básicas

Consultar todos los productos y sus categorías

```sql
SELECT id, nombre_producto, codigo_barras, precio_venta, stock, estado, id_categoria
FROM productos;

SELECT id, nombre_categoria, estado
FROM categorias;
```

Consultar todas las compras y los clientes que las realizaron
```sql
SELECT id, id_cliente,fecha_compra,medio_pago,comentario,estado
FROM compras;

SELECT nombre_cliente,apellidos,celular,direccion,correo_electronico
FROM clientes;
```


Consultar los productos comprados en una compra específica
```sql
SELECT id, id_cliente,fecha_compra,medio_pago,comentario,estado
FROM compras
WHERE id = 1;
```


Agregar un nuevo producto

```sql
INSERT INTO productos (nombre_producto, codigo_barras, precio_venta, stock, estado, id_categoria) 
VALUES 
('Televisor', '9876543210', 800000.00, 10, 1, 1);
```


Actualizar el stock de un producto
```sql
UPDATE productos 
SET stock = 5
WHERE id = 4;
```


Consultar todas las compras de un cliente específico
```sql
SELECT id, id_cliente, fecha_compra,medio_pago,comentario,estado
FROM compras
WHERE id_cliente = 1;
```


Consultar todos los clientes y sus correos electrónicos
```sql
SELECT id, nombre_cliente, apellidos, correo_electronico
FROM clientes;
```


Consultar la cantidad total de productos comprados en cada compra

```sql
select id_compra AS "Id de las compra", cantidad AS "Cantidad de compras", id_producto AS "Id del producto"
FROM compras_productos;
```

Consultar las compras realizadas en un rango de fechas

```sql
SELECT id, id_cliente,fecha_compra,medio_pago,comentario,estado
FROM compras
WHERE fecha_compra BETWEEN '2024-07-25' AND '2024-07-26';
```



# Consultas usando funciones agregadas

Contar la cantidad de productos por categoría

```SQL
SELECT id_categoria AS "Id de categoria", COUNT(id) AS "Cantidad de Productos" 
FROM productos
GROUP BY id_categoria;
```

Calcular el precio total de ventas por cada cliente

```SQL
SELECT c.nombre_cliente AS Cliente, c.apellidos AS Apellidos, SUM(cp.total) AS "Total Ventas"
FROM clientes AS c
JOIN compras AS co ON c.id = co.id_cliente
JOIN compras_productos AS cp ON co.id = cp.id_compra
GROUP BY c.id, c.nombre_cliente, c.apellidos;
```

Calcular el precio promedio de los productos por categoría

```SQL
SELECT id_categoria AS "Id de categoria", AVG(stock) AS "Promedio de Productos" 
FROM productos
GROUP BY id_categoria;
```

Encontrar la fecha de la primera y última compra registrada

```SQL
SELECT MIN(fecha_compra) AS "Primera fecha", MAX(fecha_compra) AS "Ultima fecha"
FROM compras;
```

Calcular el total de ingresos por ventas

```SQL
SELECT SUM(total) AS "Ingresos totales"
FROM compras_productos;
```

Contar la cantidad de compras realizadas por cada medio de pago

```SQL
SELECT medio_pago AS "Medio de Pago", COUNT(id) AS "Cantidad de Compras"
FROM compras
GROUP BY medio_pago;
```

Calcular el total de productos vendidos por cada producto

```SQL
SELECT p.nombre_producto AS Producto, SUM(cp.cantidad) AS Total_Vendido
FROM compras_productos cp
JOIN productos p ON cp.id_producto = p.id
GROUP BY p.id, p.nombre_producto;
```

Obtener el promedio de cantidad de productos comprados por compra

```SQL
SELECT AVG(cantidad) AS "promedio cantidad producto compra"
FROM compras_productos;
```

Encontrar los productos con el stock más bajo

```SQL
SELECT stock, nombre_producto
FROM productos
ORDER BY stock ASC
LIMIT 3;
```

Calcular el total de productos comprados y el total gastado por cliente

```SQL
SELECT c.nombre_cliente, c.apellidos, SUM(cp.cantidad) AS "Productos comprados", SUM(total) AS "gastado"
FROM clientes AS c
JOIN compras AS co ON c.id = co.id_cliente
JOIN compras_productos AS cp ON co.id = cp.id_compra
GROUP BY c.nombre_cliente, c.apellidos;
```


# Consultas usando join

Consultar todos los productos con sus categorías

```SQL
SELECT p.id AS "id producto", p.nombre_producto AS "nombre producto", p.codigo_barras, p.precio_venta, p.stock, p.estado, c.id AS "id categoria", c.nombre_categoria AS "nombre categoria", c.estado
FROM productos AS p
JOIN categorias AS c ON p.id_categoria = c.id;
```

Consultar todas las compras y los clientes que las realizaron

```SQL
SELECT c.id, c.fecha_compra, c.medio_pago, c.comentario, c.estado, cl.nombre_cliente, cl.apellidos, cl.celular, cl.direccion, cl.correo_electronico
FROM compras AS c
JOIN clientes AS cl ON cl.id = c.id_cliente;
```

Consultar los productos comprados en cada compra

```SQL
SELECT co.id AS "id de compra", co.fecha_compra AS "fecha compra", p.nombre_producto AS "nombre producto", cp.cantidad AS "cantidad", cp.total AS "Total"
FROM compras_productos AS cp
JOIN productos AS p ON cp.id_producto = p.id
JOIN compras AS co ON cp.id_compra = co.id;
```

Consultar las compras realizadas por un cliente específico

```SQL
SELECT c.id AS "Id compra", c.fecha_compra AS "fecha compra", c.medio_pago AS "medio pago", c.comentario AS comentario, c.estado AS estado
FROM compras AS c
JOIN clientes AS cl ON c.id_cliente = cl.id
WHERE cl.nombre_cliente = 'Juan' AND cl.apellidos = 'Pérez';
```

Consultar el total gastado por cada cliente

```SQL
SELECT cli.nombre_cliente, cli.apellidos, SUM(cp.total) AS Total
FROM clientes AS cli
JOIN compras AS co ON cli.id = co.id_cliente
JOIN compras_productos AS cp ON co.id = cp.id_compra
GROUP BY cli.nombre_cliente, cli.apellidos;
```

Consultar el stock disponible de productos y su categoría

```SQL
SELECT p.nombre_producto, c.nombre_categoria , p.stock 
FROM productos AS p
JOIN categorias c ON p.id_categoria = c.id;
```

Consultar los detalles de compras junto con la información del cliente y el producto

```SQL
SELECT co.id AS Compra_ID, co.fecha_compra AS Fecha_Compra, co.medio_pago AS Medio_de_Pago, co.comentario AS Comentario, co.estado AS Estado, cli.nombre_cliente AS Cliente, cli.apellidos AS Apellidos, p.nombre_producto AS Producto, cp.cantidad AS Cantidad_Comprada, cp.total AS Total
FROM compras AS co
JOIN clientes AS cli ON co.id_cliente = cli.id
JOIN compras_productos AS cp ON co.id = cp.id_compra
JOIN productos AS p ON cp.id_producto = p.id;
```

Consultar los productos que han sido comprados por más de una cantidad específica

```SQL
SELECT p.nombre_producto, SUM(cp.cantidad) AS "Total Comprado"
FROM compras_productos AS cp
JOIN productos AS p ON cp.id_producto = p.id
GROUP BY p.id, p.nombre_producto
HAVING SUM(cp.cantidad) > 2;
```

Consultar la cantidad total de productos vendidos por categoría

```SQL
SELECT c.nombre_categoria , SUM(cp.cantidad) AS vendidos
FROM compras_productos AS cp
JOIN productos AS p ON cp.id_producto = p.id
JOIN categorias AS c ON p.id_categoria = c.id
GROUP BY, c.nombre_categoria;
```

Consultar los clientes que han realizado compras en un rango de fechas específico

```SQL
SELECT cl.nombre_cliente, cl.apellidos, co.id AS "id compra", co.fecha_compra
FROM compras AS co
JOIN clientes AS cl ON co.id_cliente = cl.id
WHERE co.fecha_compra BETWEEN '2024-07-25' AND '2024-07-26';
```

Consultar el total gastado por cada cliente junto con la cantidad total de productos
comprados

```SQL
SELECT cli.nombre_cliente, cli.apellidos, SUM(cp.total) AS "Total Gastado", SUM(cp.cantidad) AS "total comprados"
FROM clientes cli
JOIN compras co ON cli.id = co.id_cliente
JOIN compras_productos cp ON co.id = cp.id_compra
GROUP BY cli.id, cli.nombre_cliente, cli.apellidos;
```

Consultar los productos que nunca han sido comprados

```SQL
SELECT p.nombre_producto, c.nombre_categoria
FROM productos AS p
LEFT JOIN compras_productos AS cp ON p.id = cp.id_producto
LEFT JOIN categorias AS c ON p.id_categoria = c.id
WHERE cp.id_producto IS NULL;
```

Consultar los clientes que han realizado más de una compra y el total gastado por ellos

```SQL
SELECT cl.nombre_cliente, cl.apellidos, COUNT(co.id) AS "numero de compras", SUM(cp.total) AS "gastado"
FROM clientes AS cl
JOIN compras AS co ON cl.id = co.id_cliente
JOIN compras_productos AS cp ON co.id = cp.id_compra
GROUP BY cl.id, cl.nombre_cliente, cl.apellidos
HAVING COUNT(co.id) > 1;
```

Consultar los productos más vendidos por categoría

```SQL
SELECT c.nombre_categoria, p.nombre_producto, SUM(cp.cantidad) AS "vendidos"
FROM compras_productos AS cp
JOIN productos AS p ON cp.id_producto = p.id
JOIN categorias AS c ON p.id_categoria = c.id
GROUP BY c.id, c.nombre_categoria, p.id, p.nombre_producto
ORDER BY c.nombre_categoria, SUM(cp.cantidad) DESC;
```


# Subconsultas

Consultar los productos que tienen un precio de venta superior al precio promedio de todos
los productos

```SQL
SELECT nombre_producto,precio_venta 
FROM productos
WHERE precio_venta > (SELECT AVG(precio_venta)
                                FROM productos);
```

Consultar los clientes que han gastado más del promedio general en sus compras

```SQL

```

Consultar las categorías que tienen más de 5 productos

```SQL
SELECT nombre_categoria
FROM categorias AS c
WHERE 
    (SELECT 
     COUNT(p.id)
     FROM productos AS p
     WHERE p.id_categoria = c.id
) > 5;
```

Consultar los productos más vendidos (top 5) por categoría

```SQL

```

Consultar los clientes que han realizado compras en los últimos 30 días

```SQL
SELECT 
    nombre_cliente,
    apellidos
FROM 
    clientes
WHERE id IN (
      SELECT id_cliente
      FROM compras
      WHERE fecha_compra BETWEEN '2024-07-01' AND '2024-07-31'
);
```

Consultar las compras y sus productos para un cliente específico, mostrando solo las
compras más recientes

```SQL

```

Consultar las categorías que tienen productos con un stock por debajo del promedio general

```SQL

```

Consultar los productos que han sido comprados por todos los clientes

```SQL

```

Consultar las compras que tienen más productos que el promedio de productos por compra

```SQL

```

Consultar los productos que se han vendido menos de la cantidad promedio de productos
vendidos

```SQL

```


# Requerimientos de entrega

1. Cree un repositorio.
2. Genere los comandos DDL y publíquelos en el Repositorio.
3. Genere comando DML para realizar la inserción de datos.
4. Genere README donde se encuentre el enunciado de la consulta y su solución.
5. Publicar el repositorio en el classroom. No olvidar entregar el trabajo en el classroom.