//
//  PinVerificationViewController.swift
//  Healr
//
//  Created by Mhmd Rizk on 11/28/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//


import UIKit
import RxSwift

protocol PinVerificationViewControllerInput {

}

protocol PinVerificationViewControllerOutput {
    
    func viewDidFinishedLoading()
    
    func retryLoadingRequested()
    
    func confirmButtonTapped() -> Completable
    
    func pinOneValueSet(_ value : String)
    
    func pinTwoValueSet(_ value : String)
    
    func pinThreeValueSet(_ value : String)
    
    func pinFourthValueSet(_ value : String)
    
    func resendButtonTapped() -> Completable
    
}

class PinVerificationViewController: BaseTableViewController, PinVerificationViewControllerInput {

    var output: PinVerificationViewControllerOutput?
    var router: PinVerificationRouter?

    //MARK:- Outlets
    
    
    @IBOutlet weak var firstPinDigitTextField: BaseSkyFloatingTextField!
    
    @IBOutlet weak var secondPinDigitTextField: BaseSkyFloatingTextField!
    
    @IBOutlet weak var thirdPindigitTextField: BaseSkyFloatingTextField!
    
    @IBOutlet weak var fourthPinDigitTextField: BaseSkyFloatingTextField!
    
    @IBOutlet weak var timerLabel: UILabel!{
        didSet{
            timerLabel
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext: { _ in
                    guard self.timerLabel.text == "RESEND" else{
                        return
                    }
                    self.resendButtonTapped()
                })
                .disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var confirmButton: AppBaseButton!{
        didSet{
            confirmButton
                .rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext : { _ in self.confirmButtonTapped()})
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        PinVerificationConfigurator.shared.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidFinishedLoading()
        self.title = "Verification"
        self.setupRetryFetchingCallBack()
        self.setTimer()
        self.subscribeToPinCompletion()
        self.initializaTextFieldObservingTextChanges()
        self.subscribeToPinValue()
        self.firstPinDigitTextField.becomeFirstResponder()
    }
    
    // MARK: Requests
    
 
    fileprivate func resendButtonTapped(){
        Utilities.ProgressHUD.showLoading(withMessage: "Resending Pin..")
        self.output?.resendButtonTapped().subscribe(onCompleted: {
            self.setTimer()
            Utilities.ProgressHUD.dismissLoading()
        }, onError: { (error) in
            Utilities
                .ProgressHUD
                .showError(withMessage: (error as! ErrorViewModel).message)
        })
        .disposed(by: disposeBag)
    }
    
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = {
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            
            self.output?.retryLoadingRequested()
        }
    }
    
    fileprivate func confirmButtonTapped(){
        Utilities.ProgressHUD.showLoading(withMessage: "Loading..")
        self.output?.confirmButtonTapped().subscribe(onCompleted: {
            //call any actions here
        }, onError: { (error) in
            Utilities
                .ProgressHUD
                .showError(withMessage: (error as! ErrorViewModel).message)
        })
        .disposed(by: disposeBag)
    }
    
    func setTimer(){
        let timerSubscription = Utilities.Timer
            .countDown(from: Constants.DefaultValues.SMSTimerInterval, to: 0, interval: 1)
        timerSubscription
            .map{$0.toTimeParts().description}
            .bind(to: timerLabel.rx.text)
            .disposed(by: disposeBag)
        timerSubscription
            .filter{ $0 == 0}
            .map{ _ in self.timerFinised()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func timerFinised(){
        timerLabel.text = "RESEND"
    }
    
    // MARK: Display logic
    
 
}

//MARK: Pin digits Subscription
extension PinVerificationViewController {

    fileprivate func subscribeToPinCompletion(){
        
        let firstPinDigitValidation = firstPinDigitTextField
            .rx
            .text
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let secondPinDigitValidation = secondPinDigitTextField
            .rx
            .text
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let thirdPinDigitValidation = thirdPindigitTextField
            .rx
            .text
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        let fourthPinDigitValidation = fourthPinDigitTextField
            .rx
            .text
            .filter { $0 != nil }
            .map { $0!}
            .map{$0.count == 1}
            .share(replay : 1)
        
        
        let confirmButtonTapped = Observable.combineLatest(firstPinDigitValidation,secondPinDigitValidation,thirdPinDigitValidation,fourthPinDigitValidation) { first,second,third,fourth in
            return first && second && third && fourth
        }
        
        
        
        confirmButtonTapped
            .bind(to:
                confirmButton
                    .rx
                    .isEnabledAndHighlighted
            )
            .disposed(by: disposeBag)
    }

    fileprivate func subscribeToPinValue(){
        self.firstPinDigitTextField
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(self.firstPinDigitTextField
                .rx
                .text
                .orEmpty)
            .subscribe(onNext : { value in
                setValuForPin(0, value)
            })
            .disposed(by: disposeBag)
        
        self.secondPinDigitTextField
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(self.secondPinDigitTextField
                .rx
                .text
                .orEmpty)
            .subscribe(onNext : { value in
                setValuForPin(1, value)
            })
            .disposed(by: disposeBag)
        
        self.thirdPindigitTextField
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(self.thirdPindigitTextField
                .rx
                .text
                .orEmpty)
            .subscribe(onNext : { value in
                setValuForPin(2, value)
            })
            .disposed(by: disposeBag)
        
        
        self.fourthPinDigitTextField
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(self.fourthPinDigitTextField
                .rx
                .text
                .orEmpty)
            .subscribe(onNext : { value in
                setValuForPin(3, value)
            })
            .disposed(by: disposeBag)
        
        func setValuForPin(_ index : Int ,_ value : String){
            switch index {
            case 0:
                self.output?.pinOneValueSet(value)
            case 1:
                self.output?.pinTwoValueSet(value)
            case 2:
                self.output?.pinThreeValueSet(value)
            case 3:
                self.output?.pinFourthValueSet(value)
            default:
                return
            }
        }
        
        
        
    }
    
}

extension PinVerificationViewController: PinVerificationPresenterOutput {
    

}

extension PinVerificationViewController : UITextFieldDelegate {
  
    fileprivate func initializaTextFieldObservingTextChanges(){
        firstPinDigitTextField.delegate = self
        firstPinDigitTextField.textAlignment = .center
        firstPinDigitTextField.keyboardType = .numberPad
        firstPinDigitTextField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(textField:)),
            for: UIControlEvents.editingChanged
        )
        
        secondPinDigitTextField.delegate = self
        secondPinDigitTextField.textAlignment = .center
        secondPinDigitTextField.keyboardType = .numberPad
        secondPinDigitTextField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(textField:)),
            for: UIControlEvents.editingChanged
        )
        
        thirdPindigitTextField.delegate = self
        thirdPindigitTextField.textAlignment = .center
        thirdPindigitTextField.keyboardType = .numberPad
        thirdPindigitTextField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(textField:)),
            for: UIControlEvents.editingChanged
        )
        
        fourthPinDigitTextField.delegate = self
        fourthPinDigitTextField.textAlignment = .center
        fourthPinDigitTextField.keyboardType = .numberPad
        fourthPinDigitTextField.addTarget(
            self,
            action: #selector(self.textFieldDidChange(textField:)),
            for: UIControlEvents.editingChanged
        )
        
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if let text = textField.text{
            if text.count == 1{
                switch textField{
                case firstPinDigitTextField:
                    secondPinDigitTextField.becomeFirstResponder()
                case secondPinDigitTextField:
                    thirdPindigitTextField.becomeFirstResponder()
                case thirdPindigitTextField:
                    fourthPinDigitTextField.becomeFirstResponder()
                case fourthPinDigitTextField:
                    fourthPinDigitTextField.resignFirstResponder()
                default:
                    break
                }
            }
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String)
        -> Bool {
            if let text  = textField.text{
                //restrict the uitextfield to accept only numbers
                let aSet = NSCharacterSet(charactersIn:"0123456789٠١٢٣٤٥٦٧٨٩").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                //check the length of the text in the textfield
                let newLength = text.count + string.count - range.length
                //return true only if the length is less than or equal to 1 and when replacemenetString is done :this to restrict the textfield to accept only numbers
                return ((newLength <= 1) && (string == numberFiltered))
                
            }else{
                return true
            }
    }
    
}
