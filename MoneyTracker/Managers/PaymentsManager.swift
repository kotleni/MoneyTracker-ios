//
//  CoreDataManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import CoreData

/// Manager for paymenets
struct PaymentsManager {
    @available(*, deprecated)
    static let shared = PaymentsManager()
    
    private var viewContext = PersistenceController.shared.container.viewContext
    
    /// Add new payment
    func addPayment(price: Float, about: String, tag: Tag = Tag.getDefault(), copies: Int = 0) -> Payment {
        let payment = Payment(context: viewContext)
        payment.price = Float(price)
        payment.about = about
        payment.date = Date()
        payment.tag = tag.name
        
        if copies > 0 {
            for index in 0...copies-1 {
                let payment = Payment(context: viewContext)
                payment.price = Float(price)
                payment.about = "\(index) of \(about)"
                payment.date = Date()
                payment.tag = tag.name
            }
        }
    
        try! viewContext.save()
        return payment
    }
    
    /// Remove payment by in index
    func removePayment(index: Int) {
        viewContext.delete(getPayments()[index])
        try! viewContext.save()
    }
    
    /// Remove payment by in payment
    func removePayment(payment: Payment) {
        viewContext.delete(payment)
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
