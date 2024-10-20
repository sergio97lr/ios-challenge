//
//  PropertyListEntitiesMock.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

@testable import iosChallenge

extension PropertyListEntity: @retroactive Equatable {
    static func mock() -> PropertyListEntity {
        return PropertyListEntity(
            propertyCode: "12345",
            thumbnail: "https://example.com/thumbnail.jpg",
            floor: "3",
            price: 300000.0,
            priceInfo: PriceInfoList(price: PriceList(amount: 300000.0, currencySuffix: "€")),
            propertyType: "flat",
            operation: "sale",
            size: 90.0,
            exterior: true,
            rooms: 4,
            bathrooms: 2,
            address: "Calle de Gran Vía, 1",
            province: "Madrid",
            municipality: "Madrid",
            district: "Centro",
            country: "España",
            neighborhood: "Salamanca",
            latitude: 40.4192,
            longitude: -3.6915,
            description: "Piso en el centro de Madrid, 4 habitaciones, 2 baños...",
            multimedia: MultimediaList(images: [ImageList(url: "https://example.com/image1.jpg", tag: "livingroom")]),
            features: Features(hasAC: true, hasBoxRoom: true, hasTerrace: true, hasGarden: false, hasSwimmingPool: true),
            parkingSpace: ParkingSpace(hasParkingSpace: true, parkingPriceIncluded: true)
        )
    }
    
    static func expectedResult() -> PropertyListEntity {
        return mock()
    }

    public static func == (lhs: PropertyListEntity, rhs: PropertyListEntity) -> Bool {
        return lhs.propertyCode == rhs.propertyCode &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.floor == rhs.floor &&
            lhs.price == rhs.price &&
            lhs.priceInfo == rhs.priceInfo &&
            lhs.propertyType == rhs.propertyType &&
            lhs.operation == rhs.operation &&
            lhs.size == rhs.size &&
            lhs.exterior == rhs.exterior &&
            lhs.rooms == rhs.rooms &&
            lhs.bathrooms == rhs.bathrooms &&
            lhs.address == rhs.address &&
            lhs.province == rhs.province &&
            lhs.municipality == rhs.municipality &&
            lhs.district == rhs.district &&
            lhs.country == rhs.country &&
            lhs.neighborhood == rhs.neighborhood &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.description == rhs.description &&
            lhs.multimedia == rhs.multimedia &&
            lhs.features == rhs.features &&
            lhs.parkingSpace == rhs.parkingSpace
    }
}

extension PriceInfoList: @retroactive Equatable {
    public static func == (lhs: PriceInfoList, rhs: PriceInfoList) -> Bool {
        return lhs.price == rhs.price
    }
}

extension PriceList: @retroactive Equatable {
    public static func == (lhs: PriceList, rhs: PriceList) -> Bool {
        return lhs.amount == rhs.amount &&
            lhs.currencySuffix == rhs.currencySuffix
    }
}

extension MultimediaList: @retroactive  Equatable {
    public static func == (lhs: MultimediaList, rhs: MultimediaList) -> Bool {
        return lhs.images == rhs.images
    }
}

extension ImageList: @retroactive Equatable {
    public static func == (lhs: ImageList, rhs: ImageList) -> Bool {
        return lhs.url == rhs.url &&
            lhs.tag == rhs.tag
    }
}

extension Features: @retroactive Equatable {
    public static func == (lhs: Features, rhs: Features) -> Bool {
        return lhs.hasAC == rhs.hasAC &&
            lhs.hasBoxRoom == rhs.hasBoxRoom &&
            lhs.hasTerrace == rhs.hasTerrace &&
            lhs.hasGarden == rhs.hasGarden &&
            lhs.hasSwimmingPool == rhs.hasSwimmingPool
    }
}

extension ParkingSpace: @retroactive Equatable {
    public static func == (lhs: ParkingSpace, rhs: ParkingSpace) -> Bool {
        return lhs.hasParkingSpace == rhs.hasParkingSpace &&
            lhs.parkingPriceIncluded == rhs.parkingPriceIncluded
    }
}
