//
//  OverviewSectionView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 13.07.2022.
//

import SwiftUI

struct OverviewSectionView: View {
    
    let description: String
    
    var body: some View {
        VStack {
            // Overview title
            HStack {
                Text("Overview")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            
            // Overview description
            Text(description)
                .padding([.leading, .trailing])
        }
    }
}
