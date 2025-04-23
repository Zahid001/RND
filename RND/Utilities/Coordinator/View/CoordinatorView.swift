//
//  CoordinatorView.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinatorImpl = AppCoordinatorImpl()
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            initialScreen()
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
                }
                .sheet(item: $appCoordinator.sheet) { sheet in
                    appCoordinator.build(sheet)
                }
                .fullScreenCover(item: $appCoordinator.fullScreenCover) { fullScreenCover in
                    appCoordinator.build(fullScreenCover)
                }
        }
        .environmentObject(appCoordinator)
        .environmentObject(authViewModel)
    }

    @ViewBuilder
    private func initialScreen() -> some View {
        if authViewModel.firebaseUser != nil {
            
        } else {
            appCoordinator.build(.onboard)
        }
    }
}

#Preview {
    CoordinatorView()
}
