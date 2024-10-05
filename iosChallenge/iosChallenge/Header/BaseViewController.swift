//
//  BaseViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import UIKit
import SwiftUI

class BaseViewController: UIViewController {

    var showBackButton: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHeaderView()
    }
    
    private func setupHeaderView() {
        let navBar = UIHostingController(rootView: HeaderView(showBackButton: showBackButton, onBackButtonPressed: {
            self.navigationController?.popViewController(animated: true)
        }))
        
        // Agregar la cabecera a la vista
        addChild(navBar)
        navBar.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar.view)
        navBar.didMove(toParent: self)
        
        // Configurar las restricciones
        if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
                            navBar.view.topAnchor.constraint(equalTo: view.topAnchor),
                            navBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                            navBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                            navBar.view.heightAnchor.constraint(equalToConstant: 60)
            ])
        } else {
            NSLayoutConstraint.activate([
                navBar.view.topAnchor.constraint(equalTo: view.topAnchor),
                navBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navBar.view.heightAnchor.constraint(equalToConstant: 120)
            ])
        }
    }
}

