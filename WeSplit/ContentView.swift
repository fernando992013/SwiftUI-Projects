//
//  ContentView.swift
//  WeSplit
//
//  Created by Fernando A on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        //converts numberOfPeople to double because it needs to be used alongside checkamount
        //Also adds 2 to numberOfPeople because it has a range from 2 to 100 but it counts from 0
        let peopleCount = Double(numberOfPeople + 2)
        //converts tipPercentage into a double
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }

    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    var body: some View {
        NavigationStack {
            Form  {
                Section {
                    TextField("Amount", value: $checkAmount,format: .currency (code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .navigationTitle("WeSplit")
                    .toolbar {
                        if amountIsFocused {
                            Button("Done"){
                                amountIsFocused = false
                            }
                        }
                    }
                }
                Section("How much do you want to tip?") {
                    Picker ("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
        }
    }
    }


#Preview {
    ContentView()
}
