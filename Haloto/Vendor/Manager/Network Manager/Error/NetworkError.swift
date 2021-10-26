//
//  NetworkError.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import Foundation

enum NetworkError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid enpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }

    var errorInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
