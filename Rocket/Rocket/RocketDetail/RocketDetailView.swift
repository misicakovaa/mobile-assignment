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
            
            TitledSection(title: "Overview") {
                Text(rocket.description)
                    .padding([.leading, .trailing])
            }
            
            //MARK: - Parameters section
            
            TitledSection(title: "Parameters") {
                
                ParametersSectionView(
                    height: rocket.height.meters,
                    diameter: rocket.diameter.meters,
                    mass: rocket.mass.kg)
                .padding(.bottom)
            }
            
            //MARK: - First Stage section
            
            StageView(
                stage: "First",
                reusable: rocket.firstStage.reusable,
                engines: rocket.firstStage.engines,
                fuelTons: Int(rocket.firstStage.fuel),
                burnTime: rocket.firstStage.burnTime ?? 0)
            .padding([.leading, .trailing, .bottom])
            
            
            
            //MARK: - Second Stage section
            
            StageView(
                stage: "Second",
                reusable: rocket.secondStage.reusable,
                engines: rocket.secondStage.engines,
                fuelTons: Int(rocket.firstStage.fuel),
                burnTime: rocket.secondStage.burnTime ?? 0)
            .padding([.leading, .trailing, .bottom])
            
            
            
            //MARK: - Photos section
            
            TitledSection(title: "Photos") {
                PhotosSectionView(images: rocket.flickrImages)
            }
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

struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RocketDetailView(rocket: Rocket(
            id: 1,
            rocketName: "Falcon 999",
            firstFlight: "13.13.2033",
            description: "Falcon 999 is awesome rocket.",
            height: Height(meters: 0),
            diameter: Diameter(meters: 0),
            mass: Mass(kg: 0),
            firstStage: Stage(
                reusable: true,
                engines: 0,
                fuel: 0,
                burnTime: 0),
            secondStage: Stage(
                reusable: false,
                engines: 0,
                fuel: 0,
                burnTime: 0),
            flickrImages: [
                "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg",
                "https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg"
            ]))
    }
}
