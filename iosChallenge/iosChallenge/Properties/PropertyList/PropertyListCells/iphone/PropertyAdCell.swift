//
//  PropertyAdCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import UIKit

class PropertyAdCell: UITableViewCell {
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var propertyAddressLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var favTextLabel: UILabel!
    @IBOutlet weak var placeholderImage: UIImageView!
    
    weak var delegate: PropertyAdCellDelegate?
    
    var imageList: [(image: UIImage, tag: String)] = []
    var property: PropertyListEntity?
    var favAd: Bool = false
    var favoriteAd: (String, Date)? = nil
    var propertyExtraParams: ExtraParams?
    
    // MARK: PrepareForReuse
    override func prepareForReuse() {
        self.property = nil
        self.operationLabel.text = ""
        self.locationLabel.text = ""
        self.propertyAddressLabel.text = ""
        self.priceLabel.text = ""
        self.parkingLabel.text = ""
        self.parkingLabel.isHidden = true
        self.additionalInfoLabel.text = ""
        self.favTextLabel.isHidden = true
        self.favAd = false
        self.favIcon.image = UIImage(named: "noFavIconList")
        self.placeholderImage.isHidden = false
        self.imageList = []
        self.propertyExtraParams = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
    }
    
    func configureCell(property: PropertyListEntity?){
        guard let property = property else {return}
        let extraParams = ExtraParams(originalPropertyCode: property.propertyCode, address: property.address, district: property.district, municipality: property.municipality, parking: property.parkingSpace?.hasParkingSpace ?? false, parkingIncluded: property.parkingSpace?.parkingPriceIncluded ?? false)
        self.propertyExtraParams = extraParams
        self.property = property
        self.selectionStyle = .none
        self.configurePropertyImages()
        self.configureStackView()
        self.adView.layer.borderWidth = 1
        self.adView.layer.borderColor = IdealistaColors.pinkIdealista?.cgColor
        self.configureNavigation()
        self.addFavTapAction()
        self.favTextLabel.isHidden = true
        self.favoriteAd = Utils.isFavoriteAd(propertyCode: property.propertyCode)
        if let adFav = self.favoriteAd {
            self.favAd = true
            self.favIcon.image = UIImage(named: "favIcon")
            self.favTextLabel.isHidden = false
            self.infoStackView.spacing = 12
            let dates = Utils.formatDate(date: adFav.1)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.favTextLabel.text = formattedString
        }
        
        self.sizeToFit()
        self.layoutIfNeeded()
    }
    
    func configurePropertyImages() {
        guard let property = self.property else { return }
        let group = DispatchGroup()
        var tempImageDict: [Int: [(image: UIImage, tag: String)]] = [:]

        for (index, propertyImage) in property.multimedia.images.enumerated() {
            guard let url = URL(string: propertyImage.url) else { continue }
            group.enter()
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    let tag = propertyImage.tag // Asumiendo que propertyImage tiene una propiedad 'tag'
                    DispatchQueue.main.async {
                        if tempImageDict[index] != nil {
                            tempImageDict[index]?.append((image: image, tag: tag))
                        } else {
                            tempImageDict[index] = [(image: image, tag: tag)]
                        }
                        group.leave()
                    }
                } else {
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.imageList = tempImageDict.sorted { $0.key < $1.key }.flatMap { $0.value }
            self?.collectionView.reloadData()
            self?.collectionView.setContentOffset(.zero, animated: false)
            if !(self?.imageList.isEmpty ?? true) {
                self?.placeholderImage.isHidden = true
            }
        }
    }


    
    func configureStackView() {
        guard let property = self.property else { return }
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight <= 667 {
                self.infoStackView.spacing = 8
            } else {
                self.infoStackView.spacing = 20
            }
        
        // MARK: Operation
        let operation = property.operation
        var operationText = Constants.LocalizableKeys.Operation.rent
        if operation.contains("sale") {
            operationText = Constants.LocalizableKeys.Operation.sale
        }
        self.operationLabel.text = operationText
        
        // MARK: Price
        let price = Utils.formatPrice(property.priceInfo.price.amount) ?? String(property.priceInfo.price.amount)
        let currencySuffix = property.priceInfo.price.currencySuffix
        self.priceLabel.text = "\(price)\(currencySuffix)"
        
        // MARK: Address
        let propertyType = property.propertyType
        var propertyTypeText = Constants.LocalizableKeys.Home.house
        if propertyType.contains("flat") {
            propertyTypeText = Constants.LocalizableKeys.Home.flat
        }
        let address = property.address
        self.propertyAddressLabel.text = "\(propertyTypeText) in \(address)"
        self.propertyAddressLabel.numberOfLines = 0
        
        // MARK: Location
        let neighborhood = property.neighborhood
        let district = property.district
        let municipality = property.municipality
        self.locationLabel.text = "\(neighborhood), \(district), \(municipality)"
        self.locationLabel.numberOfLines = 0
        
        // MARK: Parking
        let parkingSpace = property.parkingSpace?.hasParkingSpace ?? false
        if parkingSpace {
            self.parkingLabel.isHidden = false
            let included = property.parkingSpace?.parkingPriceIncluded ?? false
            if included {
                self.parkingLabel.text = Constants.LocalizableKeys.Home.parkingIncluded
            } else {
                self.parkingLabel.text = Constants.LocalizableKeys.Home.parkingNotIncluded
            }
        } else {
            self.parkingLabel.isHidden = true
        }
        
        // MARK: AdditionalProperties
        let rooms = property.rooms
        let size = Int(property.size)
        var floor = property.floor
        let exterior = property.exterior
        floor = Utils.getFloor(floor: floor)
        var exteriorOrInterior = Constants.LocalizableKeys.Home.exterior
        if !exterior {
            exteriorOrInterior = Constants.LocalizableKeys.Home.interior
        }
        
        self.additionalInfoLabel.text = "\(rooms) \(Constants.LocalizableKeys.Home.rooms) - \(size) m\u{00B2} - \(floor) - \(exteriorOrInterior)"
        
    }
    
    
    // MARK: Favorites
    func addFavTapAction() {
        let tapGestureImg = UITapGestureRecognizer(target: self, action: #selector(favTapped))
        self.favIcon.isUserInteractionEnabled = true
        self.favIcon.addGestureRecognizer(tapGestureImg)
    }
    
    @objc func favTapped() {
        self.favAd = !self.favAd
        if self.favAd {
            self.manageFavorites(addFav: true)
            UIView.transition(with: favIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.favIcon.image = UIImage(named: "favIcon")
            })
        } else {
            self.manageFavorites(addFav: false)
            UIView.transition(with: favIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.favIcon.image = UIImage(named: "noFavIconList")
            })
            
        }
    }
    
    func manageFavorites(addFav: Bool) {
        guard let property = self.property, let propertyExtraParams = self.propertyExtraParams else { return }
        if addFav {
            let date = Date()
            CoreDataManager.shared.saveFavorite(propertyCode: property.propertyCode, favDate: Date(), address: propertyExtraParams.address, district: propertyExtraParams.district, municipality: propertyExtraParams.municipality, parking: propertyExtraParams.parking, parkingIncluded: propertyExtraParams.parkingIncluded, price: property.priceInfo.price.amount, currencySufix: property.priceInfo.price.currencySuffix)
            self.favTextLabel.alpha = 0.0
            UIView.animate(withDuration: 1.75, animations: {
                self.favTextLabel.isHidden = false
                self.favTextLabel.alpha = 1.0
            })
            let screenHeight = UIScreen.main.bounds.height
            if screenHeight <= 667 {
                    self.infoStackView.spacing = 4
            } else {
                self.infoStackView.spacing = 12
            }
            let dates = Utils.formatDate(date: date)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.favTextLabel.text = formattedString
        } else {
            UIView.animate(withDuration: 1.5, animations: {
                self.favTextLabel.isHidden = true
                self.favTextLabel.alpha = 0.0
            })
            CoreDataManager.shared.deleteFavorite(propertyCode: property.propertyCode)
        }
    }
    
    // MARK: Navigations
    func configureNavigation(){
        let stackViewGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        self.infoStackView.isUserInteractionEnabled = true
        self.infoStackView.addGestureRecognizer(stackViewGesture)
    }
    
    @objc func stackViewTapped() {
        guard let propertyExtraParams = self.propertyExtraParams else { return }
        self.delegate?.navigateToDetail(extraParams: propertyExtraParams)
    }
    
}

// MARK: - UICollectionViewDataSource
extension PropertyAdCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesAdsCollectionViewCell", for: indexPath) as! ImagesAdsCollectionViewCell
        let image = self.imageList[indexPath.item].image
        let tag = self.imageList[indexPath.item].tag
        cell.configureCell(image: image, tag: tag)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PropertyAdCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
