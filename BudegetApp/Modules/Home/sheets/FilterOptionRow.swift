//
//  FilterOptionRow.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 29/09/2024.
//

import SwiftUI

struct FilterOptionRow: View {
    let text: String
    let icon: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(text)
                .font(.headline)
                .foregroundColor(.black)
            
            Image(icon)
                .foregroundColor(.black)
                .padding()
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    FilterOptionRow(text: "الصادر", icon: "TransOut")
}
