//
//  IngredientRowView.swift
import SwiftUI

struct IngredientRow: View {
    @State private var isEditing = false
    @Binding var ingredient: Ingredient

    var body: some View {
        VStack(alignment: .leading) {
            if isEditing {
                TextField("Ingredient Name", text: Binding(
                    get: { ingredient.name },
                    set: { ingredient.name = $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Measurement", text: Binding(
                    get: { ingredient.measurement ?? "" },
                    set: { ingredient.measurement = $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Done") {
                    isEditing = false
                }
            } else {
                HStack {
                    Text(ingredient.name )
                        .onTapGesture {
                            isEditing = true
                        }
                    Spacer()
                    if let measurement = ingredient.measurement, !measurement.isEmpty {
                        Text(measurement)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
