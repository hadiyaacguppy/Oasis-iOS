//
//  InitialInteractor.swift
//  Base-Project
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation
import RxSwift

protocol InitialInteractorInput {
    
}

protocol InitialInteractorOutput {
    
    func apiCallFailed(withError error : ErrorResponse) -> ErrorViewModel
    
}

protocol InitialDataSource {
    
}

protocol InitialDataDestination {
    
}

class InitialInteractor: InitialInteractorInput, InitialDataSource, InitialDataDestination {
    
    var output: InitialInteractorOutput?
    
    // MARK: Business logic
    
    
}

extension InitialInteractor: InitialViewControllerOutput, InitialRouterDataSource, InitialRouterDataDestination {
    
    func viewDidFinishedLoading(){
        
    }
    
    func retryLoadingRequested(){
        
    }
}
