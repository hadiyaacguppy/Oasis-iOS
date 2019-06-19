//
//  BaseViewController.swift
//  Base-Project
//
//  Created by Wassim on 1/26/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import  RxSwift
import AnalyticsManager


class BaseViewController : UIViewController, BaseController {
    
    var didTapOnPlaceHolderView: (() -> ())?
    
    var didTapOnRetryPlaceHolderButton: (() -> ())?
    var analyticsManager = AnalyticsManager.shared
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        analyticsManager.logEvent(withName: String(describing: type(of: self)) + "View Opened" , andParameters: [:])
    }
    
    func logEvent(withName name : String ,andParameters params : [String:Any]? = nil ){
        
        
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
            backButton.image = UIImage(named: "NavBackiconAR")!.withRenderingMode(.alwaysOriginal)
        }else {
            backButton.image = UIImage(named: "NavBackicon")!.withRenderingMode(.alwaysOriginal)
            
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
            
            dismissButton.image = UIImage(named: "iconClose")!.withRenderingMode(.alwaysOriginal)
            
            
            dismissButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = dismissButton
        }
        
    }
    
}
