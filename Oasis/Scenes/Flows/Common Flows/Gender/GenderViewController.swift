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
        stackView.spacing = 2
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
        stackView.spacing = 12
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var maleStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var femaleImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.autoLayout()
        return imgView
    }()
    
    private lazy var maleImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.autoLayout()
        return imgView
    }()
    
    private lazy var femaleGenderLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 35), color: .white)
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var maleGenderLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 35), color: .white)
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var nextViewButton : RoundedViewWithArrow = {
        let view = RoundedViewWithArrow(frame: .zero)
        view.onTap {
            self.router?.pushToOTPVerificationsScene()
        }
        return view
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
        view.backgroundColor = Constants.Colors.appViolet
        
        addTopTitle()
        addNextButton()
        buildStacks()
        buildFemaleStackview()
        buildMaleStackview()
    }
    
    private func addNextButton(){
        view.addSubview(nextViewButton)
        NSLayoutConstraint.activate([
            nextViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextViewButton.widthAnchor.constraint(equalToConstant: 86),
            nextViewButton.heightAnchor.constraint(equalToConstant: 86),
            nextViewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
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
    
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
 
    private func buildFemaleStackview(){
        mainStackView.addArrangedSubview(femaleStackView)
        femaleImageView.image = R.image.female()
        femaleStackView.addArrangedSubview(femaleImageView)

        femaleGenderLabel.text = "Female"
        femaleStackView.addArrangedSubview(femaleGenderLabel)

        femaleStackView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        femaleGenderLabel.widthAnchor.constraint(equalToConstant: 135).isActive = true
    }
    
    private func buildMaleStackview(){
        mainStackView.addArrangedSubview(maleStackView)
        maleGenderLabel.text = "Male"
        maleStackView.addArrangedSubview(maleGenderLabel)
        
        maleImageView.image = R.image.male()
        maleStackView.addArrangedSubview(maleImageView)

        maleStackView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        maleGenderLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
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


