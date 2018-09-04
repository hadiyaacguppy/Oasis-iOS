

## authorizationStatus
ReplaySubject that will contain the current authorizationStatus along with the last one
```swift
	var authorizationStatus  : ReplaySubject<CLAuthorizationStatus> = ReplaySubject<CLAuthorizationStatus>.create(bufferSize: 2)
```

Example :

````swift
  LocationService.shared.authorizationStatus.subscribe{
 }

````


## locationDidChange
ReplaySubject that will contain the the last 10 CLLocations that were captured by the location service
```swift
  var locationDidChange : ReplaySubject<CLLocation> =  ReplaySubject<CLLocation>.create(bufferSize: 10)
```

Example :

````swift
  LocationService.shared.locationDidChange.subscribe{
 }

````

## currentPosition
CLLocation property that will contain the current position of the user. nil if location does not exists
```swift
  var currentPosition : CLLocation?
```

Example :

````swift
  pos = LocationService.shared.currentPosition

````

## requestAlwaysLocation()
Asks the user to allow location always. NSLocationAlwaysAndWhenInUseUsageDescription must be present in info.plist
```swift
  func requestAlwaysLocation()
```

Example :

````swift
  LocationService.shared.requestAlwaysLocation()

````

## requestWhenInUse()
Asks the user to allow location when the app is in use. NSLocationWhenInUseUsageDescription must be present in info.plist
```swift
  func requestWhenInUse()
```

Example :

````swift
  LocationService.shared.requestWhenInUse()

````
