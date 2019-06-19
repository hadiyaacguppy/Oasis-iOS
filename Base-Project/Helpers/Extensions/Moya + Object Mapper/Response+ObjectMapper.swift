//
//  Response+ObjectMapper.swift
//  SomfyMoya
//
//  Created by Wassim on 9/26/17.
//  Copyright © 2017 wassimseif. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift
public extension Response {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil, atKeyPath keyPath : String? = nil) throws -> T {
        
        if keyPath == nil {
            guard let object = Mapper<T>(context: context).map(JSONObject: try mapJSON()) else {
                throw MoyaError.jsonMapping(self)
            }
            return object
            
        }
        
        guard let jsonDictionary = try? mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        let keypaths = keyPath!.split(separator: ".")
        var customJSONDictionary : [String: Any]? = jsonDictionary
        
        for path in keypaths  {
            customJSONDictionary = customJSONDictionary![String(path)] as? [String : Any]
            if customJSONDictionary == nil {
                throw MoyaError.jsonMapping(self)
            }
        }
        
        if customJSONDictionary == nil {
            throw MoyaError.jsonMapping(self)
        }
        guard let object = Mapper<T>(context: context).map(JSONObject: customJSONDictionary) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
        

       
    }
    
    
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil, atKeyPath keyPath : String? = nil ) throws -> [T] {
        
        if keyPath == nil {
            guard let array = try mapJSON() as? [[String : Any]] else {
                throw MoyaError.jsonMapping(self)
            }
            return Mapper<T>(context: context).mapArray(JSONArray: array)
        }
        
        
        guard let jsonDictionary = try? mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        var JSONArray : [[String: Any]]? = nil
        var intermediateJSONObjects : [String: Any]? = jsonDictionary
        let keypaths = keyPath!.split(separator: ".")
        
        for path in keypaths  {
            
            if path == keypaths.last! {
                // Here i have hands on the json array
                JSONArray = intermediateJSONObjects![String(path)] as? [[String : Any]]
                
                break
            }
            
            intermediateJSONObjects = intermediateJSONObjects![String(path)] as? [String : Any]
            if intermediateJSONObjects == nil {
                throw MoyaError.jsonMapping(self)
            }
            
        }
        guard let finalJSONArray = JSONArray else {
            throw MoyaError.jsonMapping(self)
        }
        

        return Mapper<T>(context: context).mapArray(JSONArray: finalJSONArray)
        
    }
    
}


// MARK: - ImmutableMappable
public extension Response {
    
    /// Maps data received from the signal into an object which implements the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        return try Mapper<T>(context: context).map(JSONObject: try mapJSON())
    }
    
    /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return try Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
}

