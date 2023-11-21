from flask import Flask
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

def conectar_a_mysql():
    try:
        conexion = mysql.connector.connect(
            user="admin1", 
            password="PanyChocolate1", 
            host="formales123.mysql.database.azure.com", 
            port=3306, 
            database="formales",
            ssl_disabled=False
        )
        return conexion
    except Error as e:
        print("Error al conectar a MySQL", e)
        return None

def ejecutar_consultas_sql(archivo):
    try:
        with open(archivo, 'r') as file:
            consultas = [line.strip() for line in file if line.strip()]
        
        conexion = conectar_a_mysql()
        if conexion.is_connected():
            cursor = conexion.cursor()
            for consulta in consultas:
                palabra_clave = consulta.split()[0].lower()
                cursor.execute(consulta)
                if palabra_clave == 'select':
                    resultados = cursor.fetchall()
                    for resultado in resultados:
                        print(resultado)
                else:
                    conexion.commit()
                    print(f"Operación {palabra_clave} ejecutada con éxito.")
            cursor.close()
            conexion.close()
    except Error as e:
        print("Error al ejecutar consultas en MySQL", e)

@app.route('/ejecutar_consultas', methods=['GET', 'POST', 'PUT', 'DELETE'])
def ejecutar_consultas():
    ejecutar_consultas_sql('Query.sql')
    return "Consultas ejecutadas, revisa la consola para ver los resultados."

if __name__ == '__main__':
    app.run(debug=True)
