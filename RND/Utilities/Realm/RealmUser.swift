//
//  RealmUser.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import RealmSwift
import Foundation

class RealmUser: Object, Identifiable {
    @Persisted(primaryKey: true) var uid: String = ""
    @Persisted var email: String = ""
    @Persisted var name: String = ""
    @Persisted var createdAt: Date = Date()
}
