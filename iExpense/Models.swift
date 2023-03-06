//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Prakhar Trivedi on 6/3/23.
//

import Foundation

struct ExpenseItem: Identifiable { // conformance to identifiable requires an id property that is a type of ObjectIdentifier, which UUID is.
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = []
}
