//
//  HomeViewModel.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 30/09/2024.
//

import SwiftUI
import CoreData

struct TransActionModel {
    let id: UUID
    let dayName: String
    let date: String
    let price: Double
    let type: String
    
    var transType: TransactionType {
        if type == "TransIn" {
            return .TransIn
        }
        else {
            return .TransOut
        }
    }
}

class HomeViewModel: ObservableObject {
    
    @Published var dateName: String = ""
    @Published var dateYear: String = ""
    
    @Published var transaction: [Transaction]?
    
    @Published var data: [TransActionModel] = []
    
    @Published var countOfTranaction = 0
    @Published var transActionTotalPrice = 0.0
    @Published var sumTransActionPrice = 0.0
    @Published var remainPrice = 0.0
    
    @Published var buttonSheet: Bool = false
    @Published var dateSheet: Bool = false
    
    @Published var pickedRow: Transaction?
    @Published var moveToEdit: Bool = false
    
    func renderData(type: TransactionType? = nil) {
        
        let date = Date()
        
        dateName = date.month
        dateYear = date.year
        
        guard let transaction else { return }
        
        if type == nil {
            data = []
            
            data = transaction.map { t in
                TransActionModel(
                    id: t.id ?? UUID(), // Provide a default UUID if 'id' is nil
                    dayName: getDayName(from: t.date), // Function to extract the day name from date
                    date: formatDate(t.date), // Function to format date to a string
                    price: t.price,
                    type: t.type ?? "" // Default to an empty string if 'type' is nil
                )
            }
            
            countOfTranaction = data.count
            
            let totalIn = data
                .filter { $0.transType == .TransIn } // Filter only TransOut transactions
                .reduce(0) { $0 + $1.price }       // Sum their prices
            
            transActionTotalPrice = totalIn
            sumTransActionPrice = transActionTotalPrice
            
            let totalOut = data
                .filter { $0.transType == .TransOut } // Filter only TransOut transactions
                .reduce(0) { $0 + $1.price }       // Sum their prices
            
            remainPrice = totalIn - totalOut
        }
        else {
            
            data = []
            
            switch type {
            case .TransIn:
                for t in transaction {
                    if t.type == "TransIn" {
                        data.append(TransActionModel(
                            id: t.id ?? UUID(), // Provide a default UUID if 'id' is nil
                            dayName: getDayName(from: t.date), // Function to extract the day name from date
                            date: formatDate(t.date), // Function to format date to a string
                            price: t.price,
                            type: "TransIn" // Default to an empty string if 'type' is nil
                        ))
                    }
                }

            case .TransOut:
                data = []
                for t in transaction {
                    if t.type == "TransOut" {
                        data.append(TransActionModel(
                            id: t.id ?? UUID(), // Provide a default UUID if 'id' is nil
                            dayName: getDayName(from: t.date), // Function to extract the day name from date
                            date: formatDate(t.date), // Function to format date to a string
                            price: t.price,
                            type: "TransOut" // Default to an empty string if 'type' is nil
                        ))
                    }
                }
                
                case nil: break
            }
            
            countOfTranaction = data.count
            transActionTotalPrice = data.reduce(0) { $0 + $1.price }
        }
    }
    
    
    func selectedTransaction(index: Int) {
        let picked = data[index]
        
        guard let transaction else { return }
        
        guard let model = transaction.first(where: { $0.id == picked.id }) else { return }
        
        pickedRow = model
        
        moveToEdit = true
    }
    
    
    func fetchTransactions(selectedYear: Int?,selectedMonth: Int,moc: NSManagedObjectContext) {
        let calendar = Calendar.current
        
        // Create date components for the first day of the selected month
        var startComponents = DateComponents()
        startComponents.year = selectedYear
        startComponents.month = selectedMonth
        startComponents.day = 1
        
        // Get the start of the selected month
        guard let startDate = calendar.date(from: startComponents) else { return }
        
        // Get the end of the selected month
        var endComponents = DateComponents()
        endComponents.month = 1
        endComponents.second = -1
        guard let endDate = calendar.date(byAdding: endComponents, to: startDate) else { return }
        
        // Create a fetch request
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        // Set a predicate to filter transactions by date
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate)
        
        do {
            // Fetch the transactions and update the state
            transaction = try moc.fetch(fetchRequest)
            
            guard let transaction else { return }
            
            renderData()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM" // "MMMM" for full month name
                    
            // Create a date from the selected month (year is not needed for the month name)
            var components = DateComponents()
            components.month = selectedMonth
            let date = Calendar.current.date(from: components) ?? Date()
            
            dateName = formatter.string(from: date)
            
            dateYear = String(selectedYear ?? 2024)
            
        } catch {
            print("Failed to fetch transactions: \(error)")
        }
    }
    
    
}

extension HomeViewModel {
    
    private func getDayName(from date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Day name format (e.g., Monday)
        return formatter.string(from: date)
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Formats date (e.g., Sep 30, 2024)
        return formatter.string(from: date)
    }
}
