//
//  NetworkManager.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

class NetworkManager {
    static let shared: NetworkManager = .init()
    
    private init() {}
    
    func request<T: Decodable>(endPoint: MovieEndPoint, 
                               onSuccess: @escaping (T) -> (),
                               onFailure: @escaping (NetworkError) -> ()) {
        
        let url = try? endPoint.asURL()
        
        guard let url = url else {
            onFailure(.INVALID_URL)
            return
        }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let apiKeyValue = Bundle.main.infoDictionary?["API_KEY"] as? String
        let apiKeyItem: URLQueryItem = .init(name: "apikey", value: apiKeyValue)
        request.url?.append(queryItems: [apiKeyItem])
        if let requestBody = endPoint.parameters {
            switch endPoint.encoding {
            case .JSON:
                let data = try? JSONSerialization.data(withJSONObject: requestBody)
                request.httpBody = data
            case .QUERY_STRING:
                request.url?.append(queryItems: requestBody.map {
                    URLQueryItem.init(name: $0.key, value: $0.value as? String)
                })
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                onFailure(.UNKNOWN)
            }
            else {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if (200..<300) ~= statusCode {
                        if let data = data {
                            let responseData = try? JSONDecoder().decode(T.self, from: data)
                            if let responseData = responseData {
                                onSuccess(responseData)
                            }
                            else {
                                onFailure(.DECODE_ERROR)
                            }
                        }
                        else {
                            onFailure(.EMPTY_RESPONSE)
                        }
                    }
                    else {
                        onFailure(.INVALID_STATUS_CODE(statusCode))
                    }
                }
                else {
                    onFailure(.EMPTY_RESPONSE)
                }
            }
        }.resume()
    }
}
