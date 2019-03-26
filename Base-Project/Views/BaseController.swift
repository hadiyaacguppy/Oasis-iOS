//
//  BaseController.swift
//  Base-Project
//
//  Created by Mojtaba Al Mousawi on 10/1/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


protocol BaseController {
    
    func showLoadingProgress()
    
    func display(successMessage msg : String)
    
    func display(errorMessage msg : String )
    
    func dismissProgress()
    
    func pushAnimated(viewController : UIViewController,
                      animated : Bool)
    
    func presentAnimated(viewController : UIViewController,
                         animated : Bool)
    
    func addBackButton()
    
    func addDismissButton()
    
    func preparePlaceHolderView(withErrorViewModel errorViewModel : ErrorViewModel)
    func showPlaceHolderView(withAppearanceType type : PlaceHolderAppearanceType,
                             title : String,
                             description : String?,
                             image : UIImage?)

    var didTapOnRetryPlaceHolderButton : (() -> ())?{ get }
    var didTapOnPlaceHolderView : (() -> ())?{ get }
}

extension BaseController  where Self: UIViewController{
    
    
    func showPlaceHolderView(withAppearanceType type : PlaceHolderAppearanceType,
                             title : String,
                             description : String? = nil,
                             image : UIImage? = nil){
        self.placeHolderView {  view in
            
            
            view.titleLabelString(PlaceHolderHelper.setTitle(withtext: title,
                                                             andFont: Constants.Fonts.boldSubheadline,
                                                             andTextColor: Constants.PlaceHolderView.Appearance.textColor)
            )
            
            
            view.detailLabelString(PlaceHolderHelper.setTitle(withtext: description))
            
            if type != .loading{
                view.setButtonBackgroundColor(Constants.PlaceHolderView.Appearance.buttonColor)
                view.buttonCornerRadius(Constants.PlaceHolderView.Appearance.buttonCornerRaduis)
                view.buttonTitle(PlaceHolderHelper.setButtonTitle(forState: .normal,
                                                                  andText: Constants.PlaceHolderView.Texts.retry,
                                                                  withTextColor: Constants.PlaceHolderView.Appearance.buttonTextColor,
                                                                  andFont: Constants.Fonts.boldSubheadline),
                                 for: .normal)
            }
            
            if type == .loading{
                //Progress
                view.mustShowProgress(true)
                view.shouldStartAnimatingProgress(true)
            }
            
            if image == nil {
                
                if type == .offline{
                    view.image(R.image.offline())
                }
                if type == .backendError || type == .networkError{
                    view.image(R.image.error())
                }
            }else{
                view.image(image)
            }
                        
            view.isTouchAllowed(true)
            view.dataSetBackgroundColor(Constants.PlaceHolderView.Appearance.viewColor)
            
            //Actions
            view.didTapContentView {
                self.didTapOnPlaceHolderView?()
            }
            view.didTapDataButton {
                self.didTapOnRetryPlaceHolderButton?()
            }
            
        }
        
    }
    
    
    func pushAnimated(viewController : UIViewController,
                      animated : Bool){
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.pushViewController(viewController, animated: animated )
    }
    
    
    func presentAnimated(viewController : UIViewController,
                         animated : Bool){
        
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(viewController, animated: true  , completion: nil)
        
    }
    
    func preparePlaceHolderView(withErrorViewModel errorViewModel : ErrorViewModel){
        switch errorViewModel.code{
        case .apiError(_):
            self.showPlaceHolderView(withAppearanceType: .backendError,
                                        title: errorViewModel.message)
        case .noInternetConnection:
            self.showPlaceHolderView(withAppearanceType: .offline,
                                        title: Constants.PlaceHolderView.Texts.offline)
            
        default:
            self.showPlaceHolderView(withAppearanceType: .networkError,
                                        title: errorViewModel.message)
        }
    }
    
}

extension BaseController {
    
    func showLoadingProgress(){
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
    
}
