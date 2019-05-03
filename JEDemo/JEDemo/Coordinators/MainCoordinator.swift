//
//  MainCoordinator.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
import UIKit
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let postsVC = PostsVC.instantiate()
        postsVC.coordinator = self
        navigationController.pushViewController(postsVC, animated: false)
    }

    func goToComment(postId: Int)  {
        let commentsVC = CommentsVC.instantiate()
        commentsVC.postId = postId
        commentsVC.coordinator = self
        navigationController.pushViewController(commentsVC, animated: true)
    }

}
