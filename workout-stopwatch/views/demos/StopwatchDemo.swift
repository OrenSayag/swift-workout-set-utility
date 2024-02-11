//
//  StopwatchDemo.swift
//  workout-stopwatch
//
//  Created by Oren Sayag on 11/02/2024.
//

import SwiftUI

struct StopwatchDemo: View {
    var audioPlayer = Audio()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Stopwatch (
            cb: {
                audioPlayer.play(
                    TimerSounds.done
                )
                
            },
            limit: 55
        )
    }
}

struct StopwatchDemo_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchDemo()
    }
}
