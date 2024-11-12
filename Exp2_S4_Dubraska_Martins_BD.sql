-- Tabla Clientes
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    fecha_registro DATE,
    email VARCHAR2(100),
    telefono VARCHAR2(20)
);

-- Tabla Productos
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    nombre_producto VARCHAR2(100),
    categoria VARCHAR2(50),
    precio NUMBER(10, 2),
    stock NUMBER
);

-- Tabla Personal de Ventas
CREATE TABLE sales_staff (
    staff_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    email VARCHAR2(100),
    telefono VARCHAR2(20)
);

-- Tabla Ventas
CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    product_id NUMBER,
    cantidad NUMBER,
    fecha_venta DATE,
    total_venta NUMBER(10, 2),
    staff_id NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES sales_staff(staff_id)
);


-- Insertar datos en la tabla Clientes
INSERT INTO customers VALUES (1, 'Carlos', 'Perez', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'carlos.perez@techsales.com', '1234567890');
INSERT INTO customers VALUES (2, 'Ana', 'Lopez', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'ana.lopez@techsales.com', '0987654321');
INSERT INTO customers VALUES (3, 'Luis', 'Martinez', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'luis.martinez@techsales.com', '1122334455');
INSERT INTO customers VALUES (4, 'Maria', 'Garcia', TO_DATE('2023-08-25', 'YYYY-MM-DD'), 'maria.garcia@techsales.com', '2233445566');
INSERT INTO customers VALUES (5, 'Jose', 'Rodriguez', TO_DATE('2023-09-30', 'YYYY-MM-DD'), 'jose.rodriguez@techsales.com', '3344556677');

-- Insertar datos en la tabla Productos
INSERT INTO products VALUES (1, 'Laptop Lenovo', 'Computadoras', 1200.50, 50);
INSERT INTO products VALUES (2, 'Mouse Logitech', 'Accesorios', 25.99, 150);
INSERT INTO products VALUES (3, 'Monitor Samsung', 'Pantallas', 320.00, 30);
INSERT INTO products VALUES (4, 'Teclado Corsair', 'Accesorios', 80.00, 100);
INSERT INTO products VALUES (5, 'Impresora HP', 'Impresoras', 150.00, 20);

-- Insertar datos en la tabla Personal de Ventas
INSERT INTO sales_staff VALUES (1, 'Juan', 'Diaz', 'juan.diaz@techsales.com', '9876543210');
INSERT INTO sales_staff VALUES (2, 'Elena', 'Ramos', 'elena.ramos@techsales.com', '8765432109');
INSERT INTO sales_staff VALUES (3, 'Miguel', 'Ruiz', 'miguel.ruiz@techsales.com', '7654321098');
INSERT INTO sales_staff VALUES (4, 'Laura', 'Fernandez', 'laura.fernandez@techsales.com', '6543210987');
INSERT INTO sales_staff VALUES (5, 'Pablo', 'Gomez', 'pablo.gomez@techsales.com', '5432109876');

-- Insertar datos en la tabla Ventas
INSERT INTO sales VALUES (1, 1, 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 1200.50, 1);
INSERT INTO sales VALUES (2, 2, 2, 2, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 51.98, 2);
INSERT INTO sales VALUES (3, 3, 3, 1, TO_DATE('2023-09-03', 'YYYY-MM-DD'), 320.00, 3);
INSERT INTO sales VALUES (4, 4, 4, 3, TO_DATE('2023-09-04', 'YYYY-MM-DD'), 240.00, 4);
INSERT INTO sales VALUES (5, 5, 5, 1, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 150.00, 5);


-- Desafio 1

SELECT 
    s.staff_id,
    ss.nombre || ' ' || ss.apellido AS nombre_completo,
    COUNT(s.sale_id) AS cantidad_ventas,
    SUM(s.total_venta) AS ingreso_total
FROM 
    sales s
JOIN 
    sales_staff ss ON s.staff_id = ss.staff_id
GROUP BY 
    s.staff_id, ss.nombre, ss.apellido
ORDER BY 
    ingreso_total DESC;

-- Desafio 2
SELECT 
    c.customer_id,
    c.nombre || ' ' || c.apellido AS nombre_completo,
    COUNT(s.sale_id) AS cantidad_ventas,
    MIN(s.fecha_venta) AS primera_venta,
    MAX(s.fecha_venta) AS ultima_venta
FROM 
    customers c
JOIN 
    sales s ON c.customer_id = s.customer_id
GROUP BY 
    c.customer_id, c.nombre, c.apellido
HAVING 
    COUNT(s.sale_id) >= 1
ORDER BY 
    cantidad_ventas DESC;



