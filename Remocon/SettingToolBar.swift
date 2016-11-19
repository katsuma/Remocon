//
//  SettingToolBar.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/19.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation

class SettingToolBar: UIToolbar {
    lazy fileprivate var settingButton: UIButton = self.createSettingButton()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }

    fileprivate func commonInit() {
        self.setBackgroundImage(UIImage(),
                                        forToolbarPosition: .any,
                                        barMetrics: .default)
        self.setShadowImage(UIImage(), forToolbarPosition: .any)

        self.addSubview(settingButton)
    }

    fileprivate func createSettingButton() -> SettingButton {
        return SettingButton(frame: .zero)
    }

}
