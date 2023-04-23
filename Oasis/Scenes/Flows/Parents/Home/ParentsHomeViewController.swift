//
//  ParentsHomeViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift
import FSPagerView

protocol ParentsHomeViewControllerOutput {
    
}

class ParentsHomeViewController: BaseViewController {
    
    var interactor: ParentsHomeViewControllerOutput?
    var router: ParentsHomeRouter?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var topCurvedImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.newBg()!
        img.contentMode = .scaleAspectFill
        img.autoLayout()
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
    
    lazy var sendMoneyActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var receiveMoneyActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var payActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var topUpActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var sendGiftActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var subscriptionsActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.aquaMarine
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    private lazy var areYouParentContainerView : BaseUIView = {
        let vW = BaseUIView()
        vW.backgroundColor = .clear
        vW.autoLayout()
        return vW
    }()
    
    private lazy var recentActivitiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var isThereUpcomingPayments : Bool = false
    private var upcomingPaymentsContainerView : BaseUIView = BaseUIView()
    
    private let upcomingPaymentsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.upcomingPaymentCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.upcomingPaymentCollectionCell.identifier)
        return collectionView
    }()
    
    private lazy var childrenPagerView : FSPagerView = {
        // Create a pager view
        let pagerView = FSPagerView(frame: .zero)
        pagerView.autoLayout()
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.isInfinite = false
        pagerView.itemSize = CGSize(width: 270, height: 250)
        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        pagerView.register(UINib(nibName: R.nib.childrenFSPagerViewCell.name, bundle: nil),
                           forCellWithReuseIdentifier: R.reuseIdentifier.childrenFSPagerCell.identifier)
        return pagerView
    }()
    
    public var isParent : Bool = false
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
    
    private func addScrollView () {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        addBalanceStack()
        addActionsStacksToContainer()
        
        if isParent{
            setupChildrenPagerView()
        }else{
            addAreYouParentView()
        }
        addUpcomingPaymentsSection(shouldAddPlaceholder: false)
        addRecentActivitiesSection(shouldAddPlaceholder: false)
    }
    
    private func addBalanceStack(){
        stackView.addArrangedSubview(balanceStackView)
        
        balanceStackView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        balanceStackView.addArrangedSubview(balanceStaticLabel)
        balanceStackView.addArrangedSubview(balanceValueLabel)
    }
    
    private func addActionsStacksToContainer(){
        stackView.addArrangedSubview(actionsContainerView)
        
        addActionsToCorrespondingStacks()
        
        actionsContainerView.addSubview(firstActionsStackView)
        actionsContainerView.addSubview(secondActionsStackView)
        
        NSLayoutConstraint.activate([
            actionsContainerView.heightAnchor.constraint(equalToConstant: 167),
            
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
        firstActionsStackView.addArrangedSubview(sendMoneyActionView)
        firstActionsStackView.addArrangedSubview(receiveMoneyActionView)
        firstActionsStackView.addArrangedSubview(payActionView)
        
        secondActionsStackView.addArrangedSubview(topUpActionView)
        secondActionsStackView.addArrangedSubview(sendGiftActionView)
        secondActionsStackView.addArrangedSubview(subscriptionsActionView)
        
        setupSendMoney()
        setupReceiveMoney()
        setupPay()
        setupTopUp()
        setupSendGiftUI()
        setupSubscription()
    }
    
    private func addAreYouParentView(){
        let areYouParentCardImageView : BaseImageView = {
            let img = BaseImageView(frame: .zero)
            img.autoLayout()
            img.image = R.image.backgroundHomepageBox()!
            img.contentMode = .scaleAspectFill
            return img
        }()
        
        let parentImageView : BaseImageView = {
            let img = BaseImageView(frame: .zero)
            img.autoLayout()
            img.contentMode = .scaleAspectFit
            img.image = R.image.parentPic()!
            img.roundCorners = .all(radius: 14)
            return img
        }()
        
        let staticTitle : BaseLabel = {
            let lbl = BaseLabel()
            lbl.style = .init(font: MainFont.medium.with(size: 22), color: .white, numberOfLines: 2)
            lbl.autoLayout()
            lbl.text = "Are you a \nparent?".localized
            return lbl
        }()
        
        let staticSubTitle : BaseLabel = {
            let lbl = BaseLabel()
            lbl.style = .init(font: MainFont.medium.with(size: 12), color: .white, numberOfLines: 3)
            lbl.autoLayout()
            lbl.text = "Add your childs now and teach them to be financially independant".localized
            return lbl
        }()
        
        let yesNoStackView : UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 12
            stackView.autoLayout()
            stackView.backgroundColor = .clear
            return stackView
        }()
        
        let yesButton : WhiteBorderButton = {
            let btn = WhiteBorderButton()
            btn.setTitle("Yes".localized, for: .normal)
            btn.autoLayout()
            btn.cornerRad = 20
            return btn
        }()
        
        let noButton : WhiteBorderButton = {
            let btn = WhiteBorderButton()
            btn.setTitle("Yes".localized, for: .normal)
            btn.cornerRad = 20
            btn.autoLayout()
            return btn
        }()
        
        stackView.addArrangedSubview(areYouParentContainerView)
        
        areYouParentContainerView.heightAnchor.constraint(equalToConstant: 205).isActive = true
        
        areYouParentContainerView.addSubview(areYouParentCardImageView)
        areYouParentContainerView.addSubview(staticTitle)
        areYouParentContainerView.addSubview(staticSubTitle)
        areYouParentContainerView.addSubview(yesNoStackView)
        
        yesNoStackView.addArrangedSubview(yesButton)
        yesNoStackView.addArrangedSubview(noButton)
        
        NSLayoutConstraint.activate([
            areYouParentCardImageView.topAnchor.constraint(equalTo: areYouParentContainerView.topAnchor, constant: 12),
            areYouParentCardImageView.leadingAnchor.constraint(equalTo: areYouParentContainerView.leadingAnchor, constant: 20),
            areYouParentCardImageView.trailingAnchor.constraint(equalTo: areYouParentContainerView.trailingAnchor),
            areYouParentCardImageView.bottomAnchor.constraint(equalTo: areYouParentContainerView.bottomAnchor),
            
            yesNoStackView.heightAnchor.constraint(equalToConstant: 40),
            yesNoStackView.trailingAnchor.constraint(equalTo: areYouParentContainerView.trailingAnchor, constant: -20),
            yesNoStackView.widthAnchor.constraint(equalToConstant: 180),
            yesNoStackView.bottomAnchor.constraint(equalTo: areYouParentContainerView.bottomAnchor, constant: -22),
            
            staticTitle.leadingAnchor.constraint(equalTo: yesNoStackView.leadingAnchor),
            staticTitle.topAnchor.constraint(equalTo: areYouParentContainerView.topAnchor, constant: 17),
            staticTitle.heightAnchor.constraint(equalToConstant: 55),
            staticTitle.trailingAnchor.constraint(equalTo: yesNoStackView.trailingAnchor),
            
            staticSubTitle.leadingAnchor.constraint(equalTo: yesNoStackView.leadingAnchor),
            staticSubTitle.topAnchor.constraint(equalTo: staticTitle.bottomAnchor, constant: 4),
            staticSubTitle.heightAnchor.constraint(equalToConstant: 45),
            staticSubTitle.trailingAnchor.constraint(equalTo: yesNoStackView.trailingAnchor),
        ])
        
        areYouParentContainerView.addSubview(parentImageView)
        NSLayoutConstraint.activate([
            parentImageView.bottomAnchor.constraint(equalTo: areYouParentContainerView.bottomAnchor),
            parentImageView.leadingAnchor.constraint(equalTo: areYouParentContainerView.leadingAnchor)
        ])
    }
    
    private func setupChildrenPagerView(){
        stackView.addArrangedSubview(childrenPagerView)
        
        childrenPagerView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        childrenPagerView.reloadData()
    }
    
    private func addUpcomingPaymentsSection(shouldAddPlaceholder show: Bool){
        let ulabel : BaseLabel = BaseLabel()
        ulabel.style = .init(font: MainFont.bold.with(size: 14), color: .black)
        ulabel.text = "Upcoming Payments".localized
        ulabel.autoLayout()
        
        ulabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        stackView.addArrangedSubview(ulabel)
        
        func addPlaceholder(){
            upcomingPaymentsContainerView.autoLayout()
            upcomingPaymentsContainerView.backgroundColor = .clear
            
            stackView.addArrangedSubview(upcomingPaymentsContainerView)
            
            upcomingPaymentsContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            
            let noPaymentsPlaceholderImageview : BaseImageView = {
                let img = BaseImageView(frame: .zero)
                img.image = R.image.noPaymentIcon()!
                img.contentMode = .scaleAspectFit
                img.autoLayout()
                return img
            }()
            
            let noPaymentsStaticLabel : BaseLabel = {
                let lbl = BaseLabel()
                lbl.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 2)
                lbl.text = "You have no upcoming \npayments yet".localized
                lbl.autoLayout()
                return lbl
            }()
            
            let addPaymentButton : OasisGradientButton = {
                let btn = OasisGradientButton(frame: .zero)
                btn.setTitle("Add a Payment".localized, for: .normal)
                return btn
            }()
            
            
            upcomingPaymentsContainerView.addSubview(noPaymentsPlaceholderImageview)
            upcomingPaymentsContainerView.addSubview(noPaymentsStaticLabel)
            upcomingPaymentsContainerView.addSubview(addPaymentButton)
            
            NSLayoutConstraint.activate([
                noPaymentsPlaceholderImageview.topAnchor.constraint(equalTo: upcomingPaymentsContainerView.topAnchor, constant: 8),
                noPaymentsPlaceholderImageview.centerXAnchor.constraint(equalTo: upcomingPaymentsContainerView.centerXAnchor),
                
                noPaymentsStaticLabel.topAnchor.constraint(equalTo: noPaymentsPlaceholderImageview.bottomAnchor, constant: 3),
                noPaymentsStaticLabel.centerXAnchor.constraint(equalTo: upcomingPaymentsContainerView.centerXAnchor),
                noPaymentsStaticLabel.heightAnchor.constraint(equalToConstant: 38),
                
                addPaymentButton.topAnchor.constraint(equalTo: noPaymentsStaticLabel.bottomAnchor, constant: 16),
                addPaymentButton.centerXAnchor.constraint(equalTo: upcomingPaymentsContainerView.centerXAnchor),
                addPaymentButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
        func setupUpcomingPaymentsCollectionView(){
            
            stackView.addArrangedSubview(upcomingPaymentsCollectionView)
            
            upcomingPaymentsCollectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            upcomingPaymentsCollectionView.dataSource = self
            upcomingPaymentsCollectionView.delegate = self
        }
        if show {
            addPlaceholder()
        }else{
            setupUpcomingPaymentsCollectionView()
        }
        
        
    }
    
    private func addRecentActivitiesSection(shouldAddPlaceholder show: Bool){
        
        let containerV = BaseUIView()
        containerV.autoLayout()
        containerV.backgroundColor = .clear
        
        let ulabel : BaseLabel = BaseLabel()
        ulabel.style = .init(font: MainFont.bold.with(size: 14), color: .black)
        ulabel.text = "Recent Activities".localized
        ulabel.autoLayout()
        
        let viewAllButton: BaseButton = {
            let btn = BaseButton()
            btn.autoLayout()
            let yourAttributes: [NSAttributedString.Key: Any] = [
                .font: MainFont.medium.with(size: 11),
                .foregroundColor: UIColor.black,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            let attributeString = NSMutableAttributedString(
                string: "View all",
                attributes: yourAttributes
            )
            btn.setAttributedTitle(attributeString, for: .normal)
            return btn
        }()
        
        stackView.addArrangedSubview(containerV)
        
        containerV.addSubview(ulabel)
        containerV.addSubview(viewAllButton)
        
        NSLayoutConstraint.activate([
            containerV.heightAnchor.constraint(equalToConstant: 35),
            ulabel.leadingAnchor.constraint(equalTo: containerV.leadingAnchor, constant: 8),
            ulabel.centerYAnchor.constraint(equalTo: containerV.centerYAnchor),
            
            viewAllButton.trailingAnchor.constraint(equalTo: containerV.trailingAnchor, constant: -8),
            viewAllButton.centerYAnchor.constraint(equalTo: containerV.centerYAnchor)
        ])
        
        func addPlaceholder(){
            
        }
        
        func addRecentActivities(){
            recentActivitiesStackView.backgroundColor = .clear
            recentActivitiesStackView.heightAnchor.constraint(equalToConstant: 237).isActive = true
            stackView.addArrangedSubview(recentActivitiesStackView)
            
            let vw1 = RecentActivityView.init(title: "Netflix subscription",
                                              date: "2 Feb 2023",
                                              amount: "600,000",
                                              currency: "LBP",
                                              iconName: R.image.netflix.name)
            
            let vw2 = RecentActivityView.init(title: "Money Transfer",
                                              date: "2 Feb 2023",
                                              amount: "1,500,000",
                                              currency: "LBP",
                                              iconName: R.image.netflix.name)
            
            let vw3 = RecentActivityView.init(title: "Netflix subscription",
                                              date: "2 Feb 2023",
                                              amount: "500",
                                              currency: "USD",
                                              iconName: R.image.netflix.name)
            
            recentActivitiesStackView.addArrangedSubview(vw1)
            recentActivitiesStackView.addArrangedSubview(vw2)
            recentActivitiesStackView.addArrangedSubview(vw3)
            
        }
        
        if show{
            addPlaceholder()
        }else{
            addRecentActivities()
        }
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
        navigationItem.rightBarButtonItem = rightNotificationsBarButton
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


//MARK: - Actions UI
extension ParentsHomeViewController {
    private func setupSendGiftUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.nounGift5459873()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Send gift".localized
        sendGiftActionView.addSubview(img)
        sendGiftActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: sendGiftActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: sendGiftActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: sendGiftActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        sendGiftActionView.onTap {
            self.router?.pushToSendGiftController()
        }
    }
    
    private func setupSendMoney(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.sendMoneyIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Send".localized
        sendMoneyActionView.addSubview(img)
        sendMoneyActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: sendMoneyActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: sendMoneyActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: sendMoneyActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        sendMoneyActionView.onTap {
            self.router?.pushToSendMoneyController()
        }
    }
    
    private func setupReceiveMoney(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.receiveMoneyIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Receive".localized
        receiveMoneyActionView.addSubview(img)
        receiveMoneyActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: receiveMoneyActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: receiveMoneyActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: receiveMoneyActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        receiveMoneyActionView.onTap {
            self.router?.pushToReceiveMoneyController()
        }
    }
    
    private func setupPay(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.sendMoneyIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Pay".localized
        payActionView.addSubview(img)
        payActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: payActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: payActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: payActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        payActionView.onTap {
            self.router?.pushToPaymentsController()
        }
    }
    
    private func setupTopUp(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.topUpIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Top Up".localized
        topUpActionView.addSubview(img)
        topUpActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: topUpActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: topUpActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: topUpActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        topUpActionView.onTap {
            
        }
    }
    
    private func setupSubscription(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.subscriptionIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Subscriptions".localized
        subscriptionsActionView.addSubview(img)
        subscriptionsActionView.addSubview(label)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: subscriptionsActionView.topAnchor, constant: 17),
            img.centerXAnchor.constraint(equalTo: subscriptionsActionView.centerXAnchor),
            img.heightAnchor.constraint(equalToConstant: 26),
            label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 2),
            label.centerXAnchor.constraint(equalTo: subscriptionsActionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        subscriptionsActionView.onTap {
            
        }
    }
    
}

extension ParentsHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.upcomingPaymentCollectionCell, for: indexPath)!
        cell.setupCell(title: "Netflix Subscription", subtitle: "Subtitle test", amount: "600,000 LBP")
        return cell
    }
    
    
}

extension ParentsHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 184, height: 158)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

extension ParentsHomeViewController: FSPagerViewDelegate, FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.childrenFSPagerCell.identifier, at: index) as! ChildrenFSPagerViewCell
        
        cell.setupCell(childName: "Mahdi", age: "4 years old", imageName: index != 0 ? R.image.kidsPic.name : R.image.kid.name)
        
        return cell
    }
}
