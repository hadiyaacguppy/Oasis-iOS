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
        imageV.image = R.image.backgroundHomepageBox()!
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var mainStackView = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }()
    
    private lazy var firstNameStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }
    
    private lazy var lastNameStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }
    
    private lazy var mobileStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }
    
    private lazy var emailStackview = {
        UIStackView()
            .axis(.vertical)
            .spacing(4)
            .autoLayout()
    }
    
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
    
    private lazy var nextButton : BaseButton = {
        let btn = BaseButton()
       // btn.imageStyle  = .init(image: <#T##UIImage#>, imagePadding: <#T##CGFloat#>, imagePlacement: <#T##NSDirectionalRectEdge#>)
        btn.style = .init(titleFont: MainFont.bold.with(size: 20),
                          titleColor: .white,
                          backgroundColor: .clear)
        btn.setTitle("Next".localized, for: .normal)
        return btn
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
}

//MARK:- NavBarAppearance
extension RegistrationViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
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


