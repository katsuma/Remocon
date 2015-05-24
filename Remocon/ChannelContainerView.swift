//
//  ChannelContainerView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/24.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class ChannelContainerView: UIView {
    lazy private var buttons: [ChannelButton] = self.createChannelButtons()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutChannelButtons()
    }

    private func commonInit() {
        for var i = 0; i < buttons.count; i++ {
            buttons[i].label = ConfigurationService.buttons[i]["label"]
            buttons[i].channel = ConfigurationService.buttons[i]["channel"]
            buttons[i].tag = buttons[i].channel.toInt()!
            buttons[i].addTarget(self, action: "pushedChannelButton:", forControlEvents: .TouchUpInside)
            self.addSubview(buttons[i])
        }
    }

    private func createChannelButtons() -> [ChannelButton] {
        var buttons: [ChannelButton] = []

        for var i = 0; i < ConfigurationService.buttons.count; i++ {
            buttons.append(ChannelButton(frame: CGRectZero))
        }
        return buttons

    }

    private func layoutChannelButtons() {
        for var i = 0; i < buttons.count; i++ {
            buttons[i].frame.size = CGSizeMake(80, 80)
            buttons[i].frame.origin.x = CGFloat(85 * (i % 3))
            buttons[i].frame.origin.y = CGFloat(85 * (i / 3))
        }
    }

    internal func pushedChannelButton(sender: ChannelButton) {
        println("pushed by \(sender.tag)")
    }

}
