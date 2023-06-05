//
//  InitialViewController.swift
//  Oasis
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//

import UIKit
import RxSwift
import SessionRepository

protocol InitialViewControllerInput {

}

protocol InitialViewControllerOutput {
    
    func viewDidFinishedLoading()
    
    func retryLoadingRequested()
}

class InitialViewController: BaseViewController, InitialViewControllerInput {

    var output: InitialViewControllerOutput?
    var router: InitialRouter?

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        InitialConfigurator.shared.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        output?.viewDidFinishedLoading()
        setupRetryFetchingCallBack()
        decideRedirection()
    }
    
    
    private
    func decideRedirection(){
        if SessionRepository.shared.userIsLoggedIn {
            self.router?.redirectToTabbarController()
        }else{
            self.router?.redirectToOnboardingScene()
        }
    }
    
    // MARK: Requests
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = {
            
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            
            self.output?.retryLoadingRequested()
        }
    }


    // MARK: Display logic

}
extension InitialViewController: InitialPresenterOutput {
 
    
    
}

