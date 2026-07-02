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
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
        Form {
            Section {
                TextField("Amount ", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)

                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<100) { num in
                    Text("\(num) people")
                            .tag(num)
                            
                        
                    }
                }
                .pickerStyle(.navigationLink)
            }
            Section("How much do you want to tip") {
                
                Picker("Tip percentage" , selection: $tipPercentage) {
                    ForEach(tipPercentages , id: \.self) { tip in
                        Text(tip, format: .percent)
                    }
                    
                }
                .pickerStyle(.segmented)
            }
            Section {
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USd"))
                    .foregroundStyle(tipPercentage == 0 ? .red : .black)
            }
        }
        .navigationBarTitle("WeSplit")
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
