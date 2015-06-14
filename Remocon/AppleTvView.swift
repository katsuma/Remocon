//
//  AppleTvView.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/06/14.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class AppleTvView: UIView {
    lazy private var playPauseButton: ChannelButton = self.createChannelButton()

    weak var delegate: AppleTvViewDelegate! = nil

    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func createChannelButton() -> ChannelButton {
        return ChannelButton(frame: CGRectZero)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        initPlayPauseButton()
    }

    private func initPlayPauseButton() {
        playPauseButton.label = ConfigurationService.playPauseButton["label"]
        playPauseButton.channel = ConfigurationService.playPauseButton["channel"]
        playPauseButton.tag = playPauseButton.channel.toInt()!
        playPauseButton.addTarget(self, action: "pushedButton:", forControlEvents: .TouchUpInside)

        self.addSubview(playPauseButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutPlayPauseButton()
    }

    private func layoutPlayPauseButton() {
        let playPauseButtonData: Dictionary<String, String> = ConfigurationService.playPauseButton
        let buttonTitle: String = playPauseButtonData["label"]!
        playPauseButton.frame.size = CGSizeMake(80, 80)
        playPauseButton.frame.origin.x = CGFloat(200)
        playPauseButton.frame.origin.y = CGFloat(100)
    }

    @IBAction internal func pushedButton(sender: UIButton) {
        delegate?.buttonDidTap(sender.tag, sender: self)
    }

}

protocol AppleTvViewDelegate: class {
    func buttonDidTap(channel: Int, sender: AppleTvView)
}

