//
//  BaseTableViewController.swift
//  SummerApp
//
//  Created by Wassim Seifeddine on 5/25/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class BaseTableViewController : UITableViewController {
    
    
    var disposeBag : DisposeBag = DisposeBag()
    typealias MethodHandler = ()  -> Void
    
    override
    func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismissProgress()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        
    }
    func showLoading(){
        Utilities.ProgressHUD.showLoading(withMessage: "Loading".localized)
    }
    func display(successMessage msg : String){
        Utilities.ProgressHUD.showSuccess(withMessage: msg)
    }
    
    func display(errorMessage msg : String ){
        Utilities.ProgressHUD.showError(withMessage: msg)
    }
    func dismissProgress(){
        Utilities.ProgressHUD.dismissLoading()
    }
    func setTitle( _ title : String?){
        self.title = title
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
        backButton.tintColor = UIColor.red
        if deviceLang!.contains("ar"){
            backButton.image = UIImage(named: "NavBackiconAR")!.withRenderingMode(.alwaysOriginal)
        }else {
            backButton.image = UIImage(named: "NavBackicon")!.withRenderingMode(.alwaysOriginal)
            
        }
        
        backButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        navigationItem.leftBarButtonItem = backButton
    }
    
    func pushAnimated(viewController : UIViewController, animated : Bool){
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionMoveIn
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
    func showLoading(withMessage msg : String){
        Utilities.ProgressHUD.showLoading(withMessage: msg.localized)
    }
    func removeProgress() {
        Utilities.ProgressHUD.dismissLoading()
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
//MARK: PlaceHolderView helper
extension BaseTableViewController{
    
    func showNoInternetConnectionView(withButtonAction buttonTapped : @escaping MethodHandler){
        self.placeHolderView {  view in
            
            //Title
            view.titleLabelString(PlaceHolderHelper.setTitle(withtext: "No internet connection",
                                                             andFont: .boldSystemFont(ofSize: 16),
                                                             andTextColor: .blue)
            )
            
            //Detail
            //  view.detailLabelString(PlaceHolderHelper.setTitle(withtext: "No internet connection"))
            
            view.setButtonBackgroundColor(.blue)
            view.buttonCornerRadius(5)
            view.buttonTitle(PlaceHolderHelper.setButtonTitle(forState: .normal,
                                                              andText: "TRY AGAIN",
                                                              withTextColor: .white,
                                                              andFont: .boldSystemFont(ofSize : 14)),
                             for: .normal)
            //image
            view.image(R.image.offline())
            
            //General View Properties
            view.isScrollAllowed(false)
            view.isTouchAllowed(true)
            view.dataSetBackgroundColor(.white)
            
            //Actions
            view.didTapContentView {
                print("PlaceHolder content view was tapped!")
            }
            view.didTapDataButton {
                buttonTapped()
            }
            
        }
        
        
    }
    
    func showLoadingView(withTitle title : String){
        self.placeHolderView {  view in
            
            //Title
            view.titleLabelString(PlaceHolderHelper.setTitle(withtext: title,
                                                             andFont: .boldSystemFont(ofSize: 16),
                                                             andTextColor: .blue)
            )
            
            //Detail
            view.detailLabelString(PlaceHolderHelper.setTitle(withtext: "Please wait.."))
            
            //Progress
            view.mustShowProgress(true)
            view.shouldStartAnimatingProgress(true)
            
            //General View Properties
            view.isScrollAllowed(false)
            view.isTouchAllowed(true)
            view.dataSetBackgroundColor(.white)
            
        }
        
    }
    
    func showPlaceHolderView(withTitle title : String,
                             andDescription description : String? = nil,
                             andImage image : UIImage? = nil,
                             withRetryAction retryTapped : MethodHandler? = nil){
        self.placeHolderView {  view in
            
            //Title
            view.titleLabelString(PlaceHolderHelper.setTitle(withtext: title,
                                                             andFont: .boldSystemFont(ofSize: 16),
                                                             andTextColor: .blue)
            )
            
            //Detail
            view.detailLabelString(PlaceHolderHelper.setDetailDescription(withtext: description))
            
            //image
            view.image(image)
            
            //General View Properties
            view.isScrollAllowed(false)
            view.isTouchAllowed(true)
            view.dataSetBackgroundColor(.white)
            
            view.didTapDataButton{
                retryTapped?()
            }
            
        }
        
    }
    
}

