//
//  RocketsListView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import SwiftUI

struct RocketsListView: View {
    
    @StateObject private var rocketsManager = RocketsManager()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.ui.lightGrayList
                
                List(rocketsManager.rockets) { rocket in
                    
                    //MARK: -  Rocket info row containing:
                    // - image
                    // - rocket name
                    // - first flight
                    
                    NavigationLink(destination: RocketDetailView(rocket: rocket)) {
                        RocketRow(
                            rocketName: rocket.rocketName,
                            firstFlight: rocket.firstFlight)
                    }
                }
                .navigationTitle("Rockets")
                
                if rocketsManager.isLoading {
                    ProgressView()
                }
            }
        }
        .task {
            await rocketsManager.fetchRockets()
        }
    }
}

struct RocketsListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketsListView()
    }
}
