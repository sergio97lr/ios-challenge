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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ImagesAdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesAdsCollectionViewCell")
    }
    
    override func prepareForReuse() {
        
    }

    func configureCell(originalPropertyCode: String ,images: [ImageDetail], addres: String, district: String, municipality: String, price: PriceInfoDetail, rooms: Int, size: Double, exterior: Bool, propertyType: String, operation: String) {
        
        self.configurePropertyImages(images: images)
        self.operationLabel.text = operation
        
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
