//
//  ViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties -
    lazy private var button:UIButton = self.createChannelButton()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(button)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.layoutChannelButton()
    }

    // MARK: - Create subviews -
    private func createChannelButton() -> UIButton {
        let button = UIButton(frame: CGRectZero)
        return button
    }

    // MARK: - Layout subviews -
    private func layoutChannelButton() {
        button.setTitle("1", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button.setTitle("1", forState: UIControlState.Highlighted)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)

        button.frame = CGRectMake(0, 0, 50, 50)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.position = CGPoint(x: self.view.frame.width/2, y: 200)
        button.layer.borderWidth = 0.5

        button.tag = 1
        button.addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
    }

    func onClickButton(sender: UIButton) {
        println("clicked \(sender.tag)")
    }
}

