//
//  HealthDetailWebView.swift
//  NiteFitness
//
//  Created by Trần Tấn Tiến on 11/30/22.
//

import UIKit
import WebKit

class HealthDetailWebView: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    var didLoadWebView: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadWebView(url: URL, completion: @escaping () -> Void) {
        loadViewIfNeeded()
        self.didLoadWebView = completion
        self.webView.navigationDelegate = self
        self.webView.load(URLRequest(url: url))
    }
}

extension HealthDetailWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.didLoadWebView() // Call back to the presenting view controller
    }
}
