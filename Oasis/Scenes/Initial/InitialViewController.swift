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

    lazy var logoImageView : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.contentMode = .scaleAspectFit
        img.image = R.image.logoEmblem()!
        img.autoLayout()
        return img
    }()
    
    lazy var logoNameImageView : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.contentMode = .scaleAspectFit
        img.image = R.image.logoName()!
        img.autoLayout()
        return img
    }()
    
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
        setupUI()
    }
    
    private
    func setupUI(){
        view.backgroundColor = Constants.Colors.appViolet
        view.addSubviews(logoImageView)
        view.addSubviews(logoNameImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoNameImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            logoNameImageView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor)
        ])
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

