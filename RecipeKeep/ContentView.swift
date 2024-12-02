import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showRecipes: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ShowRecipesView()) {
                    Text("View Recipes").font(.title)
                }
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.system(size:50))
                    .padding(5)
            } .navigationTitle("Recipe Keeper")
            
        }
    }
}

#Preview {
    ContentView()
}
