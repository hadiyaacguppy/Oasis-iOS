//
//  GenderViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 07/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol GenderViewControllerOutput {
    
}

class GenderViewController: BaseViewController {
    
    var interactor: GenderViewControllerOutput?
    var router: GenderRouter?
    
    private lazy var mainStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var topLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 35), color: .white)
        lbl.text = "I am".localized
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var femaleStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var maleStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var humanImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.autoLayout()
        return imgView
    }()
    
    private lazy var genderLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 35), color: .white)
        lbl.autoLayout()
        return lbl
    }()
}

//MARK:- View Lifecycle
extension GenderViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        GenderConfigurator.shared.configure(viewController: self)
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
        
    }
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addTopTitle(){
        mainStackView.addArrangedSubview(topLabel)
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 20),
            topLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 35),
            topLabel.heightAnchor.constraint(equalToConstant: 43)
        ])
    }
    
    private func buildFemaleStackview(){
        mainStackView.addArrangedSubview(femaleStackView)
        
        femaleStackView.addArrangedSubview(humanImageView)
        femaleStackView.addArrangedSubview(genderLabel)
        
        humanImageView.image = R.image.female()
        NSLayoutConstraint.activate([
            femaleStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            femaleStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            femaleStackView.heightAnchor.constraint(equalToConstant: 260),
            
            humanImageView.topAnchor.constraint(equalTo: femaleStackView.topAnchor),
            humanImageView.bottomAnchor.constraint(equalTo: femaleStackView.bottomAnchor),
            humanImageView.leadingAnchor.constraint(equalTo: femaleStackView.leadingAnchor, constant: 24)
        ])
    }
}

//MARK:- NavBarAppearance
extension GenderViewController{
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
extension GenderViewController{
    
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


