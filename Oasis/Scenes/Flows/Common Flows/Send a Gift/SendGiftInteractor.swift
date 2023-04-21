//
//  SendGiftInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol SendGiftInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol SendGiftDataStore {
    
}

class SendGiftInteractor: SendGiftDataStore{
    
    var presenter: SendGiftInteractorOutput?
    
}

extension SendGiftInteractor: SendGiftViewControllerOutput{
    
}
