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
    
    let refreshControl = UIRefreshControl()
    var presenter: PropertyListPresenterProtocol?
    var propertyList: PropertiesEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        propertyListTableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadTable()
    }
    
    
    func setupView() {
        self.propertyListTableView.register(UINib(nibName: "PropertyAdCell", bundle: nil),
                                            forCellReuseIdentifier: "PropertyAdCell")
        self.propertyListTableView.register(UINib(nibName: "PropertyAdsIpadCell", bundle: nil),
                                            forCellReuseIdentifier: "PropertyAdsIpadCell")
        self.propertyListTableView.dataSource = self
        self.propertyListTableView.delegate = self
        propertyListTableView.separatorStyle = .none
        self.propertyListTableViewTopConstraint.constant = CGFloat(70)
    }
    
    @objc func refreshData() {
        self.presenter?.getNewPropertyList()
    }
    
    override func settingsViewDidClose() {
        self.reloadTable()
    }
    
    func reloadTable() {
        self.propertyListTableView.reloadData()
    }
    
}

// MARK: PropertyListViewProtocol
extension PropertyListViewController: PropertyListViewProtocol {
    func reladData(property: PropertiesEntity? = nil) {
        var reload = false
        if let property = property {
            self.propertyList = property
            reload = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if reload {
                self.reloadTable()
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    
}

// MARK:  TableViewDelegate / TableViewDataSource
extension PropertyListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return (self.propertyList?.count ?? 2 + 1)/2
        } else {
            return self.propertyList?.count ?? 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyAdsIpadCell", for: indexPath) as! PropertyAdsIpadCell
            
            let firstIndex = indexPath.row * 2
            let secondIndex = firstIndex + 1
            let propertyLeft = self.propertyList?[firstIndex]
            let propertyRight = self.propertyList?[secondIndex]
            cell.configureCell(leftProperty: propertyLeft, rightProperty: propertyRight)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyAdCell", for: indexPath) as! PropertyAdCell
            let property = self.propertyList?[indexPath.row]
            cell.configureCell(property: property)
            cell.delegate = self
            return cell
        }
    }
}

extension PropertyListViewController: PropertyAdCellDelegate {
    func navigateToDetail(extraParams: ExtraParams) {
        self.presenter?.navigateToDetail(extraParams: extraParams)
    }
}
