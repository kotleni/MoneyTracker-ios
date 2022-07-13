//
//  PreviewCoreDataManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import CoreData

struct PreviewCoreDataManager {
    static let shared = PreviewCoreDataManager()
    
    private var viewContext = PersistenceController.preview.container.viewContext
    
    func getPayments() -> [Payment] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Payment")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Payment.date, ascending: true)]
        let array =  try! viewContext.fetch(request) as! Array<Payment>
        return array.reversed()
    }
}
