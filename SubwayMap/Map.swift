//
//  SwiftUIView.swift
//
//
//  Created by Franco Miguel Guevarra on 2/10/24.
//

import SwiftUI
import MapKit


let STOPS = loadStops()
let SHAPES = loadShapes()
let ROUTES = loadRoutes()
let TRIPS = loadTrips()

let intialCoordinate = CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130)
let center = CLLocationCoordinate2D(latitude: 40.700872, longitude: -73.937042)

struct SubwayMap: View {
    
    var body: some View {
        Map(
            initialPosition: .camera(
                MapCamera(
                    centerCoordinate: intialCoordinate,
                    distance: 50
                )
            ),
            bounds: MapCameraBounds(
                centerCoordinateBounds: MKCoordinateRegion(
                    center: center,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.4,
                        longitudeDelta: 0.7
                    )
                ),
                minimumDistance: 3000,
                maximumDistance: 40000
            ),
            interactionModes: [.pan, .zoom, .rotate]
        ){
            ForEach(STOPS, id: \.id) { stop in
                Annotation(
                    stop.name,
                    coordinate: CLLocationCoordinate2D(latitude: stop.latitude, longitude: stop.longitude)
                ){
                    Circle()
                        .fill(.white)
                        .stroke(.black, lineWidth: 1.5)
                        .frame(width: 8)
                }
            }
            
            ForEach(Lines.allCases, id: \.self) { line in
                ForEach(LineShapes[line]!.indices, id: \.self) { index in
                    MapPolyline(coordinates: LineShapes[line]![index])
                        .stroke(line.color, lineWidth: 4)
                }
            }
        }
        
    }
        
}

#Preview {
    SubwayMap()
}
