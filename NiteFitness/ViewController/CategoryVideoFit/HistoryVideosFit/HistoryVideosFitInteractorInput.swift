//
//  
//  HistoryVideosFitInteractorInput.swift
//  1SK
//
//  Created by Valerian on 24/06/2022.
//
//

import UIKit

// MARK: - Interactor Input Protocol
protocol HistoryVideosFitInteractorInputProtocol {
    func getVideoHistory(page: Int, perPage: Int)
}

// MARK: - Interactor Output Protocol
protocol HistoryVideosFitInteractorOutputProtocol: AnyObject {
    func onGetVideoHistoryFinished(with result: Result<[VideoModel], APIError>, page: Int, total: Int)
}

// MARK: - HistoryVideosFit InteractorInput
class HistoryVideosFitInteractorInput {
    weak var output: HistoryVideosFitInteractorOutputProtocol?
    var fitVideoSevice: FitVideoSeviceProtocol?
}

// MARK: - HistoryVideosFit InteractorInputProtocol
extension HistoryVideosFitInteractorInput: HistoryVideosFitInteractorInputProtocol {
    func getVideoHistory(page: Int, perPage: Int) {
        self.fitVideoSevice?.getVideoHistory(page: page, perPage: perPage, completion: { [weak self] result in
            let total = result.getTotal() ?? 0
            self?.output?.onGetVideoHistoryFinished(with: result.unwrapSuccessModel(), page: page, total: total)
        })
    }
}
