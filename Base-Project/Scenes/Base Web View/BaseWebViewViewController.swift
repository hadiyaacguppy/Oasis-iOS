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
        self.initWebView()
        output?.viewDidFinishedLoading()
    }
    
    
    func loadWebView(withURLRequest urlRequest : URLRequest){
        self.webView.load(urlRequest)
        //        self.webView.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.output?.webViewIsReady()
            .map {url in //self.initWebView() ;
                return url}
            .map { self.loadWebView(withURLRequest: $0)}
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    fileprivate
    func makebackgroundClear() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView!.isOpaque = false
        self.webView!.backgroundColor = UIColor.clear
        self.webView!.scrollView.backgroundColor = UIColor.clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.view.bounds
    }
    
    func initWebView(){
        var webViewFrame = CGRect()
        webViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.webView = WKWebView(frame: webViewFrame)
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(self.webView)
        self.view.bringSubviewToFront(self.webView)
        self.view.clipsToBounds = true
    }
    
    // MARK: Requests
    
    public
    func reloadWebViewWithURLString(string : String){
        
        self.output?.urlString = string
        self.output?.webViewIsReady()
            .map { self.loadWebView(withURLRequest: $0)}
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Utilities.ProgressHUD.dismissLoading()
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

