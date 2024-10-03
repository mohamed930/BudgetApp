//
//  MonthYearPickerView.swift
//  BudegetApp
//
//  Created by Mohamed Ali on 29/09/2024.
//

import SwiftUI

struct Result {
    let selectedMonth: Int
    let selectedYear: Int
}

struct MonthYearPickerView: View {
    
    @State private var selectedMonth = Calendar.current.component(.month, from: Date()) // Current month
    @State private var selectedYear = Calendar.current.component(.year, from: Date())   // Current year
    
    let months = Calendar.current.monthSymbols // Array of month names
    let years = Array(2000...2100)             // Range of years to choose from
    
    
    var action: (Result) -> ()
    
    let arabicMonths = [
        "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
        "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
    ]
    
    var body: some View {
        VStack {
            Text("اختر الشهر والسنة")
                .font(.title2)
                .padding(.top, 20)
            
            HStack {
                // Month Picker
                Picker(selection: $selectedMonth, label: Text("Month")) {
                    ForEach(1..<13) { index in
                        Text(months[index - 1]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 150, height: 100)
                .clipped()
                .environment(\.locale, Locale(identifier: "ar"))
                
                // Year Picker
                Picker(selection: $selectedYear, label: Text("Year")) {
                    ForEach(years, id: \.self) { year in
                        Text("\(year)").tag(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 100)
                .clipped()
            }
            .padding()
            
            // Show selected month and year in Arabic
            Text("اخترت: \(arabicMonths[selectedMonth - 1]) \(selectedYear)")
                .font(.headline)
                .padding(.top, 20)
                .environment(\.locale, Locale(identifier: "ar"))
            
            MainButton(buttonTitle: "تأكيد", isEnabled: true) {
                // MARK: - Confirm Button Action
                action(Result(selectedMonth: selectedMonth, selectedYear: selectedYear))
            }
        }
        .padding()
    }
}

#Preview {
    MonthYearPickerView { _ in }
}
