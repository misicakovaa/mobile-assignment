//
//  RocketLaunchView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import SwiftUI
import CoreMotion

struct RocketLaunchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let rocketName: String
    
    @StateObject var vm: DeviceMotionViewModel
    
    init(rocketName: String) {
        self.rocketName = rocketName
        
        let motionManager = CMMotionManager()
        _vm = StateObject(wrappedValue: DeviceMotionViewModel(motionManager: motionManager))
    }
    
    var body: some View {
        VStack {
            // Launch rocket - change image & text
            if vm.launchRocket {
                Image.ui.flyingRocket
                    .offset(y: -UIScreen.main.bounds.height)
                    .transition(.scale.animation(.default.speed(0.1)))
                
                Text("Launch successfull!")
            } else {
                Image.ui.idleRocket
                
                Text("Move your phone up \nto launch the rocket")
            }
        }
        .animation(.default, value: vm.launchRocket)
        .onAppear {
            vm.startAnalyzing()
        }
        .onDisappear{
            vm.stopAnalyzing()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    vm.stopAnalyzing()
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
