//
//  
//  LoginViewModel.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - ViewModelProtocol
protocol LoginViewModelProtocol {
    func onViewDidLoad()
    
    //var variable: Int? { get set }
    //var listVariable: [Int] { get set }
}

// MARK: - Login ViewModel
class LoginViewModel {
    weak var view: LoginViewProtocol?
    private var interactor: LoginInteractorInputProtocol

    init(interactor: LoginInteractorInputProtocol) {
        self.interactor = interactor
    }

    //var variable: Int?
    //var listVariable: [Int] = []
}

// MARK: - Login ViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    func onViewDidLoad() {
        // Begin functions
    }
}

// MARK: - Login InteractorOutputProtocol
extension LoginViewModel: LoginInteractorOutputProtocol {
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
