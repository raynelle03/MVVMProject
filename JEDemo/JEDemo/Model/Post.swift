//
//  Post.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Post: Object, Codable {
    @objc dynamic var userId = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var username: String? = nil
    override static func primaryKey() -> String? {
        return "id"
    }


}

