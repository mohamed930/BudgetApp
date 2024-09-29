//
//  MainButton.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 28/09/2024.
//

import SwiftUI

struct MainButton: View {
    
    @State var buttonTitle: String
    var isEnabled: Bool
    var action: () -> ()

    
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(buttonTitle)
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .foregroundColor(isEnabled ? .white : Color("#c6C6C6"))
                    .padding()
                    .frame(width: screenWidth - 40, height: 48) // Adjust width as needed
                    .background(isEnabled ? Color("#0032Ee") : Color("#f6F6F6")) // Change color based on isEnabled
                    .disabled(!isEnabled)
                    .clipShape(Capsule())
            })
            .disabled(!isEnabled) // Disable button if isEnabled is false
        }
        .frame(width: screenWidth, height: 48)
        .padding()
        
        
        
    }
}

#Preview {
    MainButton(buttonTitle: "Continue",isEnabled: true, action: {})
}
