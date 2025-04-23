//
//  RoundedActionButton.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/23/25.
//


import SwiftUI

struct RoundedActionButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .frame(minWidth: 100,maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(14)
        }
    }
}
