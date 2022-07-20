//
//  RocketsManager.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation
import Combine

class RocketsManager: ObservableObject {
    
    @Published var rockets = [Rocket]()
    @Published var isLoading = true
    
    let rocketFetcher = RocketsFetcher()
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() async {
        guard let url = URL(string: "https://api.spacexdata.com/v3/rockets") else {return}
        
        await rocketFetcher.getRockets(url: url)
        
        rocketFetcher.$rockets
            .sink(receiveValue: { [weak self] returnedRockets in
                self?.rockets = returnedRockets
            })
            .store(in: &cancellables)
        
//        do {
//            sleep(2)
//        }
        
        isLoading = false
    }
}

