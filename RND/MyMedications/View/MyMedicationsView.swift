//
//  MyMedicationsView.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//
import SwiftUI

struct MyMedicationsView: View {
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = MyMedicationsViewModel()

    var body: some View {
        VStack{
            List {
                ForEach(viewModel.medications) { med in
                    ItemCell(medication: med)
                }
                .onDelete(perform: viewModel.deleteMedication)
                
            }
            Spacer()
            HStack{
                Image(systemName: "plus.circle.fill")
                    
                Text("Search Medication")
                    
            }
            .foregroundStyle(Color.blue)
            .onTapGesture {
                appCoordinator.presentSheet(.search)
            }
        }
        .background(Color.primaryBackground)
        .refreshable {
            viewModel.loadMedications()
        }
        .onAppear(){
            viewModel.loadMedications()
        }
        .overlay(content: {
            if viewModel.medications.isEmpty{
                Text("No item")
            }
        })
        .navigationTitle("My Medications")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    authViewModel.signOut()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        
    }
}
