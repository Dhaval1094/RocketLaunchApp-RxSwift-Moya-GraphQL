//
//  Copyright © 2020 Vlogmi. All rights reserved.
//  

import Foundation

enum AppError: Error {
    case unprocessableRequest
    case unprocessableResponse
    case unknown
}

extension AppError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .unprocessableRequest:
            return "Failed to process request"
        case .unprocessableResponse:
            return "Failed to process request"
        case .unknown:
            return "Something went wrong"
        }
    }
}
