//
//  LocationManager.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftLocation
import CoreLocation

class LocationService {
    
    static var shared = LocationService()
    
    var authorizationStatus  : ReplaySubject<CLAuthorizationStatus> = ReplaySubject<CLAuthorizationStatus>.create(bufferSize: 2)
    
    var locationDidChange : ReplaySubject<CLLocation> =  ReplaySubject<CLLocation>.create(bufferSize: 10)
    
    var locationDidChangeSignificantly : ReplaySubject<CLLocation> =  ReplaySubject<CLLocation>.create(bufferSize: 10)
    
    var currentPosition : CLLocation?
    
    private var locationSubscription : LocationRequest!
    init() {
        _ = Locator.events.listen{ self.authorizationStatus.onNext($0) }
        
        locationSubscription = Locator.subscribePosition(accuracy: .any, onUpdate: {
            self.currentPosition = $0
            self.locationDidChange.onNext($0)
        }) { (error , loation) -> (Void) in
            
        }
        
        
        Locator.subscribeSignificantLocations(onUpdate: { newLocation in
            self.currentPosition = newLocation
            self.locationDidChangeSignificantly.onNext(newLocation)
        }) { (err, lastLocation) -> (Void) in
            
        }
        
        
    }
    
    func requestAlwaysLocation(){
        Locator.requestAuthorizationIfNeeded(.always)
    }
    
    func requestWhenInUse(){
        Locator.requestAuthorizationIfNeeded(.whenInUse)
    }
    func stop(){
        
        locationSubscription.stop()
    }
    
}
