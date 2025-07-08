//
//  MapView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    var location: CLLocationCoordinate2D

    var body: some View {
        Map(initialPosition: .region(region)) {
            Marker("", coordinate: location)
                .tint(.red) // Düzgün, tek renk kırmızı pin
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 35)
        )
    }
}

#Preview {
    MapView(location: .init(latitude: 34.011_286, longitude: 116.166_868))
}
