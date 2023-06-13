//
//  ChildDetailsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol ChildDetailsViewControllerOutput {
    
}

class ChildDetailsViewController: BaseViewController {
    
    var interactor: ChildDetailsViewControllerOutput?
    var router: ChildDetailsRouter?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.autoLayout()
        stackView.backgroundColor = .clear//Constants.Colors.appGrey
        return stackView
    }()
    
    private lazy var childContainerView: BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private lazy var childNameLabel: BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var childAgeLabel: BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var curvedGreyImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.curveBehindChild()
        imageView.autoLayout()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var greyView : BaseUIView = {
       let view = BaseUIView()
        view.backgroundColor = Constants.Colors.appGrey
        view.autoLayout()
        return view
    }()
    
    private lazy var balanceCardContainerView: BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = Constants.Colors.appViolet
        view.roundCorners = .all(radius: 12)
        view.autoLayout()
        return view
    }()
    
    private lazy var tasksContainerView: BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private lazy var goalsContainerView: BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private let tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.childTaskCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.childTaskCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let goalsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.goalCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.goalCollectionVC.identifier)
        return collectionView
    }()
    
    var blockCardView : ChildActionView!
    var setLimitsView : ChildActionView!
    var transferFundsView : ChildActionView!
    
    var tasksViewModels = [ChildDetailsModels.ViewModels.TaskDetails(id: 1, taskType: "housekeeping", taskTitle: "Tidy up your room", amount: "LBP 100,000", status: "Completed by Micheal", childImage: R.image.childDetailsImage.name, actionTitle: "Pay off"), ChildDetailsModels.ViewModels.TaskDetails(id: 2, taskType: "pets", taskTitle: "Walk the dog", amount: "LBP 75,000", status: "Assigned to Micheal", childImage: R.image.childDetailsImage.name, actionTitle: "Pending"), ChildDetailsModels.ViewModels.TaskDetails(id: 3, taskType: "gardening", taskTitle: "Water the plants outside", amount: "LBP 200,000", status: "Completed by Micheal", childImage: R.image.childDetailsImage.name, actionTitle: "Pay off")]
    
    var goalsViewModelArray = [GoalsModels.ViewModels.Goal(id: 1, Title: "Buy Playstation 5", amount: 3000, saved: 500, endDate: "2024 08 24", goalImage: R.image.photo1.name), GoalsModels.ViewModels.Goal(id: 1, Title: "Buy a Bike", amount: 2000, saved: 800, endDate: "2024 08 24", goalImage: R.image.photo1.name)]
}

//MARK:- View Lifecycle
extension ChildDetailsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ChildDetailsConfigurator.shared.configure(viewController: self)
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
        addBackgroundViews()
        addScrollView()
        addChildContainerView()
        addActionsStackViews()
        addTasksContainerView()
        addGoalsContainerView()
    }
    
    private func addBackgroundViews(){
        self.view.addSubview(curvedGreyImageView)
        self.view.addSubview(greyView)
        
        NSLayoutConstraint.activate([
            curvedGreyImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            curvedGreyImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            curvedGreyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            
            greyView.topAnchor.constraint(equalTo: curvedGreyImageView.bottomAnchor, constant: -100),
            greyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            greyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            greyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        //scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    private func addChildContainerView(){
        stackView.addArrangedSubview(childContainerView)
        
        let circlesImageView = UIImageView(image: R.image.circles())
        circlesImageView.contentMode = .scaleAspectFit
        
        childContainerView.addSubview(circlesImageView)

        
//        let childImageView = UIImageView(image: R.image.kid())
//        let nameClipImageView = UIImageView(image: R.image.childBlueNameView())
        
        //childContainerView.addSubview(childImageView)
        //childContainerView.addSubview(nameClipImageView)
        
        NSLayoutConstraint.activate([
            childContainerView.heightAnchor.constraint(equalToConstant: 300),
            
            circlesImageView.leadingAnchor.constraint(equalTo: childContainerView.leadingAnchor),
            circlesImageView.trailingAnchor.constraint(equalTo: childContainerView.trailingAnchor),
            circlesImageView.topAnchor.constraint(equalTo: childContainerView.topAnchor, constant: 20),
            circlesImageView.bottomAnchor.constraint(equalTo: childContainerView.bottomAnchor, constant: -20)
        ])


    }
    
    private func addActionsStackViews(){
        stackView.addArrangedSubview(actionsStackView)
        
        blockCardView = ChildActionView.init(actionImage: R.image.nounBlock1425420.name, actionName: "Block Card".localized)
        setLimitsView = ChildActionView.init(actionImage: R.image.limitsIcon.name, actionName: "Set Limits".localized)
        transferFundsView = ChildActionView.init(actionImage: R.image.transferIcon.name, actionName: "Transfer Funds".localized)

        actionsStackView.addArrangedSubview(blockCardView)
        actionsStackView.addArrangedSubview(setLimitsView)
        actionsStackView.addArrangedSubview(transferFundsView)
        
        NSLayoutConstraint.activate([
            actionsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func addTasksContainerView(){
        stackView.addArrangedSubview(tasksContainerView)
        
        let tasksLabel = BaseLabel()
        tasksLabel.style = .init(font: MainFont.bold.with(size: 20), color: .black)
        tasksLabel.text = "Tasks".localized
        tasksLabel.autoLayout()
        
        let assignTaskLabel = BaseLabel()
        assignTaskLabel.style = .init(font: MainFont.bold.with(size: 15), color: .black)
        assignTaskLabel.text = "+ Assign new task".localized
        assignTaskLabel.autoLayout()
        
        let underlineView = BaseUIView()
        underlineView.backgroundColor = .black
        underlineView.autoLayout()
        
        tasksContainerView.addSubview(tasksLabel)
        tasksContainerView.addSubview(tasksCollectionView)
        tasksContainerView.addSubview(assignTaskLabel)
        tasksContainerView.addSubview(underlineView)
        
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            
            tasksContainerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            tasksContainerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            tasksContainerView.heightAnchor.constraint(equalToConstant: 330),
            
            tasksLabel.topAnchor.constraint(equalTo: tasksContainerView.topAnchor, constant: 10),
            tasksLabel.heightAnchor.constraint(equalToConstant: 34),
            tasksLabel.leadingAnchor.constraint(equalTo: tasksContainerView.leadingAnchor, constant: 30),
            
            tasksCollectionView.topAnchor.constraint(equalTo: tasksLabel.bottomAnchor, constant: 15),
            tasksCollectionView.leadingAnchor.constraint(equalTo: tasksContainerView.leadingAnchor, constant: 25),
            tasksCollectionView.trailingAnchor.constraint(equalTo: tasksContainerView.trailingAnchor),
            tasksCollectionView.heightAnchor.constraint(equalToConstant: 223),
            
            assignTaskLabel.topAnchor.constraint(equalTo: tasksCollectionView.bottomAnchor, constant: 9),
            assignTaskLabel.leadingAnchor.constraint(equalTo: tasksContainerView.leadingAnchor, constant: 25),
            assignTaskLabel.heightAnchor.constraint(equalToConstant: 16),
            
            underlineView.leadingAnchor.constraint(equalTo: assignTaskLabel.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: assignTaskLabel.trailingAnchor),
            underlineView.topAnchor.constraint(equalTo: assignTaskLabel.bottomAnchor, constant: 2),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func addGoalsContainerView(){
        stackView.addArrangedSubview(goalsContainerView)
        
        let goalsLabel = BaseLabel()
        goalsLabel.style = .init(font: MainFont.bold.with(size: 20), color: .black)
        goalsLabel.text = "Goals".localized
        goalsLabel.autoLayout()
        
        goalsContainerView.addSubview(goalsLabel)
        goalsContainerView.addSubview(goalsCollectionView)
        
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            
            goalsContainerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            goalsContainerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            goalsContainerView.heightAnchor.constraint(equalToConstant: 235),
            
            goalsLabel.topAnchor.constraint(equalTo: goalsContainerView.topAnchor, constant: 10),
            goalsLabel.heightAnchor.constraint(equalToConstant: 34),
            goalsLabel.leadingAnchor.constraint(equalTo: goalsContainerView.leadingAnchor, constant: 30),
            
            goalsCollectionView.topAnchor.constraint(equalTo: goalsLabel.bottomAnchor, constant: 15),
            goalsCollectionView.leadingAnchor.constraint(equalTo: goalsContainerView.leadingAnchor, constant: 25),
            goalsCollectionView.trailingAnchor.constraint(equalTo: goalsContainerView.trailingAnchor),
            goalsCollectionView.heightAnchor.constraint(equalToConstant: 176)
        ])
    }
}

//MARK:- NavBarAppearance
extension ChildDetailsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

extension ChildDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tasksCollectionView{
            return tasksViewModels.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasksCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.childTaskCollectionViewCell, for: indexPath)!
            cell.setupCell(viewModel: tasksViewModels[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.goalCollectionVC, for: indexPath)!
            cell.goalImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            cell.transferFundsButton.setTitle("Add Funds", for: .normal)
            cell.transferFundsButton.style = .init(titleColor: .white, backgroundColor: Constants.Colors.appYellow)
            cell.bottomGreenView.backgroundColor = Constants.Colors.lightYellow
            cell.percentageGreenView.backgroundColor = Constants.Colors.appYellow
            cell.setupCell(viewModel: goalsViewModelArray[indexPath.row])
            return cell
        }
        
    }
}

extension ChildDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tasksCollectionView{
            return CGSize(width: 184, height: 223)
        }else{
            let cellWidth = view.frame.width - 80
            return CGSize(width: cellWidth, height: 176)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == tasksCollectionView{
            return 23.0
        }else{
            return 40.0
        }
    }
}

//MARK:- Callbacks
extension ChildDetailsViewController{
    
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


