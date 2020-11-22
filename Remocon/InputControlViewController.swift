//
//  InputControlViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class InputControlViewController: UIViewController {
    lazy fileprivate var inputControlView: InputControlView = self.createInputControlView()
    lazy fileprivate var signal: IremoconSignal = self.createIremoconSignal()
    private var isHiddenHomeIndicator: Bool = true

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

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        let keys = event?.allPresses.compactMap { $0.key?.characters }.filter { $0 != "" }.sorted()
        let key = keys?.first

        switch key {
        case "UIKeyInputEscape":
            self.dismiss(animated: true, completion: nil)

        case "UIKeyInputUpArrow":
            let channel = Int(ConfigurationService.controlButtons.first(where: { $0["label"] == "up" })!["channel"]!)
            signal.send(channel!)

        case "UIKeyInputDownArrow":
            let channel = Int(ConfigurationService.controlButtons.first(where: { $0["label"] == "down" })!["channel"]!)
            signal.send(channel!)

        case .none:
            print("None")
        case .some(_):
            print("Some")
        }
    }

    // MARK: - Create subviews -
    fileprivate func createInputControlView() -> InputControlView {
        return InputControlView(frame: CGRect.zero)
    }

    fileprivate func initBackground() {
        self.view.backgroundColor = .clear
        let visuaEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visuaEffectView.frame = self.view.bounds
        visuaEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visuaEffectView.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(visuaEffectView)
    }

    // MARK: - Layout subviews -
    fileprivate func layoutChannelContainerView() {
        inputControlView.frame.size = CGSize(width: 360, height: 480)
        inputControlView.center = self.view.center
    }

    fileprivate func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    fileprivate func initNavigation() {
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(InputControlViewController.pushedDoneButton(_:)))
        doneButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = doneButton

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    @objc internal func pushedDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @available(iOS 11, *)
    override var prefersHomeIndicatorAutoHidden: Bool {
        return isHiddenHomeIndicator
    }
}

extension InputControlViewController: InputControlViewDelegate {
    func buttonDidTap(_ channel: Int, sender: InputControlView) {
        signal.send(channel)
    }
}
