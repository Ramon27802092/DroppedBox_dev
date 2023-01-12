# Ventana Inteligente

## Raspberry 

### Instalación de sistema operativo 


### Instalación de ngrok

```
pip install ngrok-api 
```


### Instalación de entorno virtual
Se trabaja con la version virtualenvwrapper

```
 pip install virtualenvwrapper 
```

Dentro de la siguiente liga está la documentación: [Link](https://virtualenvwrapper.readthedocs.io/en/latest/install.html)

Creción del entorno virutal 
```
mkvirtualenv nombredelentorno -p python3
```

Activación del entorno virtual 
```
workon sbb_cv
```

Desactivar el entorno virtual
```
deactivate
```
Comandos útiles 

Activacion de camara ``pip3 install "picamera[array]"``
Listado de entornos vituales ``lsvirtualenv``
Listado de paquetes instalados con versión ``pip freeze``



### OPENCV
La instalación se realizó con base en el siguiente tutorial [OpenCV on Raspberry Pi 4](https://singleboardbytes.com/647/install-opencv-raspberry-pi-4.html), dentro del documento se puede revisar la instalación de OpenCV, Entornos Virtuales, PiCamera. **Tener cuidado de la versión estable **
### Principales problemas 

Visualizar la cámara con OpenCV, se puede utilizar el siguiente comando: 

```
export DISPLAY=:0

```
A continuación se muestran los paquete necesarios para el funcionamiento: 

```
CacheControl==0.12.11
cachetools==5.2.0
certifi==2022.12.7
chardet==4.0.0
charset-normalizer==2.1.1
click==8.1.3
contourpy==1.0.6
cycler==0.11.0
firebase-admin==5.4.0
Flask==2.2.2
fonttools==4.38.0
gcloud==0.17.0
google-api-core==2.11.0
google-api-python-client==2.71.0
google-auth==2.15.0
google-auth-httplib2==0.1.0
google-cloud-core==2.3.2
google-cloud-firestore==2.7.3
google-cloud-storage==2.7.0
google-crc32c==1.5.0
google-resumable-media==2.4.0
googleapis-common-protos==1.57.1
grpcio==1.51.1
grpcio-status==1.51.1
httplib2==0.21.0
idna==2.10
importlib-metadata==6.0.0
itsdangerous==2.1.2
Jinja2==3.1.2
jws==0.1.3
kiwisolver==1.4.4
MarkupSafe==2.1.1
matplotlib==3.6.2
msgpack==1.0.4
ngrok-api==0.8.0
numpy==1.24.1
oauth2client==3.0.0
opencv-python==4.5.4.60
packaging==22.0
picamera==1.13
Pillow==9.4.0
proto-plus==1.22.1
protobuf==4.21.12
pyasn1==0.4.8
pyasn1-modules==0.2.8
pycryptodome==3.4.3
pyngrok==5.2.1
pyparsing==3.0.9
Pyrebase==3.0.27
python-dateutil==2.8.2
python-jwt==2.0.1
PyYAML==6.0
requests==2.28.1
requests-toolbelt==0.7.0
rsa==4.9
six==1.16.0
uritemplate==4.1.1
urllib3==1.26.13
Werkzeug==2.2.2
zipp==3.11.0
```
**Poner atención en firebase, ngrok, opencv**
La version del sistema operativo es con el comando: `cat /etc/os-release`
```
PRETTY_NAME="Raspbian GNU/Linux 11 (bullseye)"
NAME="Raspbian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL=http://www.raspbian.org/RaspbianBugs

```
