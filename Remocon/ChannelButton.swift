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
        super.init(coder: aDecoder)
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutButton()
    }

    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
                self.setTitleColor(UIColor.clearColor(), forState: .Highlighted)
            } else {
                self.backgroundColor = UIColor.clearColor()
                self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }

    // MARK: - Layout view -
    private func layoutButton() {
        self.titleLabel!.font = UIFont(name: "LigatureSymbols", size: 24)
        self.setTitle(label, forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.setTitle(label, forState: .Highlighted)
        self.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7), forState: .Highlighted)

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.whiteColor().CGColor

        self.tag = channel.toInt()!
    }
}
