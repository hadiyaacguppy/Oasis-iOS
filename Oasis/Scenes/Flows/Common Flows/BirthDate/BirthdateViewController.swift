//
//  BirthdateViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol BirthdateViewControllerOutput {
    
}

class BirthdateViewController: BaseViewController {
    
    var interactor: BirthdateViewControllerOutput?
    var router: BirthdateRouter?
    
    private lazy var topStaticLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 33), color: .white, numberOfLines: 2)
        label.text = "What is your\nBirthdate?".localized
        label.autoLayout()
        return label
    }()
    
    private lazy var bottomImageView : UIImageView = {
        let img = UIImageView()
        img.image = R.image.fish()!
        img.contentMode = .scaleAspectFit
        img.autoLayout()
        return img
    }()
    
    private lazy var roundView : BaseUIView = {
       let view = BaseUIView()
        view.backgroundColor = UIColor(hexFromString: "#D9D9D9", alpha: 0.3)
        view.roundCorners = .all(radius: 43)
        view.autoLayout()
        return view
    }()
    
    private lazy var bottomStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var mainStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var dayNumberLabel : BaseLabel = {
        let label = BaseLabel()
        label.text = "1"
        label.style = .init(font: MainFont.bold.with(size: 35), color: .white, alignment: .center)
        label.autoLayout()
        return label
    }()
    
    private lazy var monthNumberLabel : BaseLabel = {
        let label = BaseLabel()
        label.text = "09"
        label.style = .init(font: MainFont.bold.with(size: 35), color: .white, alignment: .center)
        label.autoLayout()
        return label
    }()
    
    private lazy var yearNumberLabel : BaseLabel = {
        let label = BaseLabel()
        label.text = "1992"
        label.style = .init(font: MainFont.bold.with(size: 35), color: .white, alignment: .center)
        label.autoLayout()
        return label
    }()
    
    var chosenBirthdate : Date = Date()
}

//MARK:- View Lifecycle
extension BirthdateViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BirthdateConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        self.view.backgroundColor = Constants.Colors.appViolet
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupUI(){
        buildMainStackViewWithTopTitle()
        buildDateStackView(lbl: dayNumberLabel, title: "Day")
        buildDateStackView(lbl: monthNumberLabel, title: "Month")
        buildDateStackView(lbl: yearNumberLabel, title: "Year")
        buildBottomStackView()
    }
    
    private func buildMainStackViewWithTopTitle(){
        self.view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStaticLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            topStaticLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 20),
            topStaticLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            topStaticLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            topStaticLabel.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func buildDateStackView(lbl : BaseLabel, title : String){
        let dateStackView : UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = 35
            stackView.autoLayout()
            stackView.backgroundColor = .clear
            return stackView
        }()
        
        mainStackView.addArrangedSubview(dateStackView)
        
        let squareView : BaseUIView = {
           let view = BaseUIView()
            view.backgroundColor = UIColor(hexFromString: "#D9D9D9", alpha: 0.3)
            view.roundCorners = .all(radius: 15)
            view.autoLayout()
            view.onTap {
                self.showDatePicker()
            }
            return view
        }()
        
        let dateTitleLabel : BaseLabel = {
            let label = BaseLabel()
            label.style = .init(font: MainFont.bold.with(size: 35), color: .white)
            label.autoLayout()
            return label
        }()
        
        dateStackView.addArrangedSubview(squareView)
        dateStackView.addArrangedSubview(dateTitleLabel)
        squareView.addSubview(lbl)
        
        dateTitleLabel.text = title
        
        NSLayoutConstraint.activate([
//            dateStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
//            dateStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
//            dateStackView.heightAnchor.constraint(equalToConstant: 100),
            
//            squareView.leadingAnchor.constraint(equalTo: dateStackView.leadingAnchor, constant: 16),
//            squareView.topAnchor.constraint(equalTo: dateStackView.topAnchor, constant: 8),
            squareView.widthAnchor.constraint(equalToConstant: 124),
            squareView.heightAnchor.constraint(equalToConstant: 84),
            
            dateTitleLabel.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: 35),
            dateStackView.centerYAnchor.constraint(equalTo: squareView.centerYAnchor),
            
            lbl.centerYAnchor.constraint(equalTo: squareView.centerYAnchor),
            lbl.centerXAnchor.constraint(equalTo: squareView.centerXAnchor)
        ])
    }
    
    private func buildBottomStackView(){
        view.addSubview(bottomImageView)
        view.addSubview(roundView)
        
        let arrowImage = BaseImageView(frame: .zero)
        arrowImage.image = R.image.longWhiteArrow()!
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.autoLayout()
        roundView.addSubview(arrowImage)
        
        roundView.onTap{
            self.router?.pushToRegistrationVC()
        }
        
        NSLayoutConstraint.activate([
            bottomImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomImageView.widthAnchor.constraint(equalToConstant: 242),
            bottomImageView.heightAnchor.constraint(equalToConstant: 124),
            bottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
            roundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            roundView.widthAnchor.constraint(equalToConstant: 86),
            roundView.heightAnchor.constraint(equalToConstant: 86),
            roundView.bottomAnchor.constraint(equalTo: bottomImageView.topAnchor, constant: -10),
            
            arrowImage.leadingAnchor.constraint(equalTo: roundView.leadingAnchor, constant: 10),
            arrowImage.trailingAnchor.constraint(equalTo: roundView.trailingAnchor, constant: -10),
            arrowImage.topAnchor.constraint(equalTo: roundView.topAnchor, constant: 20),
            arrowImage.bottomAnchor.constraint(equalTo: roundView.bottomAnchor, constant: -20)
        ])
    }
    
    //Add Date Picker
    private func showDatePicker(){
        let datepicker = DatePickerDialog(textColor: .black,
                                          buttonColor: Constants.Colors.appViolet,
                                          font: MainFont.normal.with(size: 15),
                                          locale: nil,
                                          showCancelButton: true)
        datepicker.show("Choose your Date of Birth".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized, defaultDate: chosenBirthdate, minimumDate: nil, maximumDate: nil, datePickerMode: .date) { (chosenDate) in
            //self.calendarImageView.resignFirstResponder()
            guard let cDate = chosenDate else {return}
            self.chosenBirthdate = cDate
             let components = NSCalendar.current.dateComponents([.day,.month,.year],from: cDate)
             if let day = components.day, let month = components.month, let year = components.year {
                 self.dayNumberLabel.text = "\(day)"
                 self.monthNumberLabel.text = "\(month)"
                 self.yearNumberLabel.text = "\(year)"
             }
        }
    }
}

//MARK:- NavBarAppearance
extension BirthdateViewController{
    private func setupNavBarAppearance(){
        
        statusBarStyle = .default
        navigationBarStyle = .transparent
        
        let loginBarButton = UIBarButtonItem(title: "Login".localized, style: .plain, target: self, action: #selector(loginBarButtonPressed))
        loginBarButton.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font : MainFont.medium.with(size: 22)
            ], for: .normal)
        self.navigationItem.rightBarButtonItem = loginBarButton
    }
    
    @objc func loginBarButtonPressed(){
        self.router?.redirectToLogin()
    }
}

//MARK:- Callbacks
extension BirthdateViewController{
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = { [weak self] in
            guard let self = self  else { return }
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            #warning("Retry Action does not set")
        }
    }
}


