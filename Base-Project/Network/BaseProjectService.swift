//
//  BaseProjectService.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya

enum BaseProjectService {

    // MARK : Login - Register - Password Change etc..
    ///Example
    //case loginWithGoogle(googleUserID : String, email : String, firstName : String, lastName : String, imageUrl : String)

    
    // MARK : Payment
    
    // MARK : Profile
    
    // MARK : Push
    case setPush(pushId : String)
    
    // MARK : Others
}

// MARK: - TargetType Protocol Implementation
extension BaseProjectService: TargetType {
    
    var baseURL: URL { return URL(string: Constants.baseURl)! }
    var path: String {
        switch self {

        case .setPush( _):
            return "/push"
        }
    }
    var method: Moya.Method {
        switch self {
        case .setPush:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        
        case .setPush(let pushId):
            return .requestParameters(parameters: ["push_id" : pushId], encoding: URLEncoding.default)
            
            ///Example of Multipart Upload
            /*
        case let .registerWithEmail(email, firstName, lastName, password, nationality, location, phoneNumber, gender, dob, profileImage):
            
            var multipartParametersArray = [MultipartFormData]()
            
            let emailMulti = MultipartFormData(provider: .data(email.data(using: .utf8)!), name: "email")
            let firstNameMulti = MultipartFormData(provider: .data(firstName.data(using: .utf8)!), name: "first_name")
            let lastNameMulti = MultipartFormData(provider: .data(lastName.data(using: .utf8)!), name: "last_name")
            let phoneNumberMulti = MultipartFormData(provider: .data(phoneNumber.data(using: .utf8)!), name: "phone_number")
            let passwordMulti = MultipartFormData(provider: .data(password.data(using: .utf8)!), name: "password")
            let nationalityMulti = MultipartFormData(provider: .data(phoneNumber.data(using: .utf8)!), name: "nationality")
            let udidMulti = MultipartFormData(provider: .data(Utilities.getDeviceUDID().data(using: .utf8)!), name: "uuid")
            let appIdString = "\(passengerAppId)"
            let appidMulti = MultipartFormData(provider: .data(appIdString.data(using: .utf8)!), name: "app_id")
            let companyIDString = "\(passengerCompanyId)"
            let companyidMulti = MultipartFormData(provider: .data(companyIDString.data(using: .utf8)!), name: "company_id")
            let pushIdString = userDef.object(forKey: "FCMToken") as! String
            let pushidMulti = MultipartFormData(provider: .data(pushIdString.data(using: .utf8)!), name: "push_id")
            
            multipartParametersArray = [emailMulti, firstNameMulti, lastNameMulti, phoneNumberMulti, passwordMulti, nationalityMulti, udidMulti, appidMulti, companyidMulti, pushidMulti]
            
            if let data = profileImage{
                let imageData =  Moya.MultipartFormData(provider: .data(data), name: "profile_image", fileName: "photo.jpg", mimeType:"image/jpeg")
                multipartParametersArray.append(imageData)
            }
            
            if location != nil{
                let locationMulti = MultipartFormData(provider: .data(location!.data(using: .utf8)!), name: "location")
                multipartParametersArray.append(locationMulti)
            }
            
            if gender != nil {
                let genderMulti = MultipartFormData(provider: .data(gender!.data(using: .utf8)!), name: "gender")
                multipartParametersArray.append(genderMulti)
            }
            
            if dob != nil {
                let dobMulti = MultipartFormData(provider: .data(dob!.data(using: .utf8)!), name: "dob")
                multipartParametersArray.append(dobMulti)
            }
            
            return .uploadMultipart(multipartParametersArray)
            
            //            else{
            //                return .requestParameters(parameters: ["email" : email, "first_name" : firstName, "last_name" :lastName, "phone_number" : phoneNumber, "password" : password, "uuid" : Utilities.getDeviceUDID(), "app_id" : passengerAppId, "push_id" : 1, "company_id" : passengerCompanyId, "nationality" : nationality, "location" : location, "gender" : gender, "dob" :dob], encoding: URLEncoding.default)
            //            }
*/
       
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        switch self {
        case .setPush:
            return ["session-token" : ""]
        }
    }
    
    var validationType : ValidationType {
        
        switch self {
        default:
            return .successCodes
        }
    }
    
    
    /*
     The TargetType specifies both a base URL for the API and the sample data for each enum value. The sample data are Data instances, and could represent JSON, images, text, whatever you're expecting from that endpoint.
     
     You can also set up custom endpoints to alter the default behavior to your needs. For example:
     
     let endpointClosure = { (target: MyService) -> Endpoint<MyService> in
     return Endpoint<MyService>(url: URL(target: target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
     }
     */
    
    
    /*
     Most of the time, this closure is just a straight translation from target, method and task into an Endpoint instance. However, since it's a closure, it'll be executed at each invocation of the API, so you could do whatever you want. Say you want to test network error conditions like timeouts, too.
     
     let failureEndpointClosure = { (target: MyService) -> Endpoint<MyService> in
     let sampleResponseClosure = { () -> (EndpointSampleResponse) in
     if shouldTimeout {
     return .networkError(NSError())
     } else {
     return .networkResponse(200, target.sampleData)
     }
     }
     return Endpoint<MyService>(url: url(target), sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
     }
     */
}
