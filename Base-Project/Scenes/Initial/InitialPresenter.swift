//
//  InitialPresenter.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

protocol InitialPresenterInput {

}

protocol InitialPresenterOutput: class {
  func display(errorMessage msg : String )
}

class InitialPresenter: InitialPresenterInput {

    weak var output: InitialPresenterOutput?

    // MARK: Presentation logic

}
extension InitialPresenter: InitialInteractorOutput {
  func didFail(withErrorMessage msg : String){
    output?.display(errorMessage :  msg)
  }
}
