//
//  Counter.swift
//  workout-stopwatch
//
//  Created by Oren Sayag on 11/02/2024.
//

import SwiftUI

struct Counter: View {
    @State private var _count = 0
    
    var body: some View {
        HStack(spacing: 50) {
            Button("-") { if _count > 0 {_count-=1} }.font(Font.system(size: 50))
            Text(String(_count)).font(Font.system(size: 50))
            Button("+") { _count+=1 }.font(Font.system(size: 50))
        }
    }
}

struct CounterDemo_Preview: PreviewProvider {
    static var previews: some View {
        Counter()
    }
}
