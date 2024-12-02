import CoreData

extension Recipe {
    static func previewRecipe(context: NSManagedObjectContext) -> Recipe {
        let recipe = Recipe(context: context)
        recipe.name = "Pancakes"
        recipe.directions = ["Mix ingredients", "cook in a pan until golden brown."]

        let ingredient1 = Ingredient(context: context)
        ingredient1.name = "Flour"
        ingredient1.measurement = "2 cups"

        let ingredient2 = Ingredient(context: context)
        ingredient2.name = "Milk"
        ingredient2.measurement = "1.5 cups"

        recipe.ingredients = NSSet(array: [ingredient1, ingredient2])

        return recipe
    }
}

