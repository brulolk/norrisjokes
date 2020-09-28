//
//  BaseNavigationViewController.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setDefault()
    }

    func setDefault() {
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationBar.barTintColor = .darkGray
        self.navigationBar.tintColor = .white
        self.setupTitleColor()

    }

    private func setupTitleColor() {
        self.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 17),
                                                  .foregroundColor: UIColor.white]
        self.navigationBar.isTranslucent = false

    }

}
