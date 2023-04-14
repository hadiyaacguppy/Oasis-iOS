//
//  InterestsViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift

protocol InterestsViewControllerOutput {
    
}

class InterestsViewController: BaseViewController {
    
    var interactor: InterestsViewControllerOutput?
    var router: InterestsRouter?
    
    private lazy var topStaticLabel : BaseLabel = {
        let label = BaseLabel()
        label.style = .init(font: MainFont.medium.with(size: 33), color: .white, numberOfLines: 2)
        label.text = "What are you \ninterested in?".localized
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
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let pLayout = UICollectionViewLayout()
        return pLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(UINib(resource: R.nib.interestsCollectionViewCell),
                                forCellWithReuseIdentifier: R.reuseIdentifier.interestsCell.identifier)
        collectionView.contentInset = UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 5
        )
        return collectionView
    }()
    
    var testImages: [UIImage] = [R.image.rectangleCopy2()!,
                                 R.image.rectangleCopy3()!,
                                 R.image.rectangleCopy4()!,
                                 R.image.rectangleCopy5()!,
                                 R.image.rectangleCopy6()!,
                                 R.image.rectangleCopy()!]
    var testTitles: [String] = ["Dance", "Sports", "Fashion", "Fitness", "Family", "Nightlife"]

}

//MARK:- View Lifecycle
extension InterestsViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        InterestsConfigurator.shared.configure(viewController: self)
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
        addTopStaticLabel()
        setupLayout()
        addCollectionView()
    }
    
    
    private func addTopStaticLabel(){
        view.addSubview(topStaticLabel)
        NSLayoutConstraint.activate([
            topStaticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            topStaticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStaticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topStaticLabel.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func addCollectionView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            collectionView.topAnchor.constraint(equalTo: topStaticLabel.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        collectionView.reloadData()
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
}

extension InterestsViewController{
    private func setupLayout() {
        let layout: PinterestLayout = {
            if let layout = self.collectionViewLayout as? PinterestLayout {
                return layout
            }
            let layout = PinterestLayout()
            
            collectionView.collectionViewLayout = layout
            
            return layout
        }()
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
    }
}

//MARK:- NavBarAppearance
extension InterestsViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .transparent
        

        let nextBarButtonItem = UIBarButtonItem(title: "Next".localized, style: .plain, target: self, action: #selector(nextBarButtonPressed))
        self.navigationItem.rightBarButtonItem = nextBarButtonItem
    }
    
    @objc func nextBarButtonPressed(){
        
    }
}

//MARK:- Callbacks
extension InterestsViewController{
    
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


//MARK: UICollectionViewDataSource

extension InterestsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: R.reuseIdentifier.interestsCell.identifier, for: indexPath) as! InterestsCollectionViewCell
        
        let image = testImages[indexPath.item]
        let text = testTitles[indexPath.item]
        cell.imageView.image = image
        cell.descriptionLabel.text = text
        return cell
    }
}


//MARK: PinterestLayoutDelegate

extension InterestsViewController: PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        let image = testImages[indexPath.item]
        
        return image.height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        return 0
    }
}

