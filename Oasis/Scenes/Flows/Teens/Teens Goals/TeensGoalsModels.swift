//
//  TeensGoalsModels.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import RxSwift
import Foundation

struct TeensGoalsModels {
    
    struct ViewModels {
        
        struct Goal{
            var goalID : Int
            var goalTitle : String?
            var amount : Int?
            var saved : Int?
            var currency : String?
        }
    }
}
