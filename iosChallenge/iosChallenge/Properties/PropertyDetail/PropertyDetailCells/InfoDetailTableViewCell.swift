//
//  PropertyDetailTableViewCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 5/10/24.
//

import UIKit

class InfoDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var districLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var placeholderView: UIImageView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var mapWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: InfoCellCellDelegate?
    var imageList: [(image: UIImage, tag: String)] = []
    var favAd = false
    var favoriteAd: (String, Date)? = nil
    let phoneCollectionHeight = 320.0
    let padCollectionHeight = 600.0
    let phoneMapSize = 38.0
    let padMapSize = 64.0
    var latitude: Double?
    var longitude: Double?
    var favData: ExtraParams?
    var price: Double = 0.0
    var currencySufix: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateImageTintColor()
    }
    
    override func prepareForReuse() {
        self.favAd = false
        self.favIcon.image = UIImage(named: "noFavIconDetail")
        self.operationLabel.text = ""
        self.addresLabel.text = ""
        self.districLabel.text = ""
        self.priceLabel.text = ""
        self.extraInfoLabel.text = ""
        self.favLabel.text = ""
        self.placeholderView.isHidden = false
        self.favData = nil
        self.price = 0.0
        self.currencySufix = ""
    }
    
    func configureCell(originalPropertyCode: String ,images: [ImageDetail], address: String, district: String, municipality: String, price: PriceInfoDetail, rooms: Int, size: Double, exterior: Bool, propertyType: String, operation: String, floor: String, latitude: Double, longitude: Double, parking: Bool, parkingIncluded: Bool) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.collectionViewHeightConstraint.constant = self.padCollectionHeight
            self.mapWidthConstraint.constant = self.padMapSize
            self.mapHeightConstraint.constant = self.padMapSize
        } else {
            self.collectionViewHeightConstraint.constant = self.phoneCollectionHeight
            self.mapWidthConstraint.constant = self.phoneMapSize
            self.mapHeightConstraint.constant = self.phoneMapSize
            
        }
        
        let favData = ExtraParams(originalPropertyCode: originalPropertyCode, address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded)
        self.favData = favData
        
        self.configurePropertyImages(images: images)
        if operation.contains("sale") {
            self.operationLabel.text = Constants.LocalizableKeys.Operation.sale
        } else {
            self.operationLabel.text = Constants.LocalizableKeys.Operation.rent
        }
        
        let propertyType = propertyType
        var propertyTypeText = Constants.LocalizableKeys.Home.house
        if propertyType.contains("flat") {
            propertyTypeText = Constants.LocalizableKeys.Home.flat
        }
        self.addresLabel.text = "\(propertyTypeText) in \(address)"
        self.districLabel.text = "\(district), \(municipality)"
        
        let priceFormatted = Utils.formatPrice(price.amount) ?? "0"
        self.priceLabel.text = "\(priceFormatted)\(price.currencySuffix)"
        self.price = price.amount
        self.currencySufix = price.currencySuffix
        
        let size = Int(size)
        let exterior = exterior
        var exteriorOrInterior = "exterior"
        if !exterior {
            exteriorOrInterior = "interior"
        }
        
        self.extraInfoLabel.text = "\(rooms) \(Constants.LocalizableKeys.Home.bedrooms) - \(size) m\u{00B2} - \(floor) - \(exteriorOrInterior)"
        
        self.favLabel.numberOfLines = 0
        self.addFavTapAction()
        self.favoriteAd = Utils.isFavoriteAd(propertyCode: originalPropertyCode)
        if let adFav = self.favoriteAd {
            self.favAd = true
            self.favIcon.image = UIImage(named: "favIcon")
            let dates = Utils.formatDate(date: adFav.1)
            let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
            self.favLabel.text = formattedString
        } else {
            self.favLabel.text = Constants.LocalizableKeys.Home.noFav
        }
        self.favLabel.numberOfLines = 0
        self.favLabel.lineBreakMode = .byWordWrapping
        self.favLabel.sizeToFit()
        self.favLabel.layoutIfNeeded()
        
        self.latitude = latitude
        self.longitude = longitude
        
        let tapMapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMapImage))
        self.mapImageView.addGestureRecognizer(tapMapGesture)
        self.mapImageView.isUserInteractionEnabled = true
        self.updateImageTintColor()
        
        self.sizeToFit()
        self.layoutIfNeeded()
        
    }
    
    @objc private func didTapMapImage() {
        guard let latitude = self.latitude, let longitude = self.longitude else { return }
        self.delegate?.showMap(latitude: latitude, longitude: longitude)
    }
    
    
    func configurePropertyImages(images: [ImageDetail]) {
        let group = DispatchGroup()
        
        for propertyImage in images {
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
            if !(self?.imageList.isEmpty ?? true) {
                self?.placeholderView.isHidden = true
            }
        }
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
                self.favIcon.image = UIImage(named: "noFavIconDetail")
            })
            
        }
    }
    
    func manageFavorites(addFav: Bool) {
        guard let favData = self.favData else { return }
        if addFav {
            let date = Date()
            CoreDataManager.shared.saveFavorite(propertyCode: favData.originalPropertyCode, favDate: Date(), address: favData.address, district: favData.district, municipality: favData.municipality, parking: favData.parking, parkingIncluded: favData.parkingIncluded, price: self.price, currencySufix: self.currencySufix)
            UIView.animate(withDuration: 0.75, animations: {
                self.favLabel.alpha = 0.0
            }) { _ in
                let dates = Utils.formatDate(date: date)
                let formattedString = String(format: Constants.LocalizableKeys.Home.favList, dates.formattedDate, dates.formattedTime)
                self.favLabel.text = formattedString
                UIView.animate(withDuration: 0.75) {
                    self.favLabel.alpha = 1.0
                }
            }
        } else {
            UIView.animate(withDuration: 0.75, animations: {
                self.favLabel.alpha = 0.0
            }) { _ in
                self.favLabel.text = Constants.LocalizableKeys.Home.noFav
                UIView.animate(withDuration: 0.75) {
                    self.favLabel.alpha = 1.0
                }
            }
            
            CoreDataManager.shared.deleteFavorite(propertyCode: favData.originalPropertyCode)
        }
        
        self.favLabel.sizeToFit()
    }
    
    func updateImageTintColor() {
        if traitCollection.userInterfaceStyle == .dark {
            mapImageView.image = UIImage(named: "mapIconDark")
        } else {
            mapImageView.image = UIImage(named: "mapIcon")
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension InfoDetailTableViewCell: UICollectionViewDataSource {
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
extension InfoDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
