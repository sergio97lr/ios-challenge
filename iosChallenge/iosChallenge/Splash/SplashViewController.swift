//
//  SplashViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class SplashViewController: UIViewController {

    var presenter: SplashPresenterProtocol?
    
    @IBOutlet weak var splashIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            splashIconImageView.image = UIImage(named: "idealistaLong")
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            splashIconImageView.image = UIImage(named: "idealistaShort")
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.viewDidAppear()
    }


}

// MARK: SplashViewProtocol
extension SplashViewController: SplashViewProtocol {
    
}
