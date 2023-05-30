//
//  PaymentsModels.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import RxSwift
import Foundation

struct PaymentsModels {
    
    struct ViewModels {
        struct PaymentType {
            var id : Int
            var name : String?
        }
        
        struct Payment {
            var id : Int
            var paymentTypeTitle : String?
            var title : String?
            var amount : Int?
            var currency : String?
        }
    }
}
