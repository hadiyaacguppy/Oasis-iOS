//
//  RegistrationViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol RegistrationViewControllerOutput {
    
}

class RegistrationViewController: BaseViewController {
    
    var interactor: RegistrationViewControllerOutput?
    var router: RegistrationRouter?
    
    private let backgroundImage: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = R.image.newBackground()!
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var mainStackView = {
        UIStackView()
            .axis(.vertical)
            .spacing(40)
            .autoLayout()
            .distributionMode(.fill)
    }()
    
    private lazy var firstNameStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var lastNameStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var mobileStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var emailStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var firstNameTitleLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 33)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "What's your first name?".localized
        return label
    }()
    
    private lazy var lastNameTitleLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 33)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "What's your last name?".localized
        return label
    }()
    
    private lazy var mobileTitleLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 33)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "And mobile number?".localized
        return label
    }()
    
    private lazy var emailTitleLabel : BaseLabel = {
        let label = BaseLabel()
        label.font = MainFont.medium.with(size: 33)
        label.textColor = .white
        label.numberOfLines = 2
        label.text = "And your email?".localized
        return label
    }()
    
    private lazy var nextButton : BaseButton = {
        let btn = BaseButton()
        if #available(iOS 15.0, *) {
            btn.imageStyle  = .init(image: R.image.iconArrow()!, imagePadding: 2.0, imagePlacement: .trailing)
        } else {
            btn.setImage(R.image.iconArrow()!, for: .normal)
            btn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            btn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            btn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        btn.style = .init(titleFont: MainFont.bold.with(size: 20),
                          titleColor: .white,
                          backgroundColor: .clear)
        btn.setTitle("Next".localized, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.onTap {
            self.validateFields()
        }
        return btn
    }()
    
    private lazy var firstNameTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var lastNameTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
    
    private lazy var emailTextfield : WhiteBorderTextfield = {
        let txtf = WhiteBorderTextfield()
        return txtf
    }()
}

//MARK:- View Lifecycle
extension RegistrationViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RegistrationConfigurator.shared.configure(viewController: self)
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
 
    fileprivate
    func setupUI(){
        addBackgroundImage()
        addNextButton()
        buildStacks()
        buildFirstNameStack()
        buildLastNameStack()
        buildEmailStack()
    }
    
    private func addNextButton(){
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 35),
            nextButton.widthAnchor.constraint(equalToConstant: 90),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    private func addBackgroundImage(){
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            //mainStackView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 8)
        ])
        mainStackView.addArrangedSubview(firstNameStackview)
        mainStackView.addArrangedSubview(lastNameStackview)
        mainStackView.addArrangedSubview(emailStackview)
    }
    
    private func buildFirstNameStack(){
        firstNameStackview.addArrangedSubview(firstNameTitleLabel)
        firstNameStackview.addArrangedSubview(firstNameTextfield)
        
        firstNameTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func buildLastNameStack(){
        lastNameStackview.addArrangedSubview(lastNameTitleLabel)
        lastNameStackview.addArrangedSubview(lastNameTextfield)
        
        lastNameTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func buildEmailStack(){
        emailStackview.addArrangedSubview(emailTitleLabel)
        emailStackview.addArrangedSubview(emailTextfield)
        
        emailTextfield.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func validateFields(){
        
        guard !firstNameTextfield.text.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your first name", withCompletionHandler: nil)
            return
        }
        
        guard !lastNameTextfield.text.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your last name", withCompletionHandler: nil)
            return
        }
        
        guard !emailTextfield.text.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your email", withCompletionHandler: nil)
            return
        }
        
        RegistrationDataManager.current.userFirstName = firstNameTextfield.text
        RegistrationDataManager.current.userLastName = lastNameTextfield.text
        RegistrationDataManager.current.userEmail = emailTextfield.text
        
        self.router?.pushToOTPVerificationsScene()
    }
}

//MARK:- NavBarAppearance
extension RegistrationViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
        
        let loginBarButton = UIBarButtonItem(title: "Login".localized, style: .plain, target: self, action: #selector(loginBarButtonPressed))
        loginBarButton.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font : MainFont.medium.with(size: 22)
            ], for: .normal)
        self.navigationItem.rightBarButtonItem = loginBarButton
    }
    
    @objc func loginBarButtonPressed(){
        self.router?.redirectToLogin()
    }
}

//MARK:- Callbacks
extension RegistrationViewController{
    
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


