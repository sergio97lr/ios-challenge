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
    
    weak var delegate: PropertyAdCellDelegate?
    
    var imageList: [(image: UIImage, tag: String)] = []
    var property: PropertyListEntity?
    var favAd: Bool = false
    var favoriteAd: (String, Date)? = nil
    
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
        self.favIcon.image = UIImage(named: "noFavIcon")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
    }
    
    func configureCell(property: PropertyListEntity?){
        self.property = property
        self.selectionStyle = .none
        self.configurePropertyImages()
        self.configureStackView()
        self.adView.layer.borderWidth = 1
        self.adView.layer.borderColor = UIColor.pinkIdealista.cgColor
        self.configureNavigation()
        self.addFavTapAction()
        self.favTextLabel.isHidden = true
        self.favoriteAd = self.isFavoriteAd()
        if let adFav = self.favoriteAd {
            self.favAd = true
            self.favIcon.image = UIImage(named: "favIcon")
            self.favTextLabel.isHidden = false
            self.infoStackView.spacing = 12
            let dates = Utils.formatDate(date: adFav.1)
            self.favTextLabel.text = "Added to favorites on \(dates.formattedDate) at \(dates.formattedTime)"
        }
        
    }
    
    func configurePropertyImages() {
        guard let property = self.property else { return }
        let group = DispatchGroup()
        
        for propertyImage in property.multimedia.images {
            guard let url = URL(string: propertyImage.url) else { continue }
            group.enter()
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let imageListItem = (image: image, tag: propertyImage.tag)
                        self?.imageList.append(imageListItem)
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func configureStackView() {
        guard let property = self.property else { return }
        
        self.infoStackView.spacing = 20
        
        // MARK: Operation
        let operation = property.operation
        var operationText = "For Rent"
        if operation.contains("sale") {
            operationText = "For Sale"
        }
        self.operationLabel.text = operationText
        
        // MARK: Price
        let price = Utils.formatPrice(property.priceInfo.price.amount) ?? String(property.priceInfo.price.amount)
        let currencySuffix = property.priceInfo.price.currencySuffix
        self.priceLabel.text = "\(price)\(currencySuffix)"
        
        // MARK: Address
        let propertyType = property.propertyType
        var propertyTypeText = "House"
        if propertyType.contains("flat") {
            propertyTypeText = "Flat"
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
                self.parkingLabel.text = "Parking Included"
            } else {
                self.parkingLabel.text = "Parking Optional"
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
        var exteriorOrInterior = "exterior"
        if !exterior {
            exteriorOrInterior = "interior"
        }
        
        self.additionalInfoLabel.text = "\(rooms) bed - \(size) m\u{00B2} - \(floor) - \(exteriorOrInterior)"
        
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
                self.favIcon.image = UIImage(named: "noFavIcon")
            })
            
        }
    }
    
    func manageFavorites(addFav: Bool) {
        guard let property = self.property else { return }
        let userDefaults = UserDefaults.standard
        if addFav {
            let date = Date()
            let favProperty = ["code": property.propertyCode, "date": date] as [String : Any]
            userDefaults.set(favProperty, forKey: property.propertyCode)
            userDefaults.synchronize()
            UIView.animate(withDuration: 1.5, animations: {
                self.favTextLabel.isHidden = false
            })
            self.infoStackView.spacing = 12
            let dates = Utils.formatDate(date: date)
            self.favTextLabel.text = "Added to favorites on \(dates.formattedDate) at \(dates.formattedTime)"
        } else {
            UIView.animate(withDuration: 1.5, animations: {
                self.favTextLabel.isHidden = true
            })
            userDefaults.removeObject(forKey: property.propertyCode)
            userDefaults.synchronize()
        }
    }
    
    func isFavoriteAd() -> (codeFav: String, dateFav: Date)? {
        guard let property = self.property else { return nil }
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
        let stackViewGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        self.infoStackView.isUserInteractionEnabled = true
        self.infoStackView.addGestureRecognizer(stackViewGesture)
    }
    
    @objc func stackViewTapped() {
        guard let property = self.property else { return }
        self.delegate?.navigateToDetail(propertyCode: property.propertyCode, address: property.address, district: property.district, municipality: property.municipality)
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
