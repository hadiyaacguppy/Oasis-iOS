//
//  GoalsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol GoalsViewControllerOutput {
    func getGoals() -> Single<[GoalsModels.ViewModels.Goal]>
}

class GoalsViewController: BaseViewController {
    
    var interactor: GoalsViewControllerOutput?
    var router: GoalsRouter?
    
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Goals".localized
        return lbl
    }()
    
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
    lazy var placehholderContainerView : BaseUIView = {
        let v = BaseUIView()
        v.backgroundColor = .clear
        v.autoLayout()
        return v
    }()
    private let goalsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.goalCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.goalCollectionVC.identifier)
        return collectionView
    }()
    
    var addGoalButtonView : DottedButtonView!
    var goalsViewModelArray : [GoalsModels.ViewModels.Goal] = [] {
        didSet{
            if goalsViewModelArray.count > 0{
                addGoalsCollectionView()
                goalsCollectionView.reloadData()
            }else{
                addNoGoalsPlaceholder()
            }
        }
    }
}


//MARK:- View Lifecycle
extension GoalsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        GoalsConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
        self.tabBarController?.tabBar.isHidden = false
        showPlaceHolderView(withAppearanceType: .loading,
                            title: Constants.PlaceHolderView.Texts.wait)
        subscribeForGetGoals()
    }
    
    private func setupUI(){
        addScrollViewAndStackView()
        addtitleAndButton()
    }
    
    private func addScrollViewAndStackView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    
    private func addtitleAndButton(){
        addGoalButtonView = DottedButtonView(actionName: "+ Add new goal".localized, viewHeight: 62, viewWidth: 336, viewRadius: 48, numberOflines: 1, innerImage: nil)
        addGoalButtonView.autoLayout()
        
        stackView.addArrangedSubview(topTitleLabel)
        stackView.addArrangedSubview(addGoalButtonView)
        
        NSLayoutConstraint.activate([
            
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            addGoalButtonView.heightAnchor.constraint(equalToConstant: 62)
        ])
        
        addGoalButtonView.onTap {
            self.router?.pushToAddGoalController()
        }
    }
    
    private func addGoalsCollectionView(){
        stackView.addArrangedSubview(goalsCollectionView)
        
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
                
        goalsCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    private func addNoGoalsPlaceholder(){
        let noGoalImageView = BaseImageView(frame: .zero)
        noGoalImageView.autoLayout()
        noGoalImageView.contentMode = .scaleAspectFit
        noGoalImageView.image = R.image.noGoalImage()!
        
        let subtitleLabel = BaseLabel()
        subtitleLabel.autoLayout()
        subtitleLabel.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 3)
        subtitleLabel.text = "You have no goals yet. \nAdd a goal and start saving !"
        
        placehholderContainerView.addSubview(noGoalImageView)
        placehholderContainerView.addSubview(subtitleLabel)
        
        stackView.addArrangedSubview(placehholderContainerView)

        NSLayoutConstraint.activate([
//            placehholderContainerView.topAnchor.constraint(equalTo: addGoalButtonView.bottomAnchor, constant: 20),
//            placehholderContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            placehholderContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            placehholderContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),

            placehholderContainerView.heightAnchor.constraint(equalToConstant: 350),

            noGoalImageView.centerXAnchor.constraint(equalTo: placehholderContainerView.centerXAnchor),
            noGoalImageView.centerYAnchor.constraint(equalTo: placehholderContainerView.centerYAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: noGoalImageView.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: placehholderContainerView.centerXAnchor)
        ])
    }
}

//MARK:- NavBarAppearance
extension GoalsViewController{
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

extension GoalsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalsViewModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.goalCollectionVC, for: indexPath)!
        
        cell.containerView.shadow = .active(with: .init(color: .gray,
                                                        opacity: 0.3,
                                                        radius: 6))
        
        cell.setupCell(viewModel: goalsViewModelArray[indexPath.row])
        return cell
        
    }
}

extension GoalsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 327, height: 316)
        
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

//MARK:- Callbacks
extension GoalsViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            self.subscribeForGetGoals()
        }
    }
    
    private func subscribeForGetGoals(){
        self.interactor?.getGoals()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (goalsArray) in
                self?.removePlaceHolder()
                self?.goalsViewModelArray = goalsArray
            }, onError: { [weak self](error) in
                self?.preparePlaceHolderView(withErrorViewModel: (error as! ErrorViewModel))
            })
            .disposed(by: self.disposeBag)
    }
}
