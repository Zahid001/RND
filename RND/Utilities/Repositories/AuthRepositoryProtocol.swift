//
//  AuthRepositoryProtocol.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import Foundation
import FirebaseAuth

protocol AuthRepositoryProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signOut() throws
    func currentUser() -> User?
}

class AuthRepository: AuthRepositoryProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
}
