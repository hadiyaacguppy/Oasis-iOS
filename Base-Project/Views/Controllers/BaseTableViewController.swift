//
//  BaseTableViewController.swift
//  SummerApp
//
//  Created by Wassim Seifeddine on 5/25/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxSwift
import AnalyticsManager
import UIKit

class BaseTableViewController : UITableViewController,BaseController {
   
    
   
    var didTapOnRetryPlaceHolderButton: (() -> ())?
    
    var didTapOnPlaceHolderView: (() -> ())?
    var analyticsManager = AnalyticsManager()
    let disposeBag = DisposeBag()
    
    
    var prefferedCellBackgroundColor : UIColor = .lightGray
    
    var statusBarStyle : UIStatusBarStyle = Constants.StatusBarAppearance.appStyle{
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
            switch statusBarStyle {
            case .default:
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
    
    override
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = prefferedCellBackgroundColor
    }
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        analyticsManager.logEvent(withName: String(describing: type(of: self)) + "View Opened" , andParameters: [:])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return Constants.StatusBarAppearance.updateAnimationStyle
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.deselectSelectedRow(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismissProgress()
        analyticsManager.logEvent(withName: String(describing: type(of: self)) + "View Closed" ,
                                  andParameters: [:])
        
    }
    @objc
    func backButtonTapped(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func logEvent(withName name: String, andParameters params: [String : Any]? = nil ) {
        
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
            backButton.image = R.image.navBackAr()!.withRenderingMode(.alwaysOriginal)
        }else {
            backButton.image = R.image.navBack()!.withRenderingMode(.alwaysOriginal)
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
            dismissButton.frame = CGRect(x: 20  , y: 20, width: 34, height: 34  )
            dismissButton.addTarget(self ,
                                    action: #selector(self.dismissButtonTapped),
                                    for: .touchUpInside)
            self.view.addSubview(dismissButton)
            
        }else {
            
            let dismissButton = UIBarButtonItem(title: " ",
                                                style: .plain,
                                                target: self,
                                                action: #selector(self.dismissButtonTapped))
            
            dismissButton.image = R.image.navClose()!.withRenderingMode(.alwaysOriginal)
            
            dismissButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = dismissButton
        }
        
    }
    
}
