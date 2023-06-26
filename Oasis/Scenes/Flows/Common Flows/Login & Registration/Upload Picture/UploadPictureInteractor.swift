//
//  UploadPictureInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol UploadPictureInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol UploadPictureDataStore {
    
}

class UploadPictureInteractor: UploadPictureDataStore{
    
    var presenter: UploadPictureInteractorOutput?
    
}

extension UploadPictureInteractor: UploadPictureViewControllerOutput{
    
}
