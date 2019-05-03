//
//  DBManager.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
import RealmSwift
class DBManager {
   var realm = try! Realm()

    // MARK: Save object
     func save(object: Object) {
        // Realm should be used on the same thread in which it is accessed
        DispatchQueue.main.async {
            do {
                try self.realm.write({
                    self.realm.add(object, update: true)
                })
            } catch  let error as NSError {
                print("Realm error \(error)")
            }
        }
    }

    // MARK: Save Array
    func saveArray(objects: [Object]) {
        DispatchQueue.main.async {
            do {
                try self.realm.write({
                    self.realm.add(objects, update: true)
                })
            } catch  let error as NSError {
                print("Realm error \(error)")
            }
        }
    }

    // MARK: - Users -
     // MARK: Save Users
    func saveUsers(users: [User]) {
        self.saveArray(objects: users)
    }

    // MARK: Get Username
    func getUserName(userId: Int) -> String {
        let user = realm.objects(User.self).filter("id = \(userId)").first
        guard let username = user?.username  else {
            return ""
        }
        return username
    }

    // MARK: - Posts -
    // MARK: Save Posts
    func savePosts(posts: [Post]) -> [Post] {
        for i in 0..<posts.count {
            posts[i].username = self.getUserName(userId: posts[i].userId)
            self.save(object: posts[i])
        }
        return posts
    }

    // MARK: Get Posts (for caching)
    func getPosts() -> [Post] {
        let posts = realm.objects(Post.self)
        return Array(posts)
    }

    // MARK: - Comments -
    // MARK: Save Comments
    func saveComments(comments: [Comment]) {
        self.saveArray(objects: comments)
    }

    // MARK: Get Comments
    func getComments(postId: Int) -> [Comment] {
        let comments = realm.objects(Comment.self).filter("postId = \(postId)")
        return Array(comments)
    }
}
