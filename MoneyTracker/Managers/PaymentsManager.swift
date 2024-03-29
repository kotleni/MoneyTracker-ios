//
//  CoreDataManager.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 23.06.2022.
//

import CoreData

/// Manager for paymenets
struct PaymentsManager {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag? = nil) -> Payment {
        let tagName = (tag == nil ? "" : tag?.name)
        
        // make new payment
        let payment = Payment(context: viewContext)
        payment.price = Float(price)
        payment.about = about
        payment.date = Date()
        payment.tag = tagName
        
        try? viewContext.save()
        return payment
    }
    
    /// Remove payment by in index
    func removePayment(index: Int) {
        viewContext.delete(getPayments()[index])
        try? viewContext.save()
    }
    
    /// Remove payment by in payment
    func removePayment(payment: Payment) {
        viewContext.delete(payment)
        try? viewContext.save()
    }
    
    /// Get all payments
    func getPayments() -> [Payment] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Payment")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Payment.date, ascending: true)]
        do {
            let array = try viewContext.fetch(request) as? [Payment]
            if let array = array {
                return array.reversed()
            }
        } catch {}
        return []
    }
    
    /// Remove all payments
    func removeAll() {
        getPayments().forEach { _ in
            removePayment(index: 0)
        }
    }
}
