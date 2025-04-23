//
//  RealmMedication.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//


import RealmSwift

class RealmMedication: Object, Identifiable {
    @Persisted(primaryKey: true) var rxcui: String
    @Persisted var name: String
    @Persisted var synonym: String

    convenience init(from concept: ConceptProperty) {
        self.init()
        self.rxcui = concept.rxcui
        self.name = concept.name
        self.synonym = concept.synonym
    }

    func toConceptProperty() -> ConceptProperty {
        return ConceptProperty(rxcui: rxcui, name: name, synonym: synonym)
    }
}