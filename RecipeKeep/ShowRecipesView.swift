import SwiftUI
import CoreData

struct ShowRecipesView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: false)]
    )
    private var recipes: FetchedResults<Recipe>
    @State private var showRecipeForm = false
    @State private var recipeToEdit: Recipe?

    var body: some View {
        List {
            ForEach(recipes) { recipe in
                HStack {
                    Text(recipe.name)
                        .font(.headline)
                    Spacer()
                }
                .contentShape(Rectangle()) // Makes the whole row tappable
                .onTapGesture {
                    recipeToEdit = recipe
                    showRecipeForm = true
                }
            }
            .onDelete(perform: deleteRecipe)
        }
        .navigationTitle("Recipes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    recipeToEdit = nil
                    showRecipeForm = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showRecipeForm) {
            RecipeFormView(recipeToEdit: $recipeToEdit)
                .environment(\.managedObjectContext, viewContext)
        }
    }

    private func deleteRecipe(at offsets: IndexSet) {
        offsets.map { recipes[$0] }.forEach(viewContext.delete)
        do {
            try viewContext.save()
        } catch {
            print("Failed to delete recipe: \(error.localizedDescription)")
        }
    }
}

