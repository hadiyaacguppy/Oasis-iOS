//
//  InitialViewController.swift
//  Base-Project
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//

import UIKit
import RxSwift

protocol InitialViewControllerInput {

}

protocol InitialViewControllerOutput {
    
    func viewDidFinishedLoading()
    
    func retryLoadingRequested()
    
    func lifeIsNotFair() -> Single<Int>
}

class InitialViewController: BaseViewController, InitialViewControllerInput {

    var output: InitialViewControllerOutput?
    var router: InitialRouter?
    
    @IBOutlet weak var iOSButton: BaseButton!{
        didSet{
            
            iOSButton.style = .init(titleFont: MainFont.boldItalic.with(size: 15),
                                    titleColor: .white,
                                    backgroundColor: .blue)
            iOSButton.setTitle("iOS 15+", for: .normal)
            iOSButton.border = .value(color: .systemRed, width: 2)
            iOSButton.roundCorners = .all(radius: 25)
            iOSButton.shadow = .active(with: .init(color: .black,
                                                   opacity: 1,
                                                   radius: 10, offset: .init(width: 8, height: 8)))
            if #available(iOS 15.0, *) {
                iOSButton.imageStyle = .init(image: .init(systemName: "car")!,
                                             imagePadding: 8.0,
                                             imagePlacement: .trailing)
            }
            iOSButton
                .onTap {
                    self.output?.lifeIsNotFair()
                        .observeOn(MainScheduler.instance)
                        .trackActivity(self.iOSButton.isBusy)
                        .subscribe(onNext: { ok in
                            self.iOSButton.setTitle("iOS 15++", for: .normal)
                            print("shelo")
                        }).disposed(by: self.disposeBag)
                }
        }
    }
    
    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        InitialConfigurator.shared.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        output?.viewDidFinishedLoading()
        setupRetryFetchingCallBack()
        
    }
    
    // MARK: Requests
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = {
            
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            
            self.output?.retryLoadingRequested()
        }
    }


    // MARK: Display logic

}
extension InitialViewController: InitialPresenterOutput {
 
    
    
}

