//
//  RNDApp.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import SwiftUI
import Firebase

@main
struct RNDApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}
