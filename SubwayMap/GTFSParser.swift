//
//  GTFSParser.swift
//  
//
//  Created by Franco Miguel Guevarra on 2/22/24.
//

import Foundation

struct Stop: Codable {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "stop_id"
        case name = "stop_name"
        case latitude = "stop_lat"
        case longitude = "stop_lon"
    }
}

struct Shape: Codable, Hashable {
    let id: String
    let sequence: Int
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case id = "shape_id"
        case sequence = "shape_pt_sequence"
        case latitude = "shape_pt_lat"
        case longitude = "shape_pt_lon"
    }
}

struct Route: Codable {
    let id: String
    let shortName: String
    let type: Int
    let description: String
    let url: String
    let color: String
    let shapeID: String?

    enum CodingKeys: String, CodingKey {
        case id = "route_id"
        case shortName = "route_short_name"
        case type = "route_type"
        case description = "route_desc"
        case url = "route_url"
        case color = "route_color"
        case shapeID = "shape_id"
    }
}

struct Trip: Codable {
    let routeId: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case routeId = "route_id"
        case id = "shape_id"
    }
}

func loadStops() -> [Stop] {
    let feedURL = Bundle.main.url(forResource: "stops", withExtension: "json")!

    let data = try! Data(contentsOf: feedURL)
    let decoder = JSONDecoder()
    
    var stops: [Stop] = []
    
    do {
        stops = try decoder.decode([Stop].self, from: data)
        return stops
    } catch {
        print(error)
    }
    
    return stops
}

func loadShapes() -> [Shape] {
    let feedURL = Bundle.main.url(forResource: "shapes", withExtension: "json")!

    let data = try! Data(contentsOf: feedURL)
    let decoder = JSONDecoder()
    
    var shapes: [Shape] = []
    
    do {
        shapes = try decoder.decode([Shape].self, from: data)
        return shapes
    } catch {
        print(error)
    }
    
    return shapes
}

func loadRoutes() -> [Route] {
    let feedURL = Bundle.main.url(forResource: "routes", withExtension: "json")!

    let data = try! Data(contentsOf: feedURL)
    let decoder = JSONDecoder()
    
    var routes: [Route] = []
    
    do {
        routes = try decoder.decode([Route].self, from: data)
        return routes
    } catch {
        print(error)
    }
    
    return routes
}

func loadTrips() -> [Trip] {
    let feedURL = Bundle.main.url(forResource: "trips", withExtension: "json")!

    let data = try! Data(contentsOf: feedURL)
    let decoder = JSONDecoder()
    
    var trips: [Trip] = []
    
    do {
        trips = try decoder.decode([Trip].self, from: data)
        return trips
    } catch {
        print(error)
    }
    
    return trips
}
