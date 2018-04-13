//
//  InitialPresenter.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

protocol InitialPresenterInput {
    
}

protocol InitialPresenterOutput: class {
    func display(errorMessage msg : String )
    func navigatetoLogin()
    func navigatetoMain()
}

class InitialPresenter: InitialPresenterInput {
    
    weak var output: InitialPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension InitialPresenter: InitialInteractorOutput {
    func userIsLoggedIn() {
        output?.navigatetoLogin()
    }
    
    func userIsNotLoggedIn() {
        output?.navigatetoMain()
    }
    
    func didFail(withErrorMessage msg : String){
        output?.display(errorMessage :  msg)
    }
}
