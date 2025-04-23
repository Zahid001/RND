//
//  MyMedicationsViewModel.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//

import SwiftUI

class MyMedicationsViewModel: ObservableObject {
    @Published var medications: [ConceptProperty] = []

    @Published var dummyDetails = " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    private let repository: MedicationLocalRepositoryProtocol

    init(repository: MedicationLocalRepositoryProtocol = MedicationLocalRepository()) {
        self.repository = repository
        loadMedications()
    }

    func loadMedications() {
        medications = repository.fetchMedications()
    }

    func deleteMedication(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let med = medications[index]
            repository.deleteMedication(by: med.rxcui)
        }
        loadMedications()
    }
}
