//
//  ContentViewModel.swift
//  IP Address Info
//
//  Created by Giorgio Giannotta on 25/02/23.
//

import SwiftUI
import MapKit

extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var ipAddress: String = "Retrieving..."
        @Published var ipGeoInfo = IPGeoInfo(ip: "IP", city: "City", region: "Region", country: "Country", loc: "37.34453, 15.43565", org: "Organization Name", timezone: "Timezone")
        @Published var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        private let api = APIManager()
        
        // Initialisations
        init() {
            fetchIP()
        }
        
        // Helper function to make sure items get updated on the main thread
        func runOnMain(_ method:@escaping () -> Void) {
            DispatchQueue.main.async {
                withAnimation {
                    method()
                }
            }
        }
        
        private func fetchIP() {
            api.fetchData(url: "https://api.ipify.org?format=json", model: IP.self) { result in
                self.runOnMain {
                    self.ipAddress = result.ip
                    self.fetchGeoData(ip: result.ip)
//                    self.fetchLocation(ip: result.ip)
                }
            } failure: { error in
                self.runOnMain {
                    print("IP: \(error.localizedDescription)")
                    
                    // In case of error, try again after 10 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        print("Trying again to fetch IP...")
                        self.fetchIP()
                    }
                }
            }
        }
        
        private func fetchGeoData(ip: String) {
            api.fetchData(url: "https://ipinfo.io/\(ip)/geo", model: IPGeoInfo.self) { result in
                self.runOnMain {
                    self.ipGeoInfo = result
                    let resultLoc = result.loc
                    let locationArray = resultLoc?.components(separatedBy: ",")
                    self.location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(locationArray![0])!, longitude: Double(locationArray![1])!), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                }
            } failure: { error in
                print("GeoData: \(error.localizedDescription)")
            }
        }
        
        // Fetch the location of the IP address
        private func fetchLocation(ip: String) {
            api.fetchData(url: "https://ipapi.co/\(ip)/json/", model: IPCoordinates.self) { result in
                self.runOnMain {
                    self.location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: result.latitude, longitude: result.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                }
            } failure: { error in
                print("IPCoordinates: \(error.localizedDescription)")
            }
        }
    }
}
