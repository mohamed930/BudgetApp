//
//  FilterButtonSheet.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 29/09/2024.
//

import SwiftUI

struct FilterButtonSheet: View {
    
    var filterAction: (Bool?) -> ()
    
    var body: some View {
        VStack {
                    
            // Header Section
            ZStack {
                Text("تصفية")
                    .font(.title2)
                    .fontWeight(.medium)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Action for closing the filter
                        filterAction(nil)
                        
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(.trailing)
                    }
                }
                .padding(.trailing,16)
            }
            .padding(.top)
            
            Divider()
            
            // Filter Options
            VStack(spacing: 0) {
                FilterOptionRow(text: "الصادر", icon: "TransOut")
                    .onTapGesture {
                        filterAction(true)
                    }
                
                FilterOptionRow(text: "الوارد", icon: "TransIn")
                    .onTapGesture {
                        filterAction(false)
                    }
            }
            .padding(.top, 10)
        }
        .background(Color.white)
    }
}

#Preview {
    FilterButtonSheet { _ in }
}
