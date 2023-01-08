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


"""
Tunel con ngrok 
"""
ngrok.kill() # Finalizamos tunel por se se hubiera quedado uno abierto
ngrok.set_auth_token("2JpygCEUl0J5u4ct6aMvSsWGBWa_52wkRAS4gCxTGzDs4ii4W") # Token del correo ventana.iot@gmail.com
http_tunnel = ngrok.connect(5000,"http")
tunnels = ngrok.get_tunnels() # Obtenemos los tuneles abiertos
vpn = tunnels[1].__str__()    # Guardamos en formato string el valor 1 de la lista 
VpnNgrok=vpn[vpn.find('http'):vpn.find('ngrok.io')+8]  # Otenemos solo la url
print(VpnNgrok)

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

# Config base de datos de archivos (imagenes)
firebase = pyrebase.initialize_app(config)

storage = firebase.storage()

#db=firebase.database()

referencia_db = 'LoginSignup/usuarioRamon1644/pedidos'
ref_imagen = referencia_db + "/urls"
ref_db_imagen = db.reference(ref_imagen)
ref_db_imagen.update({
'accion': 'ok',
     'pedido': VpnNgrok
     })
"""
with open('Credenciales.json') as f: 
        data = json.load(f)

user =  data['usuario']  # Se obtiene valor de usuario 

db=firebase.database()

usuario = 'usuario'+user
"""
#db.child("LoginSignup").child("Ramon1644").child("urls").child("ipglobal").update(VpnNgrok)

app = Flask(__name__)
cap = cv2.VideoCapture(0)
#face_detector = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
def generate():
     while True:
          success, frame = cap.read()
          """
          Parece ser no de utilidad aquí 
          #tunnels = ngrok.get_tunnels() # Obtenemos los tuneles abiertos
          #vpn = tunnels[1].__str__()    # Guardamos en formato string el valor 1 de la lista 
          #VpnNgrok=vpn[vpn.find('http'):vpn.find('ngrok.io')+8]  # Otenemos solo la url
          #print(VpnNgrok)
          """
          if not success:
               break
          else:
               ret, buffer = cv2.imencode(".jpg", frame)
               frame=buffer.tobytes()
               yield(b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
@app.route("/")
def index():
     return render_template("index.html")
@app.route("/video_feed")
def video_feed():
     return Response(generate(),
          mimetype = "multipart/x-mixed-replace; boundary=frame")
if __name__ == "__main__":
     app.run(host='127.0.0.1',port=5000,debug=False)
cap.release()
