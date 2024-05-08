//
//  NetworkError.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation

enum NetworkError: Error {
    case INVALID_URL
    case DECODE_ERROR
    case UNKNOWN
    case INVALID_STATUS_CODE(Int)
    case EMPTY_RESPONSE
}
