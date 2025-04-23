//
//  MedicationDetailView.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//
import SwiftUI

struct MedicationDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinatorImpl
    let medication: ConceptProperty
    @StateObject var viewModel:MyMedicationsViewModel
    
    var body: some View {
        
        VStack() {
            Image("medIcon")
                .resizable()
                .frame(width: 32,height: 32)
            
            Text(medication.name)
                .font(.title2)
                .bold()
            Text("RxCUI: \(medication.rxcui)")
                .foregroundColor(.gray)
            
            List{
                Text(viewModel.dummyDetails)
            }
            .padding(.horizontal,0)
            
            
            Spacer()
            RoundedActionButton(title: "Add Medication to List") {
                MedicationLocalRepository().saveMedication(medication)
                coordinator.dismissSheet()
            }
            
        }
        .padding()
        .navigationTitle(Text("Details"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
