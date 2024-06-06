//
//  TimerView.swift
//  NutriGenie
//
//  Created by simge on 13.04.2024.
//

import SwiftUI

struct TimerView: View {
    @State private var selectedMinutes = 0
    @State private var timeRemaining = 0
    @State private var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let notificationManager = NotificationManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            LottieView(filename: "Lottie")
                .frame(width:400, height: 240)
            
            Text(timeString(time: timeRemaining))
                .font(.system(size: 48, weight: .bold))
                .frame(minWidth: 150, minHeight: 100)
            
            HStack(spacing: 20) {
                Button("Start") {
                    startTimer()
                }
                .disabled(timerRunning)
                .padding()
                .frame(width: 80, height: 80)
                .background(timerRunning ? Color.gray : Color.black)
                .foregroundColor(.white)
                .clipShape(Circle())
                
                Button("Pause") {
                    pauseTimer()
                }
                .disabled(!timerRunning)
                .padding()
                .frame(width: 80, height: 80)
                .background(timerRunning ? Color.black : Color.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                
                Button("Reset") {
                    resetTimer()
                }
                .padding()
                .frame(width: 80, height: 80)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Circle())
            }
            
            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(1...60, id: \.self) { minute in
                    Text("\(minute) minutes")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: selectedMinutes) { _ in
                timeRemaining = selectedMinutes * 60
            }
        }
        .onAppear {
            notificationManager.requestAuthorization()
        }
        .onReceive(timer) { _ in
            if self.timerRunning && self.timeRemaining > 0 {
                self.timeRemaining -= 1
                if self.timeRemaining == 0 {
                    self.timerRunning = false
                    notificationManager.scheduleNotification(timeInterval: 1, title: "Meal Ready", body: "Meal is ready! Enjoy your meal!")
                }
            }
        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        self.timeRemaining = selectedMinutes * 60
        self.timerRunning = true
    }
    
    func pauseTimer() {
        self.timerRunning = false
    }
    
    func resetTimer() {
        self.timeRemaining = selectedMinutes * 60
        self.timerRunning = false
    }
}

#Preview {
    TimerView()
}

