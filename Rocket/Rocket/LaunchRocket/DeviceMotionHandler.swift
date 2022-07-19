//
//  DeviceMotionHandler.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import Foundation
import CoreMotion

class DeviceMotionHandler : ObservableObject {
    
    // True when x, y, z values are first data got from gyroscope
    private var isFirstData = true
    private var pitch = 0.0
    private let motionHandler = CMMotionManager()
    
    @Published var deviceRotationChanged = false
    
    //MARK: - Start gyroscope
    
    func startGyro() {
        motionHandler.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] motion, error in
            guard let self = self, let motion = motion else { return }
            
            let pitch = motion.attitude.pitch
            
            // First value from gyroscope
            if self.isFirstData {
                self.pitch = pitch
                self.isFirstData = false
            }
            
            //MARK: - Movement tolerance
            
            // Setting tolerance
            let lowerBound = pitch - 0.5
            let higherBound = pitch + 0.5
            
            // check if new gyroscope data are NOT within the tolerance
            let tolerance = lowerBound...higherBound
            
            if tolerance.contains(self.pitch) == false {
                DispatchQueue.main.sync {
                    self.deviceRotationChanged = true
                }
            }
        }
    }
    
    //MARK: - Stop gyroscope
    
    func stopGyro() {
        motionHandler.stopDeviceMotionUpdates()
        isFirstData = true
    }
    
    //MARK: - Reset handler
    
    func resetHandler() {
        isFirstData = true
        deviceRotationChanged = false
        stopGyro()
    }
}
