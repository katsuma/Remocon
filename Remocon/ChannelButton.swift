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


    // MARKL: - Layout view -
    private func layoutButton() {
        self.titleLabel!.font = UIFont(name: "LigatureSymbols", size: 24)
        self.setTitle(label, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.setTitle(label, forState: UIControlState.Highlighted)
        self.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.borderWidth = 0.5

        self.tag = channel.toInt()!
    }
}
