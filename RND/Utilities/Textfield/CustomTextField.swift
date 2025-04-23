//
//  CustomTextField.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/23/25.
//


import SwiftUI

struct CustomTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .frame(height: 50)
        .customBackground()
    }
}
