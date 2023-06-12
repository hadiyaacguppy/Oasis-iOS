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
        lbl.style = .init(font: MainFont.medium.with(size: 22), color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var uploadPictureButtonView : BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.roundCorners = .all(radius: 35)
        view.shadow = .active(with: .init(color: .black, opacity: 0.23, radius: 6))
        view.backgroundColor = .init(red: 248, green: 250, blue: 251, alpha: 1)
        return view
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
    
    lazy var nextButton : OasisGradientButton = {
        let btn = OasisGradientButton()
        btn.setTitle("Next >", for: .normal)
        return btn
    }()
    
    lazy var infoBlueView : BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.backgroundColor = Constants.Colors.appViolet
        view.roundCorners = .top(radius: 24)
        return view
    }()
    
    var uploadPictureView : UIView!
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
        addTitle()
        addScanCodeButton()
        addInfoBlueView()
        addScrollView()
        addGeneralStackView()
        addNextButton()
    }
    
    private func addTitle(){
        view.addSubview(topTitleLabel)
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41)
        ])
    }
    
    private func addScanCodeButton(){
        scanCodeDottedView = DottedButtonView(actionName: "Scan Qr Code", viewHeight: 62, viewWidth: 336, viewRadius: 48, numberOflines: 1, innerImage: R.image.qrCode())
        
        view.addSubview(scanCodeDottedView)
        
        NSLayoutConstraint.activate([
            scanCodeDottedView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 20),
            scanCodeDottedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27)
        ])
        
        scanCodeDottedView.onTap {
        }
    }

    private func addInfoBlueView(){
        view.addSubview(infoBlueView)
        
        NSLayoutConstraint.activate([
            infoBlueView.topAnchor.constraint(equalTo: scanCodeDottedView.bottomAnchor, constant: 35),
            infoBlueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoBlueView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoBlueView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addScrollView(){
        infoBlueView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: infoBlueView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: infoBlueView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: infoBlueView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: infoBlueView.bottomAnchor)
        ])
    }
    
    private func addGeneralStackView(){
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 31),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    private func addChildInfoViews(){
        let childInfo1 = TitleWithTextFieldView.init(requestTitle: "What’s your child’s first name?",
                                                     placeHolderTxt: "First Name",
                                                     usertext: "",
                                                     isAgeRequest: false,
                                                     hasEditView: false)
        
        let childInfo2 = TitleWithTextFieldView.init(requestTitle: "What’s your child’s last name?",
                                                     placeHolderTxt: "Last Name",
                                                     usertext: "",
                                                     isAgeRequest: false,
                                                     hasEditView: false)
        
        let childInfo3 = TitleWithTextFieldView.init(requestTitle: "What’s your child’s email?",
                                                     placeHolderTxt: "Email",
                                                     usertext: "",
                                                     isAgeRequest: false,
                                                     hasEditView: false)
        stackView.addArrangedSubview(childInfo1)
        stackView.addArrangedSubview(childInfo2)
        stackView.addArrangedSubview(childInfo3)
        
        NSLayoutConstraint.activate([
            childInfo1.heightAnchor.constraint(equalToConstant: 160),
            childInfo2.heightAnchor.constraint(equalToConstant: 160),
            childInfo3.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func addPicturesStackview(){
        stackView.addArrangedSubview(pictureTitleLabel)
        stackView.addArrangedSubview(picturesStackView)
        
    }
    
    private func picturesView(view : UIView){
        uploadPictureView = UIView()
        uploadPictureView.backgroundColor = .clear
        uploadPictureView.autoLayout()
        
        
        let iconImg = BaseImageView(frame: .zero)
        iconImg.contentMode = .scaleAspectFit
        iconImg.image = R.image.uploadAPictureIcon()!
        iconImg.autoLayout()

        
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 14), color: .white)
        lbl.text = "Upload a picture".localized
        lbl.autoLayout()
        
        NSLayoutConstraint.activate([
            uploadPictureView.widthAnchor.constraint(equalToConstant: 102),
            
        ])

    }
    private func addNextButton(){
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 140),
            nextButton.heightAnchor.constraint(equalToConstant: 58),
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60)
        ])
        
        nextButton.onTap {
            self.router?.pushToAssignNewTaskController()
        }
    }
    
}

//MARK:- NavBarAppearance
extension AddChildViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
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
        self.interactor?.addchild(email: "", firstName: "", lastName: "", childImage: "")
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "Child is added successfully")
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}


