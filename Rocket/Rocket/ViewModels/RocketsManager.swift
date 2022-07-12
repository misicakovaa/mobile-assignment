//
//  RocketsManager.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation

class RocketsManager: ObservableObject {
    
    @Published var rockets = [Rocket]()
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() {
        let urlString = "https://api.spacexdata.com/v3/rockets"
        performRequest(urlString: urlString)
    }
    
    //MARK: - Perform request
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let parsedRockets = self.parseJSON(rocketsData: safeData) {
                        DispatchQueue.main.sync {
                            self.rockets = parsedRockets
                        }
                    }
                }
            }
            task.resume()
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
