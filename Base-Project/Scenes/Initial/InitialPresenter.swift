//
//  InitialPresenter.swift
//  Base-Project
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation
import RxSwift
import UIKit

protocol InitialPresenterOutput: class {
    
    func showPlaceHolderView(withAppearanceType type : PlaceHolderAppearanceType,
                 title : String,
                 description : String?,
                 image : UIImage?)
    
}

extension InitialPresenterOutput{
    func showPlaceHolderView(withAppearanceType type : PlaceHolderAppearanceType,
                 title : String,
                 description : String? = nil,
                 image : UIImage? = nil ){
        showPlaceHolderView(withAppearanceType: type,
                title: title,
                description: description,
                image: image)
    }
}

class InitialPresenter {
    
    weak var output: InitialPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension InitialPresenter: InitialInteractorOutput {
    
    func apiCallFailed(withError error : ErrorResponse){
        switch error.code{
        case let .apiError(code):
            output?.showPlaceHolderView(withAppearanceType: .backendError,
                            title: error.message)
        case .noInternetConnection:
            output?.showPlaceHolderView(withAppearanceType: .offline,
                            title: Constants.PlaceHolderView.Texts.offline)
            
        default:
            output?.showPlaceHolderView(withAppearanceType: .networkError,
                            title: error.message)
        }
    }
    
}
