//
//  PropertyDetailEntity.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import Foundation

struct PropertyDetailEntity: Decodable {
    let adid: Int
    let price: Double
    let priceInfo: PriceInfoDetail
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDetail
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: MoreCharacteristics
    let energyCertification: EnergyCertification
}

struct PriceInfoDetail: Decodable {
    let amount: Double
    let currencySuffix: String
}

struct MultimediaDetail: Decodable {
    let images: [ImageDetail]
}

struct ImageDetail: Decodable {
    let url: String
    let tag: String
    let localizedName: String
    let multimediaId: Int
}

struct Ubication: Decodable {
    let latitude: Double
    let longitude: Double
}

struct MoreCharacteristics: Decodable {
    let communityCosts: Double
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int
    let constructedArea: Double
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct EnergyCertification: Decodable {
    let title: String
    let energyConsumption: EnergyType
    let emissions: EnergyType
}

struct EnergyType: Decodable {
    let type: String
}

typealias PropertyEntity = PropertyDetailEntity
