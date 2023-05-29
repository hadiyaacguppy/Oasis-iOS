//
//  FriendsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 29/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol FriendsViewControllerOutput {
    
}

class FriendsViewController: BaseViewController {
    
    var interactor: FriendsViewControllerOutput?
    var router: FriendsRouter?
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.autoLayout()
       scrollView.backgroundColor = .clear
       scrollView.showsVerticalScrollIndicator = false
       scrollView.contentInset = .init(top: 0, left: 0, bottom: 35, right: 0)
       return scrollView
   }()
   
   lazy var stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.distribution = .fill
       stackView.spacing = 19
       stackView.autoLayout()
       stackView.backgroundColor = .clear
       return stackView
   }()
    
    lazy var viewContainingSearchBar: BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = Constants.Colors.lightGrey
        view.roundCorners = .all(radius: view.frame.height / 2)
        view.autoLayout()
        return view
    }()
    
    lazy var searchTextField : BaseTextField = {
        let txtField = BaseTextField()
        txtField.addToolBar()
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.tintColor = .white
        txtField.font = MainFont.medium.with(size: 16)
        txtField.textColor = .white
        txtField.attributedPlaceholder = NSAttributedString(string: "Search by name or mobile number".localized,
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                            NSAttributedString.Key.font: MainFont.bold.with(size: 15)])
        txtField.textAlignment = .center
        //txtField.placeholder = "Search Channel".localized
        txtField.autoLayout()
        return txtField
    }()
    
    lazy var friendsRequestsStackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let friendsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.friendsCollectionViewCell),
                               forCellWithReuseIdentifier: R.reuseIdentifier.friendsCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    var friendsViewModels = [FriendsModels.ViewModels.Friend]()
}

//MARK:- View Lifecycle
extension FriendsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        FriendsConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
        self.searchTextField.text = nil
    }
    
}

//MARK:- NavBarAppearance
extension FriendsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
    
    func setupUI(){
        
    }
    
    func addScrollAndStackView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30)
        ])
    }
    
    func addSearchBarView(){
        stackView.addArrangedSubview(viewContainingSearchBar)
        
        let searchIcon = BaseImageView(frame: .zero)
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.autoLayout()
        searchIcon.image = R.image.searchBlackIcon()!
        
        viewContainingSearchBar.addSubview(searchIcon)
        viewContainingSearchBar.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            viewContainingSearchBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            viewContainingSearchBar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            viewContainingSearchBar.heightAnchor.constraint(equalToConstant: 50),
            
            searchIcon.trailingAnchor.constraint(equalTo: viewContainingSearchBar.trailingAnchor, constant: 22),
            searchIcon.heightAnchor.constraint(equalToConstant: 25),
            searchIcon.widthAnchor.constraint(equalToConstant: 25),
            searchIcon.centerYAnchor.constraint(equalTo: viewContainingSearchBar.centerYAnchor),
            
            searchTextField.leadingAnchor.constraint(equalTo: viewContainingSearchBar.leadingAnchor, constant: 30),
            searchTextField.centerYAnchor.constraint(equalTo: viewContainingSearchBar.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchIcon.leadingAnchor, constant: -10)

        ])
    }
}

//MARK:- Callbacks
extension FriendsViewController{
    
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



extension FriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.friendsCollectionViewCell, for: indexPath)!
       
        cell.setupCell(viewModel: friendsViewModels[indexPath.row])
        return cell
        
    }
}

extension FriendsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145, height: 155)
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 21.0
    }
}


extension FriendsViewController: UITextFieldDelegate{
    
}
