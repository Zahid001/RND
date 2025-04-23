//
//  MyMedicationsViewModelTests.swift
//  RNDTests
//
//  Created by Md Zahidul Islam Mazumder on 4/24/25.
//

import XCTest
@testable import RND

// Mock repository
class MockMedicationLocalRepository: MedicationLocalRepositoryProtocol {
    var medications: [ConceptProperty] = []
    
    func saveMedication(_ medication: ConceptProperty) {
        medications.append(medication)
    }

    func fetchMedications() -> [ConceptProperty] {
        return medications
    }

    func deleteMedication(by rxcui: String) {
        medications.removeAll { $0.rxcui == rxcui }
    }

    func clearAllMedications() {
        medications.removeAll()
    }
}

class MyMedicationsViewModelTests: XCTestCase {

    var viewModel: MyMedicationsViewModel!
    var mockRepository: MockMedicationLocalRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockMedicationLocalRepository()
        viewModel = MyMedicationsViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    // Test: Load Medications
    func testLoadMedications() {
        // Arrange
        let medication1 = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        let medication2 = ConceptProperty(rxcui: "124", name: "Paracetamol", synonym: "Acetaminophen")
        mockRepository.saveMedication(medication1)
        mockRepository.saveMedication(medication2)

        // Act
        viewModel.loadMedications()

        // Assert
        XCTAssertEqual(viewModel.medications.count, 2, "Medications count should match.")
        XCTAssertEqual(viewModel.medications[0].rxcui, medication1.rxcui, "First medication's rxcui should match.")
        XCTAssertEqual(viewModel.medications[1].rxcui, medication2.rxcui, "Second medication's rxcui should match.")
    }

    // Test: Delete Medication
    func testDeleteMedication() {
        // Arrange
        let medication1 = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        let medication2 = ConceptProperty(rxcui: "124", name: "Paracetamol", synonym: "Acetaminophen")
        mockRepository.saveMedication(medication1)
        mockRepository.saveMedication(medication2)
        viewModel.loadMedications()

        // Act: Delete the first medication
        viewModel.deleteMedication(at: IndexSet([0]))

        // Assert
        XCTAssertEqual(viewModel.medications.count, 1, "After deletion, the medications count should be 1.")
        XCTAssertEqual(viewModel.medications.first?.rxcui, medication2.rxcui, "The remaining medication's rxcui should be for Paracetamol.")
    }

    // Test: Delete Medication with empty list
    func testDeleteMedication_EmptyList() {
        // Arrange: No medications added
        viewModel.loadMedications()

        // Act: Try deleting from an empty list
        viewModel.deleteMedication(at: IndexSet([0]))

        // Assert
        XCTAssertEqual(viewModel.medications.count, 0, "The medications list should remain empty.")
    }
}
