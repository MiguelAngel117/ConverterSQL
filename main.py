from flask import Flask, jsonify, request
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

def conectar_a_mysql():
    try:
        conexion = mysql.connector.connect(
            host="0.tcp.ngrok.io",  # Reemplaza con tu host de ngrok
            port="12388",          # Reemplaza con tu puerto de ngrok
            user="root",          # Tu usuario
            password="admin",      # Tu contraseña
            database="formales"    # Nombre de tu base de datos
        )
        return conexion
    except Error as e:
        print("Error al conectar a MySQL", e)
        return None

@app.route('/empleados', methods=['GET'])
def obtener_empleados():
    try:
        conexion = conectar_a_mysql()
        if conexion.is_connected():
            cursor = conexion.cursor()
            cursor.execute("SELECT * FROM empleados")
            resultados = cursor.fetchall()
            empleados = [{"nombre": fila[0]} for fila in resultados]
            cursor.close()
            conexion.close()

            # Imprimir los empleados por consola
            for empleado in empleados:
                print(empleado)

            return jsonify(empleados)
    except Error as e:
        print("Error al obtener datos de MySQL", e)
        return jsonify([]), 500


@app.route('/empleados', methods=['POST'])
def agregar_empleado():
    datos = request.json
    try:
        conexion = conectar_a_mysql()
        if conexion.is_connected():
            cursor = conexion.cursor()
            query = "INSERT INTO empleados (nombre) VALUES (%s)"
            cursor.execute(query, (datos['nombre'],))
            conexion.commit()
            cursor.close()
            conexion.close()
            return jsonify({"mensaje": "Empleado agregado exitosamente"}), 201
    except Error as e:
        print("Error al insertar en MySQL", e)
        return jsonify({"mensaje": "Error al agregar empleado"}), 500

if __name__ == '__main__':
    app.run(debug=True)
