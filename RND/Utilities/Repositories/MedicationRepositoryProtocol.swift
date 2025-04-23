//
//  MedicationRepositoryProtocol.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//


import Foundation
import Combine

protocol MedicationRepositoryProtocol {
    func fetchMedications(for query: String) -> AnyPublisher<[ConceptProperty], Error>
}

class MedicationRepository: MedicationRepositoryProtocol {
    func fetchMedications(for query: String) -> AnyPublisher<[ConceptProperty], Error> {
        // Create the APIEndpoint with the query parameter
        let endpoint = APIEndpoint.getMedications(query: query)

        // Use makeAPIRequest to fetch data
        return NetworkManager.makeAPIRequest(endpoint: endpoint)
            .map { (response: [String: DrugGroup]) in
                // Map the response to ConceptProperty array
//                return response["drugGroup"]?.conceptGroup?.flatMap { $0.conceptProperties ?? [] } ?? []
                return response["drugGroup"]?.conceptGroup?.flatMap { conceptGroup in
                        // Filter conceptGroup by tty and return the conceptProperties if tty matches
                        conceptGroup.tty == "SBD" ? conceptGroup.conceptProperties ?? [] : []
                    } ?? []
            }
            .eraseToAnyPublisher()
    }
}
