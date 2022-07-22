//
//  RocketsViewModel.swift
//  Rocket
//
//  Created by Adela Mišicáková on 22.07.2022.
//

import Foundation

@MainActor
class RocketsViewModel: ObservableObject {
    
    enum State {
        case na // not available
        case loading
        case success(data: [Rocket])
        case failed(error: Error)
    }
    
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    private let rocketsManager = RocketsManager()
    
    //MARK: - Get array with rockets
    func getRockets() async {
        self.state = .loading
        self.hasError = false
        
        do {
            let rockets = try await rocketsManager.fetchRockets()
            self.state = .success(data: rockets)
            
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
}
