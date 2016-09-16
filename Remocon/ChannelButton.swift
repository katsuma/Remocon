//
//  Channelself.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class ChannelButton: UIButton {
    // MARK: - Properties -
    internal var label: String!
    internal var channel: String!

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
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor

        self.tag = Int(channel)!
    }
}
