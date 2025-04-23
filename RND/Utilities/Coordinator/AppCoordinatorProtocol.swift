//
//  AppCoordinatorProtocol.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }
    func push(_ screen:  Screen)
    func presentSheet(_ sheet: Sheet)
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover)
    func pop()
    func popToRoot()
    func dismissSheet()
    func dismissFullScreenOver()
}

enum Screen: Identifiable, Hashable {
    
    case onboard
    case login
    case signup
    
    
    var id: Self { return self }
}

enum Sheet: Identifiable, Hashable {
    case none
    
    var id: Self { return self }
}

enum FullScreenCover: Identifiable, Hashable {
    case none

    var id: Self { return self }
}


