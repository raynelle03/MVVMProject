//
//  PostsVC.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostsVC: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel = PostViewModel(apiClient: APIClient())
    @IBOutlet var tblPosts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PostsScreenUIElements.title
        self.view.accessibilityLabel = PostsScreenUIElements.title
        tblPosts.accessibilityIdentifier = PostsScreenUIElements.tblAccessibiltyId
        tblPosts.isAccessibilityElement = true
        tblPosts.estimatedRowHeight = CGFloat(PostsScreenUIElements.tableHeight)
        tblPosts.rowHeight = UITableView.automaticDimension
        getData()
    }

    // MARK: - Networking
    private func getData() {
        self.activityIndicatorStart()
        viewModel.getUsers()
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        viewModel.showAlertClosure = { error in
            if let errorMessage = error {
                self.alert(message: errorMessage)
            }
        }
        viewModel.didFinishFetch  = {
                self.tblPosts.reloadData()
        }
    }
    
    // MARK: - Activity Indicator
    private func activityIndicatorStart() {
        self.showSpinner()
    }

    private func activityIndicatorStop() {
        self.hideSpinner()
    }
}

extension PostsVC: UITableViewDataSource, UITableViewDelegate{
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
        cell.lblTitle.text = viewModel.posts?[indexPath.row].title
        cell.lblUsername.text = viewModel.posts?[indexPath.row].username
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedPostId = viewModel.posts?[indexPath.row].id {
             coordinator?.goToComment(postId: selectedPostId)
        }
    }
}

