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
    func getPayments() -> Single<[PaymentsModels.ViewModels.Payment]>
    func getPaymentsTypes() -> Single<Void>
    func addPayment(title : String, currency : String, amount : Int, date : String, paymentTypeID : Int) -> Single<Void>

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
    
    lazy var actionsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.autoLayout()
        return scrollView
    }()
    
    lazy var firstActionsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 17
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var qrActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.appOrange
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var mobileActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.appYellow
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
        vW.backgroundColor = Constants.Colors.appPink
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
    
    lazy var insuranceActionView : BaseUIView = {
        let vW = BaseUIView(frame: .zero)
        vW.backgroundColor = Constants.Colors.appOrange
        vW.roundCorners = .all(radius: 14)
        vW.autoLayout()
        return vW
    }()
    
    lazy var latestPaymentsStaticLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "Latest Operations".localized
        return lbl
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
    
    var paymentsVMArray = [PaymentsModels.ViewModels.Payment]()
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
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        stackView.addArrangedSubview(topTitleLabel)

        stackView.addArrangedSubview(toastView)
        
        toastView.heightAnchor.constraint(equalToConstant: 78).isActive = true

        toastView.exitImageView.onTap {
            self.toastView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
                
        addActionsStacksToContainer()

        addUpcomingPaymentsSection(shouldAddPlaceholder: false)
        
        stackView.addArrangedSubview(latestPaymentsStaticLabel)
    }
    
    private func addActionsStacksToContainer(){
        stackView.addArrangedSubview(actionsContainerView)
        
        actionsContainerView.addSubview(actionsScrollView)
        
        addActionsToCorrespondingStacks()
        
        actionsScrollView.addSubview(firstActionsStackView)
        //actionsContainerView.addSubview(secondActionsStackView)
        
        NSLayoutConstraint.activate([
            actionsContainerView.heightAnchor.constraint(equalToConstant: 118),
            
            actionsScrollView.topAnchor.constraint(equalTo: actionsContainerView.topAnchor),
            actionsScrollView.leadingAnchor.constraint(equalTo: actionsContainerView.leadingAnchor),
            actionsScrollView.bottomAnchor.constraint(equalTo: actionsContainerView.bottomAnchor),
            actionsScrollView.trailingAnchor.constraint(equalTo: actionsContainerView.trailingAnchor),

            firstActionsStackView.topAnchor.constraint(equalTo: actionsScrollView.topAnchor, constant: 8),
            firstActionsStackView.leadingAnchor.constraint(equalTo: actionsScrollView.leadingAnchor, constant: 8),
            firstActionsStackView.bottomAnchor.constraint(equalTo: actionsScrollView.bottomAnchor, constant: 8),
            firstActionsStackView.trailingAnchor.constraint(equalTo: actionsScrollView.trailingAnchor),
            firstActionsStackView.heightAnchor.constraint(equalTo: actionsScrollView.heightAnchor, constant: -16)
        ])
    }
    
    private func addActionsToCorrespondingStacks(){
        firstActionsStackView.addArrangedSubview(qrActionView)
        firstActionsStackView.addArrangedSubview(mobileActionView)
        firstActionsStackView.addArrangedSubview(internetActionView)
        firstActionsStackView.addArrangedSubview(electricityActionView)
        firstActionsStackView.addArrangedSubview(insuranceActionView)
        
        NSLayoutConstraint.activate([
            qrActionView.widthAnchor.constraint(equalToConstant: 112),
            mobileActionView.widthAnchor.constraint(equalToConstant: 112),
            internetActionView.widthAnchor.constraint(equalToConstant: 112),
            electricityActionView.widthAnchor.constraint(equalToConstant: 112),
            insuranceActionView.widthAnchor.constraint(equalToConstant: 112),
        ])

        setupQRUI()
        setupMobileUI()
        setupElectricityUI()
        setupInternetUI()
        setupMechanicUI()
        setupInsuranceUI()
    }
    
    private func addUpcomingPaymentsSection(shouldAddPlaceholder show: Bool){
        let ulabel : BaseLabel = BaseLabel()
        ulabel.style = .init(font: MainFont.bold.with(size: 18), color: .black)
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
}

//MARK:- NavBarAppearance
extension PaymentsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}


//MARK: - Actions UI
extension PaymentsViewController {
    private func setupQRUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.nounScan3887954()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Pay by QR".localized
        
        qrActionView.addSubview(img)
        qrActionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: qrActionView.topAnchor, constant: 17),
            img.trailingAnchor.constraint(equalTo: qrActionView.trailingAnchor, constant: -17),
            img.heightAnchor.constraint(equalToConstant: 36),
            img.widthAnchor.constraint(equalToConstant: 45),

            
            label.bottomAnchor.constraint(equalTo: qrActionView.bottomAnchor, constant: -9),
            label.leadingAnchor.constraint(equalTo: qrActionView.leadingAnchor, constant: 17)

        ])
        
        qrActionView.onTap {

        }
    }
    
    private func setupMobileUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.nounSmartphone55101562()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Mobile".localized
        
        mobileActionView.addSubview(img)
        mobileActionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: mobileActionView.topAnchor, constant: 17),
            img.trailingAnchor.constraint(equalTo: mobileActionView.trailingAnchor, constant: -17),
            img.heightAnchor.constraint(equalToConstant: 36),
            img.widthAnchor.constraint(equalToConstant: 45),

            
            label.bottomAnchor.constraint(equalTo: mobileActionView.bottomAnchor, constant: -9),
            label.leadingAnchor.constraint(equalTo: mobileActionView.leadingAnchor, constant: 17)
        ])
        
        mobileActionView.onTap {

        }
    }
    
    private func setupElectricityUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.nounWifi3622132()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Electricity".localized
        
        electricityActionView.addSubview(img)
        electricityActionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: electricityActionView.topAnchor, constant: 17),
            img.trailingAnchor.constraint(equalTo: electricityActionView.trailingAnchor, constant: -17),
            img.heightAnchor.constraint(equalToConstant: 36),
            img.widthAnchor.constraint(equalToConstant: 45),

            
            label.bottomAnchor.constraint(equalTo: electricityActionView.bottomAnchor, constant: -9),
            label.leadingAnchor.constraint(equalTo: electricityActionView.leadingAnchor, constant: 17)
        ])
        
        electricityActionView.onTap {
            
        }
    }
    
    private func setupInternetUI(){
        let img = BaseImageView(frame: .zero)
        img.image = R.image.electricityIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Internet".localized
        
        internetActionView.addSubview(img)
        internetActionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: internetActionView.topAnchor, constant: 17),
            img.trailingAnchor.constraint(equalTo: internetActionView.trailingAnchor, constant: -17),
            img.heightAnchor.constraint(equalToConstant: 36),
            img.widthAnchor.constraint(equalToConstant: 45),

            
            label.bottomAnchor.constraint(equalTo: internetActionView.bottomAnchor, constant: -9),
            label.leadingAnchor.constraint(equalTo: internetActionView.leadingAnchor, constant: 17)
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
        img.image = R.image.insuranceIcon()!
        img.autoLayout()
        img.contentMode = .scaleAspectFit
        
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 12),
                            color: .white)
        label.autoLayout()
        label.text = "Insurance".localized
        
        insuranceActionView.addSubview(img)
        insuranceActionView.addSubview(label)
        
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: insuranceActionView.topAnchor, constant: 17),
            img.trailingAnchor.constraint(equalTo: insuranceActionView.trailingAnchor, constant: -17),
            img.heightAnchor.constraint(equalToConstant: 36),
            img.widthAnchor.constraint(equalToConstant: 45),

            
            label.bottomAnchor.constraint(equalTo: insuranceActionView.bottomAnchor, constant: -9),
            label.leadingAnchor.constraint(equalTo: insuranceActionView.leadingAnchor, constant: 17)
        ])
        
        insuranceActionView.onTap {
            
        }
    }
    
}

extension PaymentsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.upcomingPaymentCollectionCell, for: indexPath)!
        cell.setupCell(title: "Netflix Subscription", subtitle: "Subtitle test", amount: "600,000 LBP")
        return cell
    }
}

extension PaymentsViewController: UICollectionViewDelegateFlowLayout {
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
    
    private func subscribeForGetPayments(){
        self.interactor?.getPayments()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (paymentsArray) in
                self!.paymentsVMArray = paymentsArray
                self!.display(successMessage: "")
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func subscribeForGetPaymentsTypes(){
        self.interactor?.getPaymentsTypes()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "")
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
    
    
}
