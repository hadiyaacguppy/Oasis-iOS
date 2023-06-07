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
    
    private lazy var mainStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var bottomImageView : UIImageView = {
        let img = UIImageView()
        img.image = R.image.fishRight()!
        img.contentMode = .scaleAspectFit
        img.autoLayout()
        return img
    }()
    
    private lazy var roundView : BaseUIView = {
       let view = BaseUIView()
        view.backgroundColor = UIColor(hexFromString: "#D9D9D9", alpha: 0.3)
        view.roundCorners = .all(radius: 43)
        view.autoLayout()
        return view
    }()
    
    var nameView : TitleWithTextFieldView!
    var emailView : TitleWithTextFieldView!
    
    var userEmail : String?
    var userName : String?
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
        self.view.backgroundColor = Constants.Colors.appViolet
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
        buildStacks()
        buildTitlewithLabelViews()
        buildBottomView()
    }
    
    private func buildStacks(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
           // mainStackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10)
        ])
    }
    
    private func buildTitlewithLabelViews(){
         nameView = TitleWithTextFieldView.init(requestTitle: "What is your Name?",
                                                    textsColor: .white,
                                                    usertext: "",
                                                    textSize: 35,
                                                    isAgeRequest: false,
                                                    labelHeight: 89)
        
        emailView = TitleWithTextFieldView.init(requestTitle: "What is your Email?",
                                                    textsColor: .white,
                                                    usertext: "",
                                                    textSize: 35,
                                                    isAgeRequest: false,
                                                    labelHeight: 89)
        
        mainStackView.addArrangedSubview(nameView)
        mainStackView.addArrangedSubview(emailView)
        
        nameView.anyTextField.delegate = self
        emailView.anyTextField.delegate = self
        
        NSLayoutConstraint.activate([
            nameView.heightAnchor.constraint(equalToConstant: 160),
            emailView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func buildBottomView(){
        view.addSubview(bottomImageView)
        view.addSubview(roundView)
        
        let arrowImage = BaseImageView(frame: .zero)
        arrowImage.image = R.image.longWhiteArrow()!
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.autoLayout()
        roundView.addSubview(arrowImage)
        
        roundView.onTap{
            self.validateFields()
        }
        
        NSLayoutConstraint.activate([
            bottomImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            bottomImageView.widthAnchor.constraint(equalToConstant: 242),
            bottomImageView.heightAnchor.constraint(equalToConstant: 124),
            bottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
            roundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            roundView.widthAnchor.constraint(equalToConstant: 86),
            roundView.heightAnchor.constraint(equalToConstant: 86),
            roundView.bottomAnchor.constraint(equalTo: bottomImageView.topAnchor, constant: -20),
            
            arrowImage.leadingAnchor.constraint(equalTo: roundView.leadingAnchor, constant: 10),
            arrowImage.trailingAnchor.constraint(equalTo: roundView.trailingAnchor, constant: -10),
            arrowImage.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 20),
            arrowImage.bottomAnchor.constraint(equalTo: roundView.bottomAnchor, constant: -20)
        ])
    }
    private func validateFields(){
        guard userName.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Name", withCompletionHandler: nil)
            return
        }
        guard userEmail.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Email", withCompletionHandler: nil)
            return
        }
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

extension RegistrationViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.superview == nameView{
            self.userName = textField.text
        }else{
            self.userEmail = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == nameView{
            self.userName = textField.text
        }else{
            self.userEmail = textField.text
        }
        textField.resignFirstResponder()
        return true
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


