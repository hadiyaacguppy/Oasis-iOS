//
//  ReceiveMoneyViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol ReceiveMoneyViewControllerOutput {
    
}

class ReceiveMoneyViewController: BaseViewController {
    
    var interactor: ReceiveMoneyViewControllerOutput?
    var router: ReceiveMoneyRouter?
    
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
        let view = BlueToastView.init(noteLabelText: "You have received 20% more money this month than the last month".localized)
        return view
    }()
    
    lazy var submitButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Request Money", for: .normal)
       // btn.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return btn
    }()
    

    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Receive Money".localized
        return lbl
    }()
    
    lazy var fromStaticlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "From".localized
        return lbl
    }()
    
    lazy var amountStaticlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "Amount to receive".localized
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
    
    private let peopleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.peopleCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.onlyImagePeopleCollectionCell.identifier)
        return collectionView
    }()
    
    private var amountView : AmountWithCurrencyView = {
        let view = AmountWithCurrencyView(amountPlaceHolder: 0.0,
                                          amount: 0,
                                          currency: "LBP",
                                          titleLbl: "Amount to receive",
                                          frame: .zero,
                                          textColor: .black,
                                          textSize: 22)//(defaultValue: 0.0, currency: "LBP", titleLbl: "Amount to receive")
        return view
    }()
    
}

//MARK:- View Lifecycle
extension ReceiveMoneyViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ReceiveMoneyConfigurator.shared.configure(viewController: self)
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
        stackView.addArrangedSubview(fromStaticlabel)
        stackView.addArrangedSubview(peopleCollectionView)
        stackView.addArrangedSubview(receipentCollectionView)
        //stackView.addArrangedSubview(amountStaticlabel)
        stackView.addArrangedSubview(amountView)

        NSLayoutConstraint.activate([
            toastView.heightAnchor.constraint(equalToConstant: 73),
            //amountView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        peopleCollectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
    }
    
}

//MARK:- NavBarAppearance
extension ReceiveMoneyViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension ReceiveMoneyViewController{
    
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


extension ReceiveMoneyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.onlyImagePeopleCollectionCell, for: indexPath)!
        cell.setupCell()
        return cell
    }
    
    
}

extension ReceiveMoneyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
