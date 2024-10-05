//
//  PropertyDetailViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyDetailViewController: BaseViewController {

    var presenter: PropertyDetailPresenterProtocol?
    var originalPropertyCode: String?
    var address: String?
    var district: String?
    var municipality: String?
    var cells: [DetailCellType] = []
    
    @IBOutlet weak var propertyDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupView()
    }

    func setupView() {
        self.propertyDetailTableView.register(UINib(nibName: "PropertyDetailTableViewCell", bundle: nil),
                                           forCellReuseIdentifier: "PropertyDetailTableViewCell")
        self.propertyDetailTableView.dataSource = self
        self.propertyDetailTableView.delegate = self
    }
    
}

// MARK: PropertyDetailViewProtocol
extension PropertyDetailViewController: PropertyDetailViewProtocol {
    func updateCells(cells: [DetailCellType]) {
        self.cells = cells
        DispatchQueue.main.async{
            self.propertyDetailTableView.reloadData()
        }
    }
    
    
    func updatePropertyEntity() {
        self.presenter?.addPropertyParameters(originalPropertyCode: self.originalPropertyCode, address: self.address, district: self.district, municipality: self.municipality)
    }
    
    
}

// MARK:  TableViewDelegate / TableViewDataSource
extension PropertyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row]
        switch cellType {
        case .propertyDetail(let originalPropertyCode, let images, let addres, let district, let municipality, let price, let rooms, let size, let exterior, let propertyType, let operation):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyDetailTableViewCell", for: indexPath) as! PropertyDetailTableViewCell
            cell.configureCell(originalPropertyCode: originalPropertyCode, images: images, addres: addres, district: district, municipality: municipality, price: price, rooms: rooms, size: size, exterior: exterior, propertyType: propertyType, operation: operation)
            return cell
        case .title(let text):
            print("")
        case .propertyComment(let propertyComment):
            print("")
        case .additionalPropertyInfo(let text):
            print("")
        }
        return UITableViewCell()
    }
}
