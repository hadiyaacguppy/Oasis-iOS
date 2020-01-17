//
//  PushNotificationViewController.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 7/24/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

class PushNotificationContainer: BaseViewController {
   
    // Outlet
    @IBOutlet weak var closeLabel: BaseLabel!{
        didSet{
            closeLabel.text = "Close App"
            closeLabel.style = .init(font: MainFont.bold.with(size: 17),
                                     color: .black,
                                     alignment: .center)
        }
    }
    @IBOutlet weak var openLabel: BaseLabel!{
        didSet{
            openLabel.text = "Continue"
                       openLabel.style = .init(font: MainFont.bold.with(size: 15),
                                                color: .white,
                                                alignment: .center)
        }
    }
    
    @IBOutlet
    weak var closeAppButtonOutlet: BaseUIView!{
        didSet {
            closeAppButtonOutlet.backgroundColor = UIColor.lightGray
            closeAppButtonOutlet.onTap{
                fatalError("Close App in Push Notification Tapped")
            }.disposed(by: disposeBag)
        }
    }
    
    @IBOutlet
    weak var openInAppButtonOutlet: BaseUIView!{
        didSet {
            openInAppButtonOutlet.backgroundColor = .blue
            openInAppButtonOutlet.onTap {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }.disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var stackViewHolder: BaseUIView!
    
    // Properties
    var pageView: UIPageViewController!
    var viewControllers = [UIViewController]()
    var currentPageIndex = 0
    var passedMessage : PushMessageContent?
}


//MARK:- View Lifecycle
extension PushNotificationContainer{
    
    override
    func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAppearance()
        setupPageView()
        self.title = ""
        if #available(iOS 13, *) {} else {
           addDismissButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
}

//MARK:- PageView
extension PushNotificationContainer{
    
    func setupPageView(){
        pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageView.view.frame = CGRect(x: 0, y: 0,
                                     width: self.view.bounds.width,
                                     height: self.view.bounds.height - stackViewHolder.frame.height - bottomHomeScreenIndicatorHeight - 1)
        
        pageView.view.backgroundColor = UIColor.clear
        
        let vc = R.storyboard.pushNotification.pushNotificationMessageController()!
        vc.passedMessageContent = self.passedMessage
        viewControllers = [vc]
        
        pageView.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        self.addChild(pageView)
        self.view.addSubview(pageView.view)
        pageView.didMove(toParent: self)
    }

}

//MARK:- NavBarAppearance
extension PushNotificationContainer{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .appDefault
    }
}
