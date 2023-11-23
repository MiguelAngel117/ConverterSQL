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
    resultados_str = ""
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
                        resultados_str += str(resultado) + "<br>"
                else:
                    conexion.commit()
                    resultados_str += f"Operación {palabra_clave} ejecutada con éxito.<br>"
                resultados_str += "<hr>"
            cursor.close()
            conexion.close()
    except Error as e:
        resultados_str += "Error al ejecutar consultas en MySQL: " + str(e)
    return resultados_str

@app.route('/ejecutar_consultas', methods=['GET', 'POST', 'PUT', 'DELETE'])
def ejecutar_consultas():
    return ejecutar_consultas_sql('Query.sql')

if __name__ == '__main__':
    app.run(debug=True)
