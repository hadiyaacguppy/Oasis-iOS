//
//  SendGiftViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol SendGiftViewControllerOutput {
    
}

class SendGiftViewController: BaseViewController {
    
    var interactor: SendGiftViewControllerOutput?
    var router: SendGiftRouter?
    
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
    
    lazy var submitButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Send Gift", for: .normal)
        return btn
    }()
    
    //MARK: - Note
    lazy var noteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.textviewBGColor
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var noteTextview: UITextView = {
        let txtVw = UITextView()
        txtVw.font = MainFont.normal.with(size: 15)
        txtVw.translatesAutoresizingMaskIntoConstraints = false
        txtVw.textColor = .black
        txtVw.textAlignment = .left
        txtVw.showsVerticalScrollIndicator = false
        txtVw.showsHorizontalScrollIndicator = false
        txtVw.backgroundColor = .clear
        txtVw.tag = 0
        return txtVw
    }()
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Send a Gift".localized
        return lbl
    }()
    
    lazy var chooseOccasionStaticlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "Choose Occasion".localized
        return lbl
    }()
    
    lazy var toStaticlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "To".localized
        return lbl
    }()
    
    lazy var giftAmountStaticlabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 14),
                          color: .black)
        lbl.text = "Gift Amount".localized
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
    
    private let occasionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.occasionCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.occasionCollectionCell.identifier)
        return collectionView
    }()
    
    private var amountView : AmountWithCurrencyView = {
        let view = AmountWithCurrencyView(amountPlaceHolder: 0.0,
                                          amount: 0,
                                          currency: "LBP",
                                          titleLbl: "Gift Amount",
                                          frame: .zero,
                                          textColor: .black,
                                          textSize: 22)
        return view
    }()
}

//MARK:- View Lifecycle
extension SendGiftViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SendGiftConfigurator.shared.configure(viewController: self)
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
        stackView.addArrangedSubview(chooseOccasionStaticlabel)
        stackView.addArrangedSubview(occasionCollectionView)
        stackView.addArrangedSubview(toStaticlabel)
        stackView.addArrangedSubview(peopleCollectionView)
        stackView.addArrangedSubview(receipentCollectionView)
        //stackView.addArrangedSubview(giftAmountStaticlabel)
        stackView.addArrangedSubview(amountView)

        setupNoteView()
        
        //amountView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        peopleCollectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        occasionCollectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        
        occasionCollectionView.delegate = self
        occasionCollectionView.dataSource = self
    }
}

//MARK:- NavBarAppearance
extension SendGiftViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        navigationItem.title = "Send a Gift".localized
    }
}

//MARK:- Callbacks
extension SendGiftViewController{
    
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

//MARK: - Account Number
extension SendGiftViewController{
    private
    func setupNoteView(){
        stackView.addArrangedSubview(noteView)
        noteView.addSubview(noteTextview)
        
        NSLayoutConstraint.activate([
            noteView.heightAnchor.constraint(equalToConstant: 124),
            
            noteTextview.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 8),
            noteTextview.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 18),
            noteTextview.centerYAnchor.constraint(equalTo: noteView.centerYAnchor),
            noteTextview.centerXAnchor.constraint(equalTo: noteView.centerXAnchor)
        ])
        //noteTextview.placeholder = "You can add a note to your gift, type here".localized
    }
}
extension SendGiftViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == occasionCollectionView {
            return 6
        }else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == occasionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.occasionCollectionCell, for: indexPath)!
            cell.setupCell()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.onlyImagePeopleCollectionCell, for: indexPath)!
            cell.setupCell()
            return cell
        }
    }
    
    
}

extension SendGiftViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == occasionCollectionView {
            return CGSize(width: 150, height: 120)
        }else{
            return CGSize(width: 75, height: 75)
        }
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
