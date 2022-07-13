//
//  RocketsManager.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation

class RocketsManager: ObservableObject {
    
    @Published var rockets = [Rocket]()
    @Published var isLoading = false
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() async {
        let urlString = "https://api.spacexdata.com/v3/rockets"
        await performRequest(urlString: urlString)
    }
    
    //MARK: - Perform request
    
    @MainActor
    func performRequest(urlString: String) async {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            isLoading = true
            
            Task {
                do {
                    let (data, _) = try await session.data(from: url)
                    try await Task.sleep(nanoseconds: 2000_000_000) // TODO: delete
                    
                    if let parsedRockets = self.parseJSON(rocketsData: data) {
                        isLoading = false
                        self.rockets = parsedRockets
                    }
                } catch {
                    // handle error
                    print(error)
                }
            }
        }
    }
    
    //MARK: - Parse JSON
    
    func parseJSON(rocketsData: Data) -> [Rocket]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([Rocket].self, from: rocketsData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
