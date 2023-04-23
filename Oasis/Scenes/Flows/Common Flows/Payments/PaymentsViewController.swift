//
//  PaymentsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol PaymentsViewControllerOutput {
    
}

class PaymentsViewController: BaseViewController {
    
    var interactor: PaymentsViewControllerOutput?
    var router: PaymentsRouter?
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var toastView : BlueToastView = {
        let view = BlueToastView.init(noteLabelText: "Your Mobile Bill is due in 2 days !\nPay now to avoid loosing your line.")
        return view
    }()
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Payments".localized
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
    
    lazy var qrActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var mobileActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var electricityActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var internetActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var mechanicActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var inseruanceActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var latestPaymentsStaticLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "Latest Payments".localized
        return lbl
    }()
}

//MARK:- View Lifecycle
extension PaymentsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PaymentsConfigurator.shared.configure(viewController: self)
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
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        stackView.addArrangedSubview(topTitleLabel)

        addActionsStacksToContainer()
        stackView.addArrangedSubview(toastView)
        toastView.heightAnchor.constraint(equalToConstant: 73).isActive = true

        stackView.addArrangedSubview(latestPaymentsStaticLabel)
    }
    
    private func addActionsStacksToContainer(){
        stackView.addArrangedSubview(actionsContainerView)
        
        addActionsToCorrespondingStacks()
        
        actionsContainerView.addSubview(firstActionsStackView)
        actionsContainerView.addSubview(secondActionsStackView)
        
        NSLayoutConstraint.activate([
            actionsContainerView.heightAnchor.constraint(equalToConstant: 167),
            actionsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            firstActionsStackView.topAnchor.constraint(equalTo: actionsContainerView.topAnchor),
            firstActionsStackView.leadingAnchor.constraint(equalTo: actionsContainerView.leadingAnchor),
            firstActionsStackView.trailingAnchor.constraint(equalTo: actionsContainerView.trailingAnchor),
            firstActionsStackView.heightAnchor.constraint(equalToConstant: 76),
            
            secondActionsStackView.topAnchor.constraint(equalTo: firstActionsStackView.bottomAnchor, constant: 15),
            secondActionsStackView.leadingAnchor.constraint(equalTo: actionsContainerView.leadingAnchor),
            secondActionsStackView.trailingAnchor.constraint(equalTo: actionsContainerView.trailingAnchor),
            secondActionsStackView.heightAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    private func addActionsToCorrespondingStacks(){
        firstActionsStackView.addArrangedSubview(qrActionView)
        firstActionsStackView.addArrangedSubview(mobileActionView)
        firstActionsStackView.addArrangedSubview(electricityActionView)
        
        secondActionsStackView.addArrangedSubview(internetActionView)
        secondActionsStackView.addArrangedSubview(mechanicActionView)
        secondActionsStackView.addArrangedSubview(inseruanceActionView)
        
        setupQRUI()
        setupMobileUI()
        setupElectricityUI()
        setupInternetUI()
        setupMechanicUI()
        setupInsuranceUI()
    }
}

//MARK:- NavBarAppearance
extension PaymentsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension PaymentsViewController{
    
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


//MARK: - Actions UI
extension PaymentsViewController {
    private func setupQRUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.nounGift5459873()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "QR".localized
        qrActionView.addSubview(img)
        qrActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: qrActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: qrActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: qrActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        qrActionView.onTap {

        }
    }
    
    private func setupMobileUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.sendMoneyIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Send".localized
        mobileActionView.addSubview(img)
        mobileActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: mobileActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: mobileActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: mobileActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        mobileActionView.onTap {

        }
    }
    
    private func setupElectricityUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.receiveMoneyIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Receive".localized
        electricityActionView.addSubview(img)
        electricityActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: electricityActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: electricityActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: electricityActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        electricityActionView.onTap {
            
        }
    }
    
    private func setupInternetUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.sendMoneyIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Pay".localized
        internetActionView.addSubview(img)
        internetActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: internetActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: internetActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: internetActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        internetActionView.onTap {
            
        }
    }
    
    private func setupMechanicUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.topUpIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Top Up".localized
        mechanicActionView.addSubview(img)
        mechanicActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: mechanicActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: mechanicActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: mechanicActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        mechanicActionView.onTap {
            
        }
    }
    
    private func setupInsuranceUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.subscriptionIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Subscriptions".localized
        inseruanceActionView.addSubview(img)
        inseruanceActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: inseruanceActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: inseruanceActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: inseruanceActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        inseruanceActionView.onTap {
            
        }
    }
    
}
