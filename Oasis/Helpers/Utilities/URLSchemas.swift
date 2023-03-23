//
//  URLSchemas.swift
//  Oasis
//
//  Created by Mojtaba Al Mousawi on 9/19/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

struct URLSchemas{
    
    enum Browsers : String{
        case securedChrome = "googlechromes://"
        case notSecuredChrome = "googlechrome://"
        case securedFireFox = "firefox://open-url?url=https://"
        case notSecuredFireFox = "firefox://open-url?url=http://"
        case securedOpera = "opera://open-url?url=https://"
        case notSecuredOpera = "opera://open-url?url=http://"
    }
}
