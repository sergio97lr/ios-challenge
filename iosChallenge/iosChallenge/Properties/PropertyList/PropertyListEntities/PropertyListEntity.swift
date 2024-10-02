//
//  PropertyListEntity.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

struct PropertyListEntity: Decodable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfoList
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: MultimediaList
    let features: Features
    let parkingSpace: ParkingSpace?
}

struct PriceInfoList: Decodable {
    let price: PriceList
}

struct PriceList: Decodable {
    let amount: Double
    let currencySuffix: String
}

struct MultimediaList: Decodable {
    let images: [ImageList]
}

struct ImageList: Decodable {
    let url: String
    let tag: String
}

struct Features: Decodable {
    let hasAC: Bool
    let hasBoxRoom: Bool
    
    enum CodingKeys: String, CodingKey {
        case hasAC = "hasAirConditioning"
        case hasBoxRoom
        
    }
}

struct ParkingSpace: Decodable {
    let hasParkingSpace: Bool
    let parkingPriceIncluded: Bool
    
    enum CodingKeys: String, CodingKey {
        case parkingPriceIncluded = "isParkingSpaceIncludedInPrice"
        case hasParkingSpace
    }
}

typealias propertyListEntity = [PropertyListEntity]
