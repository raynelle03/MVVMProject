//
//  Comment.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Comment: Object, Codable {
    @objc dynamic var postId = 0
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var body = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
