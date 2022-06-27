//
//  CoreDataManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 23.06.2022.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    private var viewContext = PersistenceController.shared.container.viewContext
    
    func addPayment(price: Float, about: String) {
        let payment = Payment(context: viewContext)
        payment.price = Float(price)
        payment.about = about
        payment.date = Date()
    
        try! viewContext.save()
    }
    
    func removePayment(index: Int) {
        viewContext.delete(getPayments()[index])
        try! viewContext.save()
    }
    
    func getPayments() -> [Payment] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Payment")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Payment.date, ascending: true)]
        let array =  try! viewContext.fetch(request) as! Array<Payment>
        return array.reversed()
    }
}
