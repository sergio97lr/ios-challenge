//
//  PropertyDetailViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyDetailViewController: BaseViewController {
    
    var presenter: PropertyDetailPresenterProtocol?
    var extraParams: ExtraParams?
    var cells: [DetailCellType] = []
    
    @IBOutlet weak var propertyDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.registerCells()
        self.propertyDetailTableView.dataSource = self
        self.propertyDetailTableView.delegate = self
    }
    
    func registerCells() {
        self.propertyDetailTableView.register(UINib(nibName: "PropertyDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PropertyDetailTableViewCell")
        self.propertyDetailTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.propertyDetailTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.propertyDetailTableView.register(UINib(nibName: "AdditionalPropertyInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "AdditionalPropertyInfoTableViewCell")
        
    }
    
}

// MARK: PropertyDetailViewProtocol
extension PropertyDetailViewController: PropertyDetailViewProtocol {
    func setBackButtonText(text: String) {
        self.setCustomBackButton(title: text)
    }
    
    func updateCells(cells: [DetailCellType]) {
        self.cells = cells
        DispatchQueue.main.async{
            self.propertyDetailTableView.reloadData()
        }
    }
    
    
    func updatePropertyEntity() {
        guard let extraParams = self.extraParams else {return}
        self.presenter?.addPropertyParameters(extraParams: extraParams)
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
        case .propertyDetail(let originalPropertyCode, let images, let address, let district, let municipality, let price, let rooms, let size, let exterior, let propertyType, let operation, let floor):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyDetailTableViewCell", for: indexPath) as! PropertyDetailTableViewCell
            cell.configureCell(originalPropertyCode: originalPropertyCode, images: images, address: address, district: district, municipality: municipality, price: price, rooms: rooms, size: size, exterior: exterior, propertyType: propertyType, operation: operation, floor: floor)
            return cell
        case .title(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
            cell.configureCell(text: text)
            return cell
        case .propertyComment(let propertyComment):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            cell.configureCell(propertyComment: propertyComment)
            cell.delegate = self
            return cell
        case .additionalPropertyInfo(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalPropertyInfoTableViewCell", for: indexPath) as! AdditionalPropertyInfoTableViewCell
            cell.configureCell(text: text)
            return cell
        }
    }
}

extension PropertyDetailViewController: CommentCellDelegate {
    func showFullComment(comment: String) {
        self.presenter?.showFullComment(comment: comment)
    }
    
}
