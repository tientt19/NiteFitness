//
//  
//  NewFeedInteractorInput.swift
//  NiteFitness
//
//  Created by Tiến Trần on 31/10/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol NewFeedInteractorInputProtocol {
    func get_DataNameFunction(param1: String, param2: Int)
    func set_DataNameFunction(param1: String, param2: Int)
}

// MARK: - Interactor Output Protocol
protocol NewFeedInteractorOutputProtocol: AnyObject {
    func onGet_DataNameFunction_Finished(with result: Result<EmptyModel, APIError>)
    func onSet_DataNameFunction_Finished(with result: Result<EmptyModel, APIError>)
}

// MARK: - NewFeed InteractorInput
class NewFeedInteractorInput {
    weak var output: NewFeedInteractorOutputProtocol?
}

// MARK: - NewFeed InteractorInputProtocol
extension NewFeedInteractorInput: NewFeedInteractorInputProtocol {
    func get_DataNameFunction(param1: String, param2: Int) {
        // Connect API
        // Data output
    }
    
    func set_DataNameFunction(param1: String, param2: Int) {
        // Connect API
        // Data output
    }
}
