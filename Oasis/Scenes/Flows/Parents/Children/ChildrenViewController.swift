//
//  ChildrenViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol ChildrenViewControllerOutput {
    
}

class ChildrenViewController: BaseViewController {
    
    var interactor: ChildrenViewControllerOutput?
    var router: ChildrenRouter?
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Your Children".localized
        
        return lbl
    }()
    
    lazy var addChildrenButton : OasisGradientButton = {
        let btn = OasisGradientButton()
        btn.setTitle("+ Add new child", for: .normal)
        return btn
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var childrenCardsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    var isParent : Bool = true
}

//MARK:- View Lifecycle
extension ChildrenViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ChildrenConfigurator.shared.configure(viewController: self)
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
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI(){
        addTitle()
        addButton()
        if isParent{
            addChildrenCards()
        }else{
            addNoChildrenPlaceholder()
        }
    }
    
    private func addTitle(){
        view.addSubviews(topTitleLabel)
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41)
        ])
    }
    
    private func addButton(){
        view.addSubview(addChildrenButton)
        NSLayoutConstraint.activate([
            addChildrenButton.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 20),
            addChildrenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addChildrenButton.heightAnchor.constraint(equalToConstant: 58),
            addChildrenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38)
        ])
        
        addChildrenButton.onTap {
            self.router?.pushToAddChildController()
        }
    }
    
    private func addNoChildrenPlaceholder(){
        let containerView = BaseUIView()
        containerView.autoLayout()
        containerView.backgroundColor = .clear
        
        let dotsImageView = BaseImageView(frame: .zero)
        dotsImageView.autoLayout()
        dotsImageView.contentMode = .scaleAspectFit
        dotsImageView.image = R.image.dots()
        
        let parentImageView = BaseImageView(frame: .zero)
        parentImageView.autoLayout()
        parentImageView.contentMode = .scaleAspectFit
        parentImageView.image = R.image.parentPic()!
        
        let grayBackgroundImageView = BaseImageView(frame: .zero)
        grayBackgroundImageView.autoLayout()
        grayBackgroundImageView.contentMode = .scaleAspectFit
        grayBackgroundImageView.image = R.image.grayShape()!
        
        let areYouParentLabel = BaseLabel()
        areYouParentLabel.autoLayout()
        areYouParentLabel.style = .init(font: MainFont.medium.with(size: 22), color: .black, alignment: .center)
        areYouParentLabel.text = "Are you a parent ?".localized
        
        let subtitleLabel = BaseLabel()
        subtitleLabel.autoLayout()
        subtitleLabel.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 3)
        subtitleLabel.text = "Add your childs now and teach\nthem to be financially \nindependant".localized
        
        
        view.addSubview(containerView)
        containerView.addSubview(dotsImageView)
        containerView.addSubview(parentImageView)
        containerView.addSubview(grayBackgroundImageView)
        containerView.addSubview(areYouParentLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: addChildrenButton.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            dotsImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dotsImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            parentImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            parentImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            grayBackgroundImageView.topAnchor.constraint(equalTo: parentImageView.bottomAnchor, constant: -80),
            grayBackgroundImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            grayBackgroundImageView.heightAnchor.constraint(equalToConstant: 220),
            
            areYouParentLabel.centerXAnchor.constraint(equalTo: grayBackgroundImageView.centerXAnchor),
            areYouParentLabel.topAnchor.constraint(equalTo: grayBackgroundImageView.topAnchor, constant: 60),
            areYouParentLabel.heightAnchor.constraint(equalToConstant: 27),
            
            subtitleLabel.topAnchor.constraint(equalTo: areYouParentLabel.bottomAnchor, constant: 4),
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func addChildrenCards(){
        
        self.addScrollView()
        
        let vw1 = ChildView.init(name: "Michel",
                                 age: "8 years old",
                                 valueSpent: "LBP 240,000",
                                 totalValue: "of lBP 600,000",
                                 tasks: "2",
                                 goals: "1",
                                 imageName: R.image.kid.name)
        
        let vw2 = ChildView.init(name: "karen",
                                 age: "15 years old",
                                 valueSpent: "LBP 470,000",
                                 totalValue: "of lBP 600,000",
                                 tasks: "4",
                                 goals: "1",
                                 imageName: R.image.kid.name)
        
        let vw3 = ChildView.init(name: "Leo",
                                 age: "10 years old",
                                 valueSpent: "LBP 200,000",
                                 totalValue: "of lBP 600,000",
                                 tasks: "3",
                                 goals: "2",
                                 imageName: R.image.kid.name)
        
        childrenCardsStackView.addArrangedSubview(vw1)
        childrenCardsStackView.addArrangedSubview(vw2)
        childrenCardsStackView.addArrangedSubview(vw3)
    }
    
    private func addScrollView () {
        view.addSubview(scrollView)
        scrollView.addSubview(childrenCardsStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.addChildrenButton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            childrenCardsStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            childrenCardsStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            childrenCardsStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 30),
            childrenCardsStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -30),
            childrenCardsStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60)
        ])
    }
}

//MARK:- NavBarAppearance
extension ChildrenViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        
        let rightNotificationsBarButton = UIBarButtonItem(image: R.image.iconNotifications()!.withRenderingMode(.alwaysOriginal),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(alertButtonPressed))
        navigationItem.rightBarButtonItem = rightNotificationsBarButton
    }
    
    @objc private func alertButtonPressed(){
        
    }
}

//MARK:- Callbacks
extension ChildrenViewController{
    
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


