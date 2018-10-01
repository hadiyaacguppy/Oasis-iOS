//
//  InitialInteractor.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

protocol InitialInteractorInput {
    
}

protocol InitialInteractorOutput {
    func didFail(withErrorMessage msg : String)
    func userIsLoggedIn()
    func userIsNotLoggedIn()
}

protocol InitialDataSource {
    
}

protocol InitialDataDestination {
    
}

class InitialInteractor: InitialInteractorInput, InitialDataSource, InitialDataDestination {
    
    var output: InitialInteractorOutput?
    
    
    func checkIfUserIsLoggedIn() -> Bool {
        //TODO: Should Implmenet
        return false
    }
    
    
    // MARK: Business logic
    
    
}

extension InitialInteractor: InitialViewControllerOutput, InitialRouterDataSource, InitialRouterDataDestination {
    func retryLoadingRequested() {
        
    }
    
    func viewDidFinishedLoading(){
        if checkIfUserIsLoggedIn() {
            
        }else {
            
        }
    }
}
