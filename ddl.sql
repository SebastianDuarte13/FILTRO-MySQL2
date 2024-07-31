DROP DATABASE miscompras;

CREATE DATABASE miscompras;

USE miscompras;

CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL,
    estado TINYINT
);
    
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    celular DECIMAL(10,0) NOT NULL,
    direccion VARCHAR(80) NOT NULL,
    correo_electronico VARCHAR(70) NOT NULL
);

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(100) NOT NULL,
    codigo_barras VARCHAR(150) NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    estado TINYINT,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);


CREATE TABLE compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_compra DATE NOT NULL,
    medio_pago CHAR(1) NOT NULL,
    comentario VARCHAR(300) NOT NULL,
    estado CHAR(1) NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE compras_productos (
    cantidad INT NOT NULL,
    total DECIMAL(16,2) NOT NULL,
    estado TINYINT NOT NULL,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES compras(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id)
);