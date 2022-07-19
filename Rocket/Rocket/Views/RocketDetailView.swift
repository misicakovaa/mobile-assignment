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
            
            StageView(stage: "First", reusable: rocket.firstStage.reusable, engines: rocket.firstStage.engines, fuelTons: Int(rocket.firstStage.fuel), burnTime: rocket.firstStage.burnTime ?? 0)
                .padding([.leading, .trailing, .bottom])
            
            
            //MARK: - Second Stage section
            
            StageView(stage: "Second", reusable: rocket.secondStage.reusable, engines: rocket.secondStage.engines, fuelTons: Int(rocket.firstStage.fuel), burnTime: rocket.secondStage.burnTime ?? 0)
                .padding([.leading, .trailing, .bottom])
            
            
            //MARK: - Photos section
            
            PhotosSectionView(images: rocket.flickrImages)
        }
        .navigationTitle(rocket.rocketName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Title <- Rocket name
            ToolbarItem(placement: .principal) {
                Text(rocket.rocketName)
                    .font(.headline)
            }
            
            // Launch button
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RocketLaunchView(rocketName: rocket.rocketName)) {
                    Text("Launch")
                        .fontWeight(.bold)
                }
            }
        }
    }
}
