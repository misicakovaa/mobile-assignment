//
//  RocketsData.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import Foundation

struct Rocket: Identifiable, Decodable {
    let id: Int
    let rocket_name: String
    let first_flight: String
    let description: String
    
    
    // Parameters
    let height: Height
    let diameter: Diameter
    let mass: Mass
    
    // First Stage
    let first_stage: Stage
    let second_stage: Stage
    
    // Images
    let flickr_images: [String]
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
    let fuel_amount_tons: Double
    let burn_time_sec: Int?
}

