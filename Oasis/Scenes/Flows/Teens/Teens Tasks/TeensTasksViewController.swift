//
//  TeensTasksViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol TeensTasksViewControllerOutput {
    
}

class TeensTasksViewController: BaseViewController {
    
    var interactor: TeensTasksViewControllerOutput?
    var router: TeensTasksRouter?
    
    private lazy var myTasksLabel : BaseLabel = {
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
    
    lazy var whiteCircleImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.ellipse()
        img.contentMode = .scaleAspectFill
        img.autoLayout()
        return img
    }()
    
    lazy var topContainerView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    private lazy var youEarnedLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.normal.with(size: 25), color: .black, alignment: .center)
        lbl.text = "You Earned Today".localized
        return lbl
    }()
    
    private lazy var earnedAmountLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.bold.with(size: 35), color: .black, alignment: .center)
        lbl.text = "100,000 LBP"
        return lbl
    }()
    
    private lazy var tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.teensTasksCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.teensCollectionViewCell.identifier)
        return collectionView
    }()
    
    let testingTaskVMArray = [TeensTasksModels.ViewModels.Task(id: 0, taskTitle: "HOUSEKEEPING", taskDescription: "Tidy up your room", amount: 100000, currency: "LBP"), TeensTasksModels.ViewModels.Task(id: 0, taskTitle: "Cooking", taskDescription: "Cook dinner today", amount: 150000, currency: "LBP"), TeensTasksModels.ViewModels.Task(id: 0, taskTitle: "Pet", taskDescription: "Walk the dog", amount: 100000, currency: "LBP")]
}

//MARK:- View Lifecycle
extension TeensTasksViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TeensTasksConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        view.backgroundColor = Constants.Colors.maleBGColor
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
}

//MARK:- NavBarAppearance
extension TeensTasksViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
    
    private func setupUI(){
        addScrollView()
        addTopTitleLabel()
        addTopContainerView()
        addNewTasksTitle()
        addTasksCollectionView()
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
        let secondString = NSMutableAttributedString(string: "Tasks", attributes: secondAttribute )
        firstString.append(secondString)
        
        myTasksLabel.attributedText = firstString

        NSLayoutConstraint.activate([
            
            myTasksLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        stackView.addArrangedSubview(myTasksLabel)
    }
    
    private func addTopContainerView(){
        stackView.addArrangedSubview(topContainerView)
        
        topContainerView.addSubview(whiteCircleImageview)
        topContainerView.addSubview(youEarnedLabel)
        topContainerView.addSubview(earnedAmountLabel)
        
        NSLayoutConstraint.activate([
            topContainerView.heightAnchor.constraint(equalToConstant: 160),
            
            whiteCircleImageview.heightAnchor.constraint(equalToConstant: 153),
            whiteCircleImageview.widthAnchor.constraint(equalToConstant: 153),
            whiteCircleImageview.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            
            youEarnedLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 5),
            youEarnedLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -5),
            youEarnedLabel.bottomAnchor.constraint(equalTo: whiteCircleImageview.centerYAnchor, constant: -3),
            
            earnedAmountLabel.topAnchor.constraint(equalTo: whiteCircleImageview.centerYAnchor, constant: 3),
            earnedAmountLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 5),
            earnedAmountLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -5)

        ])
        
    }
    private func addNewTasksTitle(){
        let newView : BaseUIView = {
            let view = BaseUIView()
            view.backgroundColor = .clear
            view.autoLayout()
            return view
        }()
        
        let staticL : BaseLabel = {
            let lbl = BaseLabel()
            lbl.text = "NEW TASKS".localized
            lbl.style = .init(font: MainFont.medium.with(size: 12), color: .black)
            lbl.autoLayout()
            return lbl
        }()
        
        let newTaskIcon : BaseImageView = {
            let img = BaseImageView(frame: .zero)
            img.image = R.image.newTaskicon()
            img.contentMode = .scaleAspectFill
            img.autoLayout()
            return img
        }()
        
        stackView.addArrangedSubview(newView)
        
        newView.addSubview(newTaskIcon)
        newView.addSubview(staticL)
        
        NSLayoutConstraint.activate([
            
            newView.heightAnchor.constraint(equalToConstant: 20),
            
            newTaskIcon.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 10),
            newTaskIcon.centerYAnchor.constraint(equalTo: newView.centerYAnchor),
            newTaskIcon.heightAnchor.constraint(equalToConstant: 17),
            newTaskIcon.widthAnchor.constraint(equalToConstant: 17),
            
            staticL.leadingAnchor.constraint(equalTo: newTaskIcon.trailingAnchor, constant: 7),
            staticL.centerYAnchor.constraint(equalTo: newView.centerYAnchor)

        ])
        
    }
    private func addTasksCollectionView(){
        stackView.addArrangedSubview(tasksCollectionView)
        
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        
        tasksCollectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
    }
}

//MARK:- Callbacks
extension TeensTasksViewController{
    
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


extension TeensTasksViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testingTaskVMArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.teensCollectionViewCell, for: indexPath)!
        cell.setupUI(model: testingTaskVMArray[indexPath.row])
        return cell
    }
}

extension TeensTasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: 190, height: 202)
        let leftAndRightPaddings: CGFloat = 8.0
        let numberOfItemsPerRow: CGFloat = 2.0
            
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: 202)
            
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
