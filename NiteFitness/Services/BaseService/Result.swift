//
//  Result.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import UIKit

extension Result where Success: Codable {
    func unwrapSuccessModel<T>() -> Result<T, Failure> where Success == BaseModel<T>, Failure == APIError {
        return flatMap { (baseModel) -> Result<T, Failure> in
            if let data = baseModel.data {
                return .success(data)
                
            } else {
                let apiError = APIError(message: "Can not unwrap optional \(T.self)", statusCode: -1)
                return .failure(apiError)
            }
        }
    }

    func optionalSuccessModel<T>() -> Result<T?, Failure> where Success == BaseModel<T>, Failure == APIError {
        return map({ $0.data })
    }

    func getTotal<T>() -> Int? where Success == BaseModel<T> {
        switch self {
        case .success(let baseModel):
            return baseModel.meta?.total
        case .failure:
            return nil
        }
    }

    func toString<T>() -> String? where Success == BaseModel<T> {
        switch self {
        case .success(let baseModel):
            let value = baseModel.jsonString
            return value
            
        case .failure(let error):
            let value = error.asAFError?.errorDescription
            return value
        }
    }
    
    func getMeta<T>() -> Meta? where Success == BaseModel<T> {
        switch self {
        case .success(let baseModel):
            return baseModel.meta
            
        case .failure:
            return nil
        }
    }
}

