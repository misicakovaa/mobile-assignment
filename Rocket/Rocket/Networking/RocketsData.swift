//
//  RocketsData.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation

struct Rocket: Identifiable, Decodable {
    let id: Int
    let rocketName: String
    let firstFlight: String
    let description: String
    
    
    // Parameters
    let height: Height
    let diameter: Diameter
    let mass: Mass
    
    // First Stage
    let firstStage: Stage
    let secondStage: Stage
    
    // Images
    let flickrImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case rocketName     = "rocket_name"
        case firstFlight    = "first_flight"
        case firstStage     = "first_stage"
        case secondStage    = "second_stage"
        case flickrImages   = "flickr_images"
        
        case id
        case description
        case height
        case diameter
        case mass
    }
}

//MARK: - Parameters

struct Height: Decodable {
    let meters: Double
}

struct Diameter: Decodable {
    let meters: Double
}

struct Mass: Decodable {
    let kg: Int
}

//MARK: - Stage

struct Stage: Decodable {
    let reusable: Bool
    let engines: Int
    let fuel: Double
    let burnTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case burnTime   = "burn_time_sec"
        case fuel       = "fuel_amount_tons"
        
        case reusable
        case engines
    }
}

