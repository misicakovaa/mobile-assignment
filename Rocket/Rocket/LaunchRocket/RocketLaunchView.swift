//
//  RocketLaunchView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import SwiftUI

struct RocketLaunchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let rocketName: String
    
    @ObservedObject var motionHandler = DeviceMotionHandler()
    
    var body: some View {
        VStack {
            // Launch rocket - change image & text
            if motionHandler.deviceRotationChanged {
                Image("Rocket Flying")
                    .offset(y: -UIScreen.main.bounds.height)
                    .transition(.scale.animation(.default.speed(0.1)))
                
                Text("Launch successfull!")
            } else {
                Image("Rocket Idle")
                Text("Move your phone up \nto launch the rocket")
            }
        }
        .animation(.default, value: motionHandler.deviceRotationChanged)
        .onAppear {
            motionHandler.startGyro()
        }
        .onDisappear{
            motionHandler.stopGyro()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    motionHandler.resetHandler()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text(rocketName)
                    }
                }
            }
            
            // Title = Rocket name
            ToolbarItem(placement: .principal) {
                Text("Launch")
                    .font(.headline)
            }
        }
    }
}
