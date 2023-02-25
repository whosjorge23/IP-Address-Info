//
//  ContentView.swift
//  IP Address Info
//
//  Created by Giorgio Giannotta on 25/02/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .frame(width: .infinity, height: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
