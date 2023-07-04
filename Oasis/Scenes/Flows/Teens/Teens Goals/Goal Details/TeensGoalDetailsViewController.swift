//
//  TeensGoalDetailsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol TeensGoalDetailsViewControllerOutput {
    
}

class TeensGoalDetailsViewController: BaseViewController {
    
    var interactor: TeensGoalDetailsViewControllerOutput?
    var router: TeensGoalDetailsRouter?
    
    lazy var topTitleLabel :  BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.medium.with(size: 35), color: .white, numberOfLines: 2)
        lbl.autoLayout()
        lbl.text = "Buy a \nPlaystation".localized
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
    
    lazy var amountLabel :  BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        return lbl
    }()
    
    var savedValue : Double!
    var restValue : Double!
    

}

//MARK:- View Lifecycle
extension TeensGoalDetailsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TeensGoalDetailsConfigurator.shared.configure(viewController: self)
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
        view.backgroundColor = Constants.Colors.appViolet
        addScrollViewAndStackView()
        addTitle()
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
        
        topTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func addGoalInfo(title : String, value : Double, currency : String){
         let titleLabel :  BaseLabel = {
            let lbl = BaseLabel()
             lbl.text = title
            lbl.autoLayout()
            return lbl
        }()
        
        let firstString = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font : MainFont.bold.with(size: 26)])
        let secondString = NSMutableAttributedString(string: currency, attributes: [NSAttributedString.Key.font : MainFont.medium.with(size: 20)])
        firstString.append(secondString)
        
        let valueLabel :  BaseLabel = {
           let lbl = BaseLabel()
            lbl.attributedText = firstString
           lbl.autoLayout()
           return lbl
       }()
        
        NSLayoutConstraint.activate([
            
        
        ])
    }
    
    private func addDottedUnderline(){
        
    }
    
}

//MARK:- NavBarAppearance
extension TeensGoalDetailsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
    }
}

//MARK:- Callbacks
extension TeensGoalDetailsViewController{
    
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


