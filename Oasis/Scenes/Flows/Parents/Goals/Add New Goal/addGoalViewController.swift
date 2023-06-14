//
//  addGoalViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol addGoalViewControllerOutput {
    func addGoal(goalName: String, currency: String, amount: Int, endDate: String, file : String) -> Single<Void>

}

class addGoalViewController: BaseViewController {
    
    var interactor: addGoalViewControllerOutput?
    var router: addGoalRouter?
    
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        
        lbl.style = .init(font: MainFont.medium.with(size: 27), color: .black)
        lbl.text = "Add a Goal".localized
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
    
    lazy var pictureTitleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Picture"
        lbl.style = .init(font: MainFont.medium.with(size: 22), color: .black)
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var goalButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Add Goal", for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    lazy var endDateView : BaseUIView = {
        let view = BaseUIView()
        view.backgroundColor = .clear
        view.autoLayout()
        return view
    }()
    
    lazy var enddateLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "End Date"
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.bold.with(size: 20), color: .black)
        return lbl
    }()
    
    lazy var dateSelectedLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.style = .init(font: MainFont.medium.with(size: 16), color: .black)
        return lbl
    }()
    
    lazy var calendarImageView : BaseImageView = {
        let imgView = BaseImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        imgView.autoLayout()
        imgView.image = R.image.calendarIcon()!
        
        return imgView
    }()

    var goalNameView : TitleWithTextFieldView!
    var goalAmountView : AmountWithCurrencyView!
    
    var currencies = ["LBP", "$"]
    var currencySelected : String = "LBP"
    var goalName : String?
    var goalAmount : String?
    
    var chosenEndDate : Date = Date()
    var dateSelected : String?
    
    var uploadPictureButtonView : DottedButtonView!
}

//MARK:- View Lifecycle
extension addGoalViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGoalConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
        
    }
    
    private func setupUI(){
        addScrollView()
        addMainStackView()
        addtitleAndButton()
        addGoalInfoViews()
        addEndDateView()
        addGoalButton()
    }
    
    //Scroll View
    private func addScrollView(){
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addMainStackView(){
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    private func addtitleAndButton(){
        uploadPictureButtonView = DottedButtonView(actionName: "Upload a picture".localized, viewHeight: 62, viewWidth: 336, viewRadius: 48, numberOflines: 1, innerImage: R.image.uploadAPictureIcon())
        uploadPictureButtonView.autoLayout()
        
        stackView.addArrangedSubview(topTitleLabel)
        stackView.addArrangedSubview(uploadPictureButtonView)

        NSLayoutConstraint.activate([
        
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            uploadPictureButtonView.heightAnchor.constraint(equalToConstant: 62)
        ])
        
        uploadPictureButtonView.onTap {
        }
    }
    
    private func addGoalInfoViews(){
         goalNameView = TitleWithTextFieldView.init(requestTitle: "Goal’s name".localized,
                                                    textsColor: .black,
                                                    usertext: "",
                                                    textSize: 22,
                                                    isAgeRequest: false,
                                                    labelHeight: 60,
                                                    placholderText: "What’s your goal?".localized,
                                                     frame: .zero)

         goalAmountView = AmountWithCurrencyView.init(amountPlaceHolder: 0.0,
                                                 amount: 0,
                                                 currency: "LBP",
                                                 titleLbl: "Amount",
                                                     frame: .zero)
        
        stackView.addArrangedSubview(goalNameView)
        stackView.addArrangedSubview(goalAmountView)
        
        goalNameView.anyTextField.delegate = self
        goalAmountView.amountTextField.delegate = self
        
        NSLayoutConstraint.activate([
            goalNameView.heightAnchor.constraint(equalToConstant: 160),
            goalAmountView.heightAnchor.constraint(equalToConstant: 160)
        ])

        goalAmountView.currencyPicker.delegate = self
        goalAmountView.currencyPicker.dataSource = self
        
    }
    
    private func addEndDateView() {
        stackView.addArrangedSubview(endDateView)
        
        endDateView.addSubview(calendarImageView)
        endDateView.addSubview(enddateLabel)
        endDateView.addSubview(dateSelectedLabel)
    
        NSLayoutConstraint.activate([
            endDateView.heightAnchor.constraint(equalToConstant: 100),
            
            enddateLabel.leadingAnchor.constraint(equalTo: endDateView.leadingAnchor, constant: 10),
            enddateLabel.topAnchor.constraint(equalTo: endDateView.topAnchor, constant: 20),
            enddateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dateSelectedLabel.leadingAnchor.constraint(equalTo: endDateView.leadingAnchor, constant: 15),
            dateSelectedLabel.topAnchor.constraint(equalTo: enddateLabel.bottomAnchor, constant: 5),
            
            calendarImageView.trailingAnchor.constraint(equalTo: endDateView.trailingAnchor, constant: -10),
            calendarImageView.heightAnchor.constraint(equalToConstant: 35),
            calendarImageView.widthAnchor.constraint(equalToConstant: 35),
            calendarImageView.centerYAnchor.constraint(equalTo: enddateLabel.centerYAnchor),
            
        ])
        
        calendarImageView.onTap {
            self.showDatePicker()
        }
    }
    
    private func addGoalButton(){
        stackView.addArrangedSubview(goalButton)
        
        goalButton.heightAnchor.constraint(equalToConstant: 62).isActive = true

        goalButton.onTap {
            self.validateFields()
        }
    }
    
    //Date Picker
    private func showDatePicker(){
        let datepicker = DatePickerDialog(textColor: .black,
                                          buttonColor: Constants.Colors.aquaMarine,
                                          font: MainFont.normal.with(size: 15),
                                          locale: nil,
                                          showCancelButton: true)
         datepicker.show("Choose End Date".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized, defaultDate: chosenEndDate, minimumDate: nil, maximumDate: nil, datePickerMode: .date) { (chosenDate) in
            self.calendarImageView.resignFirstResponder()
             guard let cDate = chosenDate else {return}
            self.dateSelected = (Date().getStringFromTimeStamp(Int(cDate.timeIntervalSince1970)) as? String)
             self.dateSelectedLabel.text = self.dateSelected
        }
    }
    
    private func validateFields(){
        
        guard goalName.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in the Goals' Name", withCompletionHandler: nil)
            return
        }
        
        guard goalAmount.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please fill in the Goals' Amount", withCompletionHandler: nil)
            return
        }
        
        guard dateSelected.notNilNorEmpty else {
            showSimpleAlertView("", message: "Please Choose a Date", withCompletionHandler: nil)
            return
        }
        
        subscribeForAddGoal()
        
    }
}

//MARK:- NavBarAppearance
extension addGoalViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
    }
}


extension addGoalViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == goalNameView{
            self.goalName = textField.text
        }else{
            self.goalAmount = textField.text//.notNilNorEmpty ? Int(textField.text!) : 0
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.superview == goalNameView{
            self.goalName = textField.text
        }else{
            self.goalAmount = textField.text//.notNilNorEmpty ? Int(textField.text!) : 0
        }
    }
}

extension addGoalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
extension addGoalViewController{
    
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
        self.interactor?.addGoal(goalName: goalName!, currency: currencySelected, amount: Int(goalAmount!)!, endDate: dateSelected!, file: "")
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
