SELECT * FROM empleados;
SELECT * FROM empleados WHERE nombreEmpleado = 'Jose Perez';
SELECT * FROM empleados WHERE idEmpleado = 1;
SELECT * FROM empleados;
SELECT nombreEmpleado FROM empleados;
DELETE FROM empleados WHERE idEmpleado = 5;
DELETE FROM empleados WHERE nombreEmpleado = 'Jose Perez';
INSERT INTO empleados (nombreEmpleado, sexo) VALUES ('Diego Carabuena', 'M');
UPDATE empleados SET nombre = 'Juan';
ORDER BY empleados