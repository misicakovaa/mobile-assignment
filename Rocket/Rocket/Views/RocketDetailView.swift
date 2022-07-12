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
            
            VStack {
                // Overview title
                HStack {
                    Text("Overview")
                        .font(.headline)
                        .padding()
                    
                    Spacer()
                }
                
                // Overview description
                Text(rocket.description)
                    .padding([.leading, .trailing])
            }
            .padding(.bottom)
            
            //MARK: - Parameters section
            
            VStack {
                
                // Parameters title
                HStack {
                    Text("Parameters")
                        .font(.headline)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                // Parameters info
                HStack {
                    ParameterView(name: "height", number: Int(rocket.height.meters), unit: "m")
                        .padding(.leading)
                    
                    Spacer()
                    
                    ParameterView(name: "diameter", number: Int(rocket.diameter.meters), unit: "m")
                    
                    Spacer()
                    
                    ParameterView(name: "mass", number: rocket.mass.kg/1000, unit: "t")
                        .padding(.trailing)
                }
            }
            .padding(.bottom)
            
            //MARK: - First Stage section
            VStack {
                StageView(stage: "First", reusable: rocket.first_stage.reusable, engines: rocket.first_stage.engines, fuelTons: Int(rocket.first_stage.fuel_amount_tons), burnTime: rocket.first_stage.burn_time_sec ?? 0)
                    .padding([.leading, .trailing])
            }
            .padding(.bottom)
            
            //MARK: - Second Stage section
            
            VStack {
                StageView(stage: "Second", reusable: rocket.second_stage.reusable, engines: rocket.second_stage.engines, fuelTons: Int(rocket.second_stage.fuel_amount_tons), burnTime: rocket.second_stage.burn_time_sec ?? 0)
                    .padding([.leading, .trailing])
            }
            .padding(.bottom)
            
            //MARK: - Photos section
            VStack {
                // Photos title
                HStack {
                    Text("Photos")
                        .font(.headline)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                // Images
                if let safeImages = rocket.flickr_images {
                    ForEach(safeImages, id: \.self) { image in
                        
                        AsyncImage(
                            url: URL(string: image),
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .contentShape(RoundedRectangle(cornerRadius: 15))
                            },
                            placeholder: {
                                //Shows progressView while waiting for downloaded image
                                ProgressView()
                            }
                        )
                        .padding([.leading, .trailing, .bottom])
                    }
                    
                }
            }
        }
        .navigationTitle(rocket.rocket_name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Title = Rocket name
            ToolbarItem(placement: .principal) {
                    Text(rocket.rocket_name)
                        .font(.headline)
            }
            
            // Launch button
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RocketLaunchView()) {
                    Text("Launch")
                        .fontWeight(.bold)
                }
            }
        }
    }
}
