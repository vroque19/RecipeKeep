import Foundation
import CoreData

extension Recipe {
    @nonobjc public class func fetchRequest()->NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
    @NSManaged public var name: String
    @NSManaged public var directionsJSON: String
    @NSManaged public var ingredients: NSSet?
    
    var directions: [String] {
        get {
            guard let data = directionsJSON.data(using: .utf8) else {return []}
            return (try? JSONDecoder().decode([String].self, from: data)) ?? []
        } set {
            directionsJSON = (try? JSONEncoder().encode(newValue).toString()) ?? "[]"
        }
    }
    
    var ingredientsArray: [Ingredient] {
        get {
            (ingredients as? Set<Ingredient>)?.sorted { $0.name < $1.name } ?? []
        } set {
            ingredients = NSSet(array: newValue)
        }
    }
}

extension Data {
    func toString()-> String? {
        String(data: self, encoding: .utf8)
    }
}

extension Recipe: Identifiable {
    
}

