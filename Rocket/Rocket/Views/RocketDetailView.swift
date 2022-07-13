//
//  RocketDetailView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import SwiftUI

struct RocketDetailView: View {
    
    var rocket: Rocket
    
    var body: some View {
        
        ScrollView {
            
            //MARK: - Overview section
            
            OverviewSectionView(description: rocket.description)
                .padding(.bottom)
            
            //MARK: - Parameters section
            
            ParametersSectionView(height: rocket.height.meters, diameter: rocket.diameter.meters, mass: rocket.mass.kg)
                .padding(.bottom)
            
            //MARK: - First Stage section
            
            StageView(stage: "First", reusable: rocket.first_stage.reusable, engines: rocket.first_stage.engines, fuelTons: Int(rocket.first_stage.fuel_amount_tons), burnTime: rocket.first_stage.burn_time_sec ?? 0)
                .padding([.leading, .trailing, .bottom])
            
            
            //MARK: - Second Stage section
            
            StageView(stage: "Second", reusable: rocket.second_stage.reusable, engines: rocket.second_stage.engines, fuelTons: Int(rocket.second_stage.fuel_amount_tons), burnTime: rocket.second_stage.burn_time_sec ?? 0)
                .padding([.leading, .trailing, .bottom])
            
            
            //MARK: - Photos section
            
            PhotosSectionView(images: rocket.flickr_images)
        }
        .navigationTitle(rocket.rocket_name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Title <- Rocket name
            ToolbarItem(placement: .principal) {
                Text(rocket.rocket_name)
                    .font(.headline)
            }
            
            // Launch button
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RocketLaunchView(rocketName: rocket.rocket_name)) {
                    Text("Launch")
                        .fontWeight(.bold)
                }
            }
        }
    }
}
