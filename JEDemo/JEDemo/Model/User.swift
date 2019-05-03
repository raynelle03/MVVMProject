//
//  User.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
class User: Object, Codable {
     @objc dynamic var id = 0
     @objc dynamic var name = ""
     @objc dynamic var username = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
