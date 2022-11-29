//
//  
//  HistoryVideosFitViewModel.swift
//  1SK
//
//  Created by Valerian on 24/06/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol HistoryVideosFitViewModelProtocol {
    func onViewDidLoad()
    func onViewWillAppear()
    
    // UITableView
    func numberOfRows() -> Int
    func cellForRow(at indexPath: IndexPath) -> VideoModel?
    func didSelectRow(at indexPath: IndexPath)
    func onRefreshAction()
    func onLoadMoreAction()
    
    var listVideo: [VideoModel] { get set }
}

// MARK: - HistoryVideosFit ViewModel
class HistoryVideosFitViewModel {
    weak var view: HistoryVideosFitViewProtocol?
    private var interactor: HistoryVideosFitInteractorInputProtocol

    init(interactor: HistoryVideosFitInteractorInputProtocol) {
        self.interactor = interactor
    }

    var listVideo: [VideoModel] = []
    
    // Loadmore
    private var total = 0
    private var page = 1
    private let perPage = 10
    private var isOutOfData = false
    
    func getData(page: Int) {
        if page == 1 {
            self.isOutOfData = false
        }
        
        self.view?.showHud()
        self.interactor.getVideoHistory(page: page, perPage: self.perPage)
    }
    
}

// MARK: - HistoryVideosFit ViewModelProtocol
extension HistoryVideosFitViewModel: HistoryVideosFitViewModelProtocol {
    func onViewDidLoad() {
        //
    }
    
    func onViewWillAppear() {
        self.getData(page: 1)
    }
    
    // TableView
    func numberOfRows() -> Int {
        return self.listVideo.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> VideoModel? {
        return self.listVideo[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        //
    }
    
    func onRefreshAction() {
        self.getData(page: 1)
    }
    
    func onLoadMoreAction() {
        if self.listVideo.count >= self.perPage && self.isOutOfData == false {
            self.getData(page: self.page + 1)
            
        } else {
            if self.perPage > 10 {
                SKToast.shared.showToast(content: "Đã tải hết dữ liệu")
            }
            self.view?.onLoadingSuccess()
        }
    }
}

// MARK: - HistoryVideosFit InteractorOutputProtocol
extension HistoryVideosFitViewModel: HistoryVideosFitInteractorOutputProtocol {
    func onGetVideoHistoryFinished(with result: Result<[VideoModel], APIError>, page: Int, total: Int) {
        switch result {
        case .success(let listModel):
            if page <= 1 {
                self.listVideo = listModel
                self.view?.onReloadData()
                
            } else {
                for object in listModel {
                    self.listVideo.append(object)
                    self.view?.onInsertRow(at: self.listVideo.count - 1)
                }
            }
            
            self.total = total
            self.page = page
            
            // Set Out Of Data
            if self.listVideo.count >= self.total {
                self.isOutOfData = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.view?.onLoadingSuccess()
            }
            
        case .failure(let error):
            debugPrint(error)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.view?.onLoadingSuccess()
            }
        }
        self.view?.hideHud()
    }
}
