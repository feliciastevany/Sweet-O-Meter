//
//  InputPage.swift
//  Sweet o meter
//
//  Created by MacBook Pro on 26/11/24.
//

import SwiftUI

struct InputPage: View {
    @State private var productName: String = ""
    @State private var sugarWeight: String = ""
    @State private var sugarWeightchoose: Double = 0.0
    let sugarRange: ClosedRange<Double> = 0.0...100.0
    let sugarStep: Double = 1.0
    @State private var isSliderActive: Bool = false

    var body: some View {
        VStack {
            Spacer()
            // Header
            Form {
                VStack {
                    Text("Add Entry")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        .padding(.top, 30)
                    
                    Spacer()
                    // Add product name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Add Product Name")
                            .font(.headline)
                        TextField("Enter your product name", text: $productName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 70)
                    }
                    Spacer()
                    
                    // Sugar Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Add Sugar Weight")
                            .font(.headline)
                        
                        Toggle("Use Slider", isOn: $isSliderActive)
                            .padding()
                        
                        if isSliderActive {
                            Slider(
                                value: $sugarWeightchoose,
                                in: sugarRange,
                                step: sugarStep
                            )
                            .padding()
                            Text("Selected sugar weight: \(String(format: "%.1f", sugarWeightchoose)) g")
                                .padding()

                        } else {
                            TextField("Enter your sugar weight", text: $sugarWeight)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .onChange(of: sugarWeight) { newValue in
                                    if let value = Double(newValue) {
                                        sugarWeightchoose = value
                                    }
                                }
                            
                        }
                    }
                    
                    Spacer()
                    Button(action: {
                        print("Product: \(productName)\nSugar Weight: \(sugarWeight)")
                    }) {
                        Text("Input")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "FF66C4"))
                            .foregroundStyle(.white)
                            .cornerRadius(100)
                    }
                    .padding(.top, 20)
                    Spacer()
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationTitle("Sweet O'Meter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.currentIndex = scanner.string.startIndex
//        var rgb: UInt64 = 0
//        scanner.scanHexInt64(&rgb)
//
//        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
//        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
//        let blue = Double(rgb & 0x0000FF) / 255.0
//
//        self.init(red: red, green: green, blue: blue)
//    }
//}

#Preview {
    InputPage()
}
