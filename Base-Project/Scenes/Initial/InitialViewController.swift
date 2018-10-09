//
//  InitialViewController.swift
//  Base-Project
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//

import UIKit
import RxSwift

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

