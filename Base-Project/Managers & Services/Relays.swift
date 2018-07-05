//
//  Relays.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxCocoa

class Relays : NSObject{
    
    static let instance = Relays()
    
    var exampleOfRelay : PublishRelay<Int?> = PublishRelay<Int?>()
}
