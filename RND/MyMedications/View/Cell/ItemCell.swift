//
//  ItemCell.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/23/25.
//

import SwiftUI

struct ItemCell: View {
    let medication: ConceptProperty
    var body: some View {
        HStack{
            Image("medIcon")
                .resizable()
                .frame(width: 32,height: 32)
            Text(medication.name)
            Spacer()
        }
    }
}

