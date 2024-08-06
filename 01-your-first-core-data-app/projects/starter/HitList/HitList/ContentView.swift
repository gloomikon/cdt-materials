import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var people: [NSManagedObject] = []
    @State private var showPopup = false
    @State private var text = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(people.indices, id: \.self) { idx in
                    let item = people[idx]
                    let text = item.value(forKeyPath: "name") as? String
                    if let text {
                        Text(text)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .alert("Log in", isPresented: $showPopup) {
                TextField("Name", text: $text)
                    .textInputAutocapitalization(.never)
                Button("Save") {
                    add(name: text)
                    text = ""
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please enter a name")
            }
            Text("Select an item")
        }
        .onAppear {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
            do {
                people = try viewContext.fetch(fetchRequest)
              } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
              }
        }
    }

    private func add(name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: viewContext)!
        let person = NSManagedObject(entity: entity, insertInto: viewContext)
        person.setValue(name, forKeyPath: "name")

        do {
          try viewContext.save()
          people.append(person)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }

    private func addItem() {
        showPopup = true
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
