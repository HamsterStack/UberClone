//
//  HomeView.swift
//  UberClone
//
//  Created by Tom Miller on 03/12/2022.
//

import SwiftUI



struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var launchScreenManager : LaunchScreenManager
    
    @State var showMenu = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState    )
                    .ignoresSafeArea()
                if mapState == .searchingForLocation{
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture{
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState, showMenu: $showMenu)
                    .padding(.leading)
                    .padding(.top, 4)
                
            }
            
            if mapState == .locationSelected || mapState == .polylineAdded{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .sheet(isPresented: $showMenu){
            SettingsView(settingsOn: $showMenu)
                
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
