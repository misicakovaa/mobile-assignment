//
//  RocketsManager.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation
import Combine

class RocketsManager: ObservableObject {
    
    let apiService = ApiService()
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() async throws -> [Rocket] {
        
        let url = URL(string: "https://api.spacexdata.com/v3/rockets")!
        return try await apiService.getData(for: url)
    }
    
    //MARK: - Fetch Rocket detail from spacexdata
    
    func fetchRocketDetail(rocketName: String) async throws -> Rocket {
        let url = URL(string: "https://api.spacexdata.com/v3/rockets/\(rocketName)")!
        return try await apiService.getData(for: url)
    }
}
