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
    
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Fetch rockets from spacexdata
    
    func fetchRockets() async {
        guard let url = URL(string: "https://api.spacexdata.com/v3/rockets") else {return}
        await getRockets(url: url)
        isLoading = false
    }
    
    //MARK: - Fetch rockets data using combine
    
    private func getRockets(url: URL) async {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Rocket].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedRockets) in
                self?.rockets = returnedRockets
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Handle DataTaskPublisher output
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

