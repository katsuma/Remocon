//
//  InputControlView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class InputControlView: UIView {
    lazy fileprivate var upButton: ChannelButton = self.createUpButton()
    lazy fileprivate var downButton: ChannelButton = self.createDownButton()

    weak var delegate: InputControlViewDelegate! = nil

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutButtons()
    }

    fileprivate func createUpButton() -> ChannelButton {
        return ChannelButton(frame: CGRect.zero)
    }

    fileprivate func createDownButton() -> ChannelButton {
        return ChannelButton(frame: CGRect.zero)
    }

    fileprivate func commonInit() {
        upButton.label = ConfigurationService.controlButtons[0]["label"]
        upButton.channel = ConfigurationService.controlButtons[0]["channel"]
        upButton.tag = Int(ConfigurationService.controlButtons[0]["channel"]!)!
        upButton.addTarget(self, action: #selector(InputControlView.pushedControlButton(_:)), for: .touchUpInside)
        self.addSubview(upButton)

        downButton.label = ConfigurationService.controlButtons[1]["label"]
        downButton.channel = ConfigurationService.controlButtons[1]["channel"]
        downButton.tag = Int(ConfigurationService.controlButtons[1]["channel"]!)!
        downButton.addTarget(self, action: #selector(InputControlView.pushedControlButton(_:)), for: .touchUpInside)
        self.addSubview(downButton)
    }

    fileprivate func layoutButtons() {
        upButton.frame.size = CGSize(width: 80, height: 80)
        upButton.frame.origin.x = CGFloat(150)
        upButton.frame.origin.y = CGFloat(150)

        downButton.frame.size = CGSize(width: 80, height: 80)
        downButton.frame.origin.x = CGFloat(150)
        downButton.frame.origin.y = CGFloat(250)
    }

    internal func pushedControlButton(_ sender: ChannelButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }
}

protocol InputControlViewDelegate: class {
    func buttonDidTap(_ channel: Int, sender: InputControlView)
}

