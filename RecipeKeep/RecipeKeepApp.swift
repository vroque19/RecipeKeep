import SwiftUI

@main
struct RecipeKeepApp: App {
    let persistentContainer = PersistenceController.shared.persistentContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
