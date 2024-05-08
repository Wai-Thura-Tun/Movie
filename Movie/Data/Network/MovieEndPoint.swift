//
//  MovieEndPoint.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

enum MovieEndPoint: EndPoint {
    
    case List(Encodable)
    
    var path: String {
        switch self {
        case .List:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .List:
            return .GET
        }
    }
    
    var encoding: HTTPEncoding {
        switch self {
        case .List:
            return .QUERY_STRING
        }
    }
    
    var header: [String : Any]? {
        switch self {
        case .List:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .List(let request):
            return request.toDict()
        }
    }
}

extension Encodable {
    func toDict() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return dict ?? [:]
        }
        catch {
            return [:]
        }
    }
}
