//
//  GoalsModels.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import RxSwift
import Foundation

struct GoalsModels {
    
    struct ViewModels {
        struct Goal{
            var id : Int
            var Title : String?
            var amount : Int?
            var saved : Int?
            var endDate : String?
            var goalImage : String?
            var currency : String?
            
        }
    }
}
