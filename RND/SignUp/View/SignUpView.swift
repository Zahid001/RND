//
//  SignUpView.swift
//  BTest
//
//  Created by Md Zahidul Islam Mazumder on 4/21/25.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showErrorAlert = false
    
    var body: some View {
        VStack() {
            Text("Create New Account")
                .font(.title)
                
            VStack(spacing: 16) {
                CustomTextField(label: "Name", placeholder: "Alice", text: $name)
                CustomTextField(label: "Email", placeholder: "example@mail.com", text: $email)
                CustomTextField(label: "Create a password", placeholder: "Create a password", text: $password,isSecure: true)
                
            }
            
            Spacer()
            
            Group{
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                } else {
                    RoundedActionButton(title: "Create Account") {
                        authViewModel.signUp(email: email, password: password,name: name)
                        if let _ = authViewModel.errorMessage {
                            showErrorAlert = true
                        }
                    }
                    .padding(.top)
                    
                }
            }
            .onChange(of: authViewModel.firebaseUser) { newUser in
                if newUser != nil {
                    appCoordinator.popToRoot()
                }
            }
        }
        .padding()
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(authViewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}
