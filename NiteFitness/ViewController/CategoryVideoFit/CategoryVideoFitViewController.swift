//
//  
//  ListVideoExerciseViewController.swift
//  1SK
//
//  Created by Valerian on 23/06/2022.
//
//

import UIKit

enum CategoryExercises: Int {
    case Title
    case Yoga
    case Gym
    case BodyRhythm
    case BodyFight
    case BalanceFit
    case Erobics
    case Pilates
    case Zumba
    
    var toString: String {
        switch self {
        case .Title:
            return "Video bài tập"
        case .Yoga:
            return "Yoga"
        case .Gym:
            return "Gym"
        case .BodyRhythm:
            return "Body\nThythm"
        case .BodyFight:
            return "Body Fight"
        case .BalanceFit:
            return "Balance Fit"
        case .Erobics:
            return "Erobics"
        case .Pilates:
            return "Pilates"
        case .Zumba:
            return "Zumba"
        }
    }
}

// MARK: - ViewProtocol
protocol CategoryVideoFitViewProtocol: AnyObject {
    func showHud()
    func hideHud()
    
    func onReloadDataCategory()
    func onReloadVideoFit()
}

// MARK: - CategoryVideoFit ViewController
class CategoryVideoFitViewController: BaseViewController {
    var router: CategoryVideoFitRouterProtocol!
    var viewModel: CategoryVideoFitViewModelProtocol!
    
    @IBOutlet weak var tbv_CategoryFit: UITableView!
    @IBOutlet weak var tbv_VideoFit: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.viewModel.onViewDidLoad()
    }
    
    // MARK: - Init
    private func setupInit() {
        self.title = CategoryExercises.Title.toString
        
        self.setInitUIBarButtonItem()
        self.setInitUITableView()
    }
}

// MARK: - ListVideoExercise ViewProtocol
extension CategoryVideoFitViewController: CategoryVideoFitViewProtocol {
    func showHud() {
        self.showProgressHud()
    }
    
    func hideHud() {
        self.hideProgressHud()
    }
    
    func onReloadDataCategory() {
        self.tbv_CategoryFit.reloadData()
    }
    
    func onReloadVideoFit() {
        self.tbv_VideoFit.reloadData()
        if self.viewModel.listVideo.count > 0 {
            self.tbv_VideoFit.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

// MARK: - UIBarButtonItem
extension CategoryVideoFitViewController {
    func setInitUIBarButtonItem() {
        let btn_History = UIBarButtonItem(image: R.image.ic_history_gray(), style: .plain, target: self, action: #selector(self.onHistoryAction))
        btn_History.tintColor = R.color.subTitle()
        let btn_Favourite = UIBarButtonItem(image: R.image.ic_favorite_gray(), style: .plain, target: self, action: #selector(self.onFavouriteAction))
        btn_Favourite.tintColor = R.color.subTitle()
        self.navigationItem.setRightBarButtonItems([btn_Favourite, btn_History], animated: true)
    }
    
    @objc func onHistoryAction(sender: AnyObject) {
        self.router.showHistoryVideosFitRouter()
    }
    
    @objc func onFavouriteAction(sender: AnyObject) {
        self.router.showFavouriteVideoFitRouter()
    }
}

// MARK: - UITableViewDataSource
extension CategoryVideoFitViewController: UITableViewDataSource {
    func setInitUITableView() {
        self.tbv_CategoryFit.registerNib(ofType: CellTableViewCategory.self)
        self.tbv_VideoFit.registerNib(ofType: CellTableViewCategoryVideoFit.self)
        
        self.tbv_CategoryFit.delegate = self
        self.tbv_CategoryFit.dataSource = self
        self.tbv_CategoryFit.separatorStyle = .none
        
        self.tbv_VideoFit.delegate = self
        self.tbv_VideoFit.dataSource = self
        self.tbv_VideoFit.separatorStyle = .none
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tbv_CategoryFit.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tbv_CategoryFit:
            return self.viewModel.numberOfListCategoryVideoExercise()
            
        case self.tbv_VideoFit:
            return self.viewModel.numberOfListVideoExercise()
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tbv_CategoryFit:
            let cell = tableView.dequeueCell(ofType: CellTableViewCategory.self, for: indexPath)
            cell.model = self.viewModel.listCategoryExerciseCellForRow(at: indexPath)
            return cell
            
        case self.tbv_VideoFit:
            let cell = tableView.dequeueCell(ofType: CellTableViewCategoryVideoFit.self, for: indexPath)
            cell.model = self.viewModel.listVideoExerciseCellForRow(at: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.tbv_CategoryFit:
            return self.tbv_CategoryFit.frame.width
            
        case self.tbv_VideoFit:
            return 168
            
        default:
            return 0
        }
    }
}

// MARK: - UITableViewDelegate
extension CategoryVideoFitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.tbv_CategoryFit:
            self.viewModel.didSelectCategoryExerciseRow(at: indexPath)
            
        case self.tbv_VideoFit:
            self.router.showVideoFitDetailPlayerRouter(video: self.viewModel.listVideo[indexPath.row])
            
        default:
            break
        }
    }

}
