//
//  IPModel.swift
//  IP Address Info
//
//  Created by Giorgio Giannotta on 25/02/23.
//

import SwiftUI

//https://api.ipify.org/?format=json
struct IP : Decodable {
    var ip : String
}

//https://ipinfo.io/(ip)/geo
struct IPGeoInfo : Decodable {
    var ip: String?
    var city: String?
    var region: String?
    var country: String?
    var loc: String?
    var org: String?
    var postal: String?
    var timezone: String?
}

//https://ipapi.co/(ip)/json/
struct IPCoordinates : Decodable {
    var longitude : Double
    var latitude : Double
}
