//
//  PropertyAdsIpadCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 8/10/24.
//

import UIKit

class PropertyAdsIpadCell: UITableViewCell {
    
    @IBOutlet weak var leftAdView: UIView!
    @IBOutlet weak var leftCollectionView: UICollectionView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var leftOperation: UILabel!
    @IBOutlet weak var leftPropertyType: UILabel!
    @IBOutlet weak var leftNeighborhood: UILabel!
    @IBOutlet weak var leftPrice: UILabel!
    @IBOutlet weak var leftParking: UILabel!
    @IBOutlet weak var leftExtraInfo: UILabel!
    @IBOutlet weak var leftFavLabel: UILabel!
    @IBOutlet weak var leftFavIcon: UIImageView!
    @IBOutlet weak var rightAdView: UIView!
    @IBOutlet weak var rightCollectionView: UICollectionView!
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var rightOperation: UILabel!
    @IBOutlet weak var rightPropertyType: UILabel!
    @IBOutlet weak var rightNeighborhood: UILabel!
    @IBOutlet weak var rightPrice: UILabel!
    @IBOutlet weak var rightParking: UILabel!
    @IBOutlet weak var rightExtraInfo: UILabel!
    @IBOutlet weak var rightFavLabel: UILabel!
    @IBOutlet weak var rightFavIcon: UIImageView!
    
    weak var delegate: PropertyAdCellDelegate?
    
    var leftImageList: [(image: UIImage, tag: String)] = []
    var rightImageList: [(image: UIImage, tag: String)] = []
    var leftProperty: PropertyListEntity?
    var rightProperty: PropertyListEntity?
    var leftFavAd: Bool = false
    var rightFavAd: Bool = false
    var leftFavoriteAd: (String, Date)? = nil
    var rightFavoriteAd: (String, Date)? = nil
    
    // MARK: PrepareForReuse
    override func prepareForReuse() {
        self.leftProperty = nil
        self.leftOperation.text = ""
        self.leftPropertyType.text = ""
        self.leftNeighborhood.text = ""
        self.leftPrice.text = ""
        self.leftParking.text = ""
        self.leftParking.isHidden = true
        self.leftExtraInfo.text = ""
        self.leftFavLabel.isHidden = true
        self.leftFavAd = false
        self.leftFavIcon.image = UIImage(named: "noFavIconList")
        self.rightProperty = nil
        self.rightOperation.text = ""
        self.rightPropertyType.text = ""
        self.rightNeighborhood.text = ""
        self.rightPrice.text = ""
        self.rightParking.text = ""
        self.rightParking.isHidden = true
        self.rightExtraInfo.text = ""
        self.rightFavLabel.isHidden = true
        self.rightFavAd = false
        self.rightFavIcon.image = UIImage(named: "noFavIconList")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftCollectionView.dataSource = self
        self.leftCollectionView.delegate = self
        self.leftCollectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
        self.rightCollectionView.dataSource = self
        self.rightCollectionView.delegate = self
        self.rightCollectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
    }
    
    func configureCell(leftProperty: PropertyListEntity?, rightProperty: PropertyListEntity?){
        self.configureLeft(leftProperty: leftProperty)
        self.configureRight(rightProperty: rightProperty)
        self.selectionStyle = .none
        self.sizeToFit()
        self.layoutIfNeeded()
    }
    
    func configureLeft(leftProperty: PropertyListEntity?) {
        guard let leftProperty = leftProperty else { return }
        self.leftProperty = leftProperty
        self.configurePropertyImages(property: leftProperty, isLeft: true)
        self.configureLeftStackView(property: leftProperty)
        self.leftAdView.layer.borderWidth = 1
        self.leftAdView.layer.borderColor = IdealistaColors.pinkIdealista?.cgColor
        self.configureNavigation()
        self.addFavTapAction()
        self.leftFavLabel.isHidden = true
        self.leftFavoriteAd = self.isFavoriteAd(property: leftProperty)
        if let adFav = self.leftFavoriteAd {
            self.leftFavAd = true
            self.leftFavIcon.image = UIImage(named: "favIcon")
            self.leftFavLabel.isHidden = false
            self.leftStackView.spacing = 12
            let dates = Utils.formatDate(date: adFav.1)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.leftFavLabel.text = formattedString
        }
    }
    
    func configureRight(rightProperty: PropertyListEntity?) {
        guard let rightProperty = rightProperty else { return }
        self.rightProperty = rightProperty
        self.configurePropertyImages(property: rightProperty, isLeft: false)
        self.configureRightStackView(property: rightProperty)
        self.rightAdView.layer.borderWidth = 1
        self.rightAdView.layer.borderColor = IdealistaColors.pinkIdealista?.cgColor
        self.configureNavigation()
        self.addFavTapAction()
        self.rightFavLabel.isHidden = true
        self.rightFavoriteAd = self.isFavoriteAd(property: rightProperty)
        if let adFav = self.rightFavoriteAd {
            self.rightFavAd = true
            self.rightFavIcon.image = UIImage(named: "favIcon")
            self.rightFavLabel.isHidden = false
            self.rightStackView.spacing = 12
            let dates = Utils.formatDate(date: adFav.1)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.rightFavLabel.text = formattedString
        }
    }
    
    func configurePropertyImages(property: PropertyListEntity, isLeft: Bool) {
        let group = DispatchGroup()
        
        for propertyImage in property.multimedia.images {
            guard let url = URL(string: propertyImage.url) else { continue }
            group.enter()
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let imageListItem = (image: image, tag: propertyImage.tag)
                        if isLeft {
                            self?.leftImageList.append(imageListItem)
                        } else {
                            self?.rightImageList.append(imageListItem)
                        }
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.leftCollectionView.reloadData()
            self?.rightCollectionView.reloadData()
        }
    }
    
    func configureLeftStackView(property: PropertyListEntity) {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight <= 667 {
            self.leftStackView.spacing = 8
        } else {
            self.leftStackView.spacing = 20
        }
        
        // MARK: Operation
        let operation = property.operation
        var operationText = Constants.LocalizableKeys.Operation.rent
        if operation.contains("sale") {
            operationText = Constants.LocalizableKeys.Operation.sale
        }
        self.leftOperation.text = operationText
        
        // MARK: Price
        let price = Utils.formatPrice(property.priceInfo.price.amount) ?? String(property.priceInfo.price.amount)
        let currencySuffix = property.priceInfo.price.currencySuffix
        self.leftPrice.text = "\(price)\(currencySuffix)"
        
        // MARK: Address
        let propertyType = property.propertyType
        var propertyTypeText = Constants.LocalizableKeys.Home.house
        if propertyType.contains("flat") {
            propertyTypeText = Constants.LocalizableKeys.Home.flat
        }
        let address = property.address
        self.leftPropertyType.text = "\(propertyTypeText) in \(address)"
        self.leftPropertyType.numberOfLines = 0
        
        // MARK: Location
        let neighborhood = property.neighborhood
        let district = property.district
        let municipality = property.municipality
        self.leftNeighborhood.text = "\(neighborhood), \(district), \(municipality)"
        self.leftNeighborhood.numberOfLines = 0
        
        // MARK: Parking
        let parkingSpace = property.parkingSpace?.hasParkingSpace ?? false
        if parkingSpace {
            self.leftParking.isHidden = false
            let included = property.parkingSpace?.parkingPriceIncluded ?? false
            if included {
                self.leftParking.text = Constants.LocalizableKeys.Home.parkingIncluded
            } else {
                self.leftParking.text = Constants.LocalizableKeys.Home.parkingNotIncluded
            }
        } else {
            self.leftParking.isHidden = true
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
        
        self.leftExtraInfo.text = "\(rooms) \(Constants.LocalizableKeys.Home.rooms) - \(size) m\u{00B2} - \(floor) - \(exteriorOrInterior)"
        
    }
    
    func configureRightStackView(property: PropertyListEntity) {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight <= 667 {
            self.rightStackView.spacing = 8
        } else {
            self.rightStackView.spacing = 20
        }
        
        // MARK: Operation
        let operation = property.operation
        var operationText = Constants.LocalizableKeys.Operation.rent
        if operation.contains("sale") {
            operationText = Constants.LocalizableKeys.Operation.sale
        }
        self.rightOperation.text = operationText
        
        // MARK: Price
        let price = Utils.formatPrice(property.priceInfo.price.amount) ?? String(property.priceInfo.price.amount)
        let currencySuffix = property.priceInfo.price.currencySuffix
        self.rightPrice.text = "\(price)\(currencySuffix)"
        
        // MARK: Address
        let propertyType = property.propertyType
        var propertyTypeText = Constants.LocalizableKeys.Home.house
        if propertyType.contains("flat") {
            propertyTypeText = Constants.LocalizableKeys.Home.flat
        }
        let address = property.address
        self.rightPropertyType.text = "\(propertyTypeText) in \(address)"
        self.rightPropertyType.numberOfLines = 0
        
        // MARK: Location
        let neighborhood = property.neighborhood
        let district = property.district
        let municipality = property.municipality
        self.rightNeighborhood.text = "\(neighborhood), \(district), \(municipality)"
        self.rightNeighborhood.numberOfLines = 0
        
        // MARK: Parking
        let parkingSpace = property.parkingSpace?.hasParkingSpace ?? false
        if parkingSpace {
            self.rightParking.isHidden = false
            let included = property.parkingSpace?.parkingPriceIncluded ?? false
            if included {
                self.rightParking.text = Constants.LocalizableKeys.Home.parkingIncluded
            } else {
                self.rightParking.text = Constants.LocalizableKeys.Home.parkingNotIncluded
            }
        } else {
            self.rightParking.isHidden = true
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
        
        self.rightExtraInfo.text = "\(rooms) \(Constants.LocalizableKeys.Home.rooms) - \(size) m\u{00B2} - \(floor) - \(exteriorOrInterior)"
        
    }
    
    
    // MARK: Favorites
    func addFavTapAction() {
        let tapGestureLeftImg = UITapGestureRecognizer(target: self, action: #selector(leftFavTapped))
        self.leftFavIcon.isUserInteractionEnabled = true
        self.leftFavIcon.addGestureRecognizer(tapGestureLeftImg)
        let tapGestureRightImg = UITapGestureRecognizer(target: self, action: #selector(rightFavTapped))
        self.rightFavIcon.isUserInteractionEnabled = true
        self.rightFavIcon.addGestureRecognizer(tapGestureRightImg)
    }
    
    @objc func leftFavTapped() {
        self.leftFavAd = !self.leftFavAd
        if self.leftFavAd {
            self.manageLeftFavorites(addFav: true)
            UIView.transition(with: leftFavIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.leftFavIcon.image = UIImage(named: "favIcon")
            })
        } else {
            self.manageLeftFavorites(addFav: false)
            UIView.transition(with: leftFavIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.leftFavIcon.image = UIImage(named: "noFavIconList")
            })
            
        }
    }
    
    @objc func rightFavTapped() {
        self.rightFavAd = !self.rightFavAd
        if self.rightFavAd {
            self.manageRightFavorites(addFav: true)
            UIView.transition(with: rightFavIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.rightFavIcon.image = UIImage(named: "favIcon")
            })
        } else {
            self.manageRightFavorites(addFav: false)
            UIView.transition(with: rightFavIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.rightFavIcon.image = UIImage(named: "noFavIconList")
            })
            
        }
    }
    
    func manageLeftFavorites(addFav: Bool) {
        guard let property = self.leftProperty else { return }
        let userDefaults = UserDefaults.standard
        if addFav {
            let date = Date()
            let favProperty = ["code": property.propertyCode, "date": date] as [String : Any]
            userDefaults.set(favProperty, forKey: property.propertyCode)
            userDefaults.synchronize()
            self.leftFavLabel.alpha = 0.0
            UIView.animate(withDuration: 1.75, animations: {
                self.leftFavLabel.isHidden = false
                self.leftFavLabel.alpha = 1.0
            })
            let screenHeight = UIScreen.main.bounds.height
            if screenHeight <= 667 {
                self.leftStackView.spacing = 4
            } else {
                self.leftStackView.spacing = 12
            }
            let dates = Utils.formatDate(date: date)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.leftFavLabel.text = formattedString
        } else {
            UIView.animate(withDuration: 1.5, animations: {
                self.leftFavLabel.isHidden = true
                self.leftFavLabel.alpha = 0.0
            })
            userDefaults.removeObject(forKey: property.propertyCode)
            userDefaults.synchronize()
        }
    }
    
    func manageRightFavorites(addFav: Bool) {
        guard let property = self.rightProperty else { return }
        let userDefaults = UserDefaults.standard
        if addFav {
            let date = Date()
            let favProperty = ["code": property.propertyCode, "date": date] as [String : Any]
            userDefaults.set(favProperty, forKey: property.propertyCode)
            userDefaults.synchronize()
            self.rightFavLabel.alpha = 0.0
            UIView.animate(withDuration: 1.75, animations: {
                self.rightFavLabel.isHidden = false
                self.rightFavLabel.alpha = 1.0
            })
            let screenHeight = UIScreen.main.bounds.height
            if screenHeight <= 667 {
                self.rightStackView.spacing = 4
            } else {
                self.rightStackView.spacing = 12
            }
            let dates = Utils.formatDate(date: date)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.rightFavLabel.text = formattedString
        } else {
            UIView.animate(withDuration: 1.5, animations: {
                self.rightFavLabel.isHidden = true
                self.rightFavLabel.alpha = 0.0
            })
            userDefaults.removeObject(forKey: property.propertyCode)
            userDefaults.synchronize()
        }
    }
    
    func isFavoriteAd(property: PropertyListEntity) -> (codeFav: String, dateFav: Date)? {
        let userDefaults = UserDefaults.standard
        if let adFav = userDefaults.dictionary(forKey: property.propertyCode),
           let codeFav = adFav["code"] as? String,
           let dateFav = adFav["date"] as? Date {
            return (codeFav, dateFav)
        }
        return nil
    }
    
    // MARK: Navigations
    func configureNavigation(){
        let leftStackViewGesture = UITapGestureRecognizer(target: self, action: #selector(leftStackViewTapped))
        self.leftStackView.isUserInteractionEnabled = true
        self.leftStackView.addGestureRecognizer(leftStackViewGesture)
        let rightStackViewGesture = UITapGestureRecognizer(target: self, action: #selector(rightStackViewTapped))
        self.rightStackView.isUserInteractionEnabled = true
        self.rightStackView.addGestureRecognizer(rightStackViewGesture)
    }
    
    @objc func leftStackViewTapped() {
        guard let property = self.leftProperty else { return }
        let propertyExtraParams: ExtraParams = ExtraParams(originalPropertyCode: property.propertyCode, address: property.address, district: property.district, municipality: property.municipality, parking: property.parkingSpace?.hasParkingSpace ?? false, parkingIncluded: property.parkingSpace?.parkingPriceIncluded ?? false)
        self.delegate?.navigateToDetail(extraParams: propertyExtraParams)
    }
    
    @objc func rightStackViewTapped() {
        guard let property = self.leftProperty else { return }
        let propertyExtraParams: ExtraParams = ExtraParams(originalPropertyCode: property.propertyCode, address: property.address, district: property.district, municipality: property.municipality, parking: property.parkingSpace?.hasParkingSpace ?? false, parkingIncluded: property.parkingSpace?.parkingPriceIncluded ?? false)
        self.delegate?.navigateToDetail(extraParams: propertyExtraParams)
    }
    
}

// MARK: - UICollectionViewDataSource
extension PropertyAdsIpadCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == leftCollectionView {
            return leftImageList.count
        } else if collectionView == rightCollectionView {
            return rightImageList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesAdsCollectionViewCell", for: indexPath) as! ImagesAdsCollectionViewCell
        if collectionView == leftCollectionView {
            let image = leftImageList[indexPath.item].image
            let tag = leftImageList[indexPath.item].tag
            cell.configureCell(image: image, tag: tag)
        } else if collectionView == rightCollectionView {
            let image = rightImageList[indexPath.item].image
            let tag = rightImageList[indexPath.item].tag
            cell.configureCell(image: image, tag: tag)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PropertyAdsIpadCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
