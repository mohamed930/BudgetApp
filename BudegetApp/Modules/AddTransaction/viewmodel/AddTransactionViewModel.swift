//
//  AddTransactionViewModel.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 29/09/2024.
//

import SwiftUI

class AddTransactionViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var comment: String = ""
    @Published var price: String = ""
    @Published var type: TransactionType? = nil
    @Published var selectedTransIn: Bool = false
    @Published var selectedTransOut: Bool = false
    @Published var buttonEnabled: Bool = false
    
    
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
    
    
    
}
