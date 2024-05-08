//
//  MovieListRequest.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

struct MovieListRequest: Encodable {
    let search: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "s"
    }
}
