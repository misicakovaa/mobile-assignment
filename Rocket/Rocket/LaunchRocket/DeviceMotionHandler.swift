//
//  DeviceMotionHandler.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import Foundation
import CoreMotion

class DeviceMotionHandler : ObservableObject {
    
    @Published private(set) var pitch: Double
    private let motionManager: CMMotionManager
    
    init(motionManager: CMMotionManager) {
        self.pitch = 0.0
        self.motionManager = motionManager
    }
    
    //MARK: - Start gyroscope
    
    func startGyro() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] motion, error in
            guard let self = self, let motion = motion else { return }
            self.pitch = motion.attitude.pitch
        }
    }
    
    //MARK: - Stop gyroscope
    
    func stopGyro() {
        motionManager.stopDeviceMotionUpdates()
    }
}
