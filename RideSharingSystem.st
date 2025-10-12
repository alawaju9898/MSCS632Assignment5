"==================== RIDE CLASSES ===================="

Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance fare'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharingSystem'.

!Ride class methodsFor: 'instance creation'!
newId: anId pickup: pick dropoff: drop distance: dist
    ^ self new initializeId: anId pickup: pick dropoff: drop distance: dist
!!

!Ride methodsFor: 'initialization'!
initializeId: anId pickup: pick dropoff: drop distance: dist
    rideID := anId.
    pickupLocation := pick.
    dropoffLocation := drop.
    distance := dist.
    fare := 0.
!!

!Ride methodsFor: 'operations'!
calculateFare
    fare := distance * 1.5.
    ^ fare
!!

!Ride methodsFor: 'printing'!
formatNumber: aNumber
    | rounded intPart fracPart fracStr |
    rounded := (aNumber * 100) rounded / 100.
    intPart := rounded truncated.
    fracPart := ((rounded - intPart) * 100) rounded.
    fracStr := fracPart printString.
    fracPart < 10 ifTrue: [fracStr := '0', fracStr].
    ^ intPart printString, '.', fracStr
!

rideDetails
    | fareString |
    fareString := self formatNumber: self calculateFare.
    Transcript show: 'Ride ID: '; show: rideID printString;
        show: ' | From: '; show: pickupLocation;
        show: ' -> '; show: dropoffLocation;
        show: ' | Distance: '; show: distance printString;
        show: ' miles | Fare: $'; show: fareString; nl.
!!

Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharingSystem'.

!StandardRide methodsFor: 'operations'!
calculateFare
    fare := distance * 1.5.
    ^ fare
!!

Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharingSystem'.

!PremiumRide methodsFor: 'operations'!
calculateFare
    fare := distance * 2.0.
    ^ fare
!!

Ride subclass: #SharedRide
    instanceVariableNames: 'coRiders'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharingSystem'.

!SharedRide class methodsFor: 'instance creation'!
newId: anId pickup: pick dropoff: drop distance: dist riders: riderNames
    ^ self new initializeId: anId pickup: pick dropoff: drop distance: dist riders: riderNames
!!

!SharedRide methodsFor: 'initialization'!
initializeId: anId pickup: pick dropoff: drop distance: dist riders: riderNames
    super initializeId: anId pickup: pick dropoff: drop distance: dist.
    coRiders := OrderedCollection new.
    riderNames isNil ifFalse: [coRiders addAll: riderNames].
    coRiders isEmpty ifTrue: [coRiders add: 'Unknown Rider'].
!!

!SharedRide methodsFor: 'operations'!
calculateFare
    | totalFare |
    totalFare := distance * 1.8.
    fare := totalFare / coRiders size.
    ^ fare
!!

!SharedRide methodsFor: 'printing'!
rideDetails
    | riderListString fareString |
    riderListString := coRiders inject: '' into: [:acc :r | acc isEmpty ifTrue: [r] ifFalse: [acc, ', ', r]].
    fareString := self formatNumber: self calculateFare.

    Transcript show: 'Shared Ride ID: '; show: rideID printString;
        show: ' | Riders: '; show: riderListString;
        show: ' | From: '; show: pickupLocation;
        show: ' -> '; show: dropoffLocation;
        show: ' | Distance: '; show: distance printString;
        show: ' miles | Each Pays: $'; show: fareString; nl.
!!

"==================== DRIVER CLASS ===================="

Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharingSystem'.

!Driver class methodsFor: 'instance creation'!
newId: anId name: n rating: r
    ^ self new initializeId: anId name: n rating: r
!!

!Driver methodsFor: 'initialization'!
initializeId: anId name: n rating: r
    driverID := anId.
    name := n.
    rating := r.
    assignedRides := OrderedCollection new.
!!

!Driver methodsFor: 'operations'!
addRide: aRide
    assignedRides add: aRide.
!!

!Driver methodsFor: 'printing'!
formatNumber: aNumber
    | rounded intPart fracPart fracStr |
    rounded := (aNumber * 100) rounded / 100.
    intPart := rounded truncated.
    fracPart := ((rounded - intPart) * 100) rounded.
    fracStr := fracPart printString.
    fracPart < 10 ifTrue: [fracStr := '0', fracStr].
    ^ intPart printString, '.', fracStr
!

getDriverInfo
    | ratingString |
    ratingString := self formatNumber: rating.
    Transcript show: 'Driver: '; show: name;
        show: ' | Rating: '; show: ratingString;
        show: ' | Total Rides: '; show: assignedRides size printString; nl.
!!

"==================== RIDER CLASS ===================="

Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharingSystem'.

!Rider class methodsFor: 'instance creation'!
newId: anId name: n
    ^ self new initializeId: anId name: n
!!

!Rider methodsFor: 'initialization'!
initializeId: anId name: n
    riderID := anId.
    name := n.
    requestedRides := OrderedCollection new.
!!

!Rider methodsFor: 'operations'!
requestRide: aRide
    requestedRides add: aRide.
!!

!Rider methodsFor: 'printing'!
viewRides
    Transcript show: 'Ride History for '; show: name; show: ':'; nl.
    requestedRides do: [:r | r rideDetails].
!!

"==================== MAIN EXECUTION ===================="

| driver rider rides numRides |

Transcript show: '=== Welcome to Anjal''s Ride Sharing System ==='; nl; nl.

driver := Driver newId: 1 name: 'Alex' rating: 4.8.
rider := Rider newId: 1 name: 'Sam'.
rides := OrderedCollection new.

Transcript show: 'How many rides to create? '; flush.
numRides := stdin nextLine asInteger.

1 to: numRides do: [:i |
    | id pickup dropoff distance rideType ride |
    
    Transcript nl; show: '--- Ride #', i printString, ' ---'; nl.
    id := 100 + i - 1.
    
    Transcript show: 'Pickup: '; flush.
    pickup := stdin nextLine.
    
    Transcript show: 'Dropoff: '; flush.
    dropoff := stdin nextLine.
    
    Transcript show: 'Distance (miles): '; flush.
    distance := stdin nextLine asNumber.
    
    Transcript show: 'Ride Type (standard/premium/shared): '; flush.
    rideType := stdin nextLine.
    
    (rideType = 'premium') ifTrue: [
        ride := PremiumRide newId: id pickup: pickup dropoff: dropoff distance: distance.
    ] ifFalse: [
        (rideType = 'shared') ifTrue: [
            | numPassengers names |
            Transcript show: 'Number of riders sharing: '; flush.
            numPassengers := stdin nextLine asInteger.
            
            names := OrderedCollection new.
            1 to: numPassengers do: [:j |
                | passengerName |
                Transcript show: 'Enter Rider ', j printString, ' name: '; flush.
                passengerName := stdin nextLine.
                names add: passengerName.
            ].
            ride := SharedRide newId: id pickup: pickup dropoff: dropoff distance: distance riders: names.
        ] ifFalse: [
            ride := StandardRide newId: id pickup: pickup dropoff: dropoff distance: distance.
        ].
    ].
    
    rides add: ride.
    driver addRide: ride.
    rider requestRide: ride.
].

Transcript nl; show: '=== SYSTEM SUMMARY ==='; nl.
driver getDriverInfo.
rider viewRides.

Transcript nl; show: 'Thank you for using the Ride Sharing System!'; nl.