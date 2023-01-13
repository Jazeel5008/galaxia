//
//  HomeService.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit

struct ResultService {
    
    // MARK:- Singleton
    static let shared = ResultService()
    
    var url = "https://test.lascade.com/api/test/list"
    
    // MARK:- Network Call
    
    func fetchHome(completion:@escaping(HomeModel?, String?)->()) {
        
        NetworkManager.shared.makeNetworkCall(with: URL(string: url)!, method: .get, objectType: HomeModel.self) { result in
            
            switch result {
                case .success(let res):
                    completion(res,nil)
                case .failure(_):
                    print("failure")
                case .clientFailure(_):
                    print("client failure")
            }
            
        }
        
        
        //        NetworkManager.shared.makeNetworkCall(vc: inVC, url: url, method: .get , parameters: nil, isAuth: true) { response in
        //
        //            let resp = CartListModel(JSONString: response)
        //
        //            print("CART RESPONCE \(resp)")
        //
        //            completion(resp,nil,nil)
        //
        //        }clientFailureHandler: { response in
        //
        //            let resp = ErrorModel(JSONString: response)
        //            completion(nil,resp,nil)
        //
        //        } errorHandler: {message in
        //
        //            completion(nil,nil,message)
        //        }
    }
    
    
}

