//
//  TeensGoalsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol TeensGoalsViewControllerOutput {
    func getGoals() -> Single<[TeensGoalsModels.ViewModels.Goal]>

}

class TeensGoalsViewController: BaseViewController {
    
    var interactor: TeensGoalsViewControllerOutput?
    var router: TeensGoalsRouter?
    
    private lazy var myGoalsLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.textColor = .black
        lbl.numberOfLines = 2
        return lbl
    }()
    
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
        stackView.spacing = 14
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var topContainerView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private lazy var allGoalsLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.normal.with(size: 25), color: .black, alignment: .center)
        lbl.text = "All Goals".localized
        return lbl
    }()
    
    private lazy var bravoLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.bold.with(size: 25), color: .black, alignment: .left)
        lbl.text = "BRAVO!".localized
        return lbl
    }()
        
    private lazy var subtitleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.normal.with(size: 19), color: .black, alignment: .left)
        lbl.text = "You are mid way to achieving your goals!"
        return lbl
    }()
    
    private lazy var addNewGoalButton : OasisAquaButton = {
        let button = OasisAquaButton()
        button.setTitle("+ Add new goal".localized, for: .normal)
        button.autoLayout()
        button.onTap {
            
        }
        return button
    }()
    
    private lazy var placeHolderContainerView : BaseUIView = {
        let vw = BaseUIView()
        vw.autoLayout()
        vw.backgroundColor = .clear
        return vw
    }()
    
    private lazy var goalsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.clipsToBounds = false
        collectionView.register(UINib(resource: R.nib.goalsCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.goalsCollectionViewCellID.identifier)
        return collectionView
    }()
    
    var isPlaceholderAdded: Bool = false

    var goalsViewModelArray : [TeensGoalsModels.ViewModels.Goal] = [] {
        didSet{
            if goalsViewModelArray.count > 0{
                removePlaceholderView()
            }else{
                addNoGoalsPlaceholder()
            }
        }
    }
    
    var testingGoalsArray = [TeensGoalsModels.ViewModels.Goal(goalID: 0, goalTitle: "Buy a Playstation", amount: 1000000, saved: 450000, currency: "LBP"),
                             TeensGoalsModels.ViewModels.Goal(goalID: 1, goalTitle: "Trip to Paris", amount: 3000, saved: 300, currency: "$"),
                             TeensGoalsModels.ViewModels.Goal(goalID: 2, goalTitle: "Buy a Laptop", amount: 1000, saved: 50, currency: "$")]

}

//MARK:- View Lifecycle
extension TeensGoalsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TeensGoalsConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        view.backgroundColor = Constants.Colors.teensGoals
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
        //subscribeForGetGoals()
    }
    private func setupUI(){
        addScrollView()
        addTopTitleLabel()
        addNoGoalsPlaceholder()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute:{
            self.removePlaceholderView()
        })
    }
}

//MARK: UI
extension TeensGoalsViewController{
    
    private func addScrollView () {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60)
        ])
        
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    private func addTopTitleLabel(){
        let firstAttribute = [ NSAttributedString.Key.font : MainFont.medium.with(size: 20)]
        let firstString = NSMutableAttributedString(string: "My\n", attributes: firstAttribute )
        let secondAttribute = [ NSAttributedString.Key.font : MainFont.bold.with(size: 35)]
        let secondString = NSMutableAttributedString(string: "Goals", attributes: secondAttribute )
        firstString.append(secondString)
        
        myGoalsLabel.attributedText = firstString

        NSLayoutConstraint.activate([
            
            myGoalsLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        stackView.addArrangedSubview(myGoalsLabel)
    }
    
    private func addTopContainerView(){
        stackView.addArrangedSubview(bravoLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    private func addAddNewGoalsButton(){
        stackView.addArrangedSubview(addNewGoalButton)
        
        addNewGoalButton.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
    private func addNoGoalsPlaceholder(){
        let noGoalImageView = BaseImageView(frame: .zero)
        noGoalImageView.autoLayout()
        noGoalImageView.contentMode = .scaleAspectFit
        noGoalImageView.image = R.image.noGoal()!
        
        let subtitleLabel = BaseLabel()
        subtitleLabel.autoLayout()
        subtitleLabel.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 3)
        subtitleLabel.text = "You have no goals yet. \nCreate a goal and start saving!".localized
        
         let addGoalButton : OasisAquaButton = {
            let button = OasisAquaButton()
            button.setTitle("Add a Goal".localized, for: .normal)
            button.autoLayout()
            button.onTap {
                
            }
            return button
        }()
        
        //view.addSubview(placeHolderContainerView)
        placeHolderContainerView.addSubview(noGoalImageView)
        placeHolderContainerView.addSubview(addGoalButton)
        placeHolderContainerView.addSubview(subtitleLabel)
        
        stackView.addArrangedSubview(placeHolderContainerView)

        
        NSLayoutConstraint.activate([
            placeHolderContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            placeHolderContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeHolderContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeHolderContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            noGoalImageView.centerXAnchor.constraint(equalTo: placeHolderContainerView.centerXAnchor),
            noGoalImageView.centerYAnchor.constraint(equalTo: placeHolderContainerView.centerYAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: noGoalImageView.bottomAnchor, constant: 4),
            subtitleLabel.centerXAnchor.constraint(equalTo: placeHolderContainerView.centerXAnchor),
            
            addGoalButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            addGoalButton.heightAnchor.constraint(equalToConstant: 62),
            addGoalButton.widthAnchor.constraint(equalToConstant: 250),
            addGoalButton.centerXAnchor.constraint(equalTo: placeHolderContainerView.centerXAnchor),

        ])
        
        isPlaceholderAdded = true
    }
    
    private func addGoalsCollectionView(){
        let goalsLabel = BaseLabel()
        goalsLabel.autoLayout()
        goalsLabel.style = .init(font: MainFont.medium.with(size: 25), color: .black)
        goalsLabel.text = "All Goals".localized
        
        stackView.addArrangedSubview(goalsLabel)
        stackView.addArrangedSubview(goalsCollectionView)
        
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
        
        goalsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        goalsCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        goalsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true

    }
    
    private func removePlaceholderView(){
        placeHolderContainerView.removeAllSubviews()
        stackView.removeArrangedSubview(placeHolderContainerView)
        isPlaceholderAdded = false
        addViews()
    }
    
    private func addViews(){
        addTopContainerView()
        addAddNewGoalsButton()
        addGoalsCollectionView()
    }
}

//MARK:- NavBarAppearance
extension TeensGoalsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}


extension TeensGoalsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testingGoalsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.goalsCollectionViewCellID, for: indexPath)!

        cell.setupCell(vm: testingGoalsArray[indexPath.row])
        cell.contentView.backgroundColor = Constants.Colors.appViolet
        cell.contentView.roundCorners(.allCorners, radius: 15)
        
        return cell
    }
}

extension TeensGoalsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: 190, height: 202)
//        let leftAndRightPaddings: CGFloat = 8.0
//        let numberOfItemsPerRow: CGFloat = 2.0
//
//        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: 231, height: 284)

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK:- Callbacks
extension TeensGoalsViewController{
    
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
                self?.removePlaceHolder()
                self?.goalsViewModelArray = goalsArray
            }, onError: { [weak self](error) in
                self?.preparePlaceHolderView(withErrorViewModel: (error as! ErrorViewModel))
            })
            .disposed(by: self.disposeBag)
    }
}
