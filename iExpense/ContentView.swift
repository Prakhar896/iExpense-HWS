//
//  ContentView.swift
//  iExpense
//
//  Created by Prakhar Trivedi on 6/3/23.
//

import SwiftUI

struct ExpenseCell: View {
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                    .font(.system(size: 22, weight: .bold))
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.headline)
                .foregroundColor(item.amount < 10 ? .green: item.amount < 100 ? .yellow: .red)
            
        }
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses() // tells SwiftUI to watch the object for any change in the @Published expenses array
    @State var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                if (expenses.items.filter({ $0.type == "Personal" })).count > 0 {
                    Section {
                        ForEach(expenses.items.filter({ $0.type == "Personal" })) { item in
                            ExpenseCell(item: item)
                        }
                        .onDelete(perform: removePersonalItems)
                    } header: {
                        Text("Personal")
                    }
                }
                
                if (expenses.items.filter({ $0.type == "Business" })).count > 0 {
                    Section {
                        ForEach(expenses.items.filter({ $0.type == "Business" })) { item in
                            ExpenseCell(item: item)
                        }
                        .onDelete(perform: removeBusinessItems)
                    } header: {
                        Text("Business")
                    }
                }
                
                if (expenses.items.count == 0) {
                    Text("No expenses created yet. \nHit the '+' button to get started!")
                        .font(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    //                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //                    expenses.items.append(expense)
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        // Identify the ID of the expense
        let personalMap = expenses.items.filter({ $0.type == "Personal" })
        var targetExpense: ExpenseItem? = nil
        for expense in personalMap {
            if expense.id == personalMap[offsets.first ?? 0].id {
                targetExpense = expense
            }
        }
        
        // Remove the expense
        if let targetExpense = targetExpense {
            for expenseIndex in 0..<expenses.items.count {
                if expenses.items[expenseIndex].id == targetExpense.id {
                    expenses.items.remove(at: expenseIndex)
                    return
                }
            }
        } else {
            print("Failed to get target expense in personal section.")
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        // Identify the ID of the expense
        let businessMap = expenses.items.filter({ $0.type == "Business" })
        var targetExpense: ExpenseItem? = nil
        for expense in businessMap {
            if expense.id == businessMap[offsets.first ?? 0].id {
                targetExpense = expense
            }
        }
        
        // Remove the expense
        if let targetExpense = targetExpense {
            for expenseIndex in 0..<expenses.items.count {
                if expenses.items[expenseIndex].id == targetExpense.id {
                    expenses.items.remove(at: expenseIndex)
                    return
                }
            }
        } else {
            print("Failed to get target expense in business section.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
