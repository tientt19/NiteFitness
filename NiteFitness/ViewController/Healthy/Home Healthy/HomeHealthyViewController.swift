//
//  
//  HomeHealthyViewController.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - ViewProtocol
protocol HomeHealthyViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    func updateView(with filterType: HealthyLivingFilterType)
}

// MARK: - HomeHealthy ViewController
class HomeHealthyViewController: BaseViewController {
    var router: HomeHealthyRouterProtocol!
    var viewModel: HomeHealthyViewModelProtocol!
    
    // MARK: - UI Components
    @IBOutlet weak var coll_Filter: UICollectionView!
    @IBOutlet weak var view_Container: UIView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.setUpCollectionView()
    }
    
    // MARK: - Action
    @IBAction func historyVideos(_ sender: UIButton) {
//        guard Configure.shared.isLogged() == true else {
//        self.presentLoginRouter()
//        return
//    }
//        let controller = HistoryVideosFitRouter.setupModule()
//        self.navigationController?.show(controller, sender: nil)
    }
    
    @IBAction func favoriteVideo(_ sender: UIButton) {
//        guard Configure.shared.isLogged() == true else {
//            self.presentLoginRouter()
//            return
//        }
//        let controller = FavouriteVideoFitRouter.setupModule()
//        self.navigationController?.show(controller, sender: nil)
    }
}

// MARK: - HomeHealthy ViewProtocol
extension HomeHealthyViewController: HomeHealthyViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func updateView(with filterType: HealthyLivingFilterType) {
        self.removeChildVC()
        
        var childView: UIViewController = UIViewController()
        switch filterType {
        case .all:
            childView = HealthyCategoryRouter.setupModule(with: filterType)
            
//        case .exercise:
//            childView = CategoryVideoFitRouter.setupModule()
            
        case .nutrition:
            childView = HealthyCategoryRouter.setupModule(with: filterType)
            
        case .mentalhealth:
            childView = HealthyCategoryRouter.setupModule(with: filterType)
            
        case .technology:
            childView = HealthyCategoryRouter.setupModule(with: filterType)
        }
        
        childView.view.alpha = 0
        self.addChildViewController(childVC: childView)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .transitionFlipFromLeft, animations: {
            childView.view.alpha = 1
        })
    }
}

// MARK: - Helpers
extension HomeHealthyViewController {
    private func addChildViewController(childVC: UIViewController) {
        self.addChild(childVC)
        self.view_Container.addSubview(childVC.view)
        childVC.view.fillSuperView()
        childVC.didMove(toParent: self)
    }
    
    private func removeChildVC() {
        self.view_Container.subviews.forEach { $0.removeFromSuperview() }
        self.children.forEach { $0.removeFromParent() }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeHealthyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeHealthyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = 32
        let padding: CGFloat = 10
        return CGSize(width: HealthyLivingFilterType.getMenuItems()[indexPath.item].description.width(withConstrainedHeight: padding * 2, font: R.font.robotoMedium(size: 14)!) + padding * 2, height: cellHeight)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeHealthyViewController: UICollectionViewDataSource {
    private func setUpCollectionView() {
        self.coll_Filter.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.coll_Filter.registerNib(ofType: CellCollectionHealthyFilter.self)
        self.coll_Filter.delegate = self
        self.coll_Filter.dataSource = self
        self.coll_Filter.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeuCell(ofType: CellCollectionHealthyFilter.self, for: indexPath)
        cell.title = viewModel.collectionView(collectionView, cellForItemAt: indexPath)
        return cell
    }
}

// MARK: - LoginViewDelegate
//extension HomeHealthyViewController: LoginViewDelegate {
//    func presentLoginRouter() {
//        let controller = LoginRouter.setupModule(delegate: self)
//        controller.modalPresentationStyle = .custom
//        self.present(controller, animated: true)
//    }
//
//    func onLoginSuccess() {
//        SKToast.shared.showToast(content: "Đăng nhập thành công")
//    }
//}
