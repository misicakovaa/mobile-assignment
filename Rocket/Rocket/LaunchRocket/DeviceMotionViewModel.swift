//
//  DeviceMotionViewModel.swift
//  Rocket
//
//  Created by Adela Mišicáková on 25.07.2022.
//

import Foundation
import SwiftUI
import Combine
import CoreMotion

class DeviceMotionViewModel: ObservableObject {
    
    // True when x, y, z values are first data got from gyroscope
    private var isFirstData: Bool
    private var pitch: Double
    private var cancellable: Set<AnyCancellable>
    
    @Published private(set) var launchRocket: Bool
    @ObservedObject private var motionHandler: DeviceMotionHandler
    
    init(motionManager: CMMotionManager) {
        self.isFirstData = true
        self.pitch = 0.0
        self.cancellable = Set<AnyCancellable>()
        self.launchRocket = false
        self.motionHandler = DeviceMotionHandler(motionManager: motionManager)
    }
    
    //MARK: - Start analyzing
    
    func startAnalyzing() {
        motionHandler.startGyro()
        
        motionHandler.$pitch
            .map { (pitch) -> Bool in
                
                if self.isFirstData && pitch != 0.0 {
                    self.pitch = pitch
                    self.isFirstData = false
                    return false
                }
                
                //MARK: - Movement tolerance
                
                // Setting tolerance
                let lowerBound = pitch - 0.5
                let higherBound = pitch + 0.5
                
                // check if new gyroscope data are NOT within the tolerance
                let tolerance = lowerBound...higherBound
                
                if tolerance.contains(self.pitch) == false {
                    self.stopAnalyzing()
                    return true
                }
                return false
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.launchRocket, on: self)
            .store(in: &cancellable)
    }
    
    //MARK: - Stop analyzing
    
    func stopAnalyzing() {
        isFirstData = true
        DispatchQueue.main.async {
            self.launchRocket = true
        }
        motionHandler.stopGyro()
    }
}
