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
    @IBOutlet weak var addressTextField: UITextField!

    weak var delegate: SettingViewDelegate! = nil

    override func layoutSubviews() {
        super.layoutSubviews()
        addressTextField.text = ConfigurationService.iRemocon["address"]!
    }


    @IBAction func tappedButton(_ sender: UIButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }

    @IBAction func didEndOnExit(_ sender: UITextField) {
        sender.endEditing(true)
    }
}
protocol SettingViewDelegate: class {
    func buttonDidTap(_ channel: Int, sender: SettingView)
}
