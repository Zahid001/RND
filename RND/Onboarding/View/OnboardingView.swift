//
//  OnboardingView.swift
//  BTest
//
//  Created by Md Zahidul Islam Mazumder on 4/21/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl
    
    var body: some View {
        VStack {
            Spacer()
            Image("Catalog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)
            Spacer()
          
            Text("Create New Account")
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .onTapGesture {
                    appCoordinator.push(.signup)
                }
                              
            HStack {
                Text("I already have an account")
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        appCoordinator.push(.login)
                    }

            }
            .padding(.vertical)
        }
        .padding()
        .background(Color.onboardBackground)
    }
}
