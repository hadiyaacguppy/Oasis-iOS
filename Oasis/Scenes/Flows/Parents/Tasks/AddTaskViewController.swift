//
//  AddTaskViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AddTaskViewControllerOutput {
    
}

class AddTaskViewController: BaseViewController {
    
    
    var interactor: AddTaskViewControllerOutput?
    var router: AddTaskRouter?
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.bold.with(size: 27), color: .black)
        lbl.text = "Add a Task".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var createTaskButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("+ Create new task", for: .normal)
        btn.roundCorners = .all(radius: 30)
        btn.autoLayout()
        return btn
    }()
    
    lazy var suggestedTasksLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.medium.with(size: 20), color: .black)
        lbl.text = "Suggested Tasks".localized
        lbl.autoLayout()
        return lbl
    }()
    
     lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    //Horizontal Labels
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let taskTitleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.suggestedTitlesCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.taskTitleCollectionVC.identifier)
        return collectionView
    }()
    
    //Square Views
    private let tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.tasksCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.tasksCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var suggestedTaskGreenView : BaseUIView = {
        let view = BaseUIView()
        view.roundCorners = .all(radius: 14)
        view.autoLayout()
        return view
    }()
    
    lazy var smallGreenViewInnerLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 10), color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var addChildButton : OasisGradientButton = {
        let btn = OasisGradientButton()
        btn.setTitle("Add Child", for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    private let suggestedTasksdict : [String : Bool] = ["ALL" : true, "LEARNING" : false, "SOCIAL" : false, "HOUSEKEEPING" : false]
}

//MARK:- View Lifecycle
extension AddTaskViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AddTaskConfigurator.shared.configure(viewController: self)
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
        
        //Add Scroll & StackView
        addScrollViewAndStackView()
        
        //Add Top Title & Create new Task Button
        addTopTitleAndButton()
        
        //Add AddChild Button
        addAddChildButton()
        
        //Add Suggested Tasks
        addSuggestedTasksLabel()
        
    }
    
    //Top Title
    private func addTopTitleAndButton(){
        
        self.view.addSubview(topTitleLabel)
        self.view.addSubview(createTaskButton)
        
        //Top Title Constraints
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topTitleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            
            createTaskButton.leadingAnchor.constraint(equalTo: topTitleLabel.leadingAnchor),
            createTaskButton.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 20),
            createTaskButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            createTaskButton.heightAnchor.constraint(equalToConstant: 58)
        ])
                
    }
    
    private func addSuggestedTasksLabel(){
        self.view.addSubview(suggestedTasksLabel)
        
        NSLayoutConstraint.activate([
            suggestedTasksLabel.leadingAnchor.constraint(equalTo: topTitleLabel.leadingAnchor),
            suggestedTasksLabel.topAnchor.constraint(equalTo: createTaskButton.bottomAnchor, constant: 30),
            suggestedTasksLabel.heightAnchor.constraint(equalToConstant: 41),
        ])
        
        
    }
    
    private func addAddChildButton(){
        view.addSubview(addChildButton)
        
        NSLayoutConstraint.activate([
            addChildButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            addChildButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            addChildButton.heightAnchor.constraint(equalToConstant: 58),
            addChildButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        
        ])
    }
    
    //ScrollView & StackView
    private func addScrollViewAndStackView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant : 15),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant : 15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant : 15)
        ])
        
        scrollView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 0)
        
        addsuggestedTasksCollectionView()
        
    }
    
    //Tasks collectionView
    private func addsuggestedTasksCollectionView(){
        view.addSubview(tasksCollectionView)
        
        tasksCollectionView.dataSource = self
        tasksCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            tasksCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            tasksCollectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            tasksCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            tasksCollectionView.bottomAnchor.constraint(equalTo: addChildButton.topAnchor, constant: -10)
        
        ])
    }
    
}

//MARK:- NavBarAppearance
extension AddTaskViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension AddTaskViewController{
    
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

extension AddTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tasksCollectionView{
            return 6
        }else{
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasksCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.tasksCollectionCell, for: indexPath)!
            cell.setupCell(title: "Gardening", subTitle: "Water plants in the garden and indoors")
            
            return cell
        }else{
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.taskTitleCollectionVC, for: indexPath)!
            cell.setupCell(taskDict: suggestedTasksdict)
            
            return cell
        }
        
    }
}

extension AddTaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       /* let leftAndRightPaddings: CGFloat = 60
        let numberOfItemsPerRow: CGFloat = 2.0
            
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width) // You can change width and height here as pr your requirement `*/
        if collectionView == tasksCollectionView{
            return CGSize(width: 153, height: 164)
        }else{
            return CGSize(width: 93, height: 50)
        }
       
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
