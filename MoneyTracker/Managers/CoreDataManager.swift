//
//  CoreDataManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import CoreData

/// Manager for CoreData
struct CoreDataManager {
    static let shared = CoreDataManager()
    
    private var viewContext = PersistenceController.shared.container.viewContext
    
    /// Add new payment
    func addPayment(price: Float, about: String) {
        let payment = Payment(context: viewContext)
        payment.price = Float(price)
        payment.about = about
        payment.date = Date()
    
        try! viewContext.save()
    }
    
    /// Remove payment by in index
    func removePayment(index: Int) {
        viewContext.delete(getPayments()[index])
        try! viewContext.save()
    }
    
    /// Get all payments
    func getPayments() -> [Payment] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Payment")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Payment.date, ascending: true)]
        let array =  try! viewContext.fetch(request) as! Array<Payment>
        return array.reversed()
    }
    
    /// Remove all payments
    func removeAll() {
        getPayments().forEach { payment in
            removePayment(index: 0)
        }
    }
}
