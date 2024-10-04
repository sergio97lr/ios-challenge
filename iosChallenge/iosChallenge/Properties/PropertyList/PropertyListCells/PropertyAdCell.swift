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
    @IBOutlet var bottomInfoStackViewConstraint: NSLayoutConstraint!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet weak var propertyAddressLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet var favIcon: UIImageView!
    @IBOutlet var favTextLabel: UILabel!
    
    var images: [UIImage] = []
    var property: PropertyListEntity?
    var favAd: Bool = false
    
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ImagesAdListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdListCollectionViewCell")
    }
    
    func configureCell(property: PropertyListEntity?){
        self.property = property
        self.selectionStyle = .none
        self.configurePropertyImages()
        self.configureStackView()
        self.addFavTapAction()
        self.favTextLabel.isHidden = true
        
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
                        self?.images.append(image)
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
            let price = Int(property.priceInfo.price.amount)
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
            switch floor {
            case "0":
                floor = "ground floor"
            case "1":
                floor = "1st floor"
            case "2":
                floor = "2nd floor"
            case "3":
                floor = "3rd floor"
            default:
                floor = "\(floor)th floor"
            }
            var exteriorOrInterior = "exterior"
            if !exterior {
                exteriorOrInterior = "interior"
            }
            
            self.additionalInfoLabel.text = "\(rooms) bed - \(size) m2 - \(floor) - \(exteriorOrInterior)"

    }
    func addFavTapAction() {
        let tapGestureImg = UITapGestureRecognizer(target: self, action: #selector(favTapped))
        self.favIcon.isUserInteractionEnabled = true
        self.favIcon.addGestureRecognizer(tapGestureImg)
    }
    
    @objc func favTapped() {
        self.favAd = !self.favAd
        if self.favAd {
            UIView.transition(with: favIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.favIcon.image = UIImage(named: "favIcon")
            })
        } else {
            UIView.transition(with: favIcon,
                              duration: 1.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.favIcon.image = UIImage(named: "noFavIcon")
            })
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension PropertyAdCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesAdListCollectionViewCell", for: indexPath) as! ImagesAdListCollectionViewCell
        cell.imagesAds.image = images[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PropertyAdCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
