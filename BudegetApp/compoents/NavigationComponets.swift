//
//  NavigationComponets.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 28/09/2024.
//

import SwiftUI

struct NavigationComponets: View {
    
    let title: String
    let action: () -> ()
    
    var body: some View {
        
        VStack(spacing: 8) {
            ZStack {
                Text(title)
                    .setFont(fontName: .mainFontBold, size: 18)
                
                HStack {
                    Button(action: {
                        action()
                    }, label: {
                        Image(.leftActionable)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .disabled(true)
                            .padding()
                    })
                    .frame(width: 70, height: 70)
                    
                    Spacer()
                }
                .padding([.horizontal])
            }
            
            Divider()
                .padding([.bottom],20)
        }
        
        
    }
}

#Preview {
    NavigationComponets(title: "Pick your place", action: {})
}
