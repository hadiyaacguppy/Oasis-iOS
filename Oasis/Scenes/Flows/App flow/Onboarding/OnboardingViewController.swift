//
//  OnboardingViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift


protocol OnboardingViewControllerOutput {
    
}

class OnboardingViewController: BaseViewController {
    
    var interactor: OnboardingViewControllerOutput?
    var router: OnboardingRouter?
    
    
    
}

//MARK:- View Lifecycle
extension OnboardingViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        OnboardingConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupOnboarding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupOnboarding(){
        let titlesAndDescriptions: [String: String] = [
            "page1": "Learn about spending, saving & earning !",
            "page2": "Send and request money in one click !",
            "page3": "Complete tasks to get paid instantly with Guppy !",
            "page4": "Earn Guppies and unlock special offers !"
        ]
        
        let contents: [OnboardingConfig.Content] = titlesAndDescriptions.compactMap {
            OnboardingConfig.Content(
                title: OnboardingConfig.Title(text: $0.key),
                description: OnboardingConfig.Description(text: $0.value),
                image: OnboardingConfig.Image(image: UIImage(named: $0.key.replacingOccurrences(of: " ", with: ""))!))
        }
        
        let skipButton = OnboardingConfig.SkipButton(
            attributedTitle: NSAttributedString(
                string: "Login",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ])
        )
        
        let pageControl = OnboardingConfig.PageControl(
            currentPageIndicatorTintColor: .white,
            pageIndicatorTintColor: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255.0 / 255.0, alpha: 0.24)
        )
        
        let nextButton = OnboardingConfig.NextButton(
            title: "Next",
            lastTitle: "Register",
            titleColor: .white,
            backgroundColor: .clear
        )
        
        let config = OnboardingConfig(
            contents: contents,
            skipButton: skipButton,
            pageControl: pageControl,
            nextButton: nextButton
        )
        
        let introductionController = OnboardingController(config: config)
        introductionController.delegate = self
        present(introductionController, animated: true)
    }
}

//MARK:- NavBarAppearance
extension OnboardingViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .appDefault
    }
}

//MARK:- Callbacks
extension OnboardingViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
        }
    }
}

// MARK: - IntroductionControllerDelegate
extension OnboardingViewController: IntroductionControllerDelegate {
    func didSkipButtonTapped() {
        // do something
        //self.router?.redirectToTabbarController()
        self.router?.pushToLoginVC()
    }
    
    func didNextButtonTappedAtEndOfContents(){
        self.router?.redirectToRegistration()
    }
}
