//
//  AddTeensGoalViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AddTeensGoalViewControllerOutput {
    
}

class AddTeensGoalViewController: BaseViewController {
    
    var interactor: AddTeensGoalViewControllerOutput?
    var router: AddTeensGoalRouter?
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.medium.with(size: 35), color: .white)
        lbl.text = "Add a goal".localized
        lbl.autoLayout()
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
        stackView.spacing = 20
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
}

//MARK:- View Lifecycle
extension AddTeensGoalViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AddTeensGoalConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        view.backgroundColor = Constants.Colors.appViolet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupUI(){
        
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
}

//MARK:- NavBarAppearance
extension AddTeensGoalViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension AddTeensGoalViewController{
    
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


