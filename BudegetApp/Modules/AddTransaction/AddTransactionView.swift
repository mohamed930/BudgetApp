//
//  AddTransactionView.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 27/09/2024.
//

import SwiftUI

enum TransactionType: String {
    case TransIn
    case TransOut
}

struct AddTransactionView: View {
    
    @State var name: String = ""
    @State var comment: String = ""
    @State var price: String = ""
    @State var type: TransactionType? = nil
    @FocusState var isFocused : Bool
    @State var selectedTransIn: Bool = false
    @State var selectedTransOut: Bool = false
    @State var buttonEnabled: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ScrollView {
                    ZStack {
                        
                        // Detect taps on the background
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                UIApplication.shared.endEditing() // Dismiss keyboard
                            }
                        
                        VStack {
                            
                            VStack(alignment: .trailing) {
                                Text("اسم المعاملة")
                                    .setFont(fontName: .mainFontBold, size: 14)
                                    .padding(.horizontal,10)
                                
                                TextField("", text: $name)
                                    .multilineTextAlignment(.trailing)
                                    .padding(6)
                                    .setFont(fontName: .mainFontBold, size: 16)
                                    .ignoresSafeArea(.keyboard, edges: .bottom)
                                    
                                    .background(RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color("#f6F6F6"), lineWidth: 1))
                                    .focused($isFocused)
                                    .padding(.bottom,30)
                                
                                Text("تفاصيل المعاملة")
                                    .setFont(fontName: .mainFontBold, size: 14)
                                    .padding(.horizontal,10)
                                
                                TextEditor(text: $comment)
                                                .foregroundStyle(.secondary)
                                                .frame(height: 100)
                                                .padding(.horizontal)
                                                .multilineTextAlignment(.trailing)
                                                .background(RoundedRectangle(cornerRadius: 30)
                                                            .stroke(Color("#f6F6F6"), lineWidth: 1))
                                                .focused($isFocused)
                                                .padding(.bottom,30)
                                
                                Text("مبلغ المعاملة")
                                    .setFont(fontName: .mainFontBold, size: 14)
                                    .padding(.horizontal,10)
                                
                                TextField("", text: $price)
                                    .multilineTextAlignment(.trailing)
                                    .padding(6)
                                    .setFont(fontName: .mainFontBold, size: 16)
                                    .keyboardType(.asciiCapableNumberPad)
                                    .background(RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color("#f6F6F6"), lineWidth: 1))
                                    .focused($isFocused)
                                    .padding(.bottom,30)
                                
                                Text("نوع المعاملة")
                                    .setFont(fontName: .mainFontBold, size: 14)
                                    .padding(.horizontal,10)
                                
                                HStack(spacing: 24) {
                                    
                                    // First Component
                                    Button(action: {
                                        print("Button 1 tapped!!")
                                        selectedTransIn  = true
                                        selectedTransOut = false
                                        type = .TransIn
                                    }, label: {
                                        HStack {
                                            Circle()
                                                .stroke(selectedTransIn ? .clear : Color.gray, lineWidth: 2)
                                                .background(Circle().foregroundColor(selectedTransIn ? Color("#0032Ee") : .clear))
                                                .frame(width: 24, height: 24)
                                                .padding(.trailing,10)
                                            
                                            ZStack {
                                                Circle()
                                                    .fill(Color.green.opacity(0.1))
                                                    .frame(width: 40, height: 40)
                                                
                                                Image(systemName: "arrow.down.left")
                                                    .foregroundColor(.green)
                                            }
                                            
                                            Spacer()
                                            
                                            Text("صادر")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(selectedTransIn ? Color("#0032Ee") : Color("#EDEDED"))
                                                .fill(selectedTransIn ? Color("#E6EBFD") : .clear)
                                        )
                                    })
                                    
                                    // Second Component
                                    Button(action: {
                                        print("Button 2 tapped!!")
                                        selectedTransIn  = false
                                        selectedTransOut = true
                                        type = .TransOut
                                    }, label: {
                                        HStack {
                                            Circle()
                                                .stroke(selectedTransOut ? .clear : Color.gray, lineWidth: 2)
                                                .background(Circle().foregroundColor(selectedTransOut ? Color("#0032Ee") : .clear))
                                                .frame(width: 24, height: 24)
                                                .padding(.trailing,10)
                                            
                                            ZStack {
                                                Circle()
                                                    .fill(Color.red.opacity(0.1))
                                                    .frame(width: 40, height: 40)
                                                
                                                Image(systemName: "arrow.up.left")
                                                    .foregroundColor(.red)
                                            }
                                            
                                            Spacer()
                                            
                                            Text("صادر")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(selectedTransOut ? Color("#0032Ee") : Color("#EDEDED"))
                                                .fill(selectedTransOut ? Color("#E6EBFD") : .clear)
                                        )
                                    })
                                    
                                    
                                }
                                .padding(.horizontal,4)
                                
                                
                            }
                            .padding(.horizontal,16)
                            
                            
                            Spacer()
                        }
                    }
                }
                .frame(width: UIScreen.screenWidth)
                
                Spacer()
                
                MainButton(buttonTitle: "حفظ و استمرار", isEnabled: checkButton()) {
                    // MARK: - Save button action
                    
                }
            }
            
            
            
            
        }
        .navigationTitle("اضف معاملة")
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding()
        
    }
    
    private func checkButton() -> Bool {
        return !name.isEmpty && !comment.isEmpty && !price.isEmpty && type != nil
    }
}

#Preview {
    AddTransactionView()
}
