//
//  DrugGroup.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//
import Foundation

struct DrugGroup: Codable {
    let conceptGroup: [ConceptGroup]?
}

struct ConceptGroup: Codable {
    let tty: String
    let conceptProperties: [ConceptProperty]?
}

struct ConceptProperty: Codable, Identifiable, Hashable, Equatable {
    var id: String { rxcui }
    let rxcui: String
    let name: String
    let synonym: String
}
