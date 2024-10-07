//
//  PropertyCommentViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 7/10/24.
//

import SwiftUI
import UIKit

class PropertyCommentViewController: BaseViewController {
    private let comment: String

    init(comment: String) {
        self.comment = comment
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCommentView()
        self.setCustomBackButton(title: "Back to ad")
    }

    private func setupCommentView() {
        let commentView = PropertyCommentView(comment: comment)
        let hostingController = UIHostingController(rootView: commentView)

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
