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
            "Make Great Things": "We build products that are fast, effortless to use and aesthetically pleased. We roll up our sleeves and create things worthy of our clients’ and users’ time.",
            "Deliver Results": "There’s nothing like watching your app come alive. Each week we deliver a build of your app with release notes on what’s new, updated, fixed, or in progress.",
            "Embrace Transparency": "Each idea, code commit, or design concept is put into a shared space. You don’t just get an email that shows what we did when we’re done.",
            "Seek Mastery": "We build products that are fast, effortless to use and aesthetically pleased. We roll up our sleeves and create things worthy of our clients’ and users’ time.",
            "Take Ownership": "We take ownership of the solutions that we provide to our customers. We are not afraid to speak up and stand for what we think is true.",
            "Have Fun": "We believe businesses that encourage having fun are the ones where the best people do their best work."
        ]
        
        let contents: [OnboardingConfig.Content] = titlesAndDescriptions.compactMap {
            OnboardingConfig.Content(
                title: OnboardingConfig.Title(text: $0.key),
                description: OnboardingConfig.Description(text: $0.value),
                image: OnboardingConfig.Image())
            //OnboardingConfig.Image(image: UIImage(named: $0.key.replacingOccurrences(of: " ", with: ""))!)
        }
        
        let skipButton = OnboardingConfig.SkipButton(
            attributedTitle: NSAttributedString(
                string: "Login",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0),
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                ])
        )
        
        let pageControl = OnboardingConfig.PageControl(
            currentPageIndicatorTintColor: UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0),
            pageIndicatorTintColor: UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.4)
        )
        
        let nextButton = OnboardingConfig.NextButton(
            title: "Next",
            lastTitle: "Let's Go",
            titleColor: .white,
            backgroundColor: UIColor(red: 0.0 / 255.0, green: 102.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
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
        statusBarStyle = .default
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
    }
}
