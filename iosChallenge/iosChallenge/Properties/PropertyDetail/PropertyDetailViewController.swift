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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }



}

// MARK: PropertyDetailViewProtocol
extension PropertyDetailViewController: PropertyDetailViewProtocol {
    
}
