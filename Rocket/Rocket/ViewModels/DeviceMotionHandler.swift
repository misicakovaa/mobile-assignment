//
//  DeviceMotionHandler.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import Foundation
import CoreMotion

class DeviceMotionHandler : ObservableObject {
    
    @Published var deviceRotationChanged = false
    
    // True when x, y, z values are first data got from gyroscope
    var isFirstData = true
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    let motionHandler = CMMotionManager()
    
    func startGyro() {
        motionHandler.startGyroUpdates()
        motionHandler.gyroUpdateInterval = 3
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let gyroData = self.motionHandler.gyroData {
                
                let gyroX = round(gyroData.rotationRate.x*10)/10
                let gyroY = round(gyroData.rotationRate.y*10)/10
                let gyroZ = round(gyroData.rotationRate.z*10)/10
                
                // first data from gyroscope
                if self.isFirstData {
                    self.x = gyroX
                    self.y = gyroY
                    self.z = gyroZ
                    self.isFirstData = false
                }
                
                // check if new gyro data are different
                if self.x != gyroX
                    || self.y != gyroY
                    || self.z != gyroZ {
                    
                    self.deviceRotationChanged = true
                }
            }
        }
    }
    
    func stopGyro() {
        motionHandler.stopGyroUpdates()
        isFirstData = true
    }
}
