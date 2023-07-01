//
//  TeensProfileViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift
import DGCharts
import SessionRepository

protocol TeensProfileViewControllerOutput {
    
}

class TeensProfileViewController: BaseViewController {
    
    var interactor: TeensProfileViewControllerOutput?
    var router: TeensProfileRouter?
    
    
    lazy var topTitleLabel : ControllerLargeTitleLabel = {
        let lbl = ControllerLargeTitleLabel()
        lbl.text = "My Profile".localized
        
        return lbl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoLayout()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.autoLayout()
        stackView.backgroundColor = .clear
        return stackView
    }()

    lazy var analyticsStaticLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.text = "My Spending".localized
        lbl.style = .init(font: MainFont.bold.with(size: 18),
                          color: .black)
        return lbl
    }()
    
    private lazy var analyticsContainerView : BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var myFriendsSectionView : BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var myFriendsStaticLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.autoLayout()
        lbl.text = "My Friends".localized
        lbl.style = .init(font: MainFont.bold.with(size: 18),
                          color: .black)
        return lbl
    }()
    
    lazy var searchFriendsButton : BaseButton = {
        let btn = BaseButton()
        btn.setImage(R.image.searchBlackIcon()!, for: .normal)
        btn.autoLayout()
        return btn
    }()
    
    private lazy var friendsRequestsNotificationView : BaseUIView = {
        let view = BaseUIView()
        view.autoLayout()
        view.backgroundColor = Constants.Colors.lightGrey
        view.roundCorners = .all(radius: 14)
        view.shadow = .active(with: .init(color: .gray,
                                          opacity: 0.3,
                                          radius: 6))
        return view
    }()
    
    private let peopleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoLayout()
        collectionView.register(UINib(resource: R.nib.peopleCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.onlyImagePeopleCollectionCell.identifier)
        return collectionView
    }()
    
    private lazy var barChart : BarChartView = {
        let chart = BarChartView()
        chart.autoLayout()
        chart.backgroundColor = .clear
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelFont = MainFont.normal.with(size: 12)
        chart.xAxis.labelTextColor = .black
        chart.xAxis.axisLineColor = .clear
        
        chart.drawGridBackgroundEnabled = false
        chart.legend.enabled = false
        
        
        return chart
    }()
    
    var chartValues : [BarChartDataEntry] = [BarChartDataEntry(x: 0.0, y: 10.0),
                                             BarChartDataEntry(x: 1.0, y: 9.0),
                                             BarChartDataEntry(x: 2.0, y: 10.0),
                                             BarChartDataEntry(x: 3.0, y: 70.0),
                                             BarChartDataEntry(x: 4.0, y: 10.0),
                                             BarChartDataEntry(x: 5.0, y: 50.0),
                                             BarChartDataEntry(x: 6.0, y: 90, data: "Sep")]
}

//MARK:- View Lifecycle
extension TeensProfileViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TeensProfileConfigurator.shared.configure(viewController: self)
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
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI(){
        addTitle()
        addScrollView()
        setupAnalyticsUI()
        setupMyFriendsUI()
    }
    
    private func addTitle(){
        view.addSubview(topTitleLabel)
        NSLayoutConstraint.activate([
            topTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            topTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
            topTitleLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func addScrollView (){
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    private func setupAnalyticsUI(){
        stackView.addArrangedSubview(analyticsStaticLabel)
        analyticsStaticLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        setupBarChartUI()
        
        func setupBarChartUI(){
            barChart.heightAnchor.constraint(equalToConstant: 200).isActive = true
            stackView.addArrangedSubview(barChart)

            setData()
        }
    }
    
    private func setData(){
        let set1 = BarChartDataSet(entries: chartValues)
        let data = BarChartData(dataSet: set1)
                
        set1.highlightColor = UIColor.init(hexFromString: "#FF97D6")
        set1.setColor(UIColor.init(hexFromString: "#EDDBE6"))
        
        data.barWidth = 0.6
        barChart.data = data
    }
    
    private func setupMyFriendsUI(){
        let friendsStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 30
            stackView.autoLayout()
            stackView.backgroundColor = .clear
            return stackView
        }()
        
        stackView.addArrangedSubview(myFriendsSectionView)
        myFriendsSectionView.addSubview(myFriendsStaticLabel)
        myFriendsSectionView.addSubview(searchFriendsButton)
        
        NSLayoutConstraint.activate([
            myFriendsStaticLabel.leadingAnchor.constraint(equalTo: myFriendsSectionView.leadingAnchor),
            myFriendsStaticLabel.centerYAnchor.constraint(equalTo: myFriendsSectionView.centerYAnchor),
            myFriendsStaticLabel.topAnchor.constraint(equalTo: myFriendsSectionView.topAnchor),
            
            searchFriendsButton.trailingAnchor.constraint(equalTo: myFriendsSectionView.trailingAnchor),
            searchFriendsButton.topAnchor.constraint(equalTo: myFriendsSectionView.topAnchor),
            searchFriendsButton.centerYAnchor.constraint(equalTo: myFriendsSectionView.centerYAnchor),
            searchFriendsButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        stackView.addArrangedSubview(friendsStackView)
        
        //Fill notification view
        let frndsRequestsLabel : BaseLabel = {
            let lbl = BaseLabel()
            lbl.autoLayout()
            lbl.text = "Unknown"//"You have 2 new friend \nrequests".localized
            lbl.style = .init(font: MainFont.bold.with(size: 14),
                              color: .black, numberOfLines: 2)
            return lbl
        }()
        
        let viewAllFrinedsButton : BaseButton = {
            let btn = BaseButton()
            btn.setTitle("View now", for: .normal)
            btn.style = .init(titleFont: MainFont.medium.with(size: 12), titleColor: .white, backgroundColor: Constants.Colors.appViolet)
            btn.roundCorners = .all(radius: 16)
            btn.autoLayout()
            return btn
        }()
        
        friendsRequestsNotificationView.addSubview(frndsRequestsLabel)
        friendsRequestsNotificationView.addSubview(viewAllFrinedsButton)
        
        NSLayoutConstraint.activate([
            viewAllFrinedsButton.trailingAnchor.constraint(equalTo: friendsRequestsNotificationView.trailingAnchor, constant: -15),
            viewAllFrinedsButton.centerYAnchor.constraint(equalTo: friendsRequestsNotificationView.centerYAnchor),
            viewAllFrinedsButton.heightAnchor.constraint(equalToConstant: 32),
            viewAllFrinedsButton.widthAnchor.constraint(equalToConstant: 105),
            
            frndsRequestsLabel.leadingAnchor.constraint(equalTo: friendsRequestsNotificationView.leadingAnchor, constant: 24),
            frndsRequestsLabel.centerYAnchor.constraint(equalTo: friendsRequestsNotificationView.centerYAnchor),
            frndsRequestsLabel.topAnchor.constraint(equalTo: friendsRequestsNotificationView.topAnchor, constant: 11)
        ])
        
        friendsStackView.addArrangedSubview(friendsRequestsNotificationView)
        friendsStackView.addArrangedSubview(peopleCollectionView)
        friendsRequestsNotificationView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        peopleCollectionView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
    }
    
    
}

//MARK:- NavBarAppearance
extension TeensProfileViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .default
        navigationBarStyle = .transparent
        
        let alertBarButton : UIBarButtonItem = UIBarButtonItem.init(image: R.image.iconNotifications()!.withRenderingMode(.alwaysOriginal),
                                                                    style: .plain,
                                                                    target: self, action: #selector(alertIconTapped))
        let settings : UIBarButtonItem = UIBarButtonItem.init(image: R.image.settingIcon()!.withRenderingMode(.alwaysOriginal),
                                                              style: .plain,
                                                              target: self, action: #selector(settingsIconTapped))
        
        navigationItem.rightBarButtonItems = [alertBarButton, settings]
    }
    
    @objc func settingsIconTapped(){

    }
    
    @objc func alertIconTapped(){
        
    }
}

//MARK:- Callbacks
extension TeensProfileViewController{
    
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
extension TeensProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.onlyImagePeopleCollectionCell, for: indexPath)!
        cell.setupCell()
        return cell
    }
    
    
}


extension TeensProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

extension TeensProfileViewController: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("")
    }
}

