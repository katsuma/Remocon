//
//  SettingToolBar.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/19.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation

class SettingToolBar: UINavigationBar {
    lazy fileprivate var settingButton: UIButton = self.createSettingButton()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }

    override func draw(_ rect: CGRect) {
        self.isHidden = false
    }

    fileprivate func commonInit() {
        self.backgroundColor = UIColor.clear
        self.addSubview(settingButton)
    }

    fileprivate func createSettingButton() -> SettingButton {
        return SettingButton(frame: .zero)
    }

}
