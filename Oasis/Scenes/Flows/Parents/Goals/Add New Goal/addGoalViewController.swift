//
//  addGoalViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol addGoalViewControllerOutput {
    
}

class addGoalViewController: BaseViewController {
    
    var interactor: addGoalViewControllerOutput?
    var router: addGoalRouter?
    
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.bold.with(size: 27), color: .black)
        lbl.text = "Add a Goal".localized
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
    
    lazy var goalButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Add Goal", for: .normal)
        return btn
    }()
    
    lazy var endDateView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    lazy var enddateLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "End Date"
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.bold.with(size: 20), color: .black)
        return lbl
    }()
    
    lazy var calendarImageView : BaseImageView = {
        let imgView = BaseImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        imgView.autoLayout()
        imgView.image = R.image.calendarIcon()!
        return imgView
    }()
}

//MARK:- View Lifecycle
extension addGoalViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGoalConfigurator.shared.configure(viewController: self)
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
        //self.hidesBottomBarWhenPushed = true
    }
    
    private func setupUI(){
        
        //First, add Scroll View
        addScrollView()
        
        //Add Coal Button
        addGoalButton()
        
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
        
        //Third, add the GoalInfo Stack View
        addGoalInfoStackView()
        //Fourth, add upload Picture view
        addEndDateView()
    }
    
    private func addGoalInfoStackView(){
        let goalInfo1 = TitleWithTextFieldView.init(requestTitle: "Goal’s name",
                                                    placeHolderTxt: "What’s your goal?",
                                                    usertext: "",
                                                    isAgeRequest: false,
                                                    hasEditView: false)
        
        let goalInfo2 = AmountWithCurrencyView.init(currency: "LBP", titleLbl: "Amount")
        
        stackView.addArrangedSubview(goalInfo1)
        stackView.addArrangedSubview(goalInfo2)
    }
    
    //Add End Date label and image
    private func addEndDateView() {
        stackView.addArrangedSubview(endDateView)
        
        endDateView.addSubview(calendarImageView)
        endDateView.addSubview(enddateLabel)
        
        NSLayoutConstraint.activate([
            endDateView.heightAnchor.constraint(equalToConstant: 50),
            
            enddateLabel.leadingAnchor.constraint(equalTo: endDateView.leadingAnchor, constant: 10),
            enddateLabel.centerYAnchor.constraint(equalTo: endDateView.centerYAnchor),
            enddateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            calendarImageView.trailingAnchor.constraint(equalTo: endDateView.trailingAnchor, constant: -10),
            calendarImageView.heightAnchor.constraint(equalToConstant: 35),
            calendarImageView.widthAnchor.constraint(equalToConstant: 35),
            calendarImageView.centerYAnchor.constraint(equalTo: endDateView.centerYAnchor)
        ])
        
        //Fifth, add upload picture view
        addUploadPictureView()
    }
    
    //Add upload picture View
    private func addUploadPictureView(){
        
        //goalInfoStackView.addArrangedSubview(pictureTitleLabel)
        stackView.addArrangedSubview(uploadPictureButtonView)
        
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
    
    //Add Goal Button
    private func addGoalButton(){
        view.addSubview(goalButton)
        
        NSLayoutConstraint.activate([
            goalButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -47),
            goalButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 47),
            goalButton.heightAnchor.constraint(equalToConstant: 48),
            goalButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -68)
        ])
        
        goalButton.onTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK:- NavBarAppearance
extension addGoalViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension addGoalViewController{
    
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


