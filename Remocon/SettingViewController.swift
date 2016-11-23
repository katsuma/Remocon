//
//  SettingViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/20.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation

class SettingViewController: UIViewController {
    // MARK: - Properties -
    @IBOutlet var settingView: SettingView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.settingView.delegate = self
    }
}


extension SettingViewController: SettingViewDelegate {
    func buttonDidTap(_ channel: Int, sender: SettingView) {
        self.dismiss(animated: true, completion: nil)
    }
}
