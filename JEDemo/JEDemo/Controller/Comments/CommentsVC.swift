//
//  CommentsVC.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import UIKit
import MBProgressHUD

class CommentsVC: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var postId: Int!
    var viewModel = CommentsViewModel(apiClient: APIClient())
    @IBOutlet var tblComments: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = CommentsScreenUIElements.title
        self.view.accessibilityLabel = CommentsScreenUIElements.title
        tblComments.accessibilityIdentifier = CommentsScreenUIElements.tblAccessibiltyId
        tblComments.isAccessibilityElement = true
        tblComments.estimatedRowHeight = CGFloat(CommentsScreenUIElements.tableHeight)
        tblComments.rowHeight = UITableView.automaticDimension
        getComments()
    }

    // MARK: - Networking
    private func getComments() {
        self.activityIndicatorStart()
        viewModel.getComments(postId: postId)
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        viewModel.showAlertClosure = { error in
            if let errorMessage = error {
                self.alert(message: errorMessage)
            }
        }
        viewModel.didFinishFetch  = {
            if self.viewModel.comments != nil {
                self.tblComments.reloadData()
            }
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

extension CommentsVC: UITableViewDataSource, UITableViewDelegate{
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        cell.lblComments.text = viewModel.comments?[indexPath.row].body
        return cell
    }
}
