//
//  
//  SplashScreenViewModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol SplashScreenViewModelProtocol {
    func onViewDidLoad()
    
    //var variable: Int? { get set }
    //var listVariable: [Int] { get set }
}

// MARK: - SplashScreen ViewModel
class SplashScreenViewModel {
    weak var view: SplashScreenViewProtocol?
    private var interactor: SplashScreenInteractorInputProtocol

    init(interactor: SplashScreenInteractorInputProtocol) {
        self.interactor = interactor
    }

    //var variable: Int?
    //var listVariable: [Int] = []
}

// MARK: - SplashScreen ViewModelProtocol
extension SplashScreenViewModel: SplashScreenViewModelProtocol {
    func onViewDidLoad() {
 
    }
}

// MARK: - SplashScreen InteractorOutputProtocol
extension SplashScreenViewModel: SplashScreenInteractorOutputProtocol {
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
