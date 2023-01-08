from flask import Flask
from flask import render_template
from flask import Response
import cv2
from pyngrok import ngrok

"""
Tunel con ngrok 
"""
ngrok.kill() # Finalizamos tunel por se se hubiera quedado uno abierto
ngrok.set_auth_token("2JpygCEUl0J5u4ct6aMvSsWGBWa_52wkRAS4gCxTGzDs4ii4W") # Token del correo ventana.iot@gmail.com
http_tunnel = ngrok.connect(5000,"http")
tunnels = ngrok.get_tunnels() # Obtenemos los tuneles abiertos
vpn = tunnels[1].__str__()    # Guardamos en formato string el valor 1 de la lista 
VpnNgrok=vpn[vpn.find('http'):vpn.find('ngrok.io')+8]  # Otenemos solo la url
#print(VpnNgrok)
"""
Conexion con base de datos para enviar 
"""

app = Flask(__name__)
cap = cv2.VideoCapture(1)
#face_detector = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
def generate():
     while True:
          success, frame = cap.read()
          tunnels = ngrok.get_tunnels() # Obtenemos los tuneles abiertos
          vpn = tunnels[1].__str__()    # Guardamos en formato string el valor 1 de la lista 
          VpnNgrok=vpn[vpn.find('http'):vpn.find('ngrok.io')+8]  # Otenemos solo la url
          print(VpnNgrok)
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
