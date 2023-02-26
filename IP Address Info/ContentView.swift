//
//  ContentView.swift
//  IP Address Info
//
//  Created by Giorgio Giannotta on 25/02/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ZStack {
//            Map(coordinateRegion: $vm.location)
            Map(coordinateRegion: $vm.location, annotationItems: [$vm.annotation]) { annotation in
                MapAnnotation(coordinate: vm.annotation.coordinate) {
                    Circle()
//                        .strokeBorder(.red.opacity(0.80), lineWidth: 4)
                        .foregroundColor(.orange.opacity(0.50))
                        .frame(width: 30, height: 30)
                }
            }
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("**IP**: \(vm.ipAddress)")
                    Text("\(vm.ipGeoInfo.city!), \(vm.ipGeoInfo.country!), \(vm.ipGeoInfo.timezone!)")
                    Text(vm.ipGeoInfo.org!)
                    Text(vm.ipGeoInfo.loc!)
                }
                .padding()
                .frame(width: 330)
                .background(.thickMaterial)
                .cornerRadius(10)
                .padding(.vertical, 50)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
