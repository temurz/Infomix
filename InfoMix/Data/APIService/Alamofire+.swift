//
//  Alamofire+.swift
//  InfoMix
//
//  Created by Damir Asamatdinov on 26/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//
import Alamofire
import Foundation

extension Alamofire.Session{
    @discardableResult
    public func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest
    {
        
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
         
           
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
            URLCache.shared.removeCachedResponse(for: urlRequest)
            
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        }
    }
}
