//
//  WeSplit.swift
//  Challenges
//
//  Created by Kid Kid on 1/20/23.
//

import SwiftUI

struct WeSplit: View {
    @FocusState private var amountFocused: Bool
    @State private var amountEntered = 0.0
    @State private var selectedNbOfPeople = 2
    @State private var tip = 15
    
    let nbOfPeople = 2...100
    let tips = [10, 15, 20, 25, 0]
    
    var format: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        return .currency(code: currencyCode)
    }
    
    var total: Double {
        let tipAmount = amountEntered * Double(tip) / 100
        let total = amountEntered + tipAmount
        return total
    }
    
    var totalPerPerson: Double {
        return total / Double(selectedNbOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section {
                        TextField("Enter amount", value: $amountEntered, format: format)
                            .keyboardType(.decimalPad)
                            .focused($amountFocused)
                            .onAppear {
                                amountFocused = true
                            }
                                                  
                        Picker("Number of people", selection: $selectedNbOfPeople) {
                            ForEach(nbOfPeople, id: \.self) {
                                Text("\($0) people")
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    Section("How much tip?") {
                        Picker("Tip percentages", selection: $tip) {
                            ForEach(tips, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .textCase(nil)
                    
                    Section {
                        HStack {
                            Text("Total")
                            Spacer()
                            Text(total, format: format)
                                .foregroundColor(Color(.gray))
                        }
                        
                        HStack {
                            Text("Per person")
                            Spacer()
                            Text(totalPerPerson, format: format)
                                .foregroundColor(Color(.gray))
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .navigationTitle("WeSplit")
            }
            .background(Color(.systemGroupedBackground))
            .toolbar {
                // Add Button to ToolbarItemGroup
                // produce constraint warning
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFocused = false
                    }
                }
            }
        }
    }
}

struct WeSplit_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit()
    }
}
