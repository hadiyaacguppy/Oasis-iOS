//
//  ParentsHomeViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol ParentsHomeViewControllerOutput {
    
}

class ParentsHomeViewController: BaseViewController {
    
    var interactor: ParentsHomeViewControllerOutput?
    var router: ParentsHomeRouter?
    
    
    lazy var welcomeLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.light.with(size: 50), color: .black)
        lbl.text = "Home Screen"
        lbl.autoLayout()
        return lbl
    }()
}

//MARK:- View Lifecycle
extension ParentsHomeViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ParentsHomeConfigurator.shared.configure(viewController: self)
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
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK:- NavBarAppearance
extension ParentsHomeViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .appDefault
    }
}

//MARK:- Callbacks
extension ParentsHomeViewController{
    
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


