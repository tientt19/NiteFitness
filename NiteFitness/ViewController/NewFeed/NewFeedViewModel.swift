//
//  
//  NewFeedViewModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol NewFeedViewModelProtocol {
    func onViewDidLoad()
    
    //var variable: Int? { get set }
    //var listVariable: [Int] { get set }
}

// MARK: - NewFeed ViewModel
class NewFeedViewModel {
    weak var view: NewFeedViewProtocol?
    private var interactor: NewFeedInteractorInputProtocol

    init(interactor: NewFeedInteractorInputProtocol) {
        self.interactor = interactor
    }

    //var variable: Int?
    //var listVariable: [Int] = []
}

// MARK: - NewFeed ViewModelProtocol
extension NewFeedViewModel: NewFeedViewModelProtocol {
    func onViewDidLoad() {
        // Begin functions
    }
}

// MARK: - NewFeed InteractorOutputProtocol
extension NewFeedViewModel: NewFeedInteractorOutputProtocol {
    func onGet_DataNameFunction_Finished(with result: Result<EmptyModel, APIError>) {
        switch result {
        case .success(let model):
            // Handle Data
            break
            
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func onSet_DataNameFunction_Finished(with result: Result<EmptyModel, APIError>) {
        switch result {
        case .success(let model):
                // Handle Data
            break
            
        case .failure(let error):
            debugPrint(error)
        }
    }
}
