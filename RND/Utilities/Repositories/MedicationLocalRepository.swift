//
//  MedicationLocalRepository.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//


import RealmSwift

protocol MedicationLocalRepositoryProtocol {
    func saveMedication(_ medication: ConceptProperty)
    func fetchMedications() -> [ConceptProperty]
    func deleteMedication(by rxcui: String)
    func clearAllMedications()
}

class MedicationLocalRepository: MedicationLocalRepositoryProtocol {
    private let realm = try! Realm()

    func saveMedication(_ medication: ConceptProperty) {
        let realmMed = RealmMedication(from: medication)
        try! realm.write {
            realm.add(realmMed, update: .modified)
        }
    }

    func fetchMedications() -> [ConceptProperty] {
        let meds = realm.objects(RealmMedication.self)
        return meds.map { $0.toConceptProperty() }
    }

    func deleteMedication(by rxcui: String) {
        if let med = realm.object(ofType: RealmMedication.self, forPrimaryKey: rxcui) {
            try! realm.write {
                realm.delete(med)
            }
        }
    }

    func clearAllMedications() {
        let allMeds = realm.objects(RealmMedication.self)
        try! realm.write {
            realm.delete(allMeds)
        }
    }
}
