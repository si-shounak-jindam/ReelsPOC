//
//  NetworkManager.swift
//  Lucknow Super Giants
//
//  Created by Abhijeet Gawde on 07/02/23.
//

import Foundation

final class ServiceManager {
    
    static let shared = ServiceManager()
    
    func getHeaders(_ type: NetworkTokenType) -> [String: String]? {
        switch type {
        case .cleanAuthorization:
            return nil
        case .authenticationAuthorization:
            return [
                "content-type": "application/json"
            ]
        case .authenticationWithUserToken:
            return nil
        case .authenticationWithBearerToken:
            return nil
        case .authorizationForNotification:
            return [
                
                "Content-Type": "application/json"
            ]
           
        }
    }
    
    func makeGetRequest<T: Codable>(url: String,
                                    type: T.Type,
                                    headerType: NetworkTokenType = .cleanAuthorization,
                                    completion: @escaping(Result<T, ServiceError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = getHeaders(headerType)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.waitsForConnectivity = true
        sessionConfig.allowsConstrainedNetworkAccess = true
        sessionConfig.allowsCellularAccess = true
        
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataFailure))
                return
            }
            
            guard response != nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
               let decoder = JSONDecoder()
                let returnedResponse = try decoder.decode(T.self, from: data)
                completion(.success(returnedResponse))
                return
            } catch {
                print(error)
                completion(.failure(.invalidResponse))
                return
            }

        }
        task.resume()
    }
    
    func makePostRequest<Input: Codable, Output: Codable>(url: String,
                                                          type: Output.Type,
                                                          headerType: NetworkTokenType = .cleanAuthorization,
                                                          parameters: Input? = nil,
                                                          completion: @escaping(Result<Output, ServiceError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = getHeaders(headerType)
        if let parameters = parameters {
            let jsonEncoder = JSONEncoder()
            let encoderData = try? jsonEncoder.encode(parameters.self)
            request.httpBody = encoderData
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.waitsForConnectivity = true
        sessionConfiguration.allowsConstrainedNetworkAccess = true
        sessionConfiguration.allowsCellularAccess = true
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataFailure))
                return
            }
            
            guard response != nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //MARK: Save UserToken in UserDefaults....
            let responseToken = response as? HTTPURLResponse
            if let token = responseToken?.allHeaderFields["usertoken"] as? String {
                print("userToken ----- \(token)")
            }
            
            do {
                let decoder = JSONDecoder()
                let returnedResponse = try decoder.decode(Output.self, from: data)
                completion(.success(returnedResponse))
            } catch {
                debugPrint("Service Error: \(error)")
                completion(.failure(.invalidResponse))
                return
            }
        }
        task.resume()
    }
    
}

enum NetworkTokenType: String {
    case cleanAuthorization
    case authenticationAuthorization
    case authenticationWithUserToken
    case authenticationWithBearerToken
    case authorizationForNotification
}

enum ServiceError: String, Error {
    case noInternet
    case invalidUrl = "Invalid Url"
    case dataFailure = "Invalid Data"
    case invalidResponse = "Invalid Response"
    case unknownIssue = "Something went wrong!! Please try after some time"
    case userAccountExist = "User account already Exist."
    case none
    var description: String { self.rawValue }
}

enum ResponseValidStatus: String {
    case invalidCredential = "0"
    case successStatus = "1"
    case incompleteStatus = "2"
    case verificationIncomplete = "3"
    case userAlreadyExist = "-5"
    case invalidRequest = "-1"
    case requestForDeleteAccount = "7"
    case accountDeleted = "500"
}

