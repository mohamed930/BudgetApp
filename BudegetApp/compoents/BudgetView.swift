//
//  BudgetView.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI

struct BudgetView: View {
    var leftToSpend: Double
    var monthlyBudget: Double
    
    var progress: Double {
        return (monthlyBudget - leftToSpend) / monthlyBudget
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Text("متبقي لك")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("EGP \(Int(leftToSpend))")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("الميزانية الشهرية")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("EGP \(Int(monthlyBudget))")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
            
            // Progress Bar
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 10)
                    .foregroundColor(.gray.opacity(0.2))
                
                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: (progress * UIScreen.main.bounds.width - 80), height: 10)
                        .foregroundColor(.orange)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: ((progress - 0.3) * UIScreen.main.bounds.width - 40), height: 10)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 10)
        }
        .frame(width: UIScreen.screenWidth - 70)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        )
        .padding()
    }
}

#Preview {
    BudgetView(leftToSpend: 738, monthlyBudget: 2550)
}
