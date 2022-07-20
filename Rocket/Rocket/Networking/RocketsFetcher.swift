//
//  RocketsFetcher.swift
//  Rocket
//
//  Created by Adela Mišicáková on 20.07.2022.
//

import Foundation
import Combine

class RocketsFetcher {
    
    @Published var rockets: [Rocket] = []
    
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Fetch rockets data using combine
    
    func getRockets(url: URL) async {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Rocket].self, decoder: JSONDecoder())
            .sink{ (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            } receiveValue: { [weak self] (returnedRockets) in
                self?.rockets = returnedRockets
            }
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
