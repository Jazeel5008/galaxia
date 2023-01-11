//
//  NetworkLayer.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    private init() {
    }
    
    enum AppError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }
    
    enum Result<T> {
        case success(T)
        case failure(AppError)
        case clientFailure(T)
    }
    
    enum HTTPMethod : String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
    
    func makeNetworkCall<T: Decodable>(with url: URL,method:HTTPMethod, objectType: T.Type, completion: @escaping (Result<T>) -> Void){
        
        
        let dataURL = url
    
        let session = URLSession.shared
        
        var request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = method.rawValue
        
        //Result
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            
            
            guard error == nil else {
                completion(Result.failure(.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(.dataNotFound))
                return
            }
            
            do {
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
        
    }
    
    
}
