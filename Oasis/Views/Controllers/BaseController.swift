//
//  BaseController.swift
//  Oasis
//
//  Created by Mojtaba Al Mousawi on 10/1/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import RxSwift
import AnalyticsManager
import TDPopupKit

protocol BaseController {
    
    func showLoadingProgress()
    
    func display(successMessage msg : String)
    
    func display(errorMessage msg : String )
    
    func dismissProgress()
    
    func addBackButton()
    
    func addDismissButton()
    
    func preparePlaceHolderView(withErrorViewModel errorViewModel : ErrorViewModel)
    func showPlaceHolderView(withAppearanceType type : PlaceHolderAppearanceType,
                             title : String,
                             description : String?,
                             image : UIImage?)
    
    func logEvent(withName name : String ,andParameters params : [String:Any]?  )
    
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
                                                             andFont: Constants.PlaceHolderView.Fonts.boldSubheadline,
                                                             andTextColor: Constants.PlaceHolderView.Appearance.textColor)
            )
            
            
            view.detailLabelString(PlaceHolderHelper.setTitle(withtext: description))
            
            if type != .loading{
                view.setButtonBackgroundColor(Constants.PlaceHolderView.Appearance.buttonColor)
                view.buttonCornerRadius(Constants.PlaceHolderView.Appearance.buttonCornerRaduis)
                view.buttonTitle(PlaceHolderHelper.setButtonTitle(forState: .normal,
                                                                  andText: Constants.PlaceHolderView.Texts.retry,
                                                                  withTextColor: Constants.PlaceHolderView.Appearance.buttonTextColor,
                                                                  andFont: Constants.PlaceHolderView.Fonts.boldSubheadline),
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
    
    func logEvent(withName name : String ,andParameters params : [String:Any]?){
        AnalyticsManager.shared.logEvent(withName: name, andParameters: params)
    }
    
    func showLoadingProgress(){
        var spinner = UIActivityIndicatorView.init(style: .large)
        spinner.color = .white
        spinner.autoLayout()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        spinner.startAnimating()
        // PopupService.showLoadingNotifation(text: "Loading".localized)
    }
    
    func display(successMessage msg : String){
        PopupService.showSuccessNote(text: msg)
    }
    
    func display(errorMessage msg : String ){
        PopupService.showErrorNote(text: msg)
    }
    
    func dismissProgress(){
        PopupService.dismiss()
    }
    
}
