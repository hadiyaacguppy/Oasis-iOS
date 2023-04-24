//
//  SettingsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 24/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol SettingsViewControllerOutput {
    
}

class SettingsViewController: BaseViewController {
    
    var interactor: SettingsViewControllerOutput?
    var router: SettingsRouter?
    
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Settings".localized
        
        return lbl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
        
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var aboutOasisView : SettingsClickableOptionView = {
        let view = SettingsClickableOptionView.init(title: "About Oasis",
                                                    iconName: R.image.iconAbout.name, height: 68)
        return view
    }()
    
    private lazy var notificationsView : SettingsClickableOptionView = {
        let view = SettingsClickableOptionView.init(title: "Notifications",
                                                    iconName: R.image.notificationCiond.name, height: 68)
        return view
    }()
    
    private lazy var privacySecurityView : SettingsClickableOptionView = {
        let view = SettingsClickableOptionView.init(title: "Privacy & Security",
                                                    iconName: R.image.securityIcon.name, height: 68)
        return view
    }()
    
    
    private lazy var changePasswordView : SettingsClickableOptionView = {
        let view = SettingsClickableOptionView.init(title: "Change Password",
                                                    iconName: R.image.passwordIcon.name, height: 68)
        return view
    }()
    
    
    private lazy var helpView : SettingsClickableOptionView = {
        let view = SettingsClickableOptionView.init(title: "Help",
                                                    iconName: R.image.helpIcon.name, height: 68)
        return view
    }()
    
    private lazy var logoutView : SettingsClickableOptionView = {
        let view = SettingsClickableOptionView.init(title: "Logout",
                                                    iconName: R.image.logoutIcon.name, height: 68)
        view.onTap { [weak self] in
            guard let self = self else {return}
            self.router?.redirectToLogin()
        }
        return view
    }()
}

//MARK:- View Lifecycle
extension SettingsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SettingsConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupUI(){
        addLogout()
        addScrollView()
        addTitle()
        addOptions()
    }
    
    private func addTitle(){
        stackView.addArrangedSubview(topTitleLabel)
    }
    
    private func addLogout(){
        view.addSubview(logoutView)
        
        NSLayoutConstraint.activate([
            logoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            logoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            logoutView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addScrollView (){
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: logoutView.topAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -64)
        ])
    }
    
    private func addOptions(){
        

        
        stackView.addArrangedSubview(aboutOasisView)
        stackView.addArrangedSubview(notificationsView)
        stackView.addArrangedSubview(privacySecurityView)
        stackView.addArrangedSubview(changePasswordView)
        stackView.addArrangedSubview(helpView)
    }
    
}

//MARK:- NavBarAppearance
extension SettingsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        addDismissButton()
    }
}

//MARK:- Callbacks
extension SettingsViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            #warning("Retry Action does not set")
        }
    }
}


