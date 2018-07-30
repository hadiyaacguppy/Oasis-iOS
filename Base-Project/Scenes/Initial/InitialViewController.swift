//
//  InitialViewController.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

import UIKit

protocol InitialViewControllerInput {
    
}

protocol InitialViewControllerOutput {
    func viewDidFinishedLoading()
}

class InitialViewController: BaseViewController, InitialViewControllerInput {
    
    var output: InitialViewControllerOutput?
    var router: InitialRouter?
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        InitialConfigurator.shared.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingPlaceHolder()
        output?.viewDidFinishedLoading()
    }
    
    // MARK: Requests
    
    
    // MARK: Display logic
    
}
extension InitialViewController: InitialPresenterOutput {
    func navigatetoLogin() {
        
    }
    
    func navigatetoMain() {
        
    }
    
    
}

//MARK: PlaceHolder Views
extension InitialViewController{
    
    func showLoadingPlaceHolder(){
        self.placeHolderView { [weak self] view in
            
            //Title
            view.titleLabelString(PlaceHolderHelper.setTitle(withtext: "No messages available right now!",
                                                             andFont: .boldSystemFont(ofSize: 16),
                                                             andTextColor: .blue)
            )
            
            //Detail
            view.detailLabelString(PlaceHolderHelper.setTitle(withtext: "Nayyek, rja3 b3d shway "))
            
            //Button
            view.buttonTitle(PlaceHolderHelper.setButtonTitle(forState: .normal,
                                                              andText: "Try Again!",
                                                              withTextColor: .white,
                                                              andFont: .boldSystemFont(ofSize: 16)),
                             for: .normal
            )
            view.setButtonBackgroundColor(.blue)
            view.buttonCornerRadius(5)
            view.shouldAddButtonShadow(true)
            
            
            //Progress
            view.mustShowProgress(true)
            view.shouldStartAnimatingProgress(true)
            
            //General View Properties
            view.isScrollAllowed(false)
            view.isTouchAllowed(true)
            view.dataSetBackgroundColor(.white)
            
            //Actions
            view.didTapContentView {
                print("PlaceHolder content view was tapped!")
            }
            view.didTapDataButton {
                print("Button was tapped!")
            }
            //            view.image(<#T##image: UIImage?##UIImage?#>)
            //            view.imageAnimation(<#T##imageAnimation: CAAnimation?##CAAnimation?#>)
            //            view.imageTintColor(<#T##imageTintColor: UIColor?##UIColor?#>)
            //            view.isImageViewAnimateAllowed(<#T##bool: Bool##Bool#>)
            
            //            view.customView(<#T##customView: UIView?##UIView?#>)
            
            //            view.buttonBackgroundImage(<#T##buttonBackgroundImage: UIImage?##UIImage?#>, for: <#T##UIControlState#>)
            //            view.buttonImage(<#T##buttonImage: UIImage?##UIImage?#>, for: <#T##UIControlState#>)
            //            view.isButtonRounded(<#T##rounded: Bool?##Bool?#>)
            //            view.setButtonBorderColor(<#T##borderColor: UIColor?##UIColor?#>)
            //            view.setButtonBorderWidth(<#T##width: CGFloat?##CGFloat?#>)
            
            //            view.shouldDisplay(<#T##bool: Bool##Bool#>)
            //            view.shouldFadeIn(<#T##bool: Bool##Bool#>)
            //            view.verticalOffset(<#T##offset: CGFloat##CGFloat#>)
            //            view.verticalSpace(<#T##space: CGFloat##CGFloat#>)
        }
    }

}
