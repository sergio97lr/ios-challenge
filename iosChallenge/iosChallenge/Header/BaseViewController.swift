//
//  BaseViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import UIKit
import SwiftUI

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHeaderView()
        self.setNavigationAppareance()
    }
    
    private func setupHeaderView() {
        let navBar = UIHostingController(rootView: HeaderView())
        
        addChild(navBar)
        navBar.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar.view)
        navBar.didMove(toParent: self)
        
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
    
    private func setNavigationAppareance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setCustomBackButton(title: String) {
        if self.navigationController?.viewControllers.first != self {
            self.navigationItem.hidesBackButton = true
            let backButton = UIButton(type: .system)
            backButton.setTitle(title, for: .normal)
            backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            backButton.tintColor = IdealistaColors.pinkIdealista
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            let backBarButtonItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = backBarButtonItem
        }
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

