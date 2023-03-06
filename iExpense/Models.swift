//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Prakhar Trivedi on 6/3/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable { // conformance to identifiable requires an id property that is a type of ObjectIdentifier, which UUID is.
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ExpenseItems")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) { // [ExpenseItem].self tells Swift that we are not creating a copy of an array of expense items or doing anything else but that we are decoding from an idea of an array of expense items
                items = decodedItems
                return
            }
        }
        
        // Error cases come here
        items = []
    }
}
