//
//  RocketLaunchView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import SwiftUI

struct RocketLaunchView: View {
    
    @State var launchRocket = false
    @ObservedObject var motionHandler = DeviceMotionHandler()
    
    var body: some View {
        VStack {
            
            if motionHandler.deviceRotationChanged == true {
                Image("Rocket Flying")
                Text("Launch successfull!")
            } else {
                Image("Rocket Idle")
                Text("Move your phone up \nto launch the rocket")
            }
        }
        .toolbar {
            // Title = Rocket name
            ToolbarItem(placement: .principal) {
                Text("Launch")
                    .font(.headline)
            }
        }
        .onAppear {
            motionHandler.startGyro()
        }
        .onDisappear {
            motionHandler.stopGyro()
        }
    }
}

struct RocketLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        RocketLaunchView()
    }
}
