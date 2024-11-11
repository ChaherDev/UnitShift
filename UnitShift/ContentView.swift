//
//  ContentView.swift
//  UnitShift
//
//  Created by Chaher Machhour on 01/10/2024.
//

import SwiftUI

enum LengthUnit: String {
    case meters = "meters"
    case kilometers = "kilometers"
    case feet = "feet"
    case yards = "yards"
    case miles = "miles"
    
    func toMeters(value: Decimal) -> Decimal {
        switch self {
        case .meters: return value
        case .kilometers: return value * 1000
        case .feet: return value * 0.3048
        case .yards: return value * 0.9144
        case .miles: return value * 1609.34
        }
    }

    func fromMeters(value: Decimal) -> Decimal {
        switch self {
        case .meters: return value
        case .kilometers: return value / 1000
        case .feet: return value / 0.3048
        case .yards: return value / 0.9144
        case .miles: return value / 1609.34
        }
    }
}

struct ContentView: View {
    @State private var inputUnit: LengthUnit = .meters
    @State private var outputUnit: LengthUnit = .feet
    @State private var inputValue: String = ""
    @FocusState private var inputValueIsFocused: Bool  // Pour gérer le focus du clavier

    var convertedValue: Decimal {
        let input = Decimal(string: inputValue) ?? 0
        let valueInMeters = inputUnit.toMeters(value: input)
        return outputUnit.fromMeters(value: valueInMeters)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Unit")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        Text("meters").tag(LengthUnit.meters)
                        Text("kilometers").tag(LengthUnit.kilometers)
                        Text("feet").tag(LengthUnit.feet)
                        Text("yards").tag(LengthUnit.yards)
                        Text("miles").tag(LengthUnit.miles)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Output Unit")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        Text("meters").tag(LengthUnit.meters)
                        Text("kilometers").tag(LengthUnit.kilometers)
                        Text("feet").tag(LengthUnit.feet)
                        Text("yards").tag(LengthUnit.yards)
                        Text("miles").tag(LengthUnit.miles)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Value to Convert")) {
                    TextField("Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                        .focused($inputValueIsFocused) // Lier le focus du champ
                }

                Section(header: Text("Result")) {
                    Text("\(NSDecimalNumber(decimal: convertedValue).doubleValue, specifier: "%.2f") \(outputUnit.rawValue)")
                }
            }
            .navigationTitle("UnitShift")
            .toolbar {
                // Afficher le bouton Done uniquement lorsque le clavier est affiché
                ToolbarItem(placement: .navigationBarTrailing) {
                    if inputValueIsFocused {
                        Button("Done") {
                            inputValueIsFocused = false // Ferme le clavier
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Forcer la vue en mode plein écran sur iPad
    }
}

#Preview {
    ContentView()
}
