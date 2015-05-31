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
        self.initGradientBackground()
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

    private func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha: 1.0)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

//    private func blurEffectView(fromBlurStyle style: UIBlurEffectStyle, frame: CGRect) -> UIVisualEffectView {
//        let effect: UIBlurEffect = UIBlurEffect(style: style)
//        let blurView: UIVisualEffectView = UIVisualEffectView(effect: effect)
//        blurView.frame = frame
//        return blurView
//    }

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

    internal func pushedControlButton(sender: ChannelButton) {
        println("pushed by ControlButton2, \(sender.tag)")
    }
}

extension InputControlViewController: InputControlViewDelegate {
    func buttonDidTap(channel: Int, sender: InputControlView) {
        println("tapped by control view button")
        signal.send(channel)
    }
}
