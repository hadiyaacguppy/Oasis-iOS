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
    
    lazy var addGoalButton : BaseButton = {
        let btn = BaseButton()
        btn.setTitle("+ Add new goal", for: .normal)
        btn.style = .init(titleFont: MainFont.medium.with(size: 20), titleColor: .black, backgroundColor: .white)
        btn.border = .value(color: .black, width: 1)//change later
        return btn
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
    
    //View Models
    var goalsViewModelArray = [GoalsModels.ViewModels.Goal(id: 1, Title: "Travel to France", amount: "$ 3,000", saved: "$ 1,000", endDate: "2024 08 24", goalImage: R.image.photo1.name), GoalsModels.ViewModels.Goal(id: 1, Title: "Buy a Car", amount: "$ 10,000", saved: "$ 5,000", endDate: "2024 08 24", goalImage: R.image.photo2.name)]//[GoalsModels.ViewModels.Goal]()
    }

//MARK:- View Lifecycle
extension GoalsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        GoalsConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        subscribeForGetGoals()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI(){
        addTitle()
        addButton()
        addScrollViewAndStackView()
        if goalsViewModelArray.count > 0{
            addGoalsCollectionView()
        }else{
            addNoGoalsPlaceholder()
        }
    }
    
    private func addTitle(){
        view.addSubviews(topTitleLabel)
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41)
        ])
    }
    
    private func addButton(){
        view.addSubview(addGoalButton)
        NSLayoutConstraint.activate([
            addGoalButton.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 20),
            addGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addGoalButton.heightAnchor.constraint(equalToConstant: 58),
            addGoalButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38)
        ])
        
        addGoalButton.onTap {
            self.router?.pushToAddGoalController()
        }
    }
    
    private func addScrollViewAndStackView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: addGoalButton.bottomAnchor, constant: 13),
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
    private func addGoalsCollectionView(){
        stackView.addArrangedSubview(goalsCollectionView)
        
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
        
        //goalsCollectionView.isScrollEnabled = false
        
        goalsCollectionView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
    }
    
    private func addNoGoalsPlaceholder(){
        let containerView = BaseUIView()
        containerView.autoLayout()
        containerView.backgroundColor = .clear
        
        let noGoalImageView = BaseImageView(frame: .zero)
        noGoalImageView.autoLayout()
        noGoalImageView.contentMode = .scaleAspectFit
        noGoalImageView.image = R.image.noGoalImage()!

        let subtitleLabel = BaseLabel()
        subtitleLabel.autoLayout()
        subtitleLabel.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 3)
        subtitleLabel.text = "You have no goals yet. \nAdd a goal and start saving !"
        
        
        view.addSubview(containerView)
        containerView.addSubview(noGoalImageView)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: addGoalButton.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            noGoalImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            noGoalImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: noGoalImageView.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
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
            #warning("Retry Action does not set")
        }
    }
    
    private func subscribeForGetGoals(){
        self.interactor?.getGoals()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (goalsArray) in
                self!.goalsViewModelArray = goalsArray
                //self!.goalsCollectionView.reloadData()
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}
