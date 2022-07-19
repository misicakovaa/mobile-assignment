//
//  RocketsManager.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation

class RocketsManager: ObservableObject {
    
    @Published var rockets = [Rocket]()
    @Published var isLoading = true
    
    private var rocketsFetcher = RocketsFetcher()
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() async {
        let urlString = "https://api.spacexdata.com/v3/rockets"
        self.rockets = await rocketsFetcher.performRequest(urlString: urlString)
        isLoading = false
    }
}
