//
//  TransactionRow.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI

struct TransactionRow: View {
    var day: String
    var date: String
    var amount: Double
    var currency: String
        
    // Determines whether the transaction is positive or negative
    private var isPositive: Bool {
        return amount >= 0
    }
    
    var body: some View {
        HStack {
            
            // Amount
            Text("\(Int(amount)) \(currency)")
                .font(.headline)
                .foregroundColor(isPositive ? .green : .red)
            
            Spacer()
            
            
            // Day and Date
            VStack(alignment: .trailing) {
                Text(day)
                    .font(.headline)
                Text(date)
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
    TransactionRow(day: "Tuesday", date: "28 Jun 2023", amount: 300, currency: "SAR")
}
