//
//  TransactionRow.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI

struct TransactionRow: View {
    
    @Binding var model: TransActionModel
        
    // Determines whether the transaction is positive or negative
    private var isPositive: Bool {
        switch model.transType {
        case .TransIn:
            return true
        case .TransOut:
            return false
        }
    }
    
    var body: some View {
        HStack {
            
            // Amount
            Text("\(model.price.description) EGP")
                .font(.headline)
                .foregroundColor(isPositive ? .green : .red)
            
            Spacer()
            
            
            // Day and Date
            VStack(alignment: .trailing) {
                Text(model.dayName)
                    .font(.headline)
                Text(model.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Left Circle with Arrow
            ZStack {
                Circle()
                    .fill(isPositive ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: isPositive ? "arrow.down.left" : "arrow.up.right")
                    .foregroundColor(isPositive ? .green : .red)
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 3)
        )
        .padding(.bottom,10)
    }
}

#Preview {
    @State var t = TransActionModel(id: UUID(), dayName: "Wednesday", date: "21-05-2024", price: 204.6, type: "TransIn")
    
    return TransactionRow(model: $t)
}
