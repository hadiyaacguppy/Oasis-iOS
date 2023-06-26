//
//  TeensTasksModels.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import RxSwift
import Foundation

struct TeensTasksModels {
    
    struct ViewModels {
        struct Task{
            var id : Int
            var taskTitle : String?
            var taskDescription : String?
            var amount : Int?
            var currency : String?
        }
    }
}
