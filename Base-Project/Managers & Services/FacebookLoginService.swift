//
//  FacebookLoginService.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//
//
//import Foundation
//import FacebookCore
//import FacebookLogin
//import RxSwift
//import FBSDKLoginKit
//class FacebooLoginService {
//    
//    
//    
//    
//    var FBAccessToken : String {
//        return FBSDKAccessToken.current().tokenString
//    }
//    
//    var loginManager : LoginManager?
//    
//    init() {
//        self.loginManager = LoginManager()
//    }
//    
//    func performLogin(fromViewController vc : UIViewController? = UIApplication.topViewController() ) -> Single<String>  {
//        
//        return Single.create{ single  in
//            self.loginManager?.logIn(readPermissions: [ .publicProfile ], viewController: nil) { loginResult in
//                switch loginResult {
//                case .failed:
//                    single(.error(AppConstants.StaticData.Messsages.facebookLoginError))
//                case .cancelled:
//                    single(.error(AppConstants.StaticData.Messsages.facebookLoginError))
//                case .success:
//                    single(.success(self.FBAccessToken))
//                }
//            }
//            return Disposables.create {
//                print("Facebook Login Disposed")
//            }
//        }
//    }
//}
