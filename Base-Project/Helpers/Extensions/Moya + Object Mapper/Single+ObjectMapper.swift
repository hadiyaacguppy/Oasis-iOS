//
//  Single+ObjectMapper.swift
//  SomfyMoya
//
//  Created by Wassim on 9/26/17.
//  Copyright © 2017 wassimseif. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya
/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapObject<T: BaseMappable>(_ type: T.Type,atKeyPath keyPath : String? = nil, context: MapContext? = nil ) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, context: context, atKeyPath : keyPath))
        }
    }
    
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapArray<T: BaseMappable>(_ type: T.Type,atKeyPath keyPath : String? = nil, context: MapContext? = nil ) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, context: context, atKeyPath  : keyPath))
        }
    }
}


// MARK: - ImmutableMappable
public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    /// Maps data received from the signal into an object
    /// which implements the ImmutableMappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, context: context))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the ImmutableMappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, context: context))
        }
    }
}

