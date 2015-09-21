//
//  TvView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/24.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class TvView: UIView {
    lazy private var buttons: [ChannelButton] = self.createChannelButtons()
    lazy private var inputButton: UIButton = self.createInputButton()

    weak var delegate: TvViewDelegate! = nil

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutChannelButtons()
        self.layoutInputButton()
    }

    private func commonInit() {
        for var i = 0; i < buttons.count; i++ {
            buttons[i].label = ConfigurationService.channelButtons[i]["label"]
            buttons[i].channel = ConfigurationService.channelButtons[i]["channel"]
            buttons[i].tag = Int(buttons[i].channel)!
            buttons[i].addTarget(self, action: "pushedButton:", forControlEvents: .TouchUpInside)
            self.addSubview(buttons[i])
        }

        inputButton.addTarget(self, action: "pushedButton:", forControlEvents: .TouchUpInside)
        self.addSubview(inputButton)
    }

    private func createChannelButtons() -> [ChannelButton] {
        var buttons: [ChannelButton] = []

        for var i = 0; i < ConfigurationService.channelButtons.count; i++ {
            buttons.append(ChannelButton(frame: CGRectZero))
        }
        return buttons
    }

    private func createInputButton() -> UIButton {
        return UIButton(frame: CGRectMake(0, 0, 50, 35))
    }

    private func layoutChannelButtons() {
        for var i = 0; i < buttons.count; i++ {
            buttons[i].frame.size = CGSizeMake(80, 80)
            buttons[i].frame.origin.x = CGFloat(100 * (i % 3))
            buttons[i].frame.origin.y = CGFloat(100 * (i / 3))
        }
    }

    private func layoutInputButton() {
        let inputButtonData: Dictionary<String, String> = ConfigurationService.inputButton
        let buttonTitle: String = inputButtonData["label"]!
        inputButton.setTitle(buttonTitle, forState: .Normal)
        inputButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        inputButton.setTitle(buttonTitle, forState: .Highlighted)
        inputButton.setTitleColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7), forState: .Highlighted)
        inputButton.tag = Int(inputButtonData["channel"]!)!
        inputButton.frame.origin.y = 420
        inputButton.frame.origin.x = 115
    }

    internal func pushedButton(sender: UIButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }

}

protocol TvViewDelegate: class {
    func buttonDidTap(channel: Int, sender: TvView)
}

