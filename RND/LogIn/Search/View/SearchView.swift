//
//  SearchView.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//
import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var coordinator: AppCoordinatorImpl
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Search Medication", text: $viewModel.searchText)
                        .focused($isFocused)
                }
                .padding(.all,8)
                .background(Color.txtfieldBackground)
                .cornerRadius(10)
                
                if !viewModel.results.isEmpty{
                    HStack{
                        Text("Search results")
                        Spacer()
                    }
                }
            }
            
            List(viewModel.results.prefix(10)) { med in
                NavigationLink {
                    coordinator.build(.detail(medication: med))
                } label: {
                    ItemCell(medication: med)
                    
                }
            }
            
            if isFocused {
                RoundedActionButton(title: "Search") {
                    print("Search tapped with input: \(viewModel.searchText)")
                    viewModel.searchMedications()
                    isFocused = false
                }
                .padding(.bottom)
                .transition(.move(edge: .bottom).combined(with: .opacity)) 
                .animation(.easeInOut, value: isFocused)
            }

        }
        .padding(.horizontal,16)
        .background(Color.primaryBackground)
        .overlay(content: {
            if viewModel.isLoading {
                ProgressView("Searching...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding(.top)
            }
        })
        .navigationTitle(Text("Search Medication"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    coordinator.dismissSheet()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
    }
}
