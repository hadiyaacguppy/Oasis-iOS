//
//  FriendsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 29/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol FriendsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol FriendsDataStore {
    
}

class FriendsInteractor: FriendsDataStore{
    
    var presenter: FriendsInteractorOutput?
    
}

extension FriendsInteractor: FriendsViewControllerOutput{
    
}
