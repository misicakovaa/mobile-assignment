//
//  ParametersSectionView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 13.07.2022.
//

import SwiftUI

struct ParametersSectionView: View {
    
    let height: Double
    let diameter: Double
    let mass: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Parameters title
            Text("Parameters")
                .font(.headline)
                .padding(.leading)
            
            
            // Parameters info
            HStack {
                ParameterView(name: "height", number: Int(height), unit: "m")
                    .padding(.leading)
                
                Spacer()
                
                ParameterView(name: "diameter", number: Int(diameter), unit: "m")
                
                Spacer()
                
                ParameterView(name: "mass", number: mass/1000, unit: "t")
                    .padding(.trailing)
            }
        }
    }
}
