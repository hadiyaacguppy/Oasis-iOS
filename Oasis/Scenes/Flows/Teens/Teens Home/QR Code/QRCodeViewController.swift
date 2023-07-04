//
//  QRCodeViewController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit
import RxSwift
import SessionRepository

protocol QRCodeViewControllerOutput {
    
}

class QRCodeViewController: BaseViewController {
    
    var interactor: QRCodeViewControllerOutput?
    var router: QRCodeRouter?
    
    lazy var titleLabel : BaseLabel = {
        let lbl = BaseLabel()
        lbl.style = .init(font: MainFont.bold.with(size: 28), color: .white, alignment: .left, numberOfLines: 4)
        lbl.text = "Please scan the\n QR code on \nyour parent\n screen".localized
        lbl.autoLayout()
        return lbl
    }()
    
    lazy var qrCodeImageview : BaseImageView = {
        let img = BaseImageView(frame: .zero)
        img.contentMode = .scaleAspectFit
        img.autoLayout()
        return img
    }()
}

//MARK:- View Lifecycle
extension QRCodeViewController{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        QRCodeConfigurator.shared.configure(viewController: self)
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
    
    fileprivate func setupUI(){
        view.addSubview(titleLabel)
        view.addSubview(qrCodeImageview)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            qrCodeImageview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrCodeImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrCodeImageview.widthAnchor.constraint(equalToConstant: 222),
            qrCodeImageview.heightAnchor.constraint(equalToConstant: 222)
        ])
        
        qrCodeImageview.image = generateQRCode(from: "email")?.convert()
    }
    
    fileprivate
    func generateQRCode(from string: String) -> CIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let qrData = string.data(using: String.Encoding.ascii)
        qrFilter.setValue(qrData, forKey: "inputMessage")

        let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
        let qrImage = qrFilter.outputImage?.transformed(by: qrTransform)
        return qrImage?.tinted(using: .white)
    }
    
}

//MARK:- NavBarAppearance
extension QRCodeViewController{
    private func setupNavBarAppearance(){
        statusBarStyle = .lightContent
        navigationBarStyle = .hidden
        addDismissButton()
    }
}

//MARK:- Callbacks
extension QRCodeViewController{
    
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


