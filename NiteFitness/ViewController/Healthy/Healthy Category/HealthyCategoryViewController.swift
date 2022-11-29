//
//  
//  HealthyCategoryViewController.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit
import WebKit

// MARK: - ViewProtocol
protocol HealthyCategoryViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    //UITableView
    func onReloadData()
    func onLoadingSuccess()
    func onInsertRow(at index: Int)
}

// MARK: - HealthyCategory ViewController
class HealthyCategoryViewController: BaseViewController {
    var router: HealthyCategoryRouterProtocol!
    var viewModel: HealthyCategoryViewModelProtocol!
    
    @IBOutlet weak var coll_HealthyLiving: UICollectionView!
    private var refreshControl: UIRefreshControl?
    var webView: WKWebView!
    
    private var isLoading = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.setInitRefreshControl()
        self.setupCollectionView()
    }
    
    // MARK: - Action
    
}

// MARK: Refresh Control
extension HealthyCategoryViewController {
    func setInitRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Kéo xuống để tải mới", attributes: [NSAttributedString.Key.foregroundColor: R.color.mainColor() ?? UIColor.darkGray] )
        self.refreshControl?.tintColor = R.color.mainColor()
        self.refreshControl?.addTarget(self, action: #selector(self.onRefreshAction), for: .valueChanged)
        if let refresh = self.refreshControl {
            self.coll_HealthyLiving.addSubview(refresh)
        }
    }
    
    @objc func onRefreshAction() {
        self.refreshControl?.endRefreshing()
        self.viewModel.onRefreshAction()
        return
    }
}

// MARK: - HealthyCategory ViewProtocol
extension HealthyCategoryViewController: HealthyCategoryViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func onReloadData() {
        UIView.transition(with: self.coll_HealthyLiving, duration: 0.35, options: .transitionCrossDissolve, animations: {
            DispatchQueue.main.async {
                self.coll_HealthyLiving.reloadData()
            }
        })
    }
    
    func onLoadingSuccess() {
        self.isLoading = false
    }
    
    func onInsertRow(at index: Int) {
        self.coll_HealthyLiving.insertItems(at: [IndexPath.init(row: index, section: 0)])
    }
}

// MARK: - UICollectionViewDataSource
extension HealthyCategoryViewController: UICollectionViewDataSource {
    private func setupCollectionView() {
        self.coll_HealthyLiving.registerNib(ofType: CellCollHealthyCategory.self)
        
        switch self.viewModel.filterTypeValue {
        case .all:
            self.coll_HealthyLiving.registerHeaderNib(ofType: HeaderCollectionHealthyCategory.self, kind: UICollectionView.elementKindSectionHeader)
            
        default:
            self.coll_HealthyLiving.registerNib(ofType: CellCollHealthyCategoryHeader.self)
        }
        
        self.coll_HealthyLiving.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        self.coll_HealthyLiving.delegate = self
        self.coll_HealthyLiving.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch self.viewModel.filterTypeValue {
        case .all:
            if let header = collectionView.dequeueHeader(ofType: HeaderCollectionHealthyCategory.self, for: indexPath) as? HeaderCollectionHealthyCategory {
                header.model = self.viewModel.onGetListPopularPosts()
                return header
            }
            
            return UICollectionReusableView()
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch self.viewModel.filterTypeValue {
        case .all:
            return CGSize(width: collectionView.frame.width, height: 256)
            
        default:
            return CGSize(width: collectionView.frame.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        switch self.viewModel.filterTypeValue {
        case .all:
            cell = collectionView.dequeuCell(ofType: CellCollHealthyCategory.self, for: indexPath)
            if let cell = cell as? CellCollHealthyCategory {
                cell.model = self.viewModel.collectionView(collectionView, cellForItemAt: indexPath)
            }
            
        default:
            if indexPath.item == 0 {
                cell = collectionView.dequeuCell(ofType: CellCollHealthyCategoryHeader.self, for: indexPath)
                if let cell = cell as? CellCollHealthyCategoryHeader {
                    cell.filterType = self.viewModel.filterTypeValue
                    cell.model = self.viewModel.collectionView(collectionView, cellForItemAt: indexPath)
                }
                
            } else {
                cell = collectionView.dequeuCell(ofType: CellCollHealthyCategory.self, for: indexPath)
                if let cell = cell as? CellCollHealthyCategory {
                    cell.model = self.viewModel.collectionView(collectionView, cellForItemAt: indexPath)
                }
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HealthyCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let link = self.viewModel.collectionView(collectionView, cellForItemAt: indexPath).link {
            guard let url = URL(string: link) else {
                return
            }
            UIApplication.shared.open(url)
//            self.onOpenWebView(url: url)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.coll_HealthyLiving {
            let isReachingEnd = scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
            
            if isReachingEnd && self.isLoading == false {
                self.isLoading = true
                self.viewModel.onLoadMoreAction()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HealthyCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.viewModel.filterTypeValue {
        case .all:
            let imageHeight: CGFloat = 90
            let padding: CGFloat = 8
            return CGSize(width: collectionView.frame.width, height: imageHeight + padding * 2)
            
        default:
            if indexPath.item == 0 {
                return CGSize(width: collectionView.frame.width, height: 188)
            } else {
                let imageHeight: CGFloat = 90
                let padding: CGFloat = 8
                return CGSize(width: collectionView.frame.width, height: imageHeight + padding * 2)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - WKNavigationDelegate
extension HealthyCategoryViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideHud()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showHud()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideHud()
    }
}

extension HealthyCategoryViewController {
    //MARK: - OPEN MODAL WEBVIEW
    private func onOpenWebView(url: URL) {
        self.webView = WKWebView()
        self.webView.navigationDelegate = self
        self.view = self.webView
        self.webView.load(URLRequest(url: url))
        self.webView.allowsBackForwardNavigationGestures = true
    }
}
