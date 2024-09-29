//
//  recietViewComponents.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI

struct recietViewComponents: View {
    
    @Binding var productPrice: Double
    @Binding var deliveryFees: Double
    @Binding var totalPrice: Double
    
    var body: some View {
        
        ZStack {
            Color("#fafafa")
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HStack {
                    
                    Text("EGP \(productPrice.description)")
                        .setFont(fontName: .mainFontBold, size: 14)
                    
                    Spacer()
                    
                    Text("عدد العمليات")
                        .setFont(fontName: .mainFontBold, size: 14)
                        .foregroundStyle(Color("#adadad"))
                    
                } // 1. subTotal price
                
                HStack {
                    
                    Text("EGP \(deliveryFees.description)")
                        .setFont(fontName: .mainFontBold, size: 14)
                    
                    Spacer()
                    
                    Text("مجموع العمليات")
                        .setFont(fontName: .mainFontBold, size: 14)
                        .foregroundStyle(Color("#adadad"))
                    
                } // 2. delivery fees
                
            }
            .padding(.horizontal,22)
            .padding(.vertical,16)
        }
        
    }
}

#Preview {
    
    @State var productPrice = 200.0
    @State var deliveryFees = 35.0
    @State var totalPrice = 235.0
    
    return recietViewComponents(productPrice: $productPrice, deliveryFees: $deliveryFees, totalPrice: $totalPrice)
}
