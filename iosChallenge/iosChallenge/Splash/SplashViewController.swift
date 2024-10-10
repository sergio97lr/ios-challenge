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
        let splashImage = UIImage(named: "idealistaLong")
        let tintedImage = splashImage?.withRenderingMode(.alwaysTemplate)
        splashIconImageView.image = tintedImage
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateImageTintColor()
    }
    
    func updateImageTintColor() {
        if traitCollection.userInterfaceStyle == .dark {
            splashIconImageView.tintColor = UIColor.white
        } else {
            splashIconImageView.tintColor = UIColor.black
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.viewDidAppear()
    }


}

// MARK: SplashViewProtocol
extension SplashViewController: SplashViewProtocol {
    
}
