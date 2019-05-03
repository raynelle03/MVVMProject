//
//  APIPosts.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//



import Alamofire
enum APIPosts: URLRequestConvertible {
    case allposts
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .allposts:
            return .get
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .allposts:
            return "/posts"
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case  .allposts:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Server.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.timeoutInterval = 10

        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}

