//
//  
//  HealthyDetailViewController.swift
//  1SK
//
//  Created by TrungDN on 22/09/2022.
//
//

import UIKit
import WebKit

// MARK: - ViewProtocol
protocol HealthyDetailViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    //UITableView
    //func onReloadData()
    func reloadData(with model: PostHealthModel?)
}

// MARK: - HealthyDetail ViewController
class HealthyDetailViewController: BaseViewController {
    var router: HealthyDetailRouterProtocol!
    var viewModel: HealthyDetailViewModelProtocol!
    
    @IBOutlet weak var view_Content: UIView!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_PostTitle: UILabel!
    @IBOutlet weak var img_Thumbnail: UIImageView!
    @IBOutlet weak var lbl_Date: UILabel!
    
    @IBOutlet weak var wedViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentWebView: WKWebView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.title = "Chi tiết bài viết"
        self.view_Content.alpha = 0
        self.setInitWKWebView()
    }
    
    // MARK: - Action
    
}

// MARK: - HealthyDetail ViewProtocol
extension HealthyDetailViewController: HealthyDetailViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func reloadData(with model: PostHealthModel?) {
        guard let model = model else { return }
        let date = model.date?.toDate(.ymdThms)
        self.img_Thumbnail.setImage(with: model.yoastHeadJson?.ogImage?.first?.url ?? "", completion: nil)
        self.lbl_PostTitle.text = model.yoastHeadJson?.title ?? ""
        self.lbl_Date.text = date?.toString(.dmySlash)
        if let categories = model.categories {
            for category in categories {
                for filterType in HealthyLivingFilterType.getMenuItems() {
                    if category == filterType.typeId {
                        self.lbl_Category.text = filterType.description
                        break
                    }
                }
            }
        }
        
        self.contentWebView.loadHTMLString(model.content?.rendered?.asHtmlStoreProductInfo ?? "", baseURL: nil)
        UIView.transition(with: self.view, duration: 0.35, options: .transitionCrossDissolve, animations: { self.view_Content.alpha = 1 })
    }
}

// MARK: - WKNavigationDelegate
extension HealthyDetailViewController: WKNavigationDelegate {
    func setInitWKWebView() {
        self.contentWebView.navigationDelegate = self
        self.contentWebView.scrollView.isScrollEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.contentWebView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.contentWebView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    if let `height` = height as? CGFloat {
                        print("web_WebView didFinish height: ", `height`)
                        self.wedViewHeightConstraint.constant = height
                        self.view.layoutIfNeeded()
                    }
                })
            }
        })
    }
}
