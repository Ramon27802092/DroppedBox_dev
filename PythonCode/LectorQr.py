import firebase_admin
import json
import time
from firebase_admin import credentials
from firebase_admin import db
import cv2 as cv
import pyrebase 
import serial
from datetime import datetime
import signal
import sys

# Estructura de configuracion base de datos para almacenar imagenes
config = {
  "apiKey": "b6fdc2f949668840e5c5700dc4fd8a3a2dee3186",
  "authDomain": "ventanaiot-56921.appspot.com",
  "databaseURL": "https://accounts.google.com/o/oauth2/auth",
  "storageBucket": "ventanaiot-56921.appspot.com"
}

# Config base de datos de archivos (imagenes)
firebase = pyrebase.initialize_app(config)

# Variables de usuario 
id_find = "ID"
st_find = "Status"
img_find = "Imagen"
substring = "ok"        # Variable para indicar que el leector QR aceptó el código
accion = "accion"

# Configuracion de base de datos general  
cred = credentials.Certificate('firebase-sdk.json')
firebase_admin.initialize_app(cred,{
    'databaseURL' : 'https://ventanaiot-56921-default-rtdb.firebaseio.com/'
})

def inicializacion():
    control = 0
    # Lectura de credenciales desde json  
    with open('Credenciales.json') as f: 
        data = json.load(f)

    usuario_temporal =  data['usuario']  # Se obtiene valor de usuario 
    usuario = usuario_temporal.replace(".","+")
    # Concatenamos referencia de base de datos
    referencia_db = 'LoginSignup/usuario'+usuario+'/pedidos'
    accion_db = 'LoginSignup/usuario'+usuario+'/estado'
    estado_db = 'LoginSignup/usuario'+usuario+'/estado/accion'
    estado_pedido_db = 'LoginSignup/usuario'+usuario+'/estado/pedido'



    # Recuperacion de informacion de base de datos general
    ref_db = db.reference(referencia_db)
    ref_estado = db.reference(estado_db)
    ref_accion = db.reference(accion_db)
    ref_pedido = db.reference(estado_pedido_db)

    # Almacenamos diccionario en variable temporal

    temporal_estado = ref_estado.get()
    temporal_pedido = ref_pedido.get()
    temporal = ref_db.get()

    # Obtenemos información de un pedido en específico
    id_number = [val[id_find] for keys, val in temporal.items() if id_find in val]
    st_number = [val[st_find] for keys, val in temporal.items() if st_find in val]
    img_number = [val[img_find] for keys, val in temporal.items() if img_find in val]

    """
    print(id_number)
    print(st_number)
    print(img_number)
    """

    print(temporal_estado,temporal_pedido)

    """
    Este dispositivo solo la lista temporal_estado y temporal_pedido
    """
    #path_on_cloud = "imagen/foo.jpg"
    #path_local = "Foto.jpg"
    dato_apertura="Abrir\n"
    return  ref_db, id_find, st_number, referencia_db

ref_db_global, id_find_global, st_number_global, referencia_db_global = inicializacion()

while True:
    qr = input()
    qr_input = '"'+str(qr)+'"'
    if control == 1:
        bluetooth_config()
        ref_db_global, id_find_global, st_number_global, referencia_db_global = inicializacion()
        control = 0
        print(qr)
        print("Inicializacion nuevamente")
    temporal = ref_db_global.get()
    id_number = [val[id_find_global] for keys, val in temporal.items() if id_find_global in val]
    #len(id_number)
    index = "NA"
    try:
        index = id_number.index(qr_input)
        print("Dato en la lista")
        print(index)
        if(st_number_global[index]=='"Pendiente"'):
            ref_imagen = referencia_db_global + "/estado"
            ref_db_imagen = db.reference(ref_imagen)
            ref_db_imagen.update({
                'accion': 'ok',
                'pedido': id_number[index]
                })
        else:
            print("Ya fue entregado")
    except ValueError:
        print("No se encuentra en la lista")
