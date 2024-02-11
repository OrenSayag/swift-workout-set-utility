//
//  Stopwatch.swift
//  StandApp
//
//  Created by Serafín Ennes Moscoso on 28/04/2021.
//  Edited by Oren Sayag on 11/02/2024

import SwiftUI

struct Stopwatch: View {

    /// Current progress time expresed in ms
    @State private var progressTime = 0
    @State private var isRunning = false
    @State private var startDate: Date?;
    @State private var cbCalled: Bool = false;
    
    // limit in seconds will execute callback when seconds elapsed
    private var cb: ()->Void
    private var limit: Int

    /// Computed properties to get the progressTime in hh:mm:ss format
    var minutes: Int {
        ((progressTime / 1000) % 3600) / 60
    }

    var seconds: Int {
        (progressTime / 1000) % 60
    }
    
    var ms: Int {
        progressTime % 1000
    }
    
    init(cb: @escaping () -> Void, limit: Int) {
           self.cb = cb
           self.limit = limit
       }

    /// Increase progressTime each second
    @State private var timer: Timer?

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                StopwatchUnit(timeUnit: minutes, timeUnitText: "MIN", color: Color.red)
                Text(":")
                    .font(.system(size: 48))
                    .offset(y: -18)
                StopwatchUnit(timeUnit: seconds, timeUnitText: "SEC", color: Color.blue)
                Text(":")
                    .font(.system(size: 48))
                    .offset(y: -18)
                StopwatchUnit(timeUnit: ms, timeUnitText: "MS", color: Color.green)
            }

            HStack {
                Button(action: {
                    if isRunning{
                        timer?.invalidate()
                        startDate = nil
                        cbCalled = false
                    } else {
                        startDate = Date()
                        Notifications.scheduleNotification(seconds: TimeInterval(limit), title: "Limit reached", body: "Another set!")
                        timer = Timer.scheduledTimer(withTimeInterval: 1/1000, repeats: true, block: { _ in
                            let secondsSince = Date.now.timeIntervalSince(startDate!)
                            progressTime = Int(secondsSince * 1000)
                            if (Int(secondsSince) == limit && !cbCalled) {
                                cb()
                                cbCalled = true
                            }
                        })
                    }
                    isRunning.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 120, height: 50, alignment: .center)
                            .foregroundColor(isRunning ? Color.pink : Color.green)

                        Text(isRunning ? "Stop" : "Start")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }

                Button(action: {
                    progressTime = 0
                    startDate = Date()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 120, height: 50, alignment: .center)
                            .foregroundColor(.gray)

                        Text("Reset")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}


struct StopwatchUnit: View {

    var timeUnit: Int
    var timeUnitText: String
    var color: Color

    /// Time unit expressed as String.
    /// - Includes "0" as prefix if this is less than 10.
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .fill(color)
                    .frame(width: 75, height: 75, alignment: .center)

                HStack(spacing: 2) {
                    Text(timeUnitStr.substring(index: 0))
                        .font(.system(size: 48))
                        .frame(width: 28)
                    Text(timeUnitStr.substring(index: 1))
                        .font(.system(size: 48))
                        .frame(width: 28)
                }
            }

            Text(timeUnitText)
                .font(.system(size: 16))
        }
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}
