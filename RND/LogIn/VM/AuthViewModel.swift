//
//  AuthViewModel.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var firebaseUser: User? = nil
    @Published var realmUser: RealmUser? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    private let authRepository: AuthRepositoryProtocol
    private let realmRepository: RealmRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol = AuthRepository(),
         realmRepository: RealmRepositoryProtocol = RealmRepository()) {
        self.authRepository = authRepository
        self.realmRepository = realmRepository
        self.firebaseUser = authRepository.currentUser()

        if let uid = firebaseUser?.uid {
            self.realmUser = realmRepository.getUser(by: uid)
        }
    }

    func signIn(email: String, password: String) {
        if !validateFields(email: email, password: password) { return }
        
        self.isLoading = true
        authRepository.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.firebaseUser = user
                    self?.saveToRealm(user: user)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signUp(email: String, password: String, name:String) {
        if name.isEmpty{
            errorMessage = "Please enter name."
            return
        }
        if !validateFields(email: email, password: password) { return }
        
        self.isLoading = true
        authRepository.signUp(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.firebaseUser = user
                    self?.saveToRealm(user: user, name: name)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func signOut() {
        self.isLoading = true // Indicate that a network request is happening
        do {
            try authRepository.signOut()
            realmRepository.clearAll()
            firebaseUser = nil
            realmUser = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
        self.isLoading = false
    }

    private func saveToRealm(user: User,name:String? = nil) {
        let newUser = RealmUser()
        newUser.uid = user.uid
        newUser.email = user.email ?? ""
        newUser.name = name ?? (user.displayName ?? "")
        newUser.createdAt = Date()
        realmRepository.saveUser(newUser)
        realmUser = newUser
    }
}

extension AuthViewModel{
    
    // Email validation
    func validateEmail(email:String) -> Bool {
        let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    // Password validation (must be at least 6 characters)
    func validatePassword(password:String) -> Bool {
        return password.count >= 6
    }
    
    // Validate both fields
    func validateFields(email:String,password:String) -> Bool {
        errorMessage = nil
        if !validateEmail(email: email) {
            errorMessage = "Please enter a valid email address."
            return false
        }
        
        if !validatePassword(password: password) {
            errorMessage = "Password must be at least 6 characters."
            return false
        }
        
        return true
    }
    
    
}
