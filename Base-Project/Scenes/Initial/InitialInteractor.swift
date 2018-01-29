//
//  InitialInteractor.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

protocol InitialInteractorInput {

}

protocol InitialInteractorOutput {
  func didFail(withErrorMessage msg : String)
}

protocol InitialDataSource {

}

protocol InitialDataDestination {

}

class InitialInteractor: InitialInteractorInput, InitialDataSource, InitialDataDestination {

    var output: InitialInteractorOutput?

    // MARK: Business logic


}

extension InitialInteractor: InitialViewControllerOutput, InitialRouterDataSource, InitialRouterDataDestination {
  func viewDidFinishedLoading(){

  }
}
