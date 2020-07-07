//
//  ContentView.swift
//  WeSplit
//
//  Created by Gavin Butler on 05-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var chequeAmount = ""    //String because SwiftUI stores all textfield values as Strings
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 0    //Index from array of tip percentages
    
    private var chequeWithTip: Double {
        guard let chequeAmount = Double(chequeAmount) else { return 0 }
        let tipFactor = 1.0 + (Double(tipPercentages[tipPercentage]) / 100)
        return chequeAmount * tipFactor
    }
    
    private var splitAmount: Double {
        let peopleCount = Double(peopleNum)
        return chequeWithTip / peopleCount
    }
    
    private var peopleNum: Int {
        guard let number = Int(numberOfPeople), number > 0 else { return 0 }
        return number
    }
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Cheque Amount", text: $chequeAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                    .keyboardType(.decimalPad)
                    /*Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }*/
                }
                Section(header: Text("How much Tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total Cheque Amount (with Tip):")) {
                    Text("$\(chequeWithTip, specifier: "%.2f")")
                }
                Section(header: Text("Amount per person:")) {
                    if peopleNum > 0 {
                        Text("$\(splitAmount, specifier: "%.2f")")
                    } else {
                        Text("")
                    }
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Picker control and binding
/*struct ContentView: View {
    
    let students = ["Jeff", "Fred", "Bob"]  //Not marked with @State as it's a constant and not going to change.
    @State private var selectedStudent = 0  //The picker selection returns an index number
    
    var body: some View {
        VStack {
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0..<students.count) {
                    Text(self.students[$0])
                }
            }
            Spacer()
            Text("Your selection is \(students[selectedStudent])")
        }
    }
}*/


//Bindings:  Keep data and UI in sync.
/*struct ContentView: View {
    @State private var name = ""
    
    var body: some View {
        Form {
            TextField("Enter your name", text: $name)   //The binding ($) ensures that what is typed in via the UI and the variable are kept in sync.
            Spacer()
            Text(name)
        }
    }
}*/

//Button & @State variables - used to allow mutability on Struct variables
/*@State private var tapCount = 0

var body: some View {
    Button("Tap Count \(tapCount)") {   //Simply reads the property, that's why a binding not required
        self.tapCount += 1              //this is where the variable is updated, and it can only be updated in a struct because of the @State wrapper.
    }
}*/

//NavigationView (Navigation Bar) setup
/*var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello, World!")
            }
        }.navigationBarTitle("SwiftUI", displayMode: .inline)
    }
}*/


