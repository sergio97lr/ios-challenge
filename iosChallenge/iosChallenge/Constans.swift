//
//  Constans.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

struct Constants {
    static let baseUrl = "https://idealista.github.io/ios-challenge/"
    static let listEndpoint = "list.json"
    static let detailEndpoint = "detail.json"
    
    struct LocalizableKeys {
        struct Price {
            static let price = "precio".localized
            static let millarSeparator = "separador_millar".localized
            static let decimalSeparator = "separador_decimal".localized
        }
        
        struct Operation {
            static let sale = "venta".localized
            static let rent = "alquiler".localized
        }
        
        struct Home {
            static let flat = "piso".localized
            static let house = "casa".localized
            static let floor = "numero_planta".localized
            static let lift = "ascensor".localized
            static let noLift = "no_ascensor".localized
            static let favList = "favorito_lista".localized
            static let noFav = "no_favorito".localized
            static let parkingIncluded = "parking_incluido".localized
            static let parkingNotIncluded = "parking_no_incluido".localized
            static let parkingIncludedPrice = "parking_incluido_precio".localized
            static let parkingNotIncludedPrice = "parking_no_incluido_precio".localized
            static let advertiserComment = "comentario_anunciante".localized
            static let fullComment = "comentario_completo".localized
            static let basicFeature = "caracteristicas_basicas".localized
            static let constructed = "contruidos".localized
            static let bedrooms = "dormitorios".localized
            static let rooms = "habitaciones".localized
            static let bathrooms = "baños".localized
            static let building = "edificio".localized
            static let energeticCertificate = "cert_energetico".localized
            static let consumption = "consumo".localized
            static let emissions = "emisiones".localized
            static let exterior = "exterior".localized
            static let interior = "interior".localized
            static let groundFloor = "planta_baja".localized
            static let firstFloor = "primera_planta".localized
            static let secondFloor = "segunda_planta".localized
            static let thirdFloor = "tercera_planta".localized
            static let defaultFloor = "plantas_altas".localized
        }
        
        struct Navigation {
            static let backToAd = "volver_anuncio".localized
        }
        
        struct Others {
            static let en = "en".localized
        }
    }
    
}
