//
//  EndPoint.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

protocol EndPoint {
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var encoding: HTTPEncoding { get }
    
    var header: [String: Any]? { get }
    
    var parameters: [String: Any]? { get }
    
    func asURL() throws -> URL
}

extension EndPoint {
    var baseURL: URL {
        URL(string: Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "")!
    }
    
    func asURL() throws -> URL {        
        return path.isEmpty ? baseURL : baseURL.appending(path: path)
    }
}

