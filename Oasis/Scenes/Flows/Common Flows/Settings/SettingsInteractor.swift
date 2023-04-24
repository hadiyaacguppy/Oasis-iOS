//
//  SettingsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 24/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol SettingsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol SettingsDataStore {
    
}

class SettingsInteractor: SettingsDataStore{
    
    var presenter: SettingsInteractorOutput?
    
}

extension SettingsInteractor: SettingsViewControllerOutput{
    
}
