//
//  TeensHomeViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol TeensHomeViewControllerOutput {
    
}

class TeensHomeViewController: BaseViewController {
    
    var interactor: TeensHomeViewControllerOutput?
    var router: TeensHomeRouter?
    
    
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
    
    lazy var coloredCircleImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.circles2()
        img.contentMode = .scaleAspectFill
        img.autoLayout()
        return img
    }()
    
    lazy var childImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.boyPicture()
        img.contentMode = .scaleAspectFit
        img.autoLayout()
        return img
    }()
    
    lazy var topContainerView : BaseUIView = {
        let view = BaseUIView()
        view.roundCorners = .all(radius: 17)
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    lazy var balanceContainerView : BaseUIView = {
        let view = BaseUIView()
        view.roundCorners = .all(radius: 25)
        view.backgroundColor = Constants.Colors.appViolet
        view.autoLayout()
        return view
    }()
    
    lazy var fishImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.image = R.image.fishRight()!
        img.contentMode = .scaleAspectFit
        img.autoLayout()
        return img
    }()
    
    lazy var currencyLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 20), color: .white)
        lbl.text = "LBP".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var youHaveLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 20), color: .white)
        lbl.text = "You have".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var amountLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 40), color: .white)
        lbl.text = "0.00".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var linkParentButton : BaseButton = {
        let btn = BaseButton()
        btn.style = .init(titleFont: MainFont.bold.with(size: 20), titleColor: .white, backgroundColor: Constants.Colors.teensOrange)
        btn.roundCorners = .all(radius: 44)
        btn.setTitle("Link my parent".localized, for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    lazy var sendButton : BaseButton = {
        let btn = BaseButton()
        btn.style = .init(titleFont: MainFont.bold.with(size: 20), titleColor: .white, backgroundColor: Constants.Colors.teensOrange)
        btn.roundCorners = .all(radius: 44)
        btn.setTitle("Send".localized, for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    lazy var requestButton : BaseButton = {
        let btn = BaseButton()
        btn.style = .init(titleFont: MainFont.bold.with(size: 20), titleColor: .white, backgroundColor: Constants.Colors.teensOrange)
        btn.roundCorners = .all(radius: 44)
        btn.setTitle("Request".localized, for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    lazy var learnMoreContainerView : BaseUIView = {
        let view = BaseUIView()
        view.roundCorners = .all(radius: 14)
        view.backgroundColor = .white
        view.autoLayout()
        return view
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.clipsToBounds = false
        collectionView.register(UINib(resource: R.nib.teensTasksCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.teensCollectionViewCell.identifier)
        return collectionView
    }()
    
    let testingTaskVMArray = [TeensTasksModels.ViewModels.Task(id: 0, taskTitle: "HOUSEKEEPING", taskDescription: "Tidy up your room", amount: 100000, currency: "LBP"), TeensTasksModels.ViewModels.Task(id: 0, taskTitle: "Cooking", taskDescription: "Cook dinner today", amount: 150000, currency: "LBP"), TeensTasksModels.ViewModels.Task(id: 0, taskTitle: "Pet", taskDescription: "Walk the dog", amount: 100000, currency: "LBP")]
}

//MARK:- View Lifecycle
extension TeensHomeViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TeensHomeConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        view.backgroundColor = Constants.Colors.maleBGColor
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI(){
        addScrollView()
        addTopContainerView()
        addLearnMoreContainerView()
        addActionViews()
        addFinishTasksLabel()
        addTaskscollectionView()
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
    
    private func addTopContainerView(){
        stackView.addArrangedSubview(topContainerView)
        
        topContainerView.addSubview(whiteCircleImageview)
        topContainerView.addSubview(balanceContainerView)
        topContainerView.addSubview(coloredCircleImageview)
        topContainerView.addSubview(childImageview)
        topContainerView.addSubview(linkParentButton)
        
        balanceContainerView.addSubview(fishImageview)
        balanceContainerView.addSubview(youHaveLabel)
        balanceContainerView.addSubview(amountLabel)
        balanceContainerView.addSubview(currencyLabel)

        NSLayoutConstraint.activate([
            topContainerView.heightAnchor.constraint(equalToConstant: 370),
            
            whiteCircleImageview.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 40),
            whiteCircleImageview.heightAnchor.constraint(equalToConstant: 270),
            whiteCircleImageview.widthAnchor.constraint(equalToConstant: 270),
            whiteCircleImageview.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor),
            
            balanceContainerView.topAnchor.constraint(equalTo: whiteCircleImageview.centerYAnchor),
            balanceContainerView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            balanceContainerView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            balanceContainerView.heightAnchor.constraint(equalToConstant: 150),
            
            linkParentButton.centerYAnchor.constraint(equalTo: balanceContainerView.bottomAnchor),
            linkParentButton.heightAnchor.constraint(equalToConstant: 62),
            linkParentButton.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor, constant: 25),
            linkParentButton.trailingAnchor.constraint(equalTo: balanceContainerView.trailingAnchor, constant: -25),

            coloredCircleImageview.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            coloredCircleImageview.bottomAnchor.constraint(equalTo: balanceContainerView.topAnchor),
            coloredCircleImageview.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
            coloredCircleImageview.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
            
            childImageview.topAnchor.constraint(equalTo: topContainerView.topAnchor),
            childImageview.bottomAnchor.constraint(equalTo: balanceContainerView.topAnchor),
            childImageview.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor),
            childImageview.trailingAnchor.constraint(equalTo: balanceContainerView.trailingAnchor),
            
            fishImageview.topAnchor.constraint(equalTo: balanceContainerView.topAnchor, constant: 11),
            fishImageview.trailingAnchor.constraint(equalTo: balanceContainerView.trailingAnchor, constant: -10),
            fishImageview.leadingAnchor.constraint(equalTo: balanceContainerView.centerXAnchor, constant: -10),
            fishImageview.bottomAnchor.constraint(equalTo: linkParentButton.topAnchor, constant: -9),
            
            youHaveLabel.topAnchor.constraint(equalTo: balanceContainerView.topAnchor,constant: 25),
            youHaveLabel.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor, constant: 20),
            
            amountLabel.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor, constant: 20),
            amountLabel.topAnchor.constraint(equalTo: youHaveLabel.bottomAnchor, constant: 3),
            
            currencyLabel.trailingAnchor.constraint(equalTo: balanceContainerView.trailingAnchor, constant: -30),
            currencyLabel.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor)

        ])
        
        linkParentButton.onTap {
            self.router?.presentQRCodeScreen()
        }
    }
    
    private func parentLinkedUpdateUI(){
        self.linkParentButton.removeFromSuperview()
        self.addSendAndRequestButtons()
    }
    
    private func addSendAndRequestButtons(){
        topContainerView.addSubview(requestButton)
        topContainerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            requestButton.centerYAnchor.constraint(equalTo: balanceContainerView.bottomAnchor),
            requestButton.heightAnchor.constraint(equalToConstant: 62),
            requestButton.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor, constant: 25),
            requestButton.trailingAnchor.constraint(equalTo: balanceContainerView.centerXAnchor, constant: -8),
            
            sendButton.centerYAnchor.constraint(equalTo: balanceContainerView.bottomAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 62),
            sendButton.leadingAnchor.constraint(equalTo: balanceContainerView.centerXAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: balanceContainerView.trailingAnchor, constant: -25)
        ])
    }
    
    private func addLearnMoreContainerView(){
        stackView.addArrangedSubview(learnMoreContainerView)
        
        let firstAttribute = [ NSAttributedString.Key.font : MainFont.normal.with(size: 20)]
        let firstString = NSMutableAttributedString(string: "Learn more about\n", attributes: firstAttribute )
        let secondAttribute = [ NSAttributedString.Key.font : MainFont.bold.with(size: 20)]
        let secondString = NSMutableAttributedString(string: "Guppy Super App !", attributes: secondAttribute )
        firstString.append(secondString)

        
        let staticL : BaseLabel = {
            let lbl = BaseLabel()
            lbl.autoLayout()
            lbl.attributedText = firstString
            lbl.textColor = .black
            lbl.numberOfLines = 2
            return lbl
        }()
        
        let guppyLogo : BaseImageView = {
            let img = BaseImageView(frame: .zero)
            img.image = R.image.logo1()
            img.contentMode = .scaleAspectFill
            img.autoLayout()
            return img
        }()
        
        learnMoreContainerView.addSubview(guppyLogo)
        learnMoreContainerView.addSubview(staticL)
        
        NSLayoutConstraint.activate([
            learnMoreContainerView.heightAnchor.constraint(equalToConstant: 92),
            
            guppyLogo.heightAnchor.constraint(equalToConstant: 75),
            guppyLogo.widthAnchor.constraint(equalToConstant: 75),
            guppyLogo.leadingAnchor.constraint(equalTo: learnMoreContainerView.leadingAnchor, constant: 20),
            guppyLogo.topAnchor.constraint(equalTo: learnMoreContainerView.topAnchor, constant: 10),
            
            staticL.leadingAnchor.constraint(equalTo: guppyLogo.trailingAnchor, constant: 15),
            staticL.trailingAnchor.constraint(equalTo: learnMoreContainerView.trailingAnchor, constant: -10),
            staticL.centerYAnchor.constraint(equalTo: learnMoreContainerView.centerYAnchor)
            
        ])
    
    }
    
    private func addActionViews(){
        stackView.addArrangedSubview(actionsStackView)
        
        actionsStackView.addArrangedSubview(createImageWithLabelView(image: R.image.goalImage()!, title: "Create a goal".localized, bgColor: Constants.Colors.aquaMarine))
    }
    
    private func createImageWithLabelView(image : UIImage, title : String, bgColor : UIColor) -> BaseUIView{
        let containerView : BaseUIView = {
            let view = BaseUIView()
            view.backgroundColor = bgColor
            view.roundCorners = .all(radius: 14)
            view.autoLayout()
            view.onTap {
                self.router?.pushToAddGoalController()
            }
            return view
        }()
        
        let staticL : BaseLabel = {
            let lbl = BaseLabel()
            lbl.text = title
            lbl.style = .init(font: MainFont.bold.with(size: 16), color: .white, alignment: .center, numberOfLines: 2)
            lbl.autoLayout()
            return lbl
        }()
        
        let logo : BaseImageView = {
            let img = BaseImageView(frame: .zero)
            img.image = R.image.goalImage()
            img.contentMode = .scaleAspectFill
            img.autoLayout()
            return img
        }()
        
        containerView.addSubview(logo)
        containerView.addSubview(staticL)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 155),
            containerView.heightAnchor.constraint(equalToConstant: 143),
            
            logo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            logo.widthAnchor.constraint(equalToConstant: 50),
            logo.heightAnchor.constraint(equalToConstant: 50),
            logo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            staticL.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 7),
            staticL.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            staticL.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            staticL.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),


        ])
        
        return containerView
    }
    
    private func addFinishTasksLabel(){
        let staticL : BaseLabel = {
            let lbl = BaseLabel()
            lbl.text = "Finish these tasks today and get guppied !"
            lbl.style = .init(font: MainFont.bold.with(size: 25), color: .black, alignment: .center, numberOfLines: 2)
            lbl.autoLayout()
            return lbl
        }()
        
        stackView.addArrangedSubview(staticL)
    }
    
    private func addTaskscollectionView(){
        stackView.addArrangedSubview(tasksCollectionView)
        
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        
        tasksCollectionView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        tasksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
    }
    
}

//MARK:- NavBarAppearance
extension TeensHomeViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        self.navigationItem.title = "Hello Hadi"
        let rightNotificationsBarButton = UIBarButtonItem(image: R.image.iconNotifications()!.withRenderingMode(.alwaysOriginal),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(alertButtonPressed))
        navigationItem.rightBarButtonItem = rightNotificationsBarButton
    }
    
    @objc private func alertButtonPressed(){
        
    }
}

//MARK:- Callbacks
extension TeensHomeViewController{
    
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


extension TeensHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testingTaskVMArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.teensCollectionViewCell, for: indexPath)!
        cell.setupUI(model: testingTaskVMArray[indexPath.row])
        return cell
    }
}

extension TeensHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 202)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}
