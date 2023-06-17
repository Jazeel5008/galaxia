//
//  HomeModel.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import Foundation

struct HomeModel : Codable {
    let status : Bool?
    let message : String?
    let error : String?
    let result : [Galaxy]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case error = "error"
        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        result = try values.decodeIfPresent([Galaxy].self, forKey: .result)
    }
    
}

