import Foundation
import CoreData

extension Ingredient {
    @nonobjc public class func fetchRequest()->NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }
    @NSManaged public var name: String
    @NSManaged public var measurement: String?
    @NSManaged public var recipe: Recipe?
    
}

extension Ingredient: Identifiable {
    
}
