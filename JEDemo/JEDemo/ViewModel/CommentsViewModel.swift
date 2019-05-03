//
//  CommentsViewModel.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
class CommentsViewModel {
    // MARK: - Properties
    var comments: [Comment]!
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    let dbManager = DBManager()

    // MARK: - Closures for callback
    var showAlertClosure: ((String?) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?

    // MARK: - Constructor
    private var apiClient: APIClient?
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: - Network call
    func getComments(postId: Int) {
        self.apiClient?.getComments(postId: postId, completion: { (comments, errorMsg) in
            if errorMsg != nil {
                //fetch comments from Database if offline. Only the comments saved in
                //Database will be displayed
                self.comments = self.dbManager.getComments(postId: postId)
                self.showAlertClosure?(errorMsg!)
            } else if let commentslist = comments {
                self.comments = comments
                self.dbManager.saveArray(objects: commentslist)
            }
            self.didFinishFetch?()
            self.isLoading = false

        })

    }
}
