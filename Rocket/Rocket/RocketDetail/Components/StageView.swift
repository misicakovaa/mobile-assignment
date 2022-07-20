//
//  StageView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 12.07.2022.
//

import SwiftUI

struct StageView: View {
    
    let stage: String
    let reusable: Bool
    let engines: Int
    let fuelTons: Int
    let burnTime: Int
    
    var body: some View {
        
        ZStack {
            Color.ui.grayStageBackground
            
            VStack(alignment: .leading) {
                
                //MARK: - Stage title
                
                Text("\(stage) Stage")
                    .font(.headline)
                    .foregroundColor(Color.ui.stagesColor)
                
                
                //MARK: - Reusable
                
                HStack {
                    Image.ui.reusable
                    
                    if reusable {
                        Text("reusable")
                            .foregroundColor(Color.ui.stagesColor)
                    } else {
                        Text("not reusable")
                            .foregroundColor(Color.ui.stagesColor)
                    }
                    
                    Spacer()
                }
                
                //MARK: - Engine
                
                HStack {
                    Image.ui.engine
                    
                    if engines == 1 {
                        Text("\(engines) engine")
                            .foregroundColor(Color.ui.stagesColor)
                    } else {
                        Text("\(engines) engines")
                            .foregroundColor(Color.ui.stagesColor)
                    }
                    
                    Spacer()
                }
                
                //MARK: - Fuel
                
                HStack {
                    Image.ui.fuel
                    
                    Text("\(fuelTons) tons of fuel")
                        .foregroundColor(Color.ui.stagesColor)
                    
                    Spacer()
                }
                
                //MARK: - Burn
                
                HStack {
                    Image.ui.burn
                    
                    Text("\(burnTime) seconds burn time")
                        .foregroundColor(Color.ui.stagesColor)
                    
                    Spacer()
                }
            }
            .padding()
        }
        .cornerRadius(20)
    }
}
