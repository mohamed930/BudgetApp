//
//  HomeView.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI
import FittedSheetsSwiftUI
import CoreData

struct HomeView: View {
    
    // MARK: - Configure Detail FittedSheets Settings
    @State var sheetConfiguration = SheetConfiguration(sizes: [.intrinsic], // .fixed(290)
                                                options: .init(pullBarHeight: 20),
                                                sheetViewControllerOptinos: [.allowPullingPastMaxHeight(false)],
                                                shouldDismiss: nil,
                                                didDismiss: nil)
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var transaction: FetchedResults<Transaction>
    @StateObject var viewmodel = HomeViewModel()
    
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
                            AddTransactionView(viewmodel: AddTransactionViewModel(moc: moc, boxMoney: viewmodel.remainPrice,edit: false))
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
                    viewmodel.dateSheet = true
                    viewmodel.buttonSheet = true
                    
                }
                
                Text("EGP \(viewmodel.sumTransActionPrice.description)")
                    .setFont(fontName: .mainFontBold, size: 34)
                    .foregroundStyle(Color("#303048"))
                
                BudgetView(leftToSpend: viewmodel.remainPrice, monthlyBudget: viewmodel.sumTransActionPrice)
                
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        // Filter Button.
                        Button(action: {
                            // MARK: - Filter button action.
                            viewmodel.buttonSheet = true
                            viewmodel.dateSheet = false
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
                        
                        ForEach(0..<viewmodel.data.count, id: \.self) { index in
                            VStack(spacing: 20) {
                                TransactionRow(model: $viewmodel.data[index])
                                    .onTapGesture {
                                        viewmodel.selectedTransaction(index: index)
                                    }
                            }
                        }
                    }
                    
                    NavigationLink("", destination: AddTransactionView(viewmodel: AddTransactionViewModel(moc: moc, boxMoney: viewmodel.remainPrice, edit: true,pickedData: viewmodel.pickedRow)), isActive: $viewmodel.moveToEdit)
                    
                }
       
                
                Spacer()
                
                recietViewComponents(countOfTranaction: $viewmodel.countOfTranaction, transActionTotalPrice: $viewmodel.transActionTotalPrice)
                    .frame(height: 90)
                
                
            }
            .padding()
            .onAppear {
                let request = Transaction.fetchRequest()
                let transactions = try? moc.fetch(request)
                viewmodel.transaction = transactions
                viewmodel.renderData()
            }
            .fittedSheet(isPresented: $viewmodel.buttonSheet,
                         configuration: sheetConfiguration,
                         sheetView: {
                
                if viewmodel.dateSheet {
                    MonthYearPickerView()
                }
                else {
                    FilterButtonSheet { response in
                        viewmodel.buttonSheet = false
                        
                        guard let response else { viewmodel.renderData()
                            return
                        }
                        
                        if response {
                            viewmodel.renderData(type: .TransOut)
                        }
                        else {
                            viewmodel.renderData(type: .TransIn)
                        }
                    }
                }
                
            }, animated: false)
        }
    }
}

#Preview {
    HomeView()
}
