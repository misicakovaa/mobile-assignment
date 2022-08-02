//
//  RocketsViewModel.swift
//  Rocket
//
//  Created by Adela Mišicáková on 22.07.2022.
//

import Foundation

enum State<Value, Error> {
    case na // not available
    case loading
    case success(data: Value)
    case failed(error: Error)
}

@MainActor
class RocketsViewModel: ObservableObject {
    
    @Published private(set) var state: State<[Rocket], ApiService.URLError>
    @Published var hasError: Bool
    
    private let rocketsManager: RocketsManager
    
    init(apiService: ApiService) {
        self.state = .na
        self.hasError = false
        self.rocketsManager = RocketsManager(apiService: apiService)
    }
    
    //MARK: - Get array with rockets
    func getRockets() async {
        self.state = .loading
        self.hasError = false
        
        do {
            let rockets = try await rocketsManager.fetchRockets()
            self.state = .success(data: rockets)
        } catch {
            self.state = .failed(error: error as? ApiService.URLError ?? .failed)
            self.hasError = true
            
        }
    }
}
