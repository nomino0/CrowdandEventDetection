import cv2
from detect import Detector

detector = Detector("yolov5s.pt")
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    detections = detector.detect(frame)
    num_people = 0
    for detection in detections:
        if detection["class"] == 0:  # class 0 corresponds to "person"
            num_people += 1
    cv2.putText(frame, f"Number of people: {num_people}", (10, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
