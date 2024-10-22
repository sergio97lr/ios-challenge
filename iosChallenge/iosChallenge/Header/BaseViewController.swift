//
//  BaseViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import UIKit
import SwiftUI

class BaseViewController: UIViewController, SettingsViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeaderView()
        self.setNavigationAppareance()
        self.setupSettingsButton()
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
        DispatchQueue.main.async {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.isTranslucent = true
        }
    }

    private func setupSettingsButton() {
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped)
        )
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            settingsButton.image = UIImage(systemName: "gearshape.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24))
        }
        
        settingsButton.tintColor = IdealistaColors.pinkIdealista
        self.navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func settingsButtonTapped() {
        var settingsView = SettingsView()
            settingsView.delegate = self
            let hostingController = UIHostingController(rootView: settingsView)
            hostingController.modalPresentationStyle = .pageSheet
            self.present(hostingController, animated: true, completion: nil)
    }

    func setCustomBackButton(title: String) {
        DispatchQueue.main.async {
            if self.navigationController?.viewControllers.first != self {
                self.navigationItem.hidesBackButton = true
                let backButton = UIButton(type: .system)
                backButton.setTitle(title, for: .normal)
                backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
                backButton.tintColor = IdealistaColors.pinkIdealista
                backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
                let backBarButtonItem = UIBarButtonItem(customView: backButton)
                self.navigationItem.leftBarButtonItem = backBarButtonItem
            }
        }
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func settingsViewDidClose() {
        // Delegate function
    }
}
