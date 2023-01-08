from flask import Flask
from flask import render_template
from flask import Response
import cv2
app = Flask(__name__)
cap = cv2.VideoCapture(1)
#face_detector = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
def generate():
     while True:
          success, frame = cap.read()
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
     app.run(host='192.168.0.18',port=5000,debug=False)
cap.release()
