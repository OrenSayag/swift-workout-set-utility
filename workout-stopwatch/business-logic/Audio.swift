//
//  TimerAudio.swift
//  workout-stopwatch
//
//  Created by Oren Sayag on 11/02/2024.
//

import Foundation
import AVFoundation

enum TimerSounds {
    case done
    
    var resource: String {
        switch self {
        case .done:
            return "chime.mp3"
        }
    }
}

class Audio {
    
    private var _audioPlayer: AVAudioPlayer?
    
    func play(_ sound: TimerSounds) {
        let path = Bundle.main.path(forResource: sound.resource, ofType: nil)!
        let url = URL(filePath: path)
        do {
            _audioPlayer = try AVAudioPlayer(contentsOf: url)
            print("shuold play audio")
            _audioPlayer!.play()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
