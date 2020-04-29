//
//  AddView.swift
//  iExpense
//
//  Created by Christopher Walter on 4/27/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var errorAlertIsShowing = false // this will be used to trigger an alert if user enters non number for amount
    
    @ObservedObject var expenses: Expenses

    static let types = ["Business", "Personal"]

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Double(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
                else {
                    self.errorAlertIsShowing = true
                }
            })
                .alert(isPresented:$errorAlertIsShowing) {
                    Alert(title: Text("Error"), message: Text("You must enter an actual number for the amount"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
