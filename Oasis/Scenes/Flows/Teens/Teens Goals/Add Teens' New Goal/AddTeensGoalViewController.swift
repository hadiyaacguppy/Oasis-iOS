//
//  AddTeensGoalViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol AddTeensGoalViewControllerOutput {
    func addGoal(goalName: String, currency: String, amount: Int) -> Single<Void>

}

class AddTeensGoalViewController: BaseViewController {
    
    var interactor: AddTeensGoalViewControllerOutput?
    var router: AddTeensGoalRouter?
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.medium.with(size: 35), color: .white)
        lbl.text = "Add a goal".localized
        lbl.autoLayout()
        return lbl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var addGoalButton: OasisAquaButton = {
        let button = OasisAquaButton()
        button.setTitle("Add Goal", for: .normal)
        button.autoLayout()
        return button
    }()
    
    var yourGoalView : TitleWithTextFieldView!
    var goalAmountView : AmountWithCurrencyView!
    
    var currencies = ["LBP", "$"]
    var currencySelected : String = "LBP"
    var goalName : String?
    var goalAmount : String?
}

//MARK:- View Lifecycle
extension AddTeensGoalViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AddTeensGoalConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        view.backgroundColor = Constants.Colors.appViolet
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupUI(){
        addScrollViewAndStackView()
        addTitle()
        addGoalInfoViews()
        createAddGoalButton()
    }
    
    private func addScrollViewAndStackView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30)
        ])
        
    }
    
    private func addTitle(){
    
        stackView.addArrangedSubview(topTitleLabel)
        
        topTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func addGoalInfoViews(){
         yourGoalView = TitleWithTextFieldView.init(requestTitle: "What is your Goal?".localized,
                                                    textsColor: .white,
                                                    usertext: "",
                                                    textSize: 35,
                                                    isAgeRequest: false,
                                                    labelHeight: 89,
                                                    placholderText: "",
                                                    frame: .zero)

         goalAmountView = AmountWithCurrencyView.init(amountPlaceHolder: 0.00,
                                                 amount: 0,
                                                 currency: "LBP",
                                                 titleLbl: "Goal amount",
                                                frame: .zero)
        
        stackView.addArrangedSubview(yourGoalView)
        stackView.addArrangedSubview(goalAmountView)
        
        yourGoalView.anyTextField.delegate = self
        goalAmountView.amountTextField.delegate = self
        
        NSLayoutConstraint.activate([
            yourGoalView.heightAnchor.constraint(equalToConstant: 160),
            goalAmountView.heightAnchor.constraint(equalToConstant: 160)
        ])

        goalAmountView.currencyPicker.delegate = self
        goalAmountView.currencyPicker.dataSource = self
        
    }
    
    private func validateFields(){
        
        guard goalName.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in your Goal", withCompletionHandler: nil)
            return
        }
        
        guard goalAmount.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in the Goals' Amount", withCompletionHandler: nil)
            return
        }
        
        //subscribeForAddGoal()
        
    }
    
    private func createAddGoalButton(){
        stackView.addArrangedSubview(addGoalButton)
        
        addGoalButton.heightAnchor.constraint(equalToConstant: 62).isActive = true
       // addGoalButton.bottomAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
        
        addGoalButton.onTap {
            self.validateFields()
        }
    }
}

//MARK:- NavBarAppearance
extension AddTeensGoalViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
    }
}

extension AddTeensGoalViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == yourGoalView{
            self.goalName = textField.text
        }else{
            self.goalAmount = textField.text//.notNilNorEmpty ? Int(textField.text!) : 0
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.superview == yourGoalView{
            self.goalName = textField.text
        }else{
            self.goalAmount = textField.text//.notNilNorEmpty ? Int(textField.text!) : 0
        }
    }
}

extension AddTeensGoalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        currencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = currencies[row]
        currencySelected = currency
        goalAmountView.currencyLabel.text = currencySelected
        pickerView.isHidden = true
    }


}

//MARK:- Callbacks
extension AddTeensGoalViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            #warning("Retry Action does not set")
        }
    }
    
    private func subscribeForAddGoal(){
        self.interactor?.addGoal(goalName: goalName!, currency: currencySelected, amount: Int(goalAmount!)!)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self!.display(successMessage: "Goad is Added Successfully")
                self!.router?.popView()
                }, onError: { [weak self](error) in
                    self!.display(errorMessage: (error as! ErrorViewModel).message)
            })
            .disposed(by: self.disposeBag)
    }
}


