//
//  APIComments.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
import Alamofire
enum APIComments: URLRequestConvertible {
    case comments(postId: String)
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .comments:
            return .get
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .comments:
            return "/comments"
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case  .comments(let postId):
            return [APIParameterKey.postId: postId]
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: "\(Server.baseURL)\(path)")!
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters! {
            queryItems.append(URLQueryItem(name : key, value : value as? String))
        }

        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        return urlRequest
    }
}
