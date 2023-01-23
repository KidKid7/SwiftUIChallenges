//
//  BetterRest.swift
//  Challenges
//
//  Created by Kid Kid on 1/22/23.
//

import CoreML
import SwiftUI

struct BetterRest: View {
    @State private var wakeupTime = defaultWakeup
    @State private var desiredTime = 8.0
    @State private var coffeeIntake = 1
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    private static var defaultWakeup: Date {
        var component = DateComponents()
        component.hour = 8
        component.minute = 0
        
        return Calendar.current.date(from: component) ?? Date.now
    }
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
        
            Form {
                VStack {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Select time to wake up",
                               selection: $wakeupTime,
                               displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                .applyBackground()
                
                VStack {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(desiredTime.formatted()) hours", value: $desiredTime, in: 4...12, step: 0.25)
                        .padding(.horizontal, 20)
                }
                .applyBackground()
                
                VStack {
                    Text("Desired coffee intake")
                        .font(.headline)
                    Stepper("\(coffeeIntake) \(coffeeIntake == 1 ? "cup" : "cups")", value: $coffeeIntake, in: 1...10, step: 1)
                        .padding(.horizontal, 20)
                }
                .applyBackground()
            }
            .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("BetterRest")
        .toolbar {
            Button("Calculate", action: calculateBedTime)
        }
    }
    
    func calculateBedTime() {
        do {
            
            // Currently below warning is showing up but it works correctly.
            // [coreml] Failed to get the home directory when checking model path.
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
            let hours = (component.hour ?? 0) * 60 * 60
            let minutes = (component.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hours + minutes),
                                                  estimatedSleep: Double(desiredTime),
                                                  coffee: Double(coffeeIntake))
            
            let timeToSleep = wakeupTime - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = timeToSleep.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error!"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct BetterRest_Previews: PreviewProvider {
    static var previews: some View {
        BetterRest()
    }
}

private struct VStackModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

fileprivate extension View {
    func applyBackground() -> some View {
        modifier(VStackModifier())
    }
}
