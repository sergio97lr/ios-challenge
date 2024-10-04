//
//  PropertyDetailViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyDetailViewController: BaseViewController {

    var presenter: PropertyDetailPresenterProtocol?
    
    override func viewDidLoad() {
        
        showBackButton = true
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}

// MARK: PropertyDetailViewProtocol
extension PropertyDetailViewController: PropertyDetailViewProtocol {
    
}
