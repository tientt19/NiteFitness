//
//  
//  HistoryVideosFitViewController.swift
//  1SK
//
//  Created by Valerian on 24/06/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol HistoryVideosFitViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    func onReloadData()
    func onLoadingSuccess()
    func onInsertRow(at index: Int)
}

// MARK: - HistoryVideosFit ViewController
class HistoryVideosFitViewController: BaseViewController {
    var router: HistoryVideosFitRouterProtocol!
    var viewModel: HistoryVideosFitViewModelProtocol!
    
    @IBOutlet weak var tbv_TableView: UITableView!
    @IBOutlet weak var stack_NoData: UIStackView!
    
    private var refreshControl: UIRefreshControl?
    private var isLoading = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.onViewWillAppear()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.title = "Video đã tập"
        
        self.setInitUITableView()
        self.setInitRefreshControl()
    }
}

// MARK: - HistoryVideosFit ViewProtocol
extension HistoryVideosFitViewController: HistoryVideosFitViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func onReloadData() {
        self.tbv_TableView.reloadData()
        
        if self.viewModel.listVideo.count == 0 {
            self.stack_NoData.isHidden = false
        } else {
            self.stack_NoData.isHidden = true
        }
    }
    
    func onLoadingSuccess() {
        self.isLoading = false
    }
    
    func onInsertRow(at index: Int) {
        self.tbv_TableView.beginUpdates()
        self.tbv_TableView.insertRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
        self.tbv_TableView.endUpdates()
    }
}

// MARK: Refresh Control
extension HistoryVideosFitViewController {
    func setInitRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Kéo xuống để tải mới", attributes: [NSAttributedString.Key.foregroundColor: R.color.mainColor() ?? UIColor.darkGray] )
        self.refreshControl?.tintColor = R.color.mainColor()
        self.refreshControl?.addTarget(self, action: #selector(self.onRefreshAction), for: .valueChanged)
        if let refresh = self.refreshControl {
            self.tbv_TableView.addSubview(refresh)
        }
    }
    
    @objc func onRefreshAction() {
        self.refreshControl?.endRefreshing()
        self.viewModel.onRefreshAction()
        return
    }
}

//MARK: - UITableViewDataSource
extension HistoryVideosFitViewController: UITableViewDataSource {
    func setInitUITableView() {
        self.tbv_TableView.registerNib(ofType: CellTableViewVideoFit.self)
        self.tbv_TableView.delegate = self
        self.tbv_TableView.dataSource = self
        self.tbv_TableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: CellTableViewVideoFit.self, for: indexPath)
        cell.view_Favorite.isHidden = true
        cell.model = self.viewModel.cellForRow(at: indexPath)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HistoryVideosFitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.showVideoFitDetailPlayerRouter(video: self.viewModel.listVideo[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        
        if isReachingEnd && self.isLoading == false {
            self.isLoading = true
            self.viewModel.onLoadMoreAction()
        }
    }
}
