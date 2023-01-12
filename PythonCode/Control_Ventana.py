import firebase_admin
import json
import time
from firebase_admin import credentials
from firebase_admin import db
import cv2 as cv
import pyrebase 
import serial
from datetime import datetime 

# Estructura de configuracion base de datos para almacenar imagenes
config = {
  "apiKey": "b6fdc2f949668840e5c5700dc4fd8a3a2dee3186",
  "authDomain": "ventanaiot-56921.appspot.com",
  "databaseURL": "https://accounts.google.com/o/oauth2/auth",
  "storageBucket": "ventanaiot-56921.appspot.com"
}

# Config base de datos de archivos (imagenes)
firebase = pyrebase.initialize_app(config)

storage = firebase.storage()

# Variable para captura de imagen
cam = cv.VideoCapture(0)

# Variables de usuario 
id_find = "ID"
st_find = "Status"
img_find = "Imagen"
substring = "ok"        # Variable para indicar que el leector QR aceptó el código
accion = "accion"

# Lectura de credenciales desde json  
with open('Credenciales.json') as f: 
    data = json.load(f)

usuario =  data['usuario']  # Se obtiene valor de usuario
usuario_temporal = usuario.replace("."+"+") 

# Concatenamos referencia de base de datos
referencia_db = 'LoginSignup/usuario'+usuario+'/pedidos'
accion_db = 'LoginSignup/usuario'+usuario+'/estado'
estado_db = 'LoginSignup/usuario'+usuario+'/estado/accion'
estado_pedido_db = 'LoginSignup/usuario'+usuario+'/estado/pedido'

# Configuracion de base de datos general  
cred = credentials.Certificate('firebase-sdk.json')
firebase_admin.initialize_app(cred,{
    'databaseURL' : 'https://ventanaiot-56921-default-rtdb.firebaseio.com/'
})

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
dato_apertura="Abrir"
while True:
    time.sleep(5)
    temporal_estado = ref_estado.get()
    temporal_pedido = ref_pedido.get()
    # Si temporal estado es ok, se comienza el proceso de apertura
    if temporal_estado == substring:
        """ Codigo necesario para arduino, revisar puerto correcto
        #ser = serial.Serial('COM11', 9600)
        #ser.write(dato_apertura.encode())
        #ser.close()
        """
	ser = serial.Serial('/dev/ttyACM0', 115200)
        ser.write(bytes(dato_apertura, 'UTF-8'))
        ser.close()
        # Actualizamos estado de accion de ok por na
        ref_accion.update({
            'accion': 'na'
        })
        now = datetime.now()
        date_string = now.strftime("%d%m%Y%H%M%S")
        time.sleep(25)
        s, img = cam.read()
        cv.namedWindow("Foto")
        cv.imshow("Foto", img)
        # Si el argumento es 1, continua, si es 0 espera hasta que una tecla es precionada
        cv.waitKey(1)
        # Nombre de la foto usuario + pedido + fecha
        n_foto = usuario+"pedidos"+str(temporal_pedido)+ date_string+".jpg"
        cv.imwrite(n_foto,img)
        # Libera y destruye ventana
        cam.release()
        cv.destroyAllWindows()
        path_local = n_foto
        path_on_cloud = "/" + n_foto 
        print("Actualizacion de estado inicio") 
        # Almacenamos imagen en base de datos
        storage.child(path_on_cloud).put(path_local)
        # Obtenemos url de la imagen y actualizacomo base de datos
        url_img = storage.child(path_on_cloud).get_url('apiKey')
        
        ref_imagen = referencia_db + "/pedidos" + str(temporal_pedido)
        ref_db_imagen = db.reference(ref_imagen)
        ref_db_imagen.update({
            'Imagen': n_foto,
            'Status': 'Entregado'
            })
        print("Proceso de apertura")
        
    else:
        print("En espera")
        

'''
Si el campo Status es QR OK, se comienza con la secuencia de apartura y toma de fotografía 

if st_number == substring:
    print("Proceso de apertura")
    s, img = cam.read()
    cv.namedWindow("Foto")
    cv.imshow("Foto", img)
    # Si el argumento es 1, continua, si es 0 espera hasta que una tecla es precionada
    cv.waitKey(1)
    # Nombre de la foto
    cv.imwrite("Foto.jpg",img)
    # Libera y destruye ventana
    cam.release()
    cv.destroyAllWindows()
    path_local = "Foto.jpg"
    path_on_cloud = usuario + "/" + path_local 
    print("Actualizacion de estado inicio") 
    storage.child(path_on_cloud).put(path_local)
    time.sleep(2)
    print("Actualizacion de estado fin")
else:
    print("No encontrado")
'''
