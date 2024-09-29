//
//  HomeView.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI
import FittedSheetsSwiftUI

struct HomeView: View {
    
    @State var productPrice = 200.0
    @State var deliveryFees = 35.0
    @State var totalPrice = 235.0
    
    
    @State var buttonSheet: Bool = false
    @State var dateSheet: Bool = false
    
    // MARK: - Configure Detail FittedSheets Settings
    @State var sheetConfiguration = SheetConfiguration(sizes: [.intrinsic], // .fixed(290)
                                                options: .init(pullBarHeight: 20),
                                                sheetViewControllerOptinos: [.allowPullingPastMaxHeight(false)],
                                                shouldDismiss: nil,
                                                didDismiss: nil)
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                    Text("الواجهة الرئيسية")
                        .font(.system(size: 22,weight: .bold))
                        .padding(.bottom,34)
                    
                    HStack {
                        
                        Spacer()
                        
                        NavigationLink {
                            AddTransactionView()
                        } label: {
                            Image(systemName: "note.text.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .disabled(true)
                                .padding()
                                .foregroundStyle(Color("#0032Ee"))
                            
                        } 
                    }
                    .padding([.horizontal],0)
                    .padding(.top,-30)
                }
                
                
                HStack(spacing: 3) {
                    let date = Date()
                    
                    Text("\(date.month),")
                        .font(.system(size: 14))
                        .disabled(true)
                    
                    Text("\(date.year)")
                        .font(.system(size: 14))
                        .disabled(true)
                        
                    Image(.arrowDown)
                        .disabled(true)
                    
                }
                .foregroundStyle(Color("#67677A"))
                .onTapGesture {
                    // MARK: - Button sheet.
                    dateSheet = true
                    buttonSheet = true
                    
                }
                
                Text("EGP 1300")
                    .setFont(fontName: .mainFontBold, size: 34)
                    .foregroundStyle(Color("#303048"))
                
                BudgetView(leftToSpend: 738, monthlyBudget: 2550)
                
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        // Filter Button.
                        Button(action: {
                            // MARK: - Filter button action.
                            buttonSheet = true
                            dateSheet = false
                        }, label: {
                            HStack(spacing: 8) {
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                
                                Text("تصفية")
                                    .font(.body)
                                    .foregroundColor(.black)
                                
                                Image(.filter)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("#f6F6F6"), lineWidth: 1)
                            )
                        })
                        
                        Spacer()
                        
                        Text("اخر العمليات")
                            .setFont(fontName: .mainFontBold, size: 19)
                    }
                    .padding(.horizontal,18)
                    
                    
                    ScrollView {
                        
                        ForEach(0..<3) { _ in
                            VStack(spacing: 20) {
                                TransactionRow(day: "Tuesday", date: "28 Jun 2023", amount: 300, currency: "EGP")
                            }
                        }
                    }
                    
                }
       
                
                Spacer()
                
                recietViewComponents(productPrice: $productPrice, deliveryFees: $deliveryFees, totalPrice: $totalPrice)
                    .frame(height: 90)
                
                
            }
            .padding()
            .fittedSheet(isPresented: $buttonSheet,
                         configuration: sheetConfiguration,
                         sheetView: {
                
                if dateSheet {
                    MonthYearPickerView()
                }
                else {
                    FilterButtonSheet { response in
                        buttonSheet = false
                    }
                }
                
                
                
                
            }, animated: false)
        }
    }
}

#Preview {
    HomeView()
}
