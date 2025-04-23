//
//  RNDTests.swift
//  RNDTests
//
//  Created by Md Zahidul Islam Mazumder on 4/24/25.
//

import Testing
import XCTest
import RealmSwift
@testable import RND

class MedicationLocalRepositoryTests: XCTestCase {
    
    var repository: MedicationLocalRepository!
    var realm: Realm!
    
    override func setUp() {
        super.setUp()
        
        // Create an in-memory Realm instance for testing
        let config = Realm.Configuration(inMemoryIdentifier: "TestRealm")
        realm = try! Realm(configuration: config)
        
        // Initialize the repository
        repository = MedicationLocalRepository()
    }
    
    override func tearDown() {
        // Clear the Realm database after each test
        try! realm.write {
            realm.deleteAll()
        }
        repository = nil
        realm = nil
        super.tearDown()
    }
    
    // Test: Save Medication
    func testSaveMedication() {
        // Arrange
        let medication = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        
        // Act
        repository.saveMedication(medication)
        
        print("medication",medication)
        
        // Assert
        let savedMedications = repository.fetchMedications()
        print("savedMedications",savedMedications)
        XCTAssertEqual(savedMedications.count, 1, "Medication should be saved.")
        XCTAssertEqual(savedMedications.first?.rxcui, medication.rxcui, "Saved medication's rxcui should match.")
    }
    
    // Test: Fetch Medications
    func testFetchMedications() {
        // Arrange
        let medication1 = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        let medication2 = ConceptProperty(rxcui: "124", name: "Paracetamol", synonym: "Acetaminophen")
        
        // Act
        repository.saveMedication(medication1)
        repository.saveMedication(medication2)
        
        // Assert
        let savedMedications = repository.fetchMedications()
        XCTAssertEqual(savedMedications.count, 2, "There should be 2 medications saved.")
        XCTAssertEqual(savedMedications[0].rxcui, medication1.rxcui, "First medication's rxcui should match.")
        XCTAssertEqual(savedMedications[1].rxcui, medication2.rxcui, "Second medication's rxcui should match.")
    }
    
    // Test: Delete Medication by rxcui
    func testDeleteMedication() {
        // Arrange
        let medication1 = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        repository.saveMedication(medication1)
        
        // Act
        repository.deleteMedication(by: "123")
        
        // Assert
        let savedMedications = repository.fetchMedications()
        XCTAssertTrue(savedMedications.isEmpty, "There should be no medications after deletion.")
    }
    
    // Test: Clear All Medications
    func testClearAllMedications() {
        // Arrange
        let medication1 = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        let medication2 = ConceptProperty(rxcui: "124", name: "Paracetamol", synonym: "Acetaminophen")
        repository.saveMedication(medication1)
        repository.saveMedication(medication2)
        
        // Act
        repository.clearAllMedications()
        
        // Assert
        let savedMedications = repository.fetchMedications()
        XCTAssertTrue(savedMedications.isEmpty, "There should be no medications after clearing all.")
    }
    
    // Test: Verify that the medication is correctly converted to ConceptProperty
    func testMedicationConversion() {
        // Arrange
        let medication = ConceptProperty(rxcui: "123", name: "Aspirin", synonym: "Acetylsalicylic acid")
        
        // Act
        repository.saveMedication(medication)
        let savedMedications = repository.fetchMedications()
        
        // Assert
        XCTAssertEqual(savedMedications.first?.rxcui, medication.rxcui, "The medication rxcui should match.")
        XCTAssertEqual(savedMedications.first?.name, medication.name, "The medication name should match.")
        XCTAssertEqual(savedMedications.first?.synonym, medication.synonym, "The medication synonym should match.")
    }
}
struct RNDTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
