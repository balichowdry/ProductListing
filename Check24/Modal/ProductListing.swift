//
//  ProductDetailViewController.swift
//  Check24
//
//  Created by BilalSattar on 22/09/2018.
//  Copyright © 2018 BilalSattar. All rights reserved.
//

import Foundation

struct ProductListing: Codable {
    let header: Header
    let filters: [String]
    let products: [Product]
}

struct Header: Codable {
    let headerTitle, headerDescription: String
}

struct Product: Codable {
    let name: String
    let type: TypeEnum
    let id: Int
    let color: Color
    let imageURL: String
    let colorCode: ColorCode
    let available: Bool
    let releaseDate: Int
    let description, longDescription: String
    let rating: Double
    let price: Price
}

enum Color: String, Codable {
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case yellow = "Yellow"
}

enum ColorCode: String, Codable {
    case bbdefb = "BBDEFB"
    case c8E6C9 = "C8E6C9"
    case ffCDD2 = "ffCDD2"
    case ffecb3 = "FFECB3"
}

struct Price: Codable {
    let value: Double
    let currency: Currency
}

enum Currency: String, Codable {
    case eur = "EUR"
}

enum TypeEnum: String, Codable {
    case circle = "Circle"
    case hexagon = "Hexagon"
    case square = "Square"
    case triangle = "Triangle"
}

