//
//  
//  FavouriteVideoFitViewController.swift
//  1SK
//
//  Created by Thaad on 08/07/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol FavouriteVideoFitViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    func onReloadData()
}

// MARK: - FavouriteVideoFit ViewController
class FavouriteVideoFitViewController: BaseViewController {
    var router: FavouriteVideoFitRouterProtocol!
    var viewModel: FavouriteVideoFitViewModelProtocol!
    
    @IBOutlet weak var tbv_TableView: UITableView!
    @IBOutlet weak var view_NoData: UIView!
    
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
        self.title = "Video yêu thích"
        self.setInitUITableView()
    }
    
}

// MARK: - FavouriteVideoFit ViewProtocol
extension FavouriteVideoFitViewController: FavouriteVideoFitViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func onReloadData() {
        self.tbv_TableView.reloadData()
        
        if self.viewModel.listVideo.count == 0 {
            self.view_NoData.isHidden = false
            
        } else {
            self.view_NoData.isHidden = true
        }
    }
}

//MARK: - UITableViewDataSource
extension FavouriteVideoFitViewController: UITableViewDataSource {
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
        
        cell.delagate = self
        cell.indexPath = indexPath
        
        cell.view_Favorite.isHidden = false
        cell.model = self.viewModel.cellForRow(at: indexPath)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavouriteVideoFitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.showVideoFitDetailPlayerRouter(video: self.viewModel.listVideo[indexPath.row])
    }
}

//MARK: - CellTableViewHistoryVideoFitDelegate
extension FavouriteVideoFitViewController: CellTableViewVideoFitDelegate {
    func onFavoriteAction(indexPath: IndexPath?) {
        self.viewModel.onFavoriteAction(indexPath: indexPath)
    }
}
