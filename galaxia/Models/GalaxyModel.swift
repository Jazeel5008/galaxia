//
//  GalaxyModel.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import Foundation

struct Galaxy : Codable {
    let title : String?
    let description : String?
    let imageUrl : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        case imageUrl = "image-url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }

}

