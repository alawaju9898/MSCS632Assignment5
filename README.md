# MSCS632Assignment5
Steps to Run the C++ Code
Open VS Code.
Open the folder containing the file rideshare.cpp.
Open the built-in terminal in VS Code (Ctrl + `).
Compile the code using: g++ rideshare.cpp -o rideshare
Run the program:  ./rideshare
View the output in the terminal.

Steps to Run the Smalltalk Code
Install and open Pharo or Squeak Smalltalk.
Load the file rideshare.st.
Highlight and evaluate the bottom section of the file that starts after “Main”.
The output will appear in the Transcript or console window.


How the Program Works
Two rides are created — one Standard and one Premium.
A driver and a rider are created.
The driver is assigned both rides using addRide().
The rider requests both rides using requestRide().
The rider calls viewRides() to see ride details.
A list of rides demonstrates polymorphism when fareCalculation() is called on each ride.


