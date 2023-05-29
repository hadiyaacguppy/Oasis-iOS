//
//  FriendsModels.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 29/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import RxSwift
import Foundation

struct FriendsModels {
    
    struct ViewModels {
        struct Friend{
            var id : Int
            var name : String?
            var image : URL?
            var buttonTitle : String
        }
    }
}
