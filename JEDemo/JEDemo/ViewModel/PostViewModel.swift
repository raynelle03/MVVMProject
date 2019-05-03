//
//  RestaurantViewModel.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
class PostViewModel {
    // MARK: - Properties
    var posts: [Post]!
    var users: [User]!
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    let dbManager = DBManager()

    // MARK: - Closures for callback
    //The public properties and public closures are used by the ViewController to listen to any changes in the ViewModel, just like the delegate pattern in iOS.
    var showAlertClosure: ((String?) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?

    // MARK: - Constructor
    private var apiClient: APIClient?
        init(apiClient: APIClient) {
            self.apiClient = apiClient
        }

    // MARK: - Network call
    func getPosts() {
        self.apiClient?.getPosts(completion: { (posts, errorMsg) in
                if errorMsg != nil {
                    self.showAlertClosure?(errorMsg!)
                } else if let postslist = posts {
                    self.posts = self.dbManager.savePosts(posts: postslist)
                }
                self.isLoading = false
                self.didFinishFetch?()
        })
    }

    func getUsers() {
        self.apiClient?.getUsers(completion: { (users, errorMsg) in
            if errorMsg != nil {
                self.showAlertClosure?(errorMsg!)
                self.isLoading = false
                //fetch posts from Database if offline
                self.posts = DBManager().getPosts()
                self.didFinishFetch?()
            } else if let userslist = users {
                self.users = userslist
                self.dbManager.saveUsers(users: userslist)
                self.getPosts()
            }
        })
    }
}
