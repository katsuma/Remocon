//
//  TvNavigationController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/20.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation

class TvNavigationController: UINavigationController {
    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationItem()
    }

    fileprivate func initNavigationItem() {
        let navigationBar: UINavigationBar = self.navigationBar

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .white
        navigationBar.barTintColor = .clear
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
