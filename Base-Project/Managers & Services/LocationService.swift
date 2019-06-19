//
//  LocationManager.swift
//  Alfa-SelfCare
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftLocation
import CoreLocation
import SwiftLocation

class LocationService {
    
    static var shared = LocationService()
    
    
    var authorizationStatus  : ReplaySubject<LocationManager.State> = ReplaySubject<LocationManager.State>.create(bufferSize: 2)
    
    var locationDidChange : ReplaySubject<CLLocation> =  ReplaySubject<CLLocation>.create(bufferSize: 10)
    
    let locator = LocationManager.shared
    
    var currentPosition : CLLocation?
    
    private
    var locationSubscription : LocationRequest!
    
    init() {
        
        locator.onAuthorizationChange.add { (state) in
            self.authorizationStatus.onNext(state)
        }
        
        
        locator.locateFromGPS(.continous,
                              accuracy: .any) { (locationRequestData) in
                                do{
                                    let current = try locationRequestData.get()
                                    self.currentPosition = current
                                    self.locationDidChange.onNext(current)
                                    
                                }
                                catch{
                                    return
                                }
                                
        }
    }
    
    func requestAlwaysLocation(){
        locator.requireUserAuthorization(.always)
    }
    
    func requestWhenInUse(){
        locator.requireUserAuthorization(.whenInUse)
    }
    
    func stop(){
        locationSubscription.stop()
    }
    
}
