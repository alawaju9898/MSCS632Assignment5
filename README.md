# MSCS632Assignment5
A simple ride-sharing system built in C++, GNU Smalltalk that demonstrates object-oriented programming concepts including inheritance, polymorphism, and collections.


Steps to Run the C++ Code
Open VS Code.
Open the folder containing the file rideshare.cpp.
Open the built-in terminal in VS Code (Ctrl + `).
Compile the code using: g++ -std=c++17 RideSharingSystem.cpp -o ride
Run the program:  ./ride
View the output in the terminal.

Steps to Run the Smalltalk Code:
Install smalltalk for macOS
brew install gnu-smalltalk
Save the code as RideSharingSystem.st
Run the program:
gst RideSharingSystem.st
The output will appear in the Transcript or console window.


Follow the interactive prompts:

Enter the number of rides to create
For each ride, provide:

Pickup location
Dropoff location
Distance in miles
Ride type: standard, premium, or shared


If you select shared, you'll also enter:

Number of riders sharing the ride
Name of each rider



Example Run:
=== Welcome to Anjal's Ride Sharing System ===

How many rides to create? 2

--- Ride #1 ---
Pickup: Downtown
Dropoff: Airport
Distance (miles): 15
Ride Type (standard/premium/shared): premium

--- Ride #2 ---
Pickup: Mall
Dropoff: Home
Distance (miles): 8
Ride Type (standard/premium/shared): shared
Number of riders sharing: 3
Enter Rider 1 name: Alice
Enter Rider 2 name: Bob
Enter Rider 3 name: Carol

=== SYSTEM SUMMARY ===
Driver: Alex | Rating: 4.80 | Total Rides: 2
Ride History for Sam:
Ride ID: 100 | From: Downtown -> Airport | Distance: 15 miles | Fare: $30.00
Shared Ride ID: 101 | Riders: Alice, Bob, Carol | From: Mall -> Home | Distance: 8 miles | Each Pays: $4.80

Thank you for using the Ride Sharing System!


