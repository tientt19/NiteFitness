//
//  
//  HomeHealthyInteractorInput.swift
//  1SK
//
//  Created by TrungDN on 16/09/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol HomeHealthyInteractorInputProtocol {
    
}

// MARK: - Interactor Output Protocol
protocol HomeHealthyInteractorOutputProtocol: AnyObject {
    
}

// MARK: - HomeHealthy InteractorInput
class HomeHealthyInteractorInput {
    weak var output: HomeHealthyInteractorOutputProtocol?
}

// MARK: - HomeHealthy InteractorInputProtocol
extension HomeHealthyInteractorInput: HomeHealthyInteractorInputProtocol {
    
}
