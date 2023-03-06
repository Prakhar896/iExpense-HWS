//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Prakhar Trivedi on 6/3/23.
//

import Foundation

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = []
}
