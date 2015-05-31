//
//  InputControlViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class InputControlViewController: UIViewController {
    lazy private var inputControlView: InputControlView = self.createInputControlView()
    lazy private var signal: IremoconSignal = self.createIremoconSignal()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBackground()
        self.view.addSubview(inputControlView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.initNavigation()
        self.layoutChannelContainerView()
        self.inputControlView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Create subviews -
    private func createInputControlView() -> InputControlView {
        return InputControlView(frame: CGRectZero)
    }

    private func initBackground() {
        self.view.backgroundColor = .clearColor()
        let visuaEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visuaEffectView.frame = self.view.bounds
        visuaEffectView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        visuaEffectView.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.view.addSubview(visuaEffectView)
    }

    // MARK: - Layout subviews -
    private func layoutChannelContainerView() {
        inputControlView.frame.size = CGSizeMake(360, 480)
        inputControlView.center = self.view.center
    }

    private func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    private func initNavigation() {
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "pushedDoneButton:")
        doneButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = doneButton

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
    }

    internal func pushedDoneButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

extension InputControlViewController: InputControlViewDelegate {
    func buttonDidTap(channel: Int, sender: InputControlView) {
        signal.send(channel)
    }
}
