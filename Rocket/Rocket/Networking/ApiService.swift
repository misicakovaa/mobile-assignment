//
//  ApiService.swift
//  Rocket
//
//  Created by Adela Mišicáková on 22.07.2022.
//

import Foundation

struct ApiService {
    
    enum URLError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    
    //MARK: - Get data from URL
    func getData<T: Decodable>(for url: URL) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        /*
         // TEST - WITHOUT INTERNET CONNECTION
         
         let configuration = URLSessionConfiguration.ephemeral
         let (data, response) = try await URLSession(configuration: configuration).data(from: url)
         */
        
        // Check response
        try checkResponse(response: response)
        
        // Check decoded data
        let result = try parseJSON(type: T.self, data: data)
        return result
    }
    
    //MARK: - Check response
    
    func checkResponse(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError.invalidStatusCode
        }
    }
    
    //MARK: - Parse JSON
    
    func parseJSON<T: Decodable>(type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw URLError.failedToDecode
        }
    }
}
