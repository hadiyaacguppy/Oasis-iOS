//
//  SendMoneyViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol SendMoneyViewControllerOutput {
    
}

class SendMoneyViewController: BaseViewController {
    
    var interactor: SendMoneyViewControllerOutput?
    var router: SendMoneyRouter?
    
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
        let view = BlueToastView.init(noteLabelText: "You have transfered 15% more money this month than the last month".localized)
        return view
    }()
    
    lazy var submitButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Send Money", for: .normal)
       // btn.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return btn
    }()
    

    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Send Money".localized
        return lbl
    }()
    
    lazy var toStaticLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "To".localized
        return lbl
    }()
    
    lazy var amountStaticlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "Amount to send".localized
        return lbl
    }()
    
    private let receipentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "IntroductionCell")
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var amountView : AmountWithCurrencyView = {
        let view = AmountWithCurrencyView(defaultValue: 0.0, currency: "LBP")
        return view
    }()
}

//MARK:- View Lifecycle
extension SendMoneyViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SendMoneyConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupViews()
        setupLayout()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupViews() {
        addSubmitButton()
        view.insertSubview(scrollView, belowSubview: submitButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func addSubmitButton(){
        view.insertSubview(submitButton, at: 0)
        
        let tabbarHeight = self.tabBarController?.tabBar.frame.height
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -((tabbarHeight ?? 50) + 16)),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupUI(){
        stackView.addArrangedSubview(topTitleLabel)
        stackView.addArrangedSubview(toastView)
        stackView.addArrangedSubview(toStaticLabel)
        stackView.addArrangedSubview(receipentCollectionView)
        stackView.addArrangedSubview(amountStaticlabel)
        stackView.addArrangedSubview(amountView)
        NSLayoutConstraint.activate([
            toastView.heightAnchor.constraint(equalToConstant: 73),
            
            amountView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

//MARK:- NavBarAppearance
extension SendMoneyViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension SendMoneyViewController{
    
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


