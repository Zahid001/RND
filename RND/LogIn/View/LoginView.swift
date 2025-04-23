//
//  LoginView.swift
//  BTest
//
//  Created by Md Zahidul Islam Mazumder on 4/21/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showErrorAlert = false

    var body: some View {
        VStack() {
            Text("Login")
                .font(.title)
            
            VStack(spacing: 16){
                CustomTextField(label: "Email", placeholder: "example@mail.com", text: $email)
                CustomTextField(label: "Password", placeholder: "password", text: $password,isSecure: true)
                
            }
            
            Spacer()
            
            Group{
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                } else {
                    RoundedActionButton(title: "Log In") {
                        authViewModel.signIn(email: email, password: password)
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
