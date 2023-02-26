//
//  MapAnnotationExtension.swift
//  IP Address Info
//
//  Created by Giorgio Giannotta on 26/02/23.
//

import MapKit

extension MKPointAnnotation: Identifiable {
    public var id: String {
        return "\(coordinate.latitude), \(coordinate.longitude)"
    }
}
