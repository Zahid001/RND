//
//  APIEndpoint.swift
//  BTest
//
//  Created by Md Zahidul Islam Mazumder on 3/7/25.
//

import Foundation

enum APIEndpoint {
    case getMedications(query:String)
    
    private var baseURL: String {
        return "https://rxnav.nlm.nih.gov/REST/drugs.json"
    }
    
    var url: String {
        switch self {
        case .getMedications(let query):
            return "\(baseURL)?name=\(query)&expand=psn"
        }
    }
}
