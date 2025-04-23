//
//  SearchViewModel.swift
//  RND
//
//  Created by Md Zahidul Islam Mazumder on 4/22/25.
//
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [ConceptProperty] = []
    @Published var isLoading = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()
    private let repository: MedicationRepositoryProtocol

    init(repository: MedicationRepositoryProtocol = MedicationRepository()) {
        self.repository = repository
    }

    func searchMedications() {
        guard !searchText.isEmpty else { return }
        isLoading = true
        error = nil

        repository.fetchMedications(for: searchText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err.localizedDescription
                }
            } receiveValue: { [weak self] meds in
                self?.results = meds
            }
            .store(in: &cancellables)
    }
}
