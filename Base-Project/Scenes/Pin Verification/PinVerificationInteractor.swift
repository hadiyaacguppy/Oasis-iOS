//
//  PinVerificationInteractor.swift
//  Healr
//
//  Created by Mhmd Rizk on 11/28/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation
import RxSwift

protocol PinVerificationInteractorInput {
    
}

protocol PinVerificationInteractorOutput {
    
    func apiCallFailed(withError error : ErrorResponse) -> ErrorViewModel
    
}

protocol PinVerificationDataSource {
    
}

protocol PinVerificationDataDestination {
    
}

class PinVerificationInteractor: PinVerificationInteractorInput, PinVerificationDataSource, PinVerificationDataDestination {
    
    var output: PinVerificationInteractorOutput?
    
    fileprivate var pin : Int! {
        get {
            let pinString = firstPin! + secondPin! + thirdPin! + fourthPin!
            return Int(pinString)!
        }
    }
    
    fileprivate var firstPin : String?
    
    fileprivate var secondPin : String?
    
    fileprivate var thirdPin : String?
    
    fileprivate var fourthPin : String?
    
    // MARK: Business logic
    
    
  
    
}

extension PinVerificationInteractor: PinVerificationViewControllerOutput, PinVerificationRouterDataSource, PinVerificationRouterDataDestination {
    
    
    
    func confirmButtonTapped() -> Completable {
        /* provide your API call with the pin by  using self.pin */
        return Completable.empty()
//        APIClient
//            .shared
//            .submitPin(self.pin)
//            .subscribe(onComplete: { in
//                completable(.completed)
//            }, onError: { (error) in
//                completable(.error(self.output!.apiCallFailed(withError: error.errorResponse)))
//            })
//        })
//
    }
    
    func resendButtonTapped() -> Completable {
        return Completable.empty()
        //        APIClient
        //            .shared
        //            .resendPin()
        //            .subscribe(onComplete: { in
        //                completable(.completed)
        //            }, onError: { (error) in
        //                completable(.error(self.output!.apiCallFailed(withError: error.errorResponse)))
        //            })
        //        })
        //
        
    }
    
    func pinOneValueSet(_ value: String) {
        self.firstPin = value
    }
    
    func pinTwoValueSet(_ value: String) {
        self.secondPin = value
    }
    
    func pinThreeValueSet(_ value: String) {
        self.thirdPin = value
    }
    
    func pinFourthValueSet(_ value: String) {
        self.fourthPin = value
    }
    
    func viewDidFinishedLoading(){
        
    }
    
    func retryLoadingRequested(){
        
    }
}
