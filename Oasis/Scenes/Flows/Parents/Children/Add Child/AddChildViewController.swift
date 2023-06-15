//
//  AddChildViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AddChildViewControllerOutput {
    func addchild(email : String, firstName : String, lastName : String, childImage : String) -> Single<Void>
}

class AddChildViewController: BaseViewController {
    
    var interactor: AddChildViewControllerOutput?
    var router: AddChildRouter?
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.bold.with(size: 27), color: .black)
        lbl.text = "Add a Child".localized
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var pictureTitleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Picture"
        lbl.style = .init(font: MainFont.medium.with(size: 22), color: .white)
        lbl.autoLayout()
        return lbl
    }()
    
    
    lazy var picturesStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var nextImageView : BaseImageView = {
        let imgView = BaseImageView(frame: .zero)
        imgView.image = R.image.longWhiteArrow()!
        imgView.contentMode = .scaleAspectFit
        imgView.autoLayout()
        return imgView
    }()
    
    lazy var infoBlueView : BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.backgroundColor = Constants.Colors.appViolet
        view.roundCorners = .top(radius: 30)
        return view
    }()
    
    lazy var fillInfoLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Or fill the info below".localized
        lbl.style = .init(font: MainFont.medium.with(size: 16), color: .white)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var uploadPictureView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    var firstNameView : TitleWithTextFieldView!
    var lastNameView : TitleWithTextFieldView!
    var emailView : TitleWithTextFieldView!

    var childEmail : String?
    var childFirstName : String?
    var childLastName : String?
    
    var scanCodeDottedView : DottedButtonView!
}

//MARK:- View Lifecycle
extension AddChildViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AddChildConfigurator.shared.configure(viewController: self)
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
        addInfoBlueView()
        addScrollView()
        addTitleAndScanCodeButton()
        addGeneralStackView()
        addChildInfoViews()
        createPicturesView(pictureView: uploadPictureView, image: R.image.cameraIcon()!, title: "Upload a \n Picture".localized)
        addNextButton()
    }
    
    private func addTitleAndScanCodeButton(){
        stackView.addArrangedSubview(topTitleLabel)

        scanCodeDottedView = DottedButtonView(actionName: "Scan Qr Code", viewHeight: 62, viewWidth: 336, viewRadius: 48, numberOflines: 1, innerImage: R.image.qrCode())
        
        stackView.addArrangedSubview(scanCodeDottedView)
        
//        NSLayoutConstraint.activate([
//            scanCodeDottedView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 20),
//            scanCodeDottedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
//            scanCodeDottedView.heightAnchor.constraint(equalToConstant: 62)
//        ])
//
        scanCodeDottedView.onTap {
        }
    }
    
    private func addInfoBlueView(){
        view.addSubview(infoBlueView)
        
        NSLayoutConstraint.activate([
            infoBlueView.topAnchor.constraint(equalTo: view.topAnchor, constant: 265),
            infoBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoBlueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoBlueView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addScrollView(){
        infoBlueView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addGeneralStackView(){
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 31),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    private func addChildInfoViews(){
        
         firstNameView = TitleWithTextFieldView.init(requestTitle: "What’s your child’s first name?",
                                                  textsColor: .white,
                                                  usertext: "",
                                                  textSize: 22,
                                                  isAgeRequest: false,
                                                  labelHeight: 70,
                                                  placholderText: "",
                                                  frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 160))


         lastNameView = TitleWithTextFieldView.init(requestTitle: "What’s your child’s last name?",
                                                   textsColor: .white,
                                                   usertext: "",
                                                   textSize: 22,
                                                   isAgeRequest: false,
                                                   labelHeight: 70,
                                                   placholderText: "",
                                                   frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 160))
        
         emailView = TitleWithTextFieldView.init(requestTitle: "What’s your child’s email?",
                                                  textsColor: .white,
                                                  usertext: "",
                                                  textSize: 22,
                                                  isAgeRequest: false,
                                                  labelHeight: 70,
                                                  placholderText: "",
                                                  frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 160))
       
        stackView.addArrangedSubview(fillInfoLabel)
        stackView.addArrangedSubview(firstNameView)
        stackView.addArrangedSubview(lastNameView)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(pictureTitleLabel)
        stackView.addArrangedSubview(picturesStackView)
        
        firstNameView.anyTextField.delegate = self
        lastNameView.anyTextField.delegate = self
        emailView.anyTextField.delegate = self

        NSLayoutConstraint.activate([
            fillInfoLabel.heightAnchor.constraint(equalToConstant: 100),
            
            firstNameView.heightAnchor.constraint(equalToConstant: 160),
            lastNameView.heightAnchor.constraint(equalToConstant: 160),
            emailView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func createPicturesView(pictureView : UIView, image : UIImage, title : String){
        
        let iconImg = BaseImageView(frame: .zero)
        iconImg.contentMode = .scaleAspectFit
        iconImg.image = image
        iconImg.autoLayout()

        
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 14), color: .white)
        lbl.numberOfLines = 2
        lbl.text = title
        lbl.autoLayout()
        
        picturesStackView.addArrangedSubview(pictureView)
        pictureView.addSubview(iconImg)
        pictureView.addSubview(lbl)
        
        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 102),
            
            iconImg.topAnchor.constraint(equalTo: pictureView.topAnchor),
            iconImg.widthAnchor.constraint(equalToConstant: 50),
            iconImg.heightAnchor.constraint(equalToConstant: 50),
            
            lbl.topAnchor.constraint(equalTo: iconImg.bottomAnchor, constant: 5),
            lbl.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor),
            lbl.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor),
            lbl.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor)
        ])

    }
    private func addNextButton(){
        view.addSubview(nextImageView)
        
        NSLayoutConstraint.activate([
            nextImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            nextImageView.widthAnchor.constraint(equalToConstant: 140),
            nextImageView.heightAnchor.constraint(equalToConstant: 58),
            nextImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60)
        ])
        
        nextImageView.onTap {
            self.validateFields()
        }
    }
    
    private func validateFields(){
        guard childFirstName.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your First Name", withCompletionHandler: nil)
            return
        }
        guard childLastName.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Last Name", withCompletionHandler: nil)
            return
        }
        guard childEmail.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Email", withCompletionHandler: nil)
            return
        }
        
        subscribeForAddChild()
        
    }
    
}

//MARK:- NavBarAppearance
extension AddChildViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

extension AddChildViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.superview == firstNameView{
            self.childFirstName = textField.text
        }else if textField.superview == lastNameView{
            self.childLastName = textField.text
        }else{
            self.childEmail = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == firstNameView{
            self.childFirstName = textField.text
        }else if textField.superview == lastNameView{
            self.childLastName = textField.text
        }else{
            self.childEmail = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- Callbacks
extension AddChildViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
        #warning("Retry Action does not set")
        }
    }
    
    private func subscribeForAddChild(){
        self.interactor?.addchild(email: childEmail!, firstName: childFirstName!, lastName: childLastName!, childImage: "")
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "Child is added successfully")
                self?.router?.pushToAddTaskController()
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}


