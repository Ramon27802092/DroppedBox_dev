from flask import Flask
from flask import render_template
from flask import Response
import cv2
from pyngrok import ngrok
import firebase_admin
import json
import time
from firebase_admin import credentials
from firebase_admin import db
import pyrebase 
import socket

# Retardo para que la tarjeta se conecte
#time.sleep(20)

"""
Tunel con ngrok 
"""
ngrok.kill() # Finalizamos tunel por se se hubiera quedado uno abierto
ngrok.set_auth_token("2J3jqYXYKg25LWelaw8HNkFYD2x_7o74Gi5cUdfQzCJQyiX43") # Token del correo jaramillo.martinez.ramon@gmail.com
http_tunnel = ngrok.connect(22,"http")
tunnels = ngrok.get_tunnels() # Obtenemos los tuneles abiertos
vpn = tunnels[1].__str__()    # Guardamos en formato string el valor 1 de la lista 
VpnNgrok=vpn[vpn.find('http'):vpn.find('ngrok.io')+8]  # Otenemos solo la url
print(VpnNgrok)

"""
Se obtiene ip address 
"""
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
print(s.getsockname()[0])

"""
Conexion con base de datos para enviar 
"""
# Estructura de configuracion base de datos para almacenar imagenes
config = {
  "apiKey": "b6fdc2f949668840e5c5700dc4fd8a3a2dee3186",
  "authDomain": "ventanaiot-56921.appspot.com",
  "databaseURL": "https://accounts.google.com/o/oauth2/auth",
  "storageBucket": "ventanaiot-56921.appspot.com"
}

# Configuracion de base de datos general  
cred = credentials.Certificate('firebase-sdk.json')
firebase_admin.initialize_app(cred,{
    'databaseURL' : 'https://ventanaiot-56921-default-rtdb.firebaseio.com/'
})

# Credenciales de usuario 
with open('Credenciales.json') as f: 
        data = json.load(f)

usuario_temporal =  data['usuario']  # Se obtiene valor de usuario
usuario = usuario_temporal.replace(".","+")

# Config base de datos de archivos (imagenes)
firebase = pyrebase.initialize_app(config)
referencia_db = 'LoginSignup/usuario'+usuario #referencia_db = 'LoginSignup/usuarioRamon1644'
ref_urls = referencia_db + "/urls"
ref_db_urls = db.reference(ref_urls)
ref_db_urls.update({
	'ipgcontrol': VpnNgrok,
     'iplcontrol': s.getsockname()[0]
     	})

while True:
     print(VpnNgrok)
     print(s.getsockname()[0])
     time.sleep(5)
