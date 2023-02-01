//
//  Landmarks.swift
//  LandmarksList
//
//  Created by lpiem on 01/02/2023.
//

import Foundation
import UIKit
import CoreLocation

struct Landmark: Decodable, Hashable {
    struct Coordinates: Decodable, Hashable {
        let latitude: Double
        let longitude: Double
    }
    
    enum Category: String, CaseIterable, Decodable {
        case lakes = "Lakes"
        case mountainss = "Mountains"
        case rivers = "Rivers"
    }
    
    let id: Int
    let name: String
    let category: Category
    let city: String
    let state: String
    let park: String
    let isFeatured: Bool
    let isFavorite: Bool
    let description: String
    let date: Date
    
    private let imageName: String
    private let coordinates: Coordinates
    
    var image: UIImage {
        return UIImage(named: imageName)!
    }
    
    var locationCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}
