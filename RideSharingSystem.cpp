#include <iostream>
#include <vector>
#include <string>
#include <memory>
using namespace std;

// ---------- Base Ride Class ----------
class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;
    double fare;

public:
    Ride(int id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist), fare(0.0) {}

    virtual double calculateFare() {
        fare = distance * 1.5; // default rate
        return fare;
    }

    virtual void rideDetails() {
        cout << "Ride ID: " << rideID
             << " | From: " << pickupLocation
             << " -> " << dropoffLocation
             << " | Distance: " << distance << " miles"
             << " | Fare: $" << calculateFare() << endl;
    }

    virtual ~Ride() {}
};

// ---------- StandardRide ----------
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() override {
        fare = distance * 1.5;
        return fare;
    }
};

// ---------- PremiumRide ----------
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() override {
        fare = distance * 2.0; // premium rate
        return fare;
    }
};

// ---------- SharedRide ----------
class SharedRide : public Ride {
    vector<string> coRiders;
public:
    SharedRide(int id, string pickup, string dropoff, double dist, vector<string> riders)
        : Ride(id, pickup, dropoff, dist), coRiders(riders) {}

    double calculateFare() override {
        double totalFare = distance * 1.8; // shared ride total
        fare = totalFare / coRiders.size(); // split fare equally
        return fare;
    }

    void rideDetails() override {
        cout << "Shared Ride ID: " << rideID
             << " | Riders: ";
        for (auto& r : coRiders) cout << r << " ";
        cout << "| From: " << pickupLocation
             << " -> " << dropoffLocation
             << " | Distance: " << distance << " miles"
             << " | Each Pays: $" << calculateFare() << endl;
    }
};

// ---------- Driver ----------
class Driver {
private:
    int driverID;
    string name;
    double rating;
    vector<Ride*> assignedRides;

public:
    Driver(int id, string driverName, double driverRating)
        : driverID(id), name(driverName), rating(driverRating) {}

    void addRide(Ride* ride) { assignedRides.push_back(ride); }

    void getDriverInfo() {
        cout << "\nDriver: " << name << " | Rating: " << rating
             << " | Total Rides: " << assignedRides.size() << endl;
    }
};

// ---------- Rider ----------
class Rider {
private:
    int riderID;
    string name;
    vector<Ride*> requestedRides;

public:
    Rider(int id, string riderName)
        : riderID(id), name(riderName) {}

    void requestRide(Ride* ride) { requestedRides.push_back(ride); }

    void viewRides() {
        cout << "\nRide History for " << name << ":\n";
        for (Ride* r : requestedRides) r->rideDetails();
    }
};

// ---------- Main ----------
int main() {
    cout << "=== Welcome to Anjal's Ride Sharing System ===\n";

    // Create one driver and rider
    Driver driver(1, "Alex", 4.8);
    Rider rider(1, "Sam");

    vector<unique_ptr<Ride>> rides;
    int numRides;
    cout << "\nHow many rides to create? ";
    cin >> numRides;
    cin.ignore();

    for (int i = 0; i < numRides; i++) {
        cout << "\n--- Ride #" << (i + 1) << " ---\n";
        int id = 100 + i;
        string pickup, dropoff, type;
        double distance;

        cout << "Pickup: ";
        getline(cin, pickup);
        cout << "Dropoff: ";
        getline(cin, dropoff);
        cout << "Distance (miles): ";
        cin >> distance;
        cin.ignore();
        cout << "Ride Type (standard/premium/shared): ";
        getline(cin, type);

        if (type == "premium") {
            rides.push_back(make_unique<PremiumRide>(id, pickup, dropoff, distance));
        } else if (type == "shared") {
            int numPassengers;
            cout << "Number of riders sharing: ";
            cin >> numPassengers;
            cin.ignore();

            vector<string> names;
            for (int j = 0; j < numPassengers; j++) {
                string n;
                cout << "Enter Rider " << (j + 1) << " name: ";
                getline(cin, n);
                names.push_back(n);
            }
            rides.push_back(make_unique<SharedRide>(id, pickup, dropoff, distance, names));
        } else {
            rides.push_back(make_unique<StandardRide>(id, pickup, dropoff, distance));
        }

        driver.addRide(rides.back().get());
        rider.requestRide(rides.back().get());
    }

    // Summary
    cout << "\n=== SYSTEM SUMMARY ===\n";
    driver.getDriverInfo();
    rider.viewRides();

    cout << "\nThank you for using the Ride Sharing System!\n";
    return 0;
}
