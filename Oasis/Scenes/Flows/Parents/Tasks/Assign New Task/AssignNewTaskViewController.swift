//
//  AssignNewTaskViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AssignNewTaskViewControllerOutput {
    
}

class AssignNewTaskViewController: BaseViewController {
    
    var interactor: AssignNewTaskViewControllerOutput?
    var router: AssignNewTaskRouter?
    
    
    
}

//MARK:- View Lifecycle
extension AssignNewTaskViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AssignNewTaskConfigurator.shared.configure(viewController: self)
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
extension AssignNewTaskViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension AssignNewTaskViewController{
    
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


