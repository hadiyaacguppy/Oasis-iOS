//
//  PushNotificationMessageController.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 10/30/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

class PushNotificationMessageController: BaseTableViewController {
    
    @IBOutlet weak var pushImageView: BaseImageView!{
        didSet{
            
        }
    }
    
    @IBOutlet weak var pushMessageTitleLabel: BaseLabel!{
        didSet{
            pushMessageTitleLabel.text = ""
            pushMessageTitleLabel.style = .init(font: MainFont.bold.with(size: 15),
                                                color: .black,
                                                numberOfLines: 0)
        }
    }
    
    @IBOutlet weak var pushMessageLabel: BaseLabel!{
        didSet{
            pushMessageLabel.text = ""
            pushMessageLabel.style = .init(font: MainFont.normal.with(size: 15),
                                           color: .black,
                                           numberOfLines: 0)
        }
    }
    
    private var reverseAspectRatio : CGFloat? {
        guard self.passedMessageContent != nil else {
            return nil
        }
        guard let imageHeight = self.passedMessageContent?.imageHeight else{
            return nil
        }
        guard let imageWidth = self.passedMessageContent?.imageWidth else {
            return nil 
        }
        
        return CGFloat(imageHeight/imageWidth)
    }
    
    var passedMessageContent : PushMessageContent?
}

//MARK: ViewLifeCycle
extension PushNotificationMessageController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewAppearance()
        setUI()
    }
}

//MARK:- TableViewAppearance
extension PushNotificationMessageController{
    func setupTableViewAppearance(){
        self.tableView.configure(withSelectionAllowed: false,
                                 andSperatorStyle: .none,
                                 andBackgroundColor: .white,
                                 isBouncingEnabled: false)
    }
}

//MARK:- UI
extension PushNotificationMessageController{
    private func setUI(){
        guard  passedMessageContent != nil else {
            return
        }
        self.pushImageView.setNormalImage(withURL: passedMessageContent?.image?.asURL())
        self.pushMessageTitleLabel.text = passedMessageContent?.title
        self.pushMessageLabel.text = passedMessageContent?.body
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}

//MARK:- TableViewDelegates
extension PushNotificationMessageController{
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            switch indexPath.row{
            case 0:
                guard let reverseAspectRatio = self.reverseAspectRatio else { return .zero }
                return reverseAspectRatio*(UIScreen.width)
            default:
                return UITableView.automaticDimension
            }
    }
    override func tableView(_ tableView: UITableView,
                            estimatedHeightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return 40
    }
}
