import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                print("Error initializing persistent container: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}



