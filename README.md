ServoControl_PTDBean
====================

A simple example of an iOS app talking to a LightBlue Bean to move a servo.

The iOS app presents a slider, move the slider, and the bean moves the servo.  Simple huh!

Wiring
------
Ah yes, the other important part - wiring up your stuff.  You will need:

- A LightBlue Bean
- A standard servo (3 wires)
- A battery to power the servo (we used 4 AAs in a RC receiver battery box)

Battery + -> Goes to Servo + (Red or Orange)
Battery - -> Goes to Servo - (Black or Brown) and also Bean GND
Bean Pin 3 -> Goes to Servo Singal (Yellow)

What is this LightBlue Bean?
----------------------------
The Bean is a great little device from Punch Through Design: http://punchthrough.com/bean/
It is a Bluetooth 4.0 (BLE) device with an Arduino on it, plus some other bits like a thermometer and gyro, all in a tiny package, with it's own battery.  This means it's great for little 'maker' projects.

Why?
----
We made this simple demo because the Bean is brand new and not many demos exist.  We like to help people, so hopefully this will be useful for someone.

Who?
----
We are Gourmet Pixel, a mobile app development company who also like to tinker with hardware.  Look us up sometime and send us a message.
http://www.gourmetpixel.com