//
//  TestViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol TestViewControllerOutput {
    
}

class TestViewController: BaseViewController {
    
    var interactor: TestViewControllerOutput?
    var router: TestRouter?
    
    
    
}

//MARK:- View Lifecycle
extension TestViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TestConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
}

//MARK:- NavBarAppearance
extension TestViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .appDefault
    }
}

//MARK:- Callbacks
extension TestViewController{
    
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


