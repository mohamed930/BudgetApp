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
        return leftToSpend / monthlyBudget
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
                    Text("ما تم صرفه")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("EGP \(Int(monthlyBudget - leftToSpend))")
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
                    // Ensure progress is capped between 0 and 1
                    let validProgress = min(max(progress, 0), 1)
                    let totalWidth = UIScreen.main.bounds.width - 80 // Adjust width based on layout needs
                    
                    // Calculate the orange part of the progress
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 10)
                        .foregroundColor(.orange)
                    
                    // Calculate the blue part of the progress, ensuring it’s never negative
                    if validProgress > 0.3 {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (validProgress - 0.3) * totalWidth, height: 10)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.top, 10)
        }
        .frame(width: UIScreen.main.bounds.width - 70)
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
