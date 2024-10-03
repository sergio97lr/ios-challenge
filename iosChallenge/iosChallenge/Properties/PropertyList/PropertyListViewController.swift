//
//  PropertyListViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyListViewController: UIViewController {

    var presenter: PropertyListPresenterProtocol?
    
    var propertyList: PropertiesEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}

// MARK: PropertyListViewProtocol
extension PropertyListViewController: PropertyListViewProtocol {
    
}
