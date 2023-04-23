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
    
    var isParent : Bool = false
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
        areYouParentLabel.text = "Are you a parent ?"
        
        let subtitleLabel = BaseLabel()
        subtitleLabel.autoLayout()
        subtitleLabel.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 3)
        subtitleLabel.text = "Add your childs now and teach\nthem to be financially \nindependant"
        
        
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
        
    }
}

//MARK:- NavBarAppearance
extension ChildrenViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        
        let rightNotificationsBarButton = UIBarButtonItem(image: R.image.iconNotifications()!,
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


