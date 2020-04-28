//
//  ContentView.swift
//  iExpense
//
//  Created by Christopher Walter on 4/27/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI


struct ContentView: View {

    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                   HStack {
                       VStack(alignment: .leading) {
                           Text(item.name)
                               .font(.headline)
                           Text(item.type)
                       }

                       Spacer()
                       Text("$\(item.amount)")
                   }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
            
       }
        
   }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
