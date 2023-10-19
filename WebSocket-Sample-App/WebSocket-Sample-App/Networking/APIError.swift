//
//  APIError.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/13/23.
//

enum APIError: Error {
    case urlError
    case networkError
    case decodeError
    case encodeError
    case unknownError
    case genericError(Error)
    
    var description: String  {
        switch self {
            case .genericError(let error): return error.localizedDescription
                
            default: return String(describing: self)
        }
    }
}
