//
//  PropertyDetailEntitiesMock.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

@testable import iosChallenge

extension PropertyDetailEntity: @retroactive Equatable {
    static func mock() -> PropertyDetailEntity {
        return PropertyDetailEntity(
            adid: 12345,
            price: 500000.0,
            priceInfo: PriceInfoDetail(amount: 500000.0, currencySuffix: "€"),
            operation: "sale",
            propertyType: "flat",
            extendedPropertyType: "flat",
            homeType: "piso",
            state: "active",
            multimedia: MultimediaDetail(images: [ImageDetail(url: "https://example.com/image1.jpg", tag: "livingRoom", localizedName: "Salón", multimediaId: 1)]),
            propertyComment: "Piso en el centro de Madrid, 4 habitaciones, 2 baños...",
            ubication: Ubication(latitude: 40.4168, longitude: -3.7038),
            country: "es",
            moreCharacteristics: MoreCharacteristics(
                communityCosts: 100.0,
                roomNumber: 3,
                bathNumber: 2,
                exterior: true,
                housingFurnitures: "unknown",
                agencyIsABank: false,
                energyCertificationType: "A",
                flatLocation: "internal",
                modificationDate: 20231010,
                constructedArea: 120.0,
                lift: true,
                boxroom: true,
                isDuplex: true,
                floor: "3",
                status: "renew"
            ),
            energyCertification: EnergyCertification(
                title: "Certificado energético",
                energyConsumption: EnergyType(type: "A"),
                emissions: EnergyType(type: "B")
            )
        )
    }
    
    static func expectedResult() -> PropertyDetailEntity {
        return mock()
    }

    public static func == (lhs: PropertyDetailEntity, rhs: PropertyDetailEntity) -> Bool {
        return lhs.adid == rhs.adid &&
            lhs.price == rhs.price &&
            lhs.priceInfo == rhs.priceInfo &&
            lhs.operation == rhs.operation &&
            lhs.propertyType == rhs.propertyType &&
            lhs.extendedPropertyType == rhs.extendedPropertyType &&
            lhs.homeType == rhs.homeType &&
            lhs.state == rhs.state &&
            lhs.multimedia == rhs.multimedia &&
            lhs.propertyComment == rhs.propertyComment &&
            lhs.ubication == rhs.ubication &&
            lhs.country == rhs.country &&
            lhs.moreCharacteristics == rhs.moreCharacteristics &&
            lhs.energyCertification == rhs.energyCertification
    }
}

extension PriceInfoDetail: @retroactive Equatable {
    public static func == (lhs: PriceInfoDetail, rhs: PriceInfoDetail) -> Bool {
        return lhs.amount == rhs.amount &&
            lhs.currencySuffix == rhs.currencySuffix
    }
}

extension MultimediaDetail: @retroactive Equatable {
    public static func == (lhs: MultimediaDetail, rhs: MultimediaDetail) -> Bool {
        return lhs.images == rhs.images
    }
}

extension ImageDetail: @retroactive Equatable {
    public static func == (lhs: ImageDetail, rhs: ImageDetail) -> Bool {
        return lhs.url == rhs.url &&
            lhs.tag == rhs.tag &&
            lhs.localizedName == rhs.localizedName &&
            lhs.multimediaId == rhs.multimediaId
    }
}

extension Ubication: @retroactive Equatable {
    public static func == (lhs: Ubication, rhs: Ubication) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}

extension MoreCharacteristics: @retroactive Equatable {
    public static func == (lhs: MoreCharacteristics, rhs: MoreCharacteristics) -> Bool {
        return lhs.communityCosts == rhs.communityCosts &&
            lhs.roomNumber == rhs.roomNumber &&
            lhs.bathNumber == rhs.bathNumber &&
            lhs.exterior == rhs.exterior &&
            lhs.housingFurnitures == rhs.housingFurnitures &&
            lhs.agencyIsABank == rhs.agencyIsABank &&
            lhs.energyCertificationType == rhs.energyCertificationType &&
            lhs.flatLocation == rhs.flatLocation &&
            lhs.modificationDate == rhs.modificationDate &&
            lhs.constructedArea == rhs.constructedArea &&
            lhs.lift == rhs.lift &&
            lhs.boxroom == rhs.boxroom &&
            lhs.isDuplex == rhs.isDuplex &&
            lhs.floor == rhs.floor &&
            lhs.status == rhs.status
    }
}

extension EnergyCertification: @retroactive Equatable {
    public static func == (lhs: EnergyCertification, rhs: EnergyCertification) -> Bool {
        return lhs.title == rhs.title &&
            lhs.energyConsumption == rhs.energyConsumption &&
            lhs.emissions == rhs.emissions
    }
}

extension EnergyType: @retroactive Equatable {
    public static func == (lhs: EnergyType, rhs: EnergyType) -> Bool {
        return lhs.type == rhs.type
    }
}
