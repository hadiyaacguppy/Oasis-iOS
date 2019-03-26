//
//  TDAlertAction.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 11/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit

/// This is just a wrapper on UIAlertAction. The `action` of this component can be called separately
class TDAlertAction: UIAlertAction {
    
    var completionHandler: ((UIAlertAction) -> Void)?
    
    
    
    class func handlerSavingAlertAction(title: String?,
                                        style: UIAlertAction.Style,
                                        completionHandler:  @escaping ((UIAlertAction) -> Void))
        -> TDAlertAction {
            let alertAction = self.init(title: title, style: style, handler: completionHandler)
            alertAction.completionHandler = completionHandler
            return alertAction
    }
    
}
