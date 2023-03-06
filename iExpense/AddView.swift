//
//  AddView.swift
//  iExpense
//
//  Created by Prakhar Trivedi on 6/3/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses // Just saying that this exists
    
    @State var name = ""
    @State var type = "Personal"
    @State var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses()) // Note that you need to give some dummy data in order to still generate previews
    }
}