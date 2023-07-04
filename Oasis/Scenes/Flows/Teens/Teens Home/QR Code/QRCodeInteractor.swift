//
//  QRCodeInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol QRCodeInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol QRCodeDataStore {
    
}

class QRCodeInteractor: QRCodeDataStore{
    
    var presenter: QRCodeInteractorOutput?
    
}

extension QRCodeInteractor: QRCodeViewControllerOutput{
    
}
