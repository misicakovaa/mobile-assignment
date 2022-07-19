//
//  RocketsFetcher.swift
//  Rocket
//
//  Created by Adela Mišicáková on 19.07.2022.
//

import Foundation

class RocketsFetcher {
    
    private var rockets = [Rocket]()
    
    //MARK: - Perform request
    
    @MainActor
    func performRequest(urlString: String) async -> [Rocket] {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            do {
                let (data, _) = try await session.data(from: url)
                try await Task.sleep(nanoseconds: 2000_000_000)
                
                if let parsedRockets = self.parseJSON(rocketsData: data) {
                    self.rockets = parsedRockets
                }
            } catch {
                // handle error
                print("Could not fetch data")
            }
        }
        return self.rockets
    }
    
    //MARK: - Parse JSON
    
    func parseJSON(rocketsData: Data) -> [Rocket]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([Rocket].self, from: rocketsData)
            return decodedData
        } catch {
            print("Could not decode rockets")
            return nil
        }
    }
}
