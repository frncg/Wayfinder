//
//  Lines.swift
//  
//
//  Created by Franco Miguel Guevarra on 2/22/24.
//

import Foundation
import SwiftUI
import MapKit

enum Lines: String, CaseIterable {
    case line1 = "1"
    case line2 = "2"
    case line3 = "3"
    case line4 = "4"
    case line5 = "5"
    case line6 = "6"
    case line7 = "7"
    case A
    case B
    case C
    case D
    case E
    case F
    case FS
    case G
    case GS
    case H
    case J
    case L
    case M
    case N
    case Q
    case R
    case SI
    case W
    case Z
    
    var color: Color {
        let route = ROUTES.first { $0.id == self.rawValue }
        return Color(hex: route?.color ?? "000000")
    }
    
    func loadShapes() -> [[CLLocationCoordinate2D]] {
        let trips = TRIPS.filter { $0.routeId == self.rawValue }
        var shapes = [[CLLocationCoordinate2D]]()
        for trip in trips {
            shapes.append(SHAPES.filter({ $0.id == trip.id }).map {
                CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            })
        }
        
        return shapes
    }
}

let LineShapes: [Lines: [[CLLocationCoordinate2D]]] = [
    .line1: Lines.line1.loadShapes(),
    .line2: Lines.line2.loadShapes(),
    .line3: Lines.line3.loadShapes(),
    .line4: Lines.line4.loadShapes(),
    .line5: Lines.line5.loadShapes(),
    .line6: Lines.line6.loadShapes(),
    .line7: Lines.line7.loadShapes(),
    .A: Lines.A.loadShapes(),
    .B: Lines.B.loadShapes(),
    .C: Lines.C.loadShapes(),
    .D: Lines.D.loadShapes(),
    .E: Lines.E.loadShapes(),
    .F: Lines.F.loadShapes(),
    .FS: Lines.FS.loadShapes(),
    .G: Lines.G.loadShapes(),
    .GS: Lines.GS.loadShapes(),
    .H: Lines.H.loadShapes(),
    .J: Lines.J.loadShapes(),
    .L: Lines.L.loadShapes(),
    .M: Lines.M.loadShapes(),
    .N: Lines.N.loadShapes(),
    .Q: Lines.Q.loadShapes(),
    .R: Lines.R.loadShapes(),
    .SI: Lines.SI.loadShapes(),
    .W: Lines.W.loadShapes(),
    .Z: Lines.Z.loadShapes()
]
