//
//  MovieListResponse.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

struct MovieListResponse: Decodable {
    let search: [MovieVO]
    let totalResult: String?
    let response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResult = "totalResults"
        case response = "Response"
    }
}

struct MovieVO: Decodable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
