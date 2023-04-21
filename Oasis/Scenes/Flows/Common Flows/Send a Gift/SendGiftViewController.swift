//
//  SendGiftViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol SendGiftViewControllerOutput {
    
}

class SendGiftViewController: BaseViewController {
    
    var interactor: SendGiftViewControllerOutput?
    var router: SendGiftRouter?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var submitButton : OasisAquaButton = {
        let btn = OasisAquaButton()
        btn.setTitle("Send Gift", for: .normal)
       // btn.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Note
    lazy var noteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.textviewBGColor
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var noteTextview: UITextView = {
        let txtVw = UITextView()
        txtVw.font = MainFont.normal.with(size: 15)
        txtVw.translatesAutoresizingMaskIntoConstraints = false
        txtVw.textColor = .black
        txtVw.textAlignment = .left
        txtVw.showsVerticalScrollIndicator = false
        txtVw.showsHorizontalScrollIndicator = false
        txtVw.tag = 0
        return txtVw
    }()
}

//MARK:- View Lifecycle
extension SendGiftViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SendGiftConfigurator.shared.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        setupNavBarAppearance()
        setupRetryFetchingCallBack()
        setupViews()
        setupLayout()
        setupNoteView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearance()
    }
    
    private func setupViews() {
        addSubmitButton()
        view.insertSubview(scrollView, belowSubview: submitButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: submitButton.topAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func addSubmitButton(){
        view.insertSubview(submitButton, at: 0)
        
        let tabbarHeight = self.tabBarController?.tabBar.frame.height
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -((tabbarHeight ?? 50) + 16)),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
}

//MARK:- NavBarAppearance
extension SendGiftViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        navigationItem.title = "Send a Gift".localized
    }
}

//MARK:- Callbacks
extension SendGiftViewController{
    
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

//MARK: - Account Number
extension SendGiftViewController{
    private
    func setupNoteView(){
        stackView.addArrangedSubview(noteView)
        noteView.addSubview(noteTextview)
        
        NSLayoutConstraint.activate([
            noteView.heightAnchor.constraint(equalToConstant: 124),
            
            noteTextview.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 8),
            noteTextview.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 18),
            noteTextview.centerYAnchor.constraint(equalTo: noteView.centerYAnchor),
            noteTextview.centerXAnchor.constraint(equalTo: noteView.centerXAnchor)
        ])
        //noteTextview.placeholder = "You can add a note to your gift, type here".localized
    }
}
