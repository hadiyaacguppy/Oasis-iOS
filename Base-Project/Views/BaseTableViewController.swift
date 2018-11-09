//
//  BaseTableViewController.swift
//  SummerApp
//
//  Created by Wassim Seifeddine on 5/25/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxSwift
import RxGesture
import UIKit

class BaseTableViewController : UITableViewController,BaseController {
   
    var didTapOnRetryPlaceHolderButton: (() -> ())?
    
    var didTapOnPlaceHolderView: (() -> ())?
    
    let disposeBag = DisposeBag()
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.deselectSelectedRow(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismissProgress()
        
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
        
        backButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
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
            
            
            dismissButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
            navigationItem.leftBarButtonItem = dismissButton
        }
        
    }
    
}
