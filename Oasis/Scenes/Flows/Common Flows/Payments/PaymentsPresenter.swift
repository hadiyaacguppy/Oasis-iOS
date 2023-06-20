//
//  PaymentsPresenter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

class PaymentsPresenter {}

extension PaymentsPresenter: PaymentsInteractorOutput {
    
    func didGetPayments(models : [PaymentAPIModel]) -> [ParentsHomeModels.ViewModels.Payment]{
        return models.map{createPayment(model: $0)}
    }
    
    func createPayment(model : PaymentAPIModel) -> ParentsHomeModels.ViewModels.Payment{
        return ParentsHomeModels.ViewModels.Payment(id: model.id!, paymentType: model.paymentType, title: model.title, amount: model.amount)

    }

    func apiCallFailed(withError error: NetworkErrorResponse)
    -> ErrorViewModel {
        return self.parseErrorViewModel(fromErrorResponse:error)
    }
    
    func parseErrorViewModel(fromErrorResponse errorResponse : NetworkErrorResponse)
    -> ErrorViewModel {
        
        switch errorResponse.code{
        case .apiError:
            return ErrorViewModel(withMessage: errorResponse.message,
                                  isNoInternetAvaibleError: false,
                                  withCode: errorResponse.code )
        case .noInternetConnection:
            return ErrorViewModel(withMessage: errorResponse.message,
                                  isNoInternetAvaibleError: true,
                                  withCode: errorResponse.code )
        default:
            return ErrorViewModel(withMessage: errorResponse.message,
                                  isNoInternetAvaibleError: false,
                                  withCode: errorResponse.code )
        }
    }
    
}
