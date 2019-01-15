//
//  TDAlertAction.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 11/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit

class TDAlertAction: UIAlertAction {
    
    var completionHandler: ((UIAlertAction) -> Void)?
    
    
    
    class func handlerSavingAlertAction(title: String?,
                                        style: UIAlertActionStyle,
                                        completionHandler:  @escaping ((UIAlertAction) -> Void))
        -> TDAlertAction {
            let alertAction = self.init(title: title, style: style, handler: completionHandler)
            alertAction.completionHandler = completionHandler
            return alertAction
    }
    
}
