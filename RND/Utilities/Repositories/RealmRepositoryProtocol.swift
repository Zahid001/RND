//
//  RealmRepositoryProtocol.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//


import Foundation
import RealmSwift

protocol RealmRepositoryProtocol {
    func saveUser(_ user: RealmUser)
    func getUser(by uid: String) -> RealmUser?
    func clearAll()
}

class RealmRepository: RealmRepositoryProtocol {
    private let realm = try! Realm()

    func saveUser(_ user: RealmUser) {
        try! realm.write {
            realm.add(user, update: .modified)
        }
    }

    func getUser(by uid: String) -> RealmUser? {
        return realm.object(ofType: RealmUser.self, forPrimaryKey: uid)
    }

    func clearAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}