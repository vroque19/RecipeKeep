import Foundation
import SwiftUI

struct RecipeFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.dismiss) private var dismiss
    @Binding var recipeToEdit: Recipe?
 
    @State private var name: String = ""
    @State private var ingredients: [Ingredient] = []
    @State private var directions: [String] = []

    @State private var ingredientName: String = ""
    @State private var ingredientMeasurement: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $name)
                }

                Section(header: Text("Ingredients")) {
                    List {
                        ForEach($ingredients, id: \.self) { $ingredient in
                            IngredientRow(ingredient: $ingredient)
                        }
                        .onDelete(perform: deleteIngredient)
                    }

                    HStack {
                        TextField("Ingredient Name", text: $ingredientName)
                        TextField("Measurement", text: $ingredientMeasurement)
                        Button(action: addIngredient) {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }

                Section(header: Text("Directions")) {
                    ForEach(directions.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1).")
                            TextField("Direction", text: $directions[index])
                        }
                    }
                    Button("Add Step") {
                        directions.append("")
                    }
                }
        
            }
            .navigationTitle(recipeToEdit == nil ? "New Recipe" : "Edit Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                }
            }
            .onAppear {
                if let recipe = recipeToEdit {
                    loadRecipe(recipe)
                }
            }
        }
    }

    private func deleteIngredient(at offsets: IndexSet) {
        offsets.forEach { index in
            let ingredient = ingredients[index]
            viewContext.delete(ingredient)
        }
        ingredients.remove(atOffsets: offsets)
    }

    private func loadRecipe(_ recipe: Recipe) {
        name = recipe.name
        ingredients = recipe.ingredientsArray
        directions = recipe.directions
    }

    private func addIngredient() {
        if !ingredientName.isEmpty {
            let ingredient = Ingredient(context: viewContext)
            ingredient.name = ingredientName
            ingredient.measurement = ingredientMeasurement
            ingredients.append(ingredient)
            ingredientName = ""
            ingredientMeasurement = ""
            }
        do {
            try viewContext.save()
        } catch {
            print("Failed to save ingredient: \(error.localizedDescription)")
        }
    }

    private func saveRecipe() {
        let recipe = recipeToEdit ?? Recipe(context: viewContext)
        recipe.name = name
        recipe.directions = directions
        recipe.ingredients = NSSet(array: ingredients)

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save recipe!!: \(error.localizedDescription)")
        }
    }
}
