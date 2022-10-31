//
//  BaseService.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import Alamofire

class BaseService {
    // MARK: - Singleton
    static let shared = BaseService()
    
    private init() {
        // not use
    }
    
    private var headers: HTTPHeaders? {
        guard let tokenString = KeyChainManager.shared.accessToken else {
            return nil
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String.init(validatingUTF8: ptr)
            }
        }
        let userAgent = "\(KeyChainManager.shared.userAgent ?? "")-model: \(modelCode ?? "")"
        
        if APP_ENV == .DEV {
            print("Authorization: Bearer \(tokenString)")
            print("Authorization: user-agent: \(userAgent)")
        }
        
        return [
            "Authorization": "Bearer \(tokenString)",
            "user-agent": userAgent,
            "Accept": "application/json"
        ]
    }

    // MARK: - JSONDecoder
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormat = DateFormatter()
        decoder.dateDecodingStrategy = .formatted(dateFormat)
        return decoder
    }
    
    // MARK: - GET
    func GET<T: Codable>(url: String,
                         param: [String: Any]?,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url.toUrl,
                                 method: .get,
                                 parameters: param,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            
            Log.shared.logApiRequest(url: url, method: "GET", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    func get<T: Codable>(url: ApiUrlProtocol,
                         param: [String: Any]?,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url.fullURLString,
                                 method: .get,
                                 parameters: param,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            
            Log.shared.logApiRequest(url: url.fullURLString, method: "GET", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }

    // MARK: - POST
    func POST<T: Codable>(url: String,
                          param: [String: Any]?,
                          encoding: ParameterEncoding = URLEncoding.default,
                          completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url,
                                 method: .post,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            
            //vuongbachthu
            Log.shared.logApiRequest(url: url, method: "POST", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    func post<T: Codable>(url: ApiUrlProtocol,
                          param: [String: Any]?,
                          encoding: ParameterEncoding = URLEncoding.default,
                          completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        let request = AF.request(url.fullURLString,
                                 method: .post,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            
            //vuongbachthu
            Log.shared.logApiRequest(url: url.fullURLString, method: "POST", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }

    // MARK: - PUT
    func PUT<T: Codable>(url: String,
                         param: [String: Any]?,
                         encoding: ParameterEncoding = JSONEncoding.prettyPrinted,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url,
                                 method: .put,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: self.headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, queue: .main, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            //vuongbachthu
            Log.shared.logApiRequest(url: url, method: "PUT", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    func put<T: Codable>(url: ApiUrlProtocol,
                         param: [String: Any]?,
                         encoding: ParameterEncoding = JSONEncoding.prettyPrinted,
                         completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url.fullURLString,
                                 method: .put,
                                 parameters: param,
                                 encoding: encoding,
                                 headers: self.headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, queue: .main, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            //vuongbachthu
            Log.shared.logApiRequest(url: url.fullURLString, method: "PUT", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }

    // MARK: - DELETE
    func DELETE<T: Codable>(url: String,
                            param: [String: Any]?,
                            completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url,
                                 method: .delete,
                                 parameters: param,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            //vuongbachthu
            Log.shared.logApiRequest(url: url, method: "DELETE", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }
    
    func delete<T: Codable>(url: ApiUrlProtocol,
                            param: [String: Any]?,
                            completion: @escaping ((Result<BaseModel<T>, APIError>) -> Void)) {
        
        let request = AF.request(url.fullURLString,
                                 method: .delete,
                                 parameters: param,
                                 headers: headers)
        request.validate().responseDecodable(of: BaseModel<T>.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<BaseModel<T>, AFError>) in
            //vuongbachthu
            Log.shared.logApiRequest(url: url.fullURLString, method: "DELETE", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }

    // MARK: - UPLOAD
    func UPLOAD<T: Codable>(url: String,
                            param: [String: String],
                            imageParam: [String: Data],
                            completion: @escaping (Result<T, APIError>) -> Void) {
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in param {
                print("./UPLOAD: param \(key): \(value)")
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            for (key, value) in imageParam {
                multipartFormData.append(value, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
                
                print("./UPLOAD: key:", key)
            }
        },
        to: url,
        usingThreshold: UInt64(),
        method: .post,
        headers: headers)
        
        request.uploadProgress { progress in
            let completedUnitCount = progress.completedUnitCount
            print("./UPLOAD: completed ", Units(bytes: Int64(completedUnitCount)).getReadableUnit())
            
        }.validate().responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<T, AFError>) in
            
            Log.shared.logApiRequest(url: url, method: "./UPLOAD", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }

    func upload<T: Codable>(url: ApiUrlProtocol,
                            param: [String: String],
                            imageParam: [String: Data],
                            completion: @escaping (Result<T, APIError>) -> Void) {
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in param {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            for (key, value) in imageParam {
                multipartFormData.append(value, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
                //print("./UPLOAD: key:", key)
            }
        },
        to: url.fullURLString,
        usingThreshold: UInt64(),
        method: .post,
        headers: headers)
        
        request.uploadProgress { progress in
            let completedUnitCount = progress.completedUnitCount
            print("upload: completed ", Units(bytes: Int64(completedUnitCount)).getReadableUnit())
            
        }.validate().responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<T, AFError>) in
            
            Log.shared.logApiRequest(url: url.fullURLString, method: "UPLOAD", parameters: param, result: response.data)
            
            guard let `self` = self else {
                return
            }
            completion(self.handleResponse(response))
        }
    }

//    // MARK: UPLOAD BINARY FILE
//    func UPLOAD_BINARY_FILE<T: Codable>(url: String,
//                                        paramsText: [String: String],
//                                        listData: [[String: Any]],
//                                        completion: @escaping (Result<T, APIError>) -> Void) {
//        let request = AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in paramsText {
//                print("./UPLOAD: bynary param \(key): \(value)")
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
//            for object in listData {
//                guard let data = object as? [String: Data] else {
//                    return
//                }
//                guard let key = data.keys.first, let value = data.values.first else {
//                    return
//                }
//
//                multipartFormData.append(value, withName: "data[]", fileName: "\(key)", mimeType: "application/octet-stream")
//                print("./UPLOAD: bynary key true:", key)
//            }
//        },
//        to: url,
//        usingThreshold: UInt64(),
//        method: .post,
//        headers: headers)
//
//        request.uploadProgress { progress in
//            let completedUnitCount = progress.completedUnitCount
//            print("./UPLOAD: completed ", Units(bytes: Int64(completedUnitCount)).getReadableUnit())
//
//        }.validate().responseDecodable(of: T.self, decoder: self.jsonDecoder) { [weak self] (response: DataResponse<T, AFError>) in
//
//            Log.shared.logApiRequest(url: url, method: "UPLOAD", parameters: paramsText, result: response.data)
//
//            guard let `self` = self else {
//                return
//            }
//            completion(self.handleResponse(response))
//        }
//    }

    // MARK: - Handle Response
    func handleResponse<T: Codable>(_ response: DataResponse<T, AFError>) -> (Result<T, APIError>) {
        switch response.result {
        case .success(let value):
            return Result.success(value)
            
        case .failure(let error):
            guard let data = response.data else {
                let code = response.response?.statusCode ?? -1
                if code == 401 {
                    self.handlerTokenExpire()
                }
                
                let message =  error.errorDescription ?? "AFError"
                let apiError = APIError(message: message, statusCode: code)
                return Result.failure(apiError)
            }
            
            if let apiError = try? self.jsonDecoder.decode(APIError.self, from: data) {
                return Result.failure(apiError)
                
            } else {
                let code = response.response?.statusCode ?? -1
                if code == 401 {
                    self.handlerTokenExpire()
                }
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                let metaObject = jsonObject?["meta"] as? [String: Any]
                let messageData = metaObject?["message"] as? String
                
                let message = messageData ?? error.errorDescription ?? "AFError"
                let apiError = APIError(message: message, statusCode: code)
                return Result.failure(apiError)
            }
        }
    }

    func handlerTokenExpire() {
        NotificationCenter.default.post(name: .tokenExpire, object: nil)
    }

    func cancelAllRequest() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}

