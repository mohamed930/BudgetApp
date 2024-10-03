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
