//
//  PersistenceController.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import CoreData

/// Database controller
struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    // disabled (need for previews)
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Payment(context: viewContext)
//            newItem.price = -10
//            newItem.about = "Tips"
//            newItem.date = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
