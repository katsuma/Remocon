//
//  SettingView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/23.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation

class SettingView: UIView {
    @IBOutlet weak var closeButton: UIButton!

    weak var delegate: SettingViewDelegate! = nil

    @IBAction func tappedButton(_ sender: UIButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }
}
protocol SettingViewDelegate: class {
    func buttonDidTap(_ channel: Int, sender: SettingView)
}
