//
//  RocketsListView.swift
//  Rocket
//
//  Created by Adela Mišicáková on 11.07.2022.
//

import SwiftUI

struct RocketsListView: View {
    
    @StateObject private var vm: RocketsViewModel
    
    init() {
        let apiService = ApiService(urlString: "https://api.spacexdata.com/v3/rockets")
        _vm = StateObject(wrappedValue: RocketsViewModel(apiService: apiService))
    }
    
    var body: some View {
        
        NavigationView {
            switch vm.state {
            case .success(let rockets):
                ZStack {
                    Color.ui.lightGrayList
                    
                    List(rockets) { rocket in
                        
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
                }
                
            case .loading:
                ProgressView()
                
            default:
                EmptyView()
            }
        }
        .task {
            await vm.getRockets()
        }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.state, actions: { detail in
            Button("Retry") {
                Task {
                    await vm.getRockets()
                }
            }
        }, message: { detail in
            if case let .failed(error) = detail {
                Text(error.localizedDescription)
            }
        })
    }
}

struct RocketsListView_Previews: PreviewProvider {
    static var previews: some View {
        RocketsListView()
    }
}
