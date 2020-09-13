//
//  WebViewController.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var webView: WKWebView!
    var repositoryData: UniversalRepositoryModel?
    
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height))
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    func showActivityIndicator(show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        webView.isHidden = show
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        guard let url = repositoryData?.url else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupNavigationBar() {
        var barColor: UIColor?
        switch repositoryData?.type {
        case .gitHub:
            barColor = UIColor.black
        case .bitBucket:
            barColor = UIColor.blue
        default:
            barColor = nil
        }
        
        navigationController?.navigationBar.barTintColor = barColor
        navigationController?.navigationBar.barStyle = .black
        
        self.navigationItem.title = repositoryData?.repoName
        
        let backButton = UIBarButtonItem(title: "✕", style: .plain, target: self, action: #selector(backButtonTapped))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
    }
    
    // MARK: Selectors
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
}
