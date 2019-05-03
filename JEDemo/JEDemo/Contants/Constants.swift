//
//  Constants.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation

struct PostsScreenUIElements {
     static let tableHeight = 68.0
     static let title = "Posts"
     static let tblAccessibiltyId = "PostsTableView"
}
struct CommentsScreenUIElements {
    static let tableHeight = 68.0
    static let title = "Comments"
    static let tblAccessibiltyId = "CommentsTableView"
}

struct Server {
        static let baseURL = "https://jsonplaceholder.typicode.com"
}

struct APIParameterKey {
    static let postId = "postId"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}
