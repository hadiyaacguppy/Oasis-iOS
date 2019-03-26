//
//  BaseWebViewViewController.swift
//  Base-Project
//
//  Created by Wassim on 10/24/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//

import UIKit
import RxSwift
import WebKit
protocol BaseWebViewViewControllerInput {

}

protocol BaseWebViewViewControllerOutput {
    
    func viewDidFinishedLoading()
    
    func retryLoadingRequested()
    
    func webViewIsReady() -> Single<URLRequest>
    var urlString : String {get set }
}

class BaseWebViewViewController: BaseViewController, BaseWebViewViewControllerInput {

    var output: BaseWebViewViewControllerOutput?
    var router: BaseWebViewRouter?
    var webView : WKWebView!

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        BaseWebViewConfigurator.shared.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //        showPlaceHolderView(withAppearanceType: .loading,
        //                            title: Constants.PlaceHolderView.Texts.wait)
        output?.viewDidFinishedLoading()
        setupRetryFetchingCallBack()
    }
    
    
    func loadWebView(withURLRequest urlRequest : URLRequest){
        self.webView.load(urlRequest)
    }
    
    fileprivate
    func makebackgroundClear() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView!.isOpaque = false
        self.webView!.backgroundColor = UIColor.clear
        self.webView!.scrollView.backgroundColor = UIColor.clear
    }
    
    func initWebView(){
        
        self.view.backgroundColor = UIColor.black
      self.webView = WKWebView()
        makebackgroundClear()
        
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        
        
        webView.navigationDelegate = self
        
        self.view.bringSubview(toFront: self.webView)
        
    }
    // MARK: Requests
    
    fileprivate
    func setupRetryFetchingCallBack(){
        self.didTapOnRetryPlaceHolderButton = {
            
            self.showPlaceHolderView(withAppearanceType: .loading,
                                     title: Constants.PlaceHolderView.Texts.wait)
            
            self.output?.retryLoadingRequested()
        }
    }


    // MARK: Display logic

}
extension BaseWebViewViewController: BaseWebViewPresenterOutput {
 
    
    
}

extension BaseWebViewViewController :WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Utilities.ProgressHUD.showLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)  {
        Utilities.ProgressHUD.dismissLoading()
       
    }
    
}
