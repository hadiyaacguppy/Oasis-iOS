//
//  ParentsHomeModels.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import RxSwift
import Foundation

struct ParentsHomeModels {
    
    struct ViewModels {
        struct Payment{
            var paymentType : String?
            var title : String?
            var amount : Int?
        }
        
        struct Balance {
            var amount : Int?
            var currency : String?
        }
    }
}
