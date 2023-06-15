//
//  ChildrenViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol ChildrenViewControllerOutput {
    func getchildren() -> Single<[ChildrenModels.ViewModels.Children]>
}

class ChildrenViewController: BaseViewController {
    
    var interactor: ChildrenViewControllerOutput?
    var router: ChildrenRouter?
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Your Children".localized
        
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
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    var isParent : Bool = true
    var addChildrenButtonView : DottedButtonView!
    var childrenViewModelArray = [ChildrenModels.ViewModels.Children]()
}

//MARK:- View Lifecycle
extension ChildrenViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ChildrenConfigurator.shared.configure(viewController: self)
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
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI(){
        addScrollAndStackViews()
        addTitleAndbutton()
        if childrenViewModelArray.count > 0{
            for child in childrenViewModelArray{
                
            }
        }else{
            addNoChildrenPlaceholder()
        }
    }
    
    private func addScrollAndStackViews(){
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

        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
    }
    private func addTitleAndbutton(){
        
        addChildrenButtonView = DottedButtonView(actionName: "+ Add new child".localized, viewHeight: 62, viewWidth: 336, viewRadius: 48, numberOflines: 1, innerImage: nil)
        addChildrenButtonView.autoLayout()
        
        stackView.addArrangedSubview(topTitleLabel)
        stackView.addArrangedSubview(addChildrenButtonView)

        NSLayoutConstraint.activate([
        
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            addChildrenButtonView.heightAnchor.constraint(equalToConstant: 62)
        ])
        
        addChildrenButtonView.onTap {
            self.router?.pushToAddChildController()
        }
    }
    
    private func addNoChildrenPlaceholder(){
        let containerView = BaseUIView()
        containerView.autoLayout()
        containerView.backgroundColor = .clear
        
        let dotsImageView = BaseImageView(frame: .zero)
        dotsImageView.autoLayout()
        dotsImageView.contentMode = .scaleAspectFit
        dotsImageView.image = R.image.dots()
        
        let parentImageView = BaseImageView(frame: .zero)
        parentImageView.autoLayout()
        parentImageView.contentMode = .scaleAspectFit
        parentImageView.image = R.image.parentPic()!
        
        let grayBackgroundImageView = BaseImageView(frame: .zero)
        grayBackgroundImageView.autoLayout()
        grayBackgroundImageView.contentMode = .scaleAspectFit
        grayBackgroundImageView.image = R.image.grayShape()!
        
        let areYouParentLabel = BaseLabel()
        areYouParentLabel.autoLayout()
        areYouParentLabel.style = .init(font: MainFont.medium.with(size: 22), color: .black, alignment: .center)
        areYouParentLabel.text = "Are you a parent ?".localized
        
        let subtitleLabel = BaseLabel()
        subtitleLabel.autoLayout()
        subtitleLabel.style = .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center, numberOfLines: 3)
        subtitleLabel.text = "Add your childs now and teach\nthem to be financially \nindependant".localized
        
        
        view.addSubview(containerView)
        containerView.addSubview(dotsImageView)
        containerView.addSubview(parentImageView)
        containerView.addSubview(grayBackgroundImageView)
        containerView.addSubview(areYouParentLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: addChildrenButtonView.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            dotsImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dotsImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            parentImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            parentImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            grayBackgroundImageView.topAnchor.constraint(equalTo: parentImageView.bottomAnchor, constant: -80),
            grayBackgroundImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            grayBackgroundImageView.heightAnchor.constraint(equalToConstant: 220),
            
            areYouParentLabel.centerXAnchor.constraint(equalTo: grayBackgroundImageView.centerXAnchor),
            areYouParentLabel.topAnchor.constraint(equalTo: grayBackgroundImageView.topAnchor, constant: 60),
            areYouParentLabel.heightAnchor.constraint(equalToConstant: 27),
            
            subtitleLabel.topAnchor.constraint(equalTo: areYouParentLabel.bottomAnchor, constant: 4),
            subtitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func addChildCard(){
        
        let vw1 = ChildView.init(name: "Michel",
                                 age: "8 years old",
                                 valueSpent: "LBP 240,000",
                                 totalValue: "of lBP 600,000",
                                 tasks: "2",
                                 goals: "1",
                                 imageName: R.image.kid.name)
        
        let vw2 = ChildView.init(name: "karen",
                                 age: "15 years old",
                                 valueSpent: "LBP 470,000",
                                 totalValue: "of lBP 600,000",
                                 tasks: "4",
                                 goals: "1",
                                 imageName: R.image.kid.name)
        
        let vw3 = ChildView.init(name: "Leo",
                                 age: "10 years old",
                                 valueSpent: "LBP 200,000",
                                 totalValue: "of lBP 600,000",
                                 tasks: "3",
                                 goals: "2",
                                 imageName: R.image.kid.name)
        
        stackView.addArrangedSubview(vw1)
        stackView.addArrangedSubview(vw2)
        stackView.addArrangedSubview(vw3)
        
        vw1.onTap {
            self.router?.pushToChildDetailsVC()
        }
        vw2.onTap {
            self.router?.pushToChildDetailsVC()
        }
        vw3.onTap {
            self.router?.pushToChildDetailsVC()
        }
    }
}

//MARK:- NavBarAppearance
extension ChildrenViewController{
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

//MARK:- Callbacks
extension ChildrenViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
#warning("Retry Action does not set")
        }
    }
    
    private func subscribeForGetChildren(){
        self.interactor?.getchildren()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (childrenAray) in
                self!.display(successMessage: "Done")
                self?.childrenViewModelArray = childrenAray
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}


