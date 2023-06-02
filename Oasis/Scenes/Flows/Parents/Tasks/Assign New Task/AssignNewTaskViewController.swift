//
//  AssignNewTaskViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AssignNewTaskViewControllerOutput {
    func getTaskTypes() -> Single<[AssignNewTaskModels.ViewModels.Task]>
    func addTask(title: String, currency: String, amount: Int, childID: String, taskTypeID: Int) -> Single<Void>
}

class AssignNewTaskViewController: BaseViewController {
    
    var interactor: AssignNewTaskViewControllerOutput?
    var router: AssignNewTaskRouter?
    
    lazy var topTitleLabel :  ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "Assign New Task".localized
        return lbl
    }()
    
    lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.autoLayout()
       scrollView.backgroundColor = .clear
       scrollView.showsVerticalScrollIndicator = false
       return scrollView
   }()
   
   //Horizontal Labels
   lazy var stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.distribution = .fillEqually
       stackView.spacing = 19
       stackView.autoLayout()
       stackView.backgroundColor = .clear
       return stackView
   }()
    
    lazy var categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 19
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
}

//MARK:- View Lifecycle
extension AssignNewTaskViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AssignNewTaskConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
}

//MARK:- NavBarAppearance
extension AssignNewTaskViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension AssignNewTaskViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            #warning("Retry Action does not set")
        }
    }
    
    private func subscribeForGetTaskTypes(){
        self.interactor?.getTaskTypes()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "Done")
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func subscribeForAddNewTask(){
        self.interactor?.addTask(title: "", currency: "", amount: 0, childID: "", taskTypeID: 0)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "Done")
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}


