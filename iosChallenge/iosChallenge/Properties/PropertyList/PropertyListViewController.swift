//
//  PropertyListViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit
import SwiftUI

class PropertyListViewController: BaseViewController {
    
    @IBOutlet weak var propertyListTableView: UITableView!
    @IBOutlet var propertyListTableViewTopConstraint: NSLayoutConstraint!
    
    var presenter: PropertyListPresenterProtocol?
    var propertyList: PropertiesEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.propertyListTableView.reloadData()
    }
    
    func setupView() {
        self.propertyListTableView.register(UINib(nibName: "PropertyAdCell", bundle: nil),
                                           forCellReuseIdentifier: "PropertyAdCell")
        self.propertyListTableView.dataSource = self
        self.propertyListTableView.delegate = self
        propertyListTableView.separatorStyle = .none
        self.propertyListTableViewTopConstraint.constant = CGFloat(70)
    }
    
    
}

// MARK: PropertyListViewProtocol
extension PropertyListViewController: PropertyListViewProtocol {
    
}

// MARK:  TableViewDelegate / TableViewDataSource
extension PropertyListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertyList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyAdCell", for: indexPath) as! PropertyAdCell
        let property = self.propertyList?[indexPath.row]
        cell.configureCell(property: property)
        cell.delegate = self
        return cell
    }
}

extension PropertyListViewController: PropertyAdCellDelegate {
    func navigateToDetail(extraParams: ExtraParams) {
        self.presenter?.navigateToDetail(extraParams: extraParams)
        }
    }
