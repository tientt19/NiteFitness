//
//  
//  NewFeedViewController.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol NewFeedViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    //UITableView
    //func onReloadData()
}

// MARK: - NewFeed ViewController
class NewFeedViewController: BaseViewController {
    var router: NewFeedRouterProtocol!
    var viewModel: NewFeedViewModelProtocol!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {

    }
    
    // MARK: - Action
    
}

// MARK: - NewFeed ViewProtocol
extension NewFeedViewController: NewFeedViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
}
