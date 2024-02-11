//
//  AudioPlayerDemo.swift
//  workout-stopwatch
//
//  Created by Oren Sayag on 11/02/2024.
//

import SwiftUI

struct AudioPlayerDemo: View {
    var audioPlayer = Audio()
    var body: some View {
        Button("Play Done") {
            audioPlayer.play(.done)
        }
    }
}

struct AudioPlayerDemo_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerDemo()
    }
}
