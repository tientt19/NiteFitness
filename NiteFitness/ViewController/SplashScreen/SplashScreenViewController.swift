//
//  
//  SplashScreenViewController.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol SplashScreenViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    //UITableView
    //func onReloadData()
}

// MARK: - SplashScreen ViewController
class SplashScreenViewController: BaseViewController {
    var router: SplashScreenRouterProtocol!
    var viewModel: SplashScreenViewModelProtocol!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.router.goToMainTabbar()
        }
    }
    
    // MARK: - Action
    
}

// MARK: - SplashScreen ViewProtocol
extension SplashScreenViewController: SplashScreenViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
}
