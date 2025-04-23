//
//  FieldBackgroundModifier.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/23/25.
//

import SwiftUI

struct FieldBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(Color.txtfieldBackground)
            .cornerRadius(8)
    }
}

extension View {
    func customBackground() -> some View {
        self.modifier(FieldBackgroundModifier())
    }
}
