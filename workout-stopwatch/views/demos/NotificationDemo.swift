//
//  NotificationDemo.swift
//  workout-stopwatch
//
//  Created by Oren Sayag on 11/02/2024.
//

import SwiftUI

struct NotificationDemo: View {
    @State private var showWarning = false
    @Environment (\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
//            Button("Send notification") {
//                Notifications.scheduleNotification(seconds: 5, title: "test title", body: "test body")
//            }
            
            if showWarning {
                VStack {
                    Text("Notifications are disabled")
                    Button("Enable") {
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                        
                    }
                }
            }
        }
        .onChange(of: scenePhase) { scenePhase in
            if(scenePhase == .active){
                Notifications.checkAuthorization { authorized in
                    showWarning = !authorized
                }
            }
        }
    }
}

struct NotificationDemo_Previews: PreviewProvider {
    static var previews: some View {
        NotificationDemo()
    }
}
