//
//  ContentView.swift
//  UnitShift
//
//  Created by Chaher Machhour on 01/10/2024.
//

import SwiftUI

// Enum pour les unités de longueur
enum LengthUnit: String {
    case meters = "meters"
    case kilometers = "kilometers"
    case feet = "feet"
    case yards = "yards"
    case miles = "miles"
    
    // Fonction pour convertir vers des mètres
    func toMeters(value: Double) -> Double {
        switch self {
        case .meters:
            return value
        case .kilometers:
            return value * 1000
        case .feet:
            return value * 0.3048
        case .yards:
            return value * 0.9144
        case .miles:
            return value * 1609.34
        }
    }

    // Fonction pour convertir à partir des mètres
    func fromMeters(value: Double) -> Double {
        switch self {
        case .meters:
            return value
        case .kilometers:
            return value / 1000
        case .feet:
            return value / 0.3048
        case .yards:
            return value / 0.9144
        case .miles:
            return value / 1609.34
        }
    }
}

struct ContentView: View {
    @State private var inputUnit: LengthUnit = .meters
    @State private var outputUnit: LengthUnit = .feet
    @State private var inputValue: String = ""

    // Calcul du résultat
    var convertedValue: Double {
        let input = Double(inputValue) ?? 0
        let valueInMeters = inputUnit.toMeters(value: input)
        return outputUnit.fromMeters(value: valueInMeters)
    }

    var body: some View {
        NavigationView {
            Form {
                // Choix de l'unité d'entrée
                Section(header: Text("Unité d'entrée")) {
                    Picker("Unité d'entrée", selection: $inputUnit) {
                        Text("meters").tag(LengthUnit.meters)
                        Text("kilometers").tag(LengthUnit.kilometers)
                        Text("feet").tag(LengthUnit.feet)
                        Text("yards").tag(LengthUnit.yards)
                        Text("miles").tag(LengthUnit.miles)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Choix de l'unité de sortie
                Section(header: Text("Unité de sortie")) {
                    Picker("Unité de sortie", selection: $outputUnit) {
                        Text("meters").tag(LengthUnit.meters)
                        Text("kilometers").tag(LengthUnit.kilometers)
                        Text("feet").tag(LengthUnit.feet)
                        Text("yards").tag(LengthUnit.yards)
                        Text("miles").tag(LengthUnit.miles)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Saisie de la valeur
                Section(header: Text("Valeur à convertir")) {
                    TextField("Valeur", text: $inputValue)
                        .keyboardType(.decimalPad)
                }

                // Résultat de la conversion
                Section(header: Text("Résultat")) {
                    Text("\(convertedValue, specifier: "%.2f") \(outputUnit.rawValue)")
                }
            }
            .navigationTitle("UnitShift")
        }
    }
}

#Preview {
    ContentView()
}
