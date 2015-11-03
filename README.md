#RoomControl

#Author 
* Jeff Zheng 
* Aishwarya Parasuram

#Purpose 
RoomControl is an iOS utility application that helps the user control IoT devices within a room. 

#Features 

* Ability to detect number of users in a room using an PIR motion sensor
* Control the ambient lighting based on room occupancy 
* OPTIONAL: Discover IoT devices within the room 

#Control Flow 

* Start the app and connect with motion sensor 
* Whenever a user walks into a room, sensor detects new entrant and sends information to the application over the internet
* Application UI updates with statistics corresponding to room occupancy 
* App actuates room lighting based on occupancy 
* User can modify how lighting responds to the number of people within the room 
* Manual control of light also optional 
* User can set limit on room occupancy
* Alert the user when the room is over occupied 

#Implemented 
##Model
* Swift file that defines class variables
* Swift file that handles app interaction with the IoT device
* Separate Swift file for each view controller
* AppDelegate.swift

##View 
* List view that displays the IoT devices
* Detailed view that shows the statistics corresponding to the specific IoT device
* Settings page

##Controller
* (Control Page) List view controller that controls logic behind what devices are displayed on the app and controls the logic behind the list view touch 
* (Detail Page) View controller for the detail page 
* Settings page controller 
