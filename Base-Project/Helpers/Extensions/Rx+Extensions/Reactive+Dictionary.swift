//
//  Reactive+Dictionary.swift
//  Base-Project
//
//  Created by Wassim on 9/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

enum JSONMappingError : Swift.Error {
    case mappingError([String : Any])
    case arrayMappingError(Any)
    public var errorDescription: String? {
        switch self {
        case let .mappingError(json):
            return "Failed to map \(json) to Requested Type"
        case let .arrayMappingError(json):
            return "Failed to map \(json) to Requested Type"
        }
    }
}
public extension PrimitiveSequence where Trait == SingleTrait , ElementType == [ String : Any]{
    public func mapObject<T: BaseMappable>(_ type: T.Type,atKeyPath keyPath : String? = nil, context: MapContext? = nil )  -> Single<T> {
        return flatMap { json -> Single<T> in
            if keyPath == nil {
                guard let obj = Mapper<T>().map(JSON: json) else {
                    return Single.error(JSONMappingError.mappingError(json))
                }
                return Single.just(obj)
            }
            guard let customJSONDictionary = json[keyPath!] as? [String : Any] else {
                return Single.error(JSONMappingError.mappingError(json))
            }
            guard let object = Mapper<T>(context: context).map(JSONObject: customJSONDictionary) else {
                return Single.error(JSONMappingError.mappingError(json))
            }
            return Single.just(object)
        }
        
    }
    
    
}
public extension PrimitiveSequence where Trait == SingleTrait , ElementType == Any{
    public func mapArray<T: BaseMappable>(_ type: T.Type,atKeyPath keyPath : String? = nil, context: MapContext? = nil )  -> Single<[T]> {
        return flatMap { json -> Single<[T]> in
            if keyPath == nil {
                guard let jsonArray =  json as? [[String : Any]] else {
                    return Single.error(JSONMappingError.arrayMappingError(json))
                    
                }
                return Single.just(Mapper<T>().mapArray(JSONArray: jsonArray))
            }
            
            guard let jsonObj = json as? [String : Any] else {
                return Single.error(JSONMappingError.arrayMappingError(json))
            }
            guard let customJSONDictionary = jsonObj[keyPath!] as? [[String : Any]] else {
                return Single.error(JSONMappingError.arrayMappingError(json))
            }
            return Single.just(Mapper<T>().mapArray(JSONArray: customJSONDictionary))
            
        }
        
    }
}
