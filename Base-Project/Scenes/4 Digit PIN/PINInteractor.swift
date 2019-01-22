//
//  PINInteractor.swift
//  Base-Project
//
//  Created by Hadi on 1/22/19.
//  Copyright (c) 2019 Tedmob. All rights reserved.
//

//  
import Foundation
import RxSwift

protocol PINInteractorInput {
    
}

protocol PINInteractorOutput {
    
     func apiCallFailed(withError error : ErrorResponse) -> ErrorViewModel
    
}

protocol PINDataSource {
    
}

protocol PINDataDestination {
    
}

class PINInteractor: PINInteractorInput, PINDataSource, PINDataDestination {
    
    var output: PINInteractorOutput?
    
    // MARK: Business logic
    
    
}

extension PINInteractor: PINViewControllerOutput, PINRouterDataSource, PINRouterDataDestination {
    
    func viewDidFinishedLoading(){
        
    }
    
    func retryLoadingRequested(){
        
    }
}
