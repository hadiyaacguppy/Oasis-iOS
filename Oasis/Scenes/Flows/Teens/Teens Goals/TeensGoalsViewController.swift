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
    
}

class TeensGoalsViewController: BaseViewController {
    
    var interactor: TeensGoalsViewControllerOutput?
    var router: TeensGoalsRouter?
    
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
}

//MARK:- NavBarAppearance
extension TeensGoalsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
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
}


