//
//  RocketsManager.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation
import Combine

class RocketsManager: ObservableObject {
    
    var apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() async throws -> [Rocket] {
        return try await apiService.getData()
    }
    
    //MARK: - Fetch Rocket detail from spacexdata
    
    func fetchRocketDetail(rocketName: String) async throws -> Rocket {
        apiService.addToBaseString(query: "/\(rocketName)")
        return try await apiService.getData()
    }
}
