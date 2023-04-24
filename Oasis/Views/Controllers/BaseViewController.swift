//
//  BaseViewController.swift
//  Oasis
//
//  Created by Wassim on 1/26/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit
import RxSwift
import AnalyticsManager

class BaseViewController : UIViewController, BaseController {
    
    var didTapOnPlaceHolderView: (() -> ())?
    var didTapOnRetryPlaceHolderButton: (() -> ())?
    
    private var analyticsManager : AnalyticsManager{
        return AnalyticsManager.shared
    }
    
    let disposeBag = DisposeBag()
    
    var statusBarStyle : UIStatusBarStyle = Constants.StatusBarAppearance.appStyle{
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
            switch statusBarStyle {
            case .default,.darkContent:
                self.navigationController?.navigationBar.barStyle = .default
            case .lightContent:
                self.navigationController?.navigationBar.barStyle = .black
            @unknown default:
                self.navigationController?.navigationBar.barStyle = .default
            }
        }
    }
    
    var navigationBarStyle : NavigationBarType = .normal{
        didSet{
            switch navigationBarStyle{
            case .hidden:
                (self.navigationController as? BaseNavigationController)?.style = .hidden
            case .normal:
                (self.navigationController as? BaseNavigationController)?.style = .normal
            case .transparent:
                (self.navigationController as? BaseNavigationController)?.style = .transparent
            case .custom(let appearance):
                (self.navigationController as? BaseNavigationController)?.style = .custom(appearance)
            case .appDefault:
                (self.navigationController as? BaseNavigationController)?.style = .appDefault
            }
        }
    }
}

//MARK:- ViewLifeCycle
extension BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        analyticsManager.logEvent(withName: String(describing: type(of: self)) + "View Opened" , andParameters: [:])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsManager.logEvent(withName: String(describing: type(of: self)) + "View Closed" ,
                                  andParameters: [:])
    }
}

//MARK:- StatusBarAppearance
extension BaseViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return Constants.StatusBarAppearance.animationStyle
    }
}

//MARK:- NavigationBarItems
extension BaseViewController{
    @objc func backButtonTapped(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addBackButton(){
        if self.navigationController == nil {
            
            return
        }
        if (self.navigationController!.viewControllers.count) == 1 {
            
            return
        }
        self.navigationController?.navigationItem.backBarButtonItem = nil
        let backButton = UIBarButtonItem(title: " ",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.backButtonTapped))
        
        
        if LanguageService().isRTL{
            backButton.image = R.image.blackBackArrow()!.withRenderingMode(.alwaysOriginal)
        }else {
            backButton.image = R.image.blackBackArrow()!.withRenderingMode(.alwaysOriginal)
        }
        
        backButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func dismissButtonTapped(){
        DispatchQueue.main.async {
            self.dismiss(animated: true , completion: nil)
        }
    }
    
    func addDismissButton(){
        
        if self.navigationController == nil {
            
            let dismissButton = UIButton()
            dismissButton.frame = CGRect(x: 20  , y: 20, width: 34, height: 34)
            dismissButton.addTarget(self ,
                                    action: #selector(self.dismissButtonTapped),
                                    for: .touchUpInside)
            self.view.addSubview(dismissButton)
            
        }else {
            
            let dismissButton = UIBarButtonItem(title: " ",
                                                style: .plain,
                                                target: self,
                                                action: #selector(self.dismissButtonTapped))
            
            dismissButton.image = R.image.navBlackClose()!.withRenderingMode(.alwaysOriginal)
            
            dismissButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = dismissButton
        }
    }
}
