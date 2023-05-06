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
        stackView.spacing = 6
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var childInfoStackView: UIStackView = {
        UIStackView()
            .axis(.vertical)
            .spacing(15)
            .autoLayout()
            .distributionMode(.fill)
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
    
    lazy var nextButton : OasisGradientButton = {
        let btn = OasisGradientButton()
        btn.setTitle("Next >", for: .normal)
        return btn
    }()
    
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
        
        //First, add Scroll View
        addScrollView()
        
        //Add Next Button
        addNextButton()
        
    }
    
    //Scroll View
    private func addScrollView(){
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            //Scroll View Constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //Second, add the elements in scroll view(Title,stack views,actions,....)
        //Add Top Title
        addTitle()
    }
    
    //Top Title
    private func addTitle(){
        
        scrollView.addSubviews(topTitleLabel)
        
        //Top Title Constraints
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            topTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 37),
        ])
        
        addGeneralStackView()
    }
    
    //StackView
    private func addGeneralStackView(){
        //Add general stack view
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            //General StackView Constraints
            stackView.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 31),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
        
        //Third, add the ChildInfo Stack View
        addChildInfoStackView()
    }
    
    private func addChildInfoStackView(){
        stackView.addArrangedSubview(childInfoStackView)
        
        let childInfo1 = TitleWithTextFieldView.init(requestTitle: "What’s your child’s name?",
                                                     placeHolderTxt: "Child name",
                                                     usertext: "",
                                                     isAgeRequest: false,
                                                     hasEditView: false)
        
        let childInfo2 = TitleWithTextFieldView.init(requestTitle: "Age",
                                                     placeHolderTxt: "0",
                                                     usertext: "",
                                                     isAgeRequest: true,
                                                     hasEditView: false)
        
        childInfoStackView.addArrangedSubview(childInfo1)
        childInfoStackView.addArrangedSubview(childInfo2)
        childInfoStackView.addArrangedSubview(pictureTitleLabel)
        childInfoStackView.addArrangedSubview(uploadPictureButtonView)
        
        let iconImg = BaseImageView(frame: .zero)
        iconImg.contentMode = .scaleAspectFit
        iconImg.autoLayout()
        iconImg.image = R.image.uploadAPictureIcon()!
        
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.medium.with(size: 16), color: .black)
        lbl.text = "Upload a picture".localized

        uploadPictureButtonView.addSubview(iconImg)
        uploadPictureButtonView.addSubview(lbl)
        
        NSLayoutConstraint.activate([
            uploadPictureButtonView.heightAnchor.constraint(equalToConstant: 70),
            
            iconImg.leadingAnchor.constraint(equalTo: uploadPictureButtonView.leadingAnchor, constant: 37),
            iconImg.centerYAnchor.constraint(equalTo: uploadPictureButtonView.centerYAnchor),
            iconImg.heightAnchor.constraint(equalToConstant: 20),
            iconImg.widthAnchor.constraint(equalToConstant: 20),
            
            lbl.leadingAnchor.constraint(equalTo: iconImg.trailingAnchor, constant: 25),
            lbl.centerYAnchor.constraint(equalTo: uploadPictureButtonView.centerYAnchor)
        ])
    }
    
    //Next Button
    private func addNextButton(){
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 140),
            nextButton.heightAnchor.constraint(equalToConstant: 58),
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60)
        ])
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
}


