//
//  APIErrorBase.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/30/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import Foundation

public protocol APIError: LocalizedError {
    var statusCode: Int? { get }
}

public extension APIError {  // swiftlint:disable:this no_extension_access_modifier
    var statusCode: Int? { return nil }
}

public struct APIInvalidResponseError: APIError {
    
    public init() {
        
    }
    
    public var errorDescription: String? {
        return NSLocalizedString("api.invalidResponseError",
                                 value: "Invalid server response",
                                 comment: "")
    }
}

public struct APIUnknownError: APIError {
    
    public let statusCode: Int?
    public let disputable: Bool
    
    public init(statusCode: Int?) {
        self.init(statusCode: statusCode, errorDescription: NSLocalizedString("api.unknownError",
                                                           value: "Unknown API error",
                                                           comment: ""), disputable: false)
    }
    
    public init(statusCode: Int?, errorDescription: String?){
        self.init(statusCode: statusCode,errorDescription: errorDescription,disputable: false)
    }
    
    public init(statusCode: Int?, errorDescription: String?, disputable: Bool){
        self.statusCode = statusCode
        self.errorDescription = errorDescription
        self.disputable = disputable
        
    }
    
    public let errorDescription: String?
}
