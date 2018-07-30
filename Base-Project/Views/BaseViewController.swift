//
//  BaseViewController.swift
//  Base-Project
//
//  Created by Wassim on 1/26/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import UIKit
import  RxSwift
class BaseViewController : UIViewController {
    
    
    var disposeBag = DisposeBag()
    override
    func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        dismissProgress()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
    }
    
    func showLoading(){
        Utilities.ProgressHUD.showLoading(withMessage: "Loading".localized)
    }
    func display(successMessage msg : String){
        dismissProgress()
        Utilities.ProgressHUD.showSuccess(withMessage: msg)
    }
    
    
    func display(errorMessage msg : String ){
        dismissProgress()
        Utilities.ProgressHUD.showError(withMessage: msg)
    }
    func dismissProgress(){
        Utilities.ProgressHUD.dismissLoading()
    }
    func pushAnimated(viewController : UIViewController, animated : Bool){
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.pushViewController(viewController, animated: animated )
    }
    
    
    func presentAnimated(viewController : UIViewController, animated : Bool){
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(viewController, animated: true  , completion: nil)
        
    }
    @objc func backButtonTapped(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addBackButton(){
        if self.navigationController == nil {
            
            return
        }
        if (self.navigationController!.viewControllers.count) == 1 {
            
            return
        }
        self.navigationController?.navigationItem.backBarButtonItem = nil
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: #selector(self.backButtonTapped))
        
        
        if deviceLang!.contains("ar"){
             backButton.image = UIImage(named: "NavBackiconAR")!.withRenderingMode(.alwaysOriginal)
        }else {
            backButton.image = UIImage(named: "NavBackicon")!.withRenderingMode(.alwaysOriginal)
           
        }
        
        
        
        backButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func dismissButtonTapped(){
        self.dismiss(animated: true , completion: nil)
    }
    
    func addDismissButton(){
        
        if self.navigationController == nil {
           
            let dismissButton = UIButton()
            dismissButton.frame = CGRect(x: 20  , y: 20, width: 34, height: 34  )
            dismissButton.addTarget(self , action: #selector(self.dismissButtonTapped), for: .touchUpInside)
            self.view.addSubview(dismissButton)
            
        }else {
            
            let dismissButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: #selector(self.dismissButtonTapped))
            
            dismissButton.image = UIImage(named: "iconClose")!.withRenderingMode(.alwaysOriginal)
            
            
            dismissButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            navigationItem.leftBarButtonItem = dismissButton
        }
      
    }


}

