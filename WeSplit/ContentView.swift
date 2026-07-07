//
//  ContentView.swift
//  WeSplit
//
//  Created by Atagwe Roger on 25/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    let tipPercentages = [10 , 15 ,20 , 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var totalCheckAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people" , selection: $numberOfPeople) {
                        ForEach(2..<100) { number in
                            Text("\(number) people")
                                .tag(number)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much do you want to tip?") {
                    
                    Picker("Tip Percentage" , selection: $tipPercentage) {
                        ForEach(tipPercentages , id: \.self) { percentage in
                            Text(percentage , format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Total Amount") {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Amount per person") {
                    Text(totalPerPerson , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                    
                }
            }
        }
        
        
  }
}

#Preview {
    ContentView()
}
