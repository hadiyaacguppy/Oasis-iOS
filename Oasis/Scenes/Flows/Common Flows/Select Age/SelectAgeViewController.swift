//
//  SelectAgeViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol SelectAgeViewControllerOutput {
    
}

class SelectAgeViewController: BaseViewController {
    
    var interactor: SelectAgeViewControllerOutput?
    var router: SelectAgeRouter?
    
    private lazy var topStaticLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 33), color: .white, numberOfLines: 2)
        label.text = "How old are\nyou".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var yearsOldStaticLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.bold.with(size: 22), color: .white)
        label.text = "years old".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.image = R.image.newBackground()!
        imageV.contentMode = .scaleAspectFill
        return imageV
    }()
    
    private lazy var nextButton : BaseButton = {
        let btn = BaseButton()
        if #available(iOS 15.0, *) {
            btn.imageStyle  = .init(image: R.image.iconArrow()!, imagePadding: 2.0, imagePlacement: .trailing)
        } else {
            btn.setImage(R.image.iconArrow()!, for: .normal)
            btn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            btn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            btn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        btn.style = .init(titleFont: MainFont.bold.with(size: 20),
                          titleColor: .white,
                          backgroundColor: .clear)
        btn.setTitle("Next".localized, for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.onTap {
            self.router?.pushToRegistration()
        }
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.disablingAutoresizing()
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView() // Removes empty cell separators
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        //tableView.isPagingEnabled = true
        tableView.register(UINib(resource: R.nib.ageTableViewCell),
                           forCellReuseIdentifier: R.reuseIdentifier.ageCell.identifier)
        return tableView
    }()
    
    private lazy var fixedSelection : BaseUIView = {
        let view = BaseUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners = .all(radius: 8)
        view.backgroundColor = UIColor(red: 25/255, green: 22/255, blue: 31/255, alpha: 0.47)
        return view
    }()
    
    var datasource = Array(7...70).map{ "\($0)" }
    var firstVisibleIndexPath: IndexPath = IndexPath(row: 0, section: 0){
        didSet{
            tableView.reloadData()
            tableView.scrollToRow(at: firstVisibleIndexPath, at: .top, animated: true)
        }
    }
}

//MARK:- View Lifecycle
extension SelectAgeViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SelectAgeConfigurator.shared.configure(viewController: self)
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
    
    fileprivate
    func setupUI(){
        addBackgroundImage()
        addNextButton()
        addTopStaticLabel()
        addFixedSelection()
        addTableview()
        addYearsOldLabel()
    }
    
    private func addTopStaticLabel(){
        view.addSubview(topStaticLabel)
        NSLayoutConstraint.activate([
            topStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            topStaticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStaticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStaticLabel.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func addBackgroundImage(){
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func addNextButton(){
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 35),
            nextButton.widthAnchor.constraint(equalToConstant: 90),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    private func addTableview(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topStaticLabel.bottomAnchor, constant: 37),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.widthAnchor.constraint(equalToConstant: 120)
        ])
        tableView.reloadData()
    }
    
    private func addFixedSelection(){
        view.addSubview(fixedSelection)
        NSLayoutConstraint.activate([
            fixedSelection.topAnchor.constraint(equalTo: topStaticLabel.bottomAnchor, constant: 37),
            fixedSelection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            fixedSelection.widthAnchor.constraint(equalToConstant: 120),
            fixedSelection.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    private func addYearsOldLabel(){
        view.addSubview(yearsOldStaticLabel)
        NSLayoutConstraint.activate([
            yearsOldStaticLabel.leadingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 31),
            yearsOldStaticLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 36)
        ])
    }
}

//MARK:- NavBarAppearance
extension SelectAgeViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
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
extension SelectAgeViewController{
    
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


//MARK: - TableViewDataSource
extension SelectAgeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
    -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.ageCell.identifier, for: indexPath) as! AgeTableViewCell

        let newFontSize = 65 - (indexPath.row * 7)
        cell.setupCell(ageNumber: datasource[indexPath.row], fontSize: newFontSize > 25 ? CGFloat(newFontSize) : 25, isAgeSelected: indexPath == firstVisibleIndexPath)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        firstVisibleIndexPath = self.tableView.indexPathsForVisibleRows?[0] ?? IndexPath(row: 0, section: 0)
        print("First visible cell section=\(firstVisibleIndexPath.section), and row=\(firstVisibleIndexPath.row)")
    }
}

extension SelectAgeViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstVisibleIndexPath = indexPath
    }
}

