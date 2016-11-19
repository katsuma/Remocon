//
//  ConfigButton.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/19.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation

import UIKit

class SettingButton: UIButton {
    // MARK: - Properties -
    internal var label: String! = "setting"

    // MARK: - Life cycle events -
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutButton()
    }

    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
                self.setTitleColor(UIColor.clear, for: .highlighted)
            } else {
                self.backgroundColor = UIColor.clear
                self.setTitleColor(UIColor.white, for: UIControlState())
            }
        }
    }

    // MARK: - Layout view -
    fileprivate func layoutButton() {
        self.titleLabel!.font = UIFont(name: "LigatureSymbols", size: 24)
        self.setTitle(label, for: UIControlState())
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.setTitle(label, for: .highlighted)
        self.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7), for: .highlighted)

        self.layer.masksToBounds = true
    }
}
