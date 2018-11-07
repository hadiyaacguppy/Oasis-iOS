//
//  BaseWebViewInteractor.swift
//  Base-Project
//
//  Created by Wassim on 10/24/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation
import RxSwift

protocol BaseWebViewInteractorInput {
    
}

protocol BaseWebViewInteractorOutput {
    
     func apiCallFailed(withError error : ErrorResponse) -> ErrorViewModel
    
}

protocol BaseWebViewDataSource {
    
}

protocol BaseWebViewDataDestination {
    
}

class BaseWebViewInteractor: BaseWebViewInteractorInput, BaseWebViewDataSource, BaseWebViewDataDestination {
    
    var output: BaseWebViewInteractorOutput?
    var urlString : String = ""
    // MARK: Business logic
    
    
}

extension BaseWebViewInteractor: BaseWebViewViewControllerOutput, BaseWebViewRouterDataSource, BaseWebViewRouterDataDestination {
    func webViewIsReady() -> Single<URLRequest> {
        guard let url = URL(string: self.urlString) else {
            return Single.error("")
        }
        let urlRequest = URLRequest(url: url)
        
        return Single.just(urlRequest)
    }
    func viewDidFinishedLoading(){
        
    }
    
    func retryLoadingRequested(){
        
    }
}
