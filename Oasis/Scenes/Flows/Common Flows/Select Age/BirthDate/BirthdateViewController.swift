//
//  BirthdateViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol BirthdateViewControllerOutput {
    
}

class BirthdateViewController: BaseViewController {
    
    var interactor: BirthdateViewControllerOutput?
    var router: BirthdateRouter?
    
    private lazy var topStaticLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 33), color: .white, numberOfLines: 2)
        label.text = "What is your\nBirthdate?".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
}

//MARK:- View Lifecycle
extension BirthdateViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BirthdateConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        self.view.backgroundColor = Constants.Colors.appViolet
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupUI(){
        
    }
    
    
}

//MARK:- NavBarAppearance
extension BirthdateViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension BirthdateViewController{
    
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


