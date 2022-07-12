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
            Color.ui.lightGrayStage
            
            VStack {
                
                //MARK: - Stage title
                
                HStack {
                    Text("\(stage) Stage")
                        .font(.headline)
                    
                    Spacer()
                }
                
                //MARK: - Reusable
                HStack {
                    Image("Reusable")
                    
                    if reusable == true {
                        Text("reusable")
                    } else {
                        Text("not reusable")
                    }
                    
                    Spacer()
                }
                
                //MARK: - Engine
                HStack {
                    Image("Engine")
                    
                    if engines == 1 {
                        Text("\(engines) engine")
                    } else {
                        Text("\(engines) engines")
                    }
                    
                    Spacer()
                }
                
                //MARK: - Fuel
                HStack {
                    Image("Fuel")
                    
                    Text("\(fuelTons) tons of fuel")
                    
                    Spacer()
                }
                
                //MARK: - Burn
                
                HStack {
                    Image("Burn")
                    
                    Text("\(burnTime) seconds burn time")
                    
                    Spacer()
                }
            }
            .padding()
        }
        
        .cornerRadius(20)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(stage: "First", reusable: true, engines: 2, fuelTons: 300, burnTime: 160)
    }
}
