//
//  ContentView.swift
//  workout-stopwatch
//
//  Created by Oren Sayag on 10/02/2024.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            NotificationDemo()
            StopwatchDemo()
            Counter()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
