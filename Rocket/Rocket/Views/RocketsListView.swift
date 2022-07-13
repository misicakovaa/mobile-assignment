//
//  RocketsListView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import SwiftUI

struct RocketsListView: View {
    
    @ObservedObject private var rocketsManager = RocketsManager()
    
    //MARK: - Formate dateString
    // - Formates dateString in format yyyy-MM-dd to d.M.yyyy
    // - Returns formatted dateString
    
    func formateDateString (dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        let date = inputDateFormatter.date(from: dateString)!
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d.M.yyyy"
        
        return outputDateFormatter.string(from: date)
    }
    
    var body: some View {
        
        ZStack {
            NavigationView {
                ZStack {
                    
                    Color.ui.lightGrayList
                    
                    List(rocketsManager.rockets) { rocket in
                        
                        //MARK: -  Rocket info item containing:
                        // - image
                        // - rocket name
                        // - first flight
                        
                        NavigationLink(destination: RocketDetailView(rocket: rocket)) {
                            
                            HStack {
                                // Rocket image
                                Image("Rocket")
                                    .padding(.trailing, 10)
                                
                                // Rocket name and first flight
                                VStack (alignment: .leading) {
                                    Text(rocket.rocket_name)
                                        .font(.headline)
                                    
                                    let formattedFirstFlight = formateDateString(dateString: rocket.first_flight)
                                    
                                    Text("First flight: \(formattedFirstFlight)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding([.top, .bottom], 10)
                        }
                    }
                    .navigationTitle("Rockets")
                    
                    if rocketsManager.isLoading {
                        ProgressView()
                    }
                }
            }
        }
        .task {
            await rocketsManager.fetchRockets()
        }
    }
}
