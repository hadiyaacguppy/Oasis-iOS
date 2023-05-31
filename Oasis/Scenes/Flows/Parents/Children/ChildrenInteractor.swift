//
//  ChildrenInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol ChildrenInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
    func didGetchildren(models : [ChildAPIModel]) -> [ChildrenModels.ViewModels.Children]
}

protocol ChildrenDataStore {
    
}

class ChildrenInteractor: ChildrenDataStore{
    
    var presenter: ChildrenInteractorOutput?
    
}

extension ChildrenInteractor: ChildrenViewControllerOutput{
    func getchildren() -> Single<[ChildrenModels.ViewModels.Children]> {
        return Single<[ChildrenModels.ViewModels.Children]>.create(subscribe: { single in
            APIClient.shared.getChildren()
                .subscribe(onSuccess: { [weak self] (children) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetchildren(models: children))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
    
    
}
