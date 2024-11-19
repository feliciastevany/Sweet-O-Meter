import SwiftUI

struct ContentView: View {
    // State variables
    @State private var sugarIntake: Int = 0
    @State private var remainingSugar: Int = 50
    @State private var todayEntries: [String] = []
    @State private var sugarGoal: Int = 50
    @State private var selectedFood: String = "Apple"
    
    // Weekly data for graph
    @State private var weeklyIntake: [Int] = [15, 20, 25, 10, 35, 45, 30]
    
    let dayLabels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        ZStack {
            VStack {
                // Fixed Header with Title
                ZStack {
                    Color(hex: "#ff66c4") // Background Color
                        .frame(height: 120)
                    Text("Sweet o' Meter")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                }
                .edgesIgnoringSafeArea(.top) // To make the header go beyond safe area
                
                // ScrollView for the rest of the content
                ScrollView {
                    VStack(spacing: 20) {
                        // Daily Tracker Section with Goal and Progress Bar
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Daily Tracker")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#ff66c4"))
                            
                            HStack {
                                Text("\(sugarIntake) g")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(sugarIntake > sugarGoal ? Color.red : Color(hex: "#ff66c4"))
                                
                                Spacer()
                                
                                Text("Left: \(remainingSugar) g")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.trailing)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                            
                            // Progress Bar
                            ProgressBar(progress: Double(sugarIntake) / Double(sugarGoal))
                                .frame(height: 8)
                                .padding(.top, 10)
                        }
                        .padding(.horizontal)
                        
                        // Weekly Intake Bar Chart
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Weekly Intake")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#ff66c4"))
                            
                            HStack(spacing: 12) {
                                ForEach(weeklyIntake.indices, id: \.self) { index in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(sugarIntake > sugarGoal ? Color.red : Color(hex: "#ff66c4"))
                                            .frame(height: CGFloat(weeklyIntake[index]) * 1.5)
                                        Text(dayLabels[index])
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                        .padding(.horizontal)
                        
                        // Today Entries Section with Food Suggestions
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Today Entries")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#ff66c4"))
                            
                            if todayEntries.isEmpty {
                                Text("No Entries")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .padding()
                            } else {
                                List(todayEntries, id: \.self) { entry in
                                    HStack {
                                        Text(entry)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text("27 g")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(height: 150)
                            }
                            
                            // Predefined food selection for simplicity
                            Picker("Add Food", selection: $selectedFood) {
                                Text("Apple").tag("Apple")
                                Text("Banana").tag("Banana")
                                Text("Orange").tag("Orange")
                                Text("Chocolate").tag("Chocolate")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                            
                            Button(action: addFoodEntry) {
                                Text("Add \(selectedFood) to Today's Entries")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(hex: "#ff66c4"))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: Color(hex: "#ffc1e3").opacity(0.5), radius: 4)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
                .padding(.top, -20) // Remove space after header
            }
            
            .overlay(
               // Floating Add Button
               Button(action: addRandomEntry) {
                   ZStack {
                       Circle()
                           .fill(Color(hex: "#ff66c4"))
                           .frame(width: 64, height: 64)
                           .shadow(color: .gray.opacity(0.3), radius: 6)
                       
                       Image(systemName: "plus")
                           .font(.title)
                           .foregroundColor(.white)
                   }
               }
               
               
               .padding(.bottom, 48) // Halfway touching the navbar
               .padding(.leading, (UIScreen.main.bounds.width - 400) / 2) // Center horizontally
               , alignment: .bottom
           )
            // Fixed Bottom Navbar
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        // Handle Home action
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.pink)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        // Handle Menu action
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.3), radius: 5)
                .padding(.horizontal)
                .frame(height: 80)
            }
        }
        .edgesIgnoringSafeArea(.bottom) // To ensure the navbar goes all the way to the edge
    }
    
    // Helper functions to add food and random entries
    func addFoodEntry() {
        let foodIntake = selectedFood == "Apple" ? 15 : selectedFood == "Banana" ? 25 : selectedFood == "Orange" ? 20 : 35
        todayEntries.append("\(selectedFood) - \(foodIntake) g")
        sugarIntake += foodIntake
        remainingSugar = max(0, remainingSugar - foodIntake)
    }
    
    func addRandomEntry() {
        let randomIntake = Int.random(in: 10...30)
        todayEntries.append("Random Food - \(randomIntake) g")
        sugarIntake += randomIntake
        remainingSugar = max(0, remainingSugar - randomIntake)
    }
}

// Progress Bar view
struct ProgressBar: View {
    var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 8)
            Capsule()
                .fill(Color(hex: "#ff66c4"))
                .frame(width: CGFloat(progress) * UIScreen.main.bounds.width, height: 8)
        }
        .cornerRadius(4)
    }
}

// Custom Hex Color Support
extension Color {
    init(hex: String) {
        var hexString = hex
        if hex.hasPrefix("#") {
            hexString = String(hex.dropFirst()) // Remove the #
        }
        
        let scanner = Scanner(string: hexString)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

#Preview {
    ContentView()
}
