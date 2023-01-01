import cv2
import sys
import pyrebase

# config data base
config = {
    "apiKey": "AIzaSyAkczivRUHC5K-OAyfrael2yvdrwhEaLcA",
    "authDomain": "crowddet-raspb-iotminiproject.firebaseapp.com",
    "databaseURL": "https://crowddet-raspb-iotminiproject-default-rtdb.europe-west1.firebasedatabase.app",
    "storageBucket": "crowddet-raspb-iotminiproject.appspot.com"
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()

f = "facemodel.xml"
facemodel = cv2.CascadeClassifier(f)
video_capture = cv2.VideoCapture(0)
cv2.namedWindow('frame', cv2.WINDOW_NORMAL)


f = "haarcascade_upperbody.xml"
facemodel = cv2.CascadeClassifier(f)
video_capture = cv2.VideoCapture(0)
cv2.namedWindow('frame', cv2.WINDOW_NORMAL)

while True:
    ret, frame = video_capture.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = facemodel.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=2,
        minSize=(25, 50),
        flags=cv2.CASCADE_SCALE_IMAGE
    )
    print(len(faces))

    data = {
        "Nombre de personnes": len(faces)
    }

    db.child("Status").push(data)
    db.update(data)

    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x + w, h + y), (0, 0, 255) ,1 )
    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
