//
//  PropertyDetailTableViewCell.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 5/10/24.
//

import UIKit

class PropertyDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var districLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    
    var imageList: [(image: UIImage, tag: String)] = []
    var favAd = false
    var favoriteAd: (String, Date)? = nil
    var originalPropertyCode = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
    }
    
    override func prepareForReuse() {
        self.favAd = false
        self.originalPropertyCode = ""
        self.favIcon.image = UIImage(named: "noFavIconDetail")
        self.operationLabel.text = ""
        self.addresLabel.text = ""
        self.districLabel.text = ""
        self.priceLabel.text = ""
        self.extraInfoLabel.text = ""
        self.favLabel.text = ""
    }
    
    func configureCell(originalPropertyCode: String ,images: [ImageDetail], address: String, district: String, municipality: String, price: PriceInfoDetail, rooms: Int, size: Double, exterior: Bool, propertyType: String, operation: String, floor: String) {
        
        self.originalPropertyCode = originalPropertyCode
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
        
        let size = Int(size)
        let exterior = exterior
        var exteriorOrInterior = "exterior"
        if !exterior {
            exteriorOrInterior = "interior"
        }
        
        self.extraInfoLabel.text = "\(rooms) \(Constants.LocalizableKeys.Home.bedrooms) - \(size) m\u{00B2} - \(floor) - \(exteriorOrInterior)"
        
        self.favLabel.numberOfLines = 0
        self.addFavTapAction()
        self.favoriteAd = self.isFavoriteAd()
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
        self.sizeToFit()
        self.layoutIfNeeded()
        
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
        let userDefaults = UserDefaults.standard
        if addFav {
            let date = Date()
            let favProperty = ["code": self.originalPropertyCode, "date": date] as [String : Any]
            userDefaults.set(favProperty, forKey: self.originalPropertyCode)
            userDefaults.synchronize()
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
            userDefaults.removeObject(forKey: self.originalPropertyCode)
            userDefaults.synchronize()
        }
        
        self.favLabel.sizeToFit()
    }
    
    func isFavoriteAd() -> (codeFav: String, dateFav: Date)? {
        let userDefaults = UserDefaults.standard
        if let adFav = userDefaults.dictionary(forKey: self.originalPropertyCode),
           let codeFav = adFav["code"] as? String,
           let dateFav = adFav["date"] as? Date {
            return (codeFav, dateFav)
        }
        return nil
    }
    
}

// MARK: - UICollectionViewDataSource
extension PropertyDetailTableViewCell: UICollectionViewDataSource {
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
extension PropertyDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
