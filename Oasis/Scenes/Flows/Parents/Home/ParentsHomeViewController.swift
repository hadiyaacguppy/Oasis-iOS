//
//  ParentsHomeViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol ParentsHomeViewControllerOutput {
    
}

class ParentsHomeViewController: BaseViewController {
    
    var interactor: ParentsHomeViewControllerOutput?
    var router: ParentsHomeRouter?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var scrollViewContentView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.autoLayout()
        return v
    }()
    
    lazy var topCurvedImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.newBg()!
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    lazy var balanceStackView : UIStackView = {
        UIStackView()
            .axis(.vertical)
            .spacing(15)
            .autoLayout()
            .distributionMode(.fill)
    }()
    
    lazy var balanceStaticLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 18), color: .white)
        lbl.text = "Balance".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var balanceValueLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 30), color: .white)
        lbl.text = "0.00 LBP".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var actionsContainerView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    lazy var firstActionsStackView : UIStackView = {
        UIStackView()
            .axis(.horizontal)
            .spacing(13)
            .autoLayout()
            .distributionMode(.fillEqually)
    }()
    
    lazy var secondActionsStackView : UIStackView = {
        UIStackView()
            .axis(.horizontal)
            .spacing(13)
            .autoLayout()
            .distributionMode(.fillEqually)
    }()
}

//MARK:- View Lifecycle
extension ParentsHomeViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ParentsHomeConfigurator.shared.configure(viewController: self)
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
        addTopCurvedImage()
        addScrollView()
        addBalanceStack()
    }
    
    private func addScrollView () {
        view.addSubview(scrollView)
        //view.sendSubviewToBack(scrollView)
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        scrollView.addSubview(scrollViewContentView)
        NSLayoutConstraint.activate([
            contentGuide.leadingAnchor
                .constraint(equalTo: scrollViewContentView.leadingAnchor),
            contentGuide.trailingAnchor
                .constraint(equalTo: scrollViewContentView.trailingAnchor),
            contentGuide.topAnchor
                .constraint(equalTo: scrollViewContentView.topAnchor),
            contentGuide.bottomAnchor
                .constraint(equalTo: scrollViewContentView.bottomAnchor),
            contentGuide.heightAnchor
                .constraint(equalTo: scrollViewContentView.heightAnchor)
        ])
    }
    
    private func addTopCurvedImage(){
        view.addSubview(topCurvedImageview)
        NSLayoutConstraint.activate([
            topCurvedImageview.topAnchor.constraint(equalTo: view.topAnchor),
            topCurvedImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCurvedImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCurvedImageview.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func addBalanceStack(){
        scrollViewContentView.addSubview(balanceStackView)
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalTo: scrollViewContentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            balanceStackView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 30),
            balanceStackView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -30),
            balanceStackView.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        balanceStackView.addArrangedSubview(balanceStaticLabel)
        balanceStackView.addArrangedSubview(balanceValueLabel)
    }
    
    
    private func addActionsStacksToContainer(){
        view.addSubview(actionsContainerView)
        
        NSLayoutConstraint.activate([
            actionsContainerView.topAnchor.constraint(equalTo: balanceStackView.bottomAnchor, constant: 8),
            actionsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            actionsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            actionsContainerView.heightAnchor.constraint(equalToConstant: 165)
        ])
    }
}

//MARK:- NavBarAppearance
extension ParentsHomeViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
        
        let rightNotificationsBarButton = UIBarButtonItem(image: R.image.whiteAlertIcon()!,
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(alertButtonPressed))
    }
    
    @objc private func alertButtonPressed(){
        
    }
}

//MARK:- Callbacks
extension ParentsHomeViewController{
    
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


