//
//  AddTransactionViewModel.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 29/09/2024.
//

import SwiftUI
import CoreData

class AddTransactionViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var comment: String = ""
    @Published var price: String = ""
    @Published var type: TransactionType? = nil
    @Published var selectedTransIn: Bool = false
    @Published var selectedTransOut: Bool = false
    @Published var buttonEnabled: Bool = false
    @Published var alert: Bool = false
    @Published var errorAlert: Bool = false
    
    let moc: NSManagedObjectContext
    let boxMoney: Double
    let edit: Bool
    let pickedData: Transaction?
    
    init(moc: NSManagedObjectContext,boxMoney: Double,edit: Bool,pickedData: Transaction? = nil) {
        self.moc = moc
        self.boxMoney = boxMoney
        self.edit = edit
        self.pickedData = pickedData
    }
    
    
    func selectTransActionType(_ type: TransactionType) {
        switch type {
        case .TransIn:
            selectedTransIn = true
            selectedTransOut = false
        case .TransOut:
            selectedTransIn = false
            selectedTransOut = true
        }
        
        self.type = type
    }
    
    func checkButton() -> Bool {
        return !name.isEmpty && !comment.isEmpty && !price.isEmpty && type != nil
    }
    
    func saveUser() {
        
        if type == .TransOut {
            if Double(price)! <= boxMoney {
                saveTransaction()
            }
            else {
                errorAlert = true
                alert = true
            }
        }
        else {
            saveTransaction()
        }
        
        
    }
    
    private func saveTransaction() {
        
        if edit {
            
            guard let pickedData else { return }
            
            pickedData.name = name
            pickedData.comment = comment
            pickedData.price = Double(price)!
            pickedData.type = type!.rawValue
        }
        else {
            let transaction = Transaction(context: moc)
            transaction.id = UUID()
            transaction.name = name
            transaction.comment = comment
            transaction.price = Double(price)!
            transaction.type = type!.rawValue
            transaction.date = Date()
            
            name = ""
            comment = ""
            price = ""
            type = nil
            selectedTransIn = false
            selectedTransOut = false
        }
        
        try? moc.save()
        errorAlert = false
        alert = true
    }
    
    func loadData() {
        
        if edit {
            guard let pickedData else { return }
            
            name = pickedData.name ?? ""
            comment = pickedData.comment ?? ""
            price = String(pickedData.price)
            type = pickedData.type == "TransIn" ? .TransIn : .TransOut
            switch type {
                case .TransIn:
                    selectedTransIn = true
                    selectedTransOut = false
                case .TransOut:
                    selectedTransIn = false
                    selectedTransOut = true
                case nil: break
            }
        }
    }
    
    
}
