SELECT * FROM empleados;
SELECT * FROM empleados WHERE nombre_empleado = "Juan Perez";
UPDATE empleados SET nombreEmpleado = 'Benito Jose' WHERE idEmpleado = 3;
SELECT * FROM empleados INNER JOIN empleadoDepartamento WHERE empleados.idEmpleado = empleadoDepartamento.idEmpleado
SELECT DISTINCT nameEmpleado FROM empleados